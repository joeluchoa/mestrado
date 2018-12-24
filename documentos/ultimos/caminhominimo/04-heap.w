\chapter{Implementações de Filas de Prioridade}
\label{cap:implementacao-fila-prioridade}
O algoritmo de Dijkstra, segundo o teorema~\ref{teorema:no-operacoes}, 
realiza uma seqüência de $n$ \textsf{insert}, $n$ \textsf{delete-min}
e no máximo $m$ \textsf{decrease-key} operações, em um grafo com $n$
vértices e $m$ arcos. Logo, o consumo de tempo do algoritmo de Dijkstra
pode variar conforme a implementação de cada uma dessas operações da
fila de prioridade.

 % Logo, para melhorar a complexidade desse algoritmo
 %é preciso ``acelerar'' o processo de escolher o vértice com o menor
 %potencial.

 %Uma maneira de se fazer isso é guardar os vértices de maneira organizada, tal
 %que, encontrar o vértice com o menor potencial seja rápido, e ainda 
 %não gaste muito tempo para examinar os arcos. Isso pode ser feito
 %fazendo-se uso da uma fila de prioridade.
 
Existem muitos trabalhos envolvendo implementações de filas de
 prioridade com o intuito de reduzir o tempo gasto pelo algoritmo 
de Dijkstra. Para citar alguns bons exemplos temos
~\cite{ahuja:radixheap, boris:buckets, FredTarjan:Fibonacci}.

% Como visto na seção~\ref{sec:filadeprioridade}, uma fila de prioridade
% é um tipo abstrato de dados que consiste de uma coleção de itens,
% cada um, com um valor ou prioridade associada. Nesta dissertação, as
% estruturas de dados utilizadas para implementar filas de prioridade,
% utilizam vértices para representar os itens e funções potencial para
% representar o valor associado a cada item. Cada implementação,
% envolve a codificação, em \CWEB, das operações insert, delete-min e
% decrease-key. 

 As estruturas de dados utilizadas na implementação das filas de
prioridade podem ser divididas em duas categorias, conforme as
operações elementares utilizadas:
\begin{enumerate}[(1)]
\item (modelo de comparação) estruturas baseadas em comparações; e
\item (modelo RAM) estruturas baseadas em ``bucketing''.
\end{enumerate}

\defi{Bucketing}\index{bucketing} é um método de
 organização dos dados que particiona um conjunto em partes chamadas
 \defi{buckets}\index{bucket}. No que diz respeito ao algoritmo de
 Dijkstra, cada bucket agrupa vértices de um grafo relacionados
 através de prioridades, que nesse caso, são os potenciais.

 Neste capítulo, são descritas as implementações das estruturas de dados 
\textit{heap, \dheap} e \textit{fibonacci heap} que são baseadas em
comparações e as estruturas
\textit{bucket heap}\footnote{Na literatura, a implementação do
 algoritmo que utiliza buckets é conhecida como implementação de
Dial~\cite{dial:buckets}.}
e \textit{radix heap} que trabalham no modelo RAM. Nas implementações,
 cada item da fila será um vértice e a prioridade desse vértice será um
valor numérico, o seu potencial. As implementações foram baseadas nos
livros, Network Flows~\cite{ahuja:netflows},
Introduction to Algorithms~\cite{clr:introalg-1999}, 
The Stanford GraphBase~\cite{knuth:sgb} 
e no livro de Schrijver~\cite{sch:comb}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  HEAP
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Heap}
\label{sec:heap}

  Um \defi{heap}\index{heap} é uma estrutura de dados que mantêm uma 
 seqüência de itens, onde cada item é acessado através de um índice
 numérico. No nosso caso, os itens são vértices, que serão dispostos em
 um vetor $\L$ conforme o seu potencial. A organização dos vértices em
 $\L$ respeita a seguinte propriedade:
 \begin{propriedade}{ordem}\index{propriedade!ordem no heap}
  \label{prop:heap-ordem}
  \[ \fp(\L[\floor{i/2}]) \leq \fp(\L[i]), 
     \ \mbox{para cada posição} \  i \  
     \mbox{em} \  [2..qsize], \]  
 onde |qsize| representa o número de vértices em $\L$. 
  \end{propriedade} 

Intuitivamente, o vetor $\L$ também pode ser visto como uma árvore binária,
%~\footnote{arborescência onde cada vértice é ponta inicial
%de exatamente dois arcos.} 
onde cada posição do vetor representa um
vértice da árvore. A figura~\ref{fig:heap} ilustra essa representação.
 
 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(a)}{(a)}
    \psfrag{(b)}{(b)}
  \includegraphics{fig/heap.eps}
  \caption[{\sf Heap}]
  {\label{fig:heap} (a) um heap visto como uma árvore binária;
  (b) o mesmo heap visto como um vetor.} 
 \end{center}
 \end{figure}

@ Na implementação, o vetor $\L$ é simulado utilizando-se o campo
utilitário |x| da estrutura do \SGB{} (seção~\ref{sec:sgb}), ou seja, 
|(Q + i)->x.V| aponta para o vértice da posição |i|. Para simplificar 
a notação, |(Q + i)->x.V| é definido como |Q(i)|. 
Além do mais, se |Q(i)| aponta para o vértice |v|, então 
|v->posicao = i|.

@<Definições@>=
#define Q(i) @,@,@,@, (Q + i)->x.V
#define posicao @,@,@,@, w.I

@ @<Variáveis globais@>=
Vertex *Q;             /* heap */

@ Para criar o heap $\L$ é utilizada a função \textit{create\_heap}.
@<Filas de prioridade@>=
void 
create_heap(g) /* cria um heap vazio */
 Graph *g;
{
  register Vertex *v;

  Q = g->vertices;
  for(v = g->vertices ; v < g->vertices + g->n; v++){
    v->posicao = 0;
    v->x.V = NULL;
  }
}

@  As implementações das operações \textsf{insert, delete-min} e
\textsf{decrease-key}, são representadas pelas funções \textit{insert\_heap,
delete\_min\_heap} e \textit{decrease\_key\_heap}.
@<Filas de prioridade@>=
 void insert_heap(Vertex *v);
 Vertex *delete_min_heap();
 void decrease_key_heap(Vertex *v);

@ %Implementação da operação \textsf{insert}. 
O tempo gasto para inserir um vértice no heap é $O(1)$, 
somado ao tempo consumido pela operação |decrease_key_heap|. Essa operação
funciona como se o último vértice tivesse seu potencial alterado
(diminuído), então é necessário o reposicionamento deste vértice em
$Q$, de modo que a propriedade~\ref{prop:heap-ordem} continue sendo respeitada.
@<Filas de prioridade@>=
void 
insert_heap(v)
     Vertex *v;
{
  v->posicao = qsize + 1;
  decrease_key_heap(v);
}

@ %Implementação da operação \textsf{delete-min}.
Em um heap, o vértice com o menor potencial se encontra na
primeira posição, ou seja, em |Q(1)|. Porém, após sua remoção, é
preciso encontrar o novo vértice com potencial mínimo. No pior caso,
essa operação gasta tempo $O(\log qsize)$.
@<Filas de prioridade@>=
Vertex *
delete_min_heap ()
{
  register unsigned long p, f;
  register Vertex *v, *vmin;

  if(qsize == 0) return NULL;
  vmin = Q(1);
  v = Q(qsize);
  p = 1;
  f = p << 1; /* f = 2p */
  while(f <= (qsize-1)){
    if((f < (qsize-1)) && (Q(f)->dist > Q(f+1)->dist)) f++;
    if(Q(f)->dist >= v->dist) break;
    Q(p) = Q(f);
    Q(p)->posicao = p;
    p = f;
    f = p << 1;
  }
  Q(p) = v;
  Q(p)->posicao = p;
  return vmin;
}

@ %Implementação da operação \textsf{decrease-key}.
Diminuir o potencial de um vértice, ao visitá-lo, 
 pode tornar necessário reposicioná-lo em
$\L$, de modo que a propriedade~\ref{prop:heap-ordem} continue sendo
respeitada. 
No pior caso, essa operação gasta tempo $O(\log qsize)$.
@<Filas de prioridade@>=
void 
decrease_key_heap(v)
     Vertex *v;
{
  register unsigned long p, f;

  f = v->posicao;
  p = f >> 1; /* $\floor{f/2}$ */
  while ( (p > 0) && (Q(p)->dist > v->dist) ){
    Q(f) = Q(p);
    Q(f)->posicao = f;
    f = p;
    p = f >> 1;
  } 
  Q(f) = v;
  Q(f)->posicao = f;
}
@

\begin{lema}{operações heap}
\label{lema:operacoes-heap}
 Na implementação da fila de prioridade $Q$, utilizando um heap,
 cada operação \textsf{insert}, \textsf{delete-min} e
\textsf{decrease-key}, gasta tempo $O(\log n)$. \fimprova
\end{lema}

Portanto, do teorema~\ref{teorema:no-operacoes} e do
lema~\ref{lema:operacoes-heap}, o tempo gasto pelo
algoritmo de Dijkstra utilizando um heap, é

\[
  \underbrace{O(n \log n)}_{\mbox{\textsf{insert}}} + 
  \underbrace{O(m \log n)}_{\mbox{\textsf{decrease-key}}} +
  \underbrace{O(n \log n)}_{\mbox{\textsf{delete-min}}}
  = O(m \log n).
\]

\begin{teorema}{}
 A implementação do algoritmo de Dijkstra que utiliza um heap resolve o
 problema do caminho mínimo em um grafo com $n$ vértices e $m$ arcos
 em tempo $O(m \log n)$. \fimprova
\end{teorema}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  D-HEAP
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{\dheap}
\label{sec:dheap}

Um \defi{\dheap}\index{heap!\dheap}, assim como o heap 
(seção~\ref{sec:heap}), é uma estrutura de dados que mantêm uma
seqüência de vértices, num vetor $\L$,  dispostos de maneira organizada
em relação a função potencial, de maneira que:  
 \begin{propriedade}{ordem}\index{propriedade!ordem no \dheap}
   \label{prop:dheap-ordem}
   \[ \fp(\L[\ceil{(i-1)/\D}]) \leq \fp(\L[i]), 
      \ \mbox{para cada posição} \  i \  
      \mbox{em} \  [2..qsize], \]
  onde |qsize| representa o número de vértices em $\L$ e $\D$ é o
maior número de filhos de um vértice. 
 \end{propriedade} 

%Note que a propriedade~\ref{prop:dheap-ordem} é a mesma que
%~\ref{prop:heap-ordem} quando \D{} é igual a $2$. Ou seja, o heap é um caso
%particular do \dheap.

Intuitivamente, o vetor $\L$ pode ser visto como uma árvore, em que
cada vértice pertencente a ele pode ter no máximo \D{} filhos. A
figura~\ref{fig:dheap} ilustra a representação de um $3$-heap.

 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(a)}{(a)}
    \psfrag{(b)}{(b)}
  \includegraphics{fig/dheap.eps}
  \caption[{\sf \dheap}]
 {\label{fig:dheap} Ilustração de um $3$-heap. Em (a) o $3$-heap
é visto como uma árvore e em (b) como um vetor.} 
 \end{center}
 \end{figure}

@ Na implementação, |D| é o maior número de filhos de um vértice.
 A escolha de |D| é feita dinamicamente, em relação a
$\max\{2,\ceil{m/n}\}$. O motivo pelo qual |D| é escolhido dessa
 maneira é mostrado no final da seção.  
@<Variáveis globais@>=
unsigned long D;          /* número máximo de filhos de um vértice */

@ A função |teto(i,j)| devolve $\ceil{i/j}$. A primeira utilidade da
função é encontrar um valor para~|D|.
@<Funções ...@>=
unsigned long 
teto(i, j)
  unsigned long i; 
  unsigned long j;
{
  return ( i%j == 0 ? i/j : i/j + 1); 
}

@ Para criar o \dheap{} $\L$ é utilizada a função
\textit{create\_dheap}.
@<Filas de prioridade@>=
void 
create_dheap(g) /* cria um heap vazio */
 Graph *g;
{
  unsigned long t;
  register Vertex *v;

  Q = g->vertices;
  for(v = g->vertices ; v < g->vertices + g->n; v++){
    v->posicao = 0;
  }
  t = teto(g->m/2,g->n);  /*número de arestas é o dobro do número de arcos*/
  D = t > 2? t : 2; 
}
 

@ As implementações das operações \textsf{insert, delete-min} e
\textsf{decrease-key}, são representadas pelas funções \textit{insert\_dheap,
delete\_min\_dheap} e \textit{decrease\_key\_dheap}.
@<Filas de prioridade@>=
 void insert_dheap(Vertex *v);
 Vertex *delete_min_dheap();
 void decrease_key_dheap(Vertex *v);

@ Inserir um vértice no \dheap{} funciona de forma análoga a inserir um
vértice no heap.
@<Filas de prioridade@>=
void 
insert_dheap(v)
     Vertex *v;
{
  v->posicao = qsize + 1;
  decrease_key_dheap(v);
}

@  Assim como no heap~\ref{sec:heap}, o vértice com o menor potencial
pode ser encontrado na primeira posição, ou seja, em |Q(1)|. 
E após sua remoção, é preciso encontrar o novo vértice com potencial mínimo.  
No pior caso, essa operação gasta tempo  $O(D \log_{D} qsize)$
@<Filas de prioridade@>=
Vertex *
delete_min_dheap ()
{
  register unsigned long p, f, i, ultimo_filho;
  register Vertex *v, *vmin;

  if(qsize == 0) return NULL;
  vmin = Q(1);
  v = Q(qsize);
  p = 1;
  /*os filhos do vértice da posicão $p$, são encontrados nas posições
                     $pD - D + 2, \ldots, \min \{n, pD + 1\}$ */
  f = p*D - D + 2; 
  while(f <= (qsize-1)){
    @<Encontra filho |f| de |p| tal que $\fp(f)$ seja mínimo@>@;
    if(Q(f)->dist >= v->dist) break;
    Q(p) = Q(f);
    Q(p)->posicao = p;
    p = f;
    f = p*D - D + 2; 
  }
  Q(p) = v;
  Q(p)->posicao = p;
  return vmin;
}

@ Encontra o $\min\{Q(f)$|->|$dist\}$ para cada filho |f| de |p|.
@<Encontra filho |f| de |p| tal que $\fp(f)$ seja mínimo@>=
ultimo_filho = (qsize - 1) < p*D + 1? (qsize - 1) : p*D + 1;
for(i = f + 1; i <= ultimo_filho ; i++)
     if( Q(f)->dist  > Q(i)->dist ) 
       f = i;

@ Diminuir o potencial de um vértice, ao visitá-lo, pode tornar 
necessário   
reposicioná-lo em $\L$, de modo que a 
propriedade~\ref{prop:dheap-ordem} continue sendo respeitada.
No pior caso, essa operação gasta tempo $O(\log_{D} qsize)$.
@<Filas de prioridade@>=
void 
decrease_key_dheap(v)
     Vertex *v;
{
  register unsigned long p, f;

  f = v->posicao;
  p = teto(f-1,D);  /* pai de um vértice é encontrado na posição 
                       $\ceil{(f-1)/\D}$ */
  while ( (p > 0) && (Q(p)->dist > v->dist) ){
    Q(f) = Q(p);
    Q(f)->posicao = f;
    f = p;
    p = teto(f-1,D);
  } 
  Q(f) = v;
  Q(f)->posicao = f;
}
@ 

\begin{lema}{operações \dheap}
\label{lema:operacoes-dheap}
  Na implementação da fila de prioridade $Q$, utilizando um \dheap,
  cada operação \textsf{insert} e \textsf{decrease-key} gasta tempo
  $O(\log_{D} n)$ e a operação \textsf{delete-min} gasta tempo 
  $O(D \log_{D} n)$, onde $D = \max\{2,\ceil{m/n}\}$. \fimprova
\end{lema}

Portanto, do teorema~\ref{teorema:no-operacoes} e do
lema~\ref{lema:operacoes-dheap}, o tempo gasto pelo
algoritmo de Dijkstra utilizando um \dheap, é

\[
  \underbrace{O(n \log_{D} n)}_{\mbox{\textsf{insert}}} + 
  \underbrace{O(m \log_{D} n)}_{\mbox{\textsf{decrease-key}}} +
  \underbrace{O(nD \log_{D} n)}_{\mbox{\textsf{delete-min}}}
  = O(m \log_{D} n).
\]

Note que o valor escolhido para |D| na implementação é ótimo, 
pois para grafos esparsos, isto é, quando $m = O(n)$, o tempo gasto é 
$O(n \log n)$,  e para grafos não-esparsos, isto é, quando 
$m = \Omega(n^{1 + \epsilon})$ para algum $\epsilon > 0$, o tempo gasto é  
$O(m \log_{D} n) = O((m \log n)/(\log D)) = O((m \log n)/(\log n^{\epsilon})) = 
O((m \log n)/(\epsilon \log n)) = O(m/\epsilon) = O(m)$. 
A última igualdade é verdadeira desde que $\epsilon$ seja uma
constante. Portanto, o tempo gasto é $O(m)$ que é ótimo.

\begin{teorema}{}
 A implementação do algoritmo de Dijkstra que utiliza um \dheap{} resolve o
 problema do caminho mínimo em um grafo com $n$ vértices e $m$ arcos
 em tempo $O(m \log_{D} n)$. \fimprova
\end{teorema}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  FIBONACCI HEAP
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Fibonacci heap}
\label{sec:fibonacci}

 Um \defi{fibonacci heap}\index{heap!fibonacci} é um conjunto de
 arborescências que respeitam as seguintes propriedades: 
 \begin{propriedade}{ordem}\index{propriedade!ordem no
 fibonacci heap}
 \label{prop:ordem-fheap}
  Para cada par $(p,f)$, em uma mesma arborescência, onde $p$ é o 
pai do vértice $f$, $\fp(p) \leq \fp(f)$ (análoga a propriedade~\ref{prop:heap-ordem}).
 \end{propriedade}

 \begin{propriedade}{descendentes}\index{propriedade!número de
  descendentes de um vértice no fibonacci heap}
  \label{prop:descendentes}
  Para cada vértice $p$, os filhos de $p$ podem ser ordenados de maneira que 
 o $i$-ésimo filho tenha pelo menos $i-2$ filhos. 
 \end{propriedade}

 Dizemos que o \defi{grau}\index{grau de um vértice} de um vértice é
 o seu número de filhos.
 Como conseqüência da propriedade~\ref{prop:descendentes} pode-se
 notar que todo vértice de grau $k$  
 possui pelo menos $F_{k+2}$ descendentes (incluindo ele mesmo),
onde $F_k$ é o número de fibonacci, 
  \[ F_{k} = \left\{ 
             \begin{array}{ll}
             0 & \mbox{if $k = 0$ }\\
             1 & \mbox{if $k = 1$ }\\
             F_{k-1} + F_{k-2} & \mbox{if $k \geq 2$ }
             \end{array}
             \right.\]
 \begin{center} ou \end{center}
\[F_{k+2} = 1 + \sum_{i=0}^{k} F_{i}. \]
dando a entender a origem do nome fibonacci heap.
 
 A implementação de um fibonacci heap é feita através de uma lista
ligada $\L$, como ilustrada na figura~\ref{fig:fibonacci}.
 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(a)}{(a)}
    \psfrag{(b)}{(b)}
  \includegraphics{fig/fibonacci.eps}
  \caption[{\sf Fibonacci heap}]
 {\label{fig:fibonacci} Em (a)~é exibido um fibonacci heap composto por
 três arborescências. A linha pontilhada enfatiza o fato do fibonacci
heap ser formado pelo conjunto das arborescências. Em
 (b)~é ilustrada a representação em forma de lista, mostrando os
ponteiros da estrutura.} 
 \end{center}
 \end{figure}


% \begin{lema}{número máximo de filhos}
% Todo vértice num fibonacci Heap tem no máximo $1 + 2\log n$ filhos.
%\end{lema}
%\begin{prova}
%\end{prova}


@ A lista $\L$ pode ser dividida em dois tipos de listas:
 (1) (|root|) uma lista formada pelas raízes das
 arborescências; e
 (2) (|child|) lista formada por filhos de um mesmo vértice.
Cada vértice num fibonacci heap contém sete campos, que são: 
 ponteiros |pai|, |filho|, |direita|, |esquerda|, que representam
listas duplamente ligadas circulares (lista |root| e |child|);
|grau_marca|, que guarda o número $2*grau + marca$, onde o 
|grau| é o grau do vértice e |marca| tem valor $1$ se o vértice
(exceto o raiz) já perdeu algum filho, e $0$ caso contrário.
Os campos |predecessor| ($\psi$) e |dist| ($\fp$) são os mesmos utilizados
anteriormente.
 Note que a estrutura Vertex do \SGB{} tem seis
campos utilitários. Então, para implementar o fibonacci heap foi
redefinida a estrutura \tipo{Vertex} do \SGB{} para sete campos. \normalsize

@<Definições@>=
#define pai @,@,@,@, t.V
#define filho @,@,@,@, w.V
#define direita @,@,@,@, y.V
#define esquerda @,@,@,@, z.V
#define grau_marca @,@,@,@, x.I

@ As funções a seguir são responsáveis por inserir e remover vértices
de uma lista. A função |insere_na_lista| insere na lista |l| o vértice
|v| e a função |remove_da_lista| remove o vértice |v| da lista.
@<Funções ...@>=
void 
insere_na_lista(l, v)
     Vertex *l;
     Vertex *v;
{
  v->direita = l->direita;
  (l->direita)->esquerda = v;
  v->esquerda = l;
  l->direita = v;
}

void
remove_da_lista(v)
     Vertex *v;
{
  (v->esquerda)->direita = v->direita;
  (v->direita)->esquerda = v->esquerda;
}

@ Para criar o fibonacci heap $\L$ é utilizada a função
\textit{create\_fheap}.
@<Filas de prioridade@>=
void 
create_fheap(g)
 Graph *g;
{
  register Vertex *v;  
  
  Q = NULL;
  for(v = g->vertices ; v < g->vertices + g->n; v++){
    v->direita = v->esquerda = v;
    v->grau_marca = 0; 
    v->pai = v->filho = NULL;
  }
}

@ As implementações das operações \textsf{insert, delete-min} e
\textsf{decrease-key} são representadas pelas funções \textit{insert\_fheap,
delete\_min\_fheap} e \textit{decrease\_key\_fheap}.
@<Filas de prioridade@>=
 void insert_fheap(Vertex *v);
 Vertex *delete_min_fheap();
 void decrease_key_fheap(Vertex *v);

@ Inserir um vértice no fibonacci heap significa colocá-lo na lista
|root|.  No pior caso, essa operação gasta tempo  $O(1)$.
@<Filas de prioridade@>=
void 
insert_fheap(v)
     Vertex *v;
{
  if(Q == NULL){
    Q = v;
  }
  else{
    insere_na_lista(Q,v);     /* insere |v| na lista |root| */
    if(v->dist < Q->dist) Q = v;
  }
}

@ O vértice com o menor potencial no fibonacci heap se encontra na
primeira posição, ou seja, |Q| aponta para o vértice com potencial
mínimo. Remover esse vértice implica em
adicionar seus filhos à lista |root|, e em seguida é necessário
utilizar o bloco |@<Consolidate@>|, para atualizar o número de
arborescências
e encontrar o novo vértice com potencial mínimo.
Essa operação gasta tempo amortizado $O(\log qsize)$. 
@<Filas de prioridade@>=
Vertex *
delete_min_fheap()
{
  register Vertex *min, *f, *v, *x, *y, *aux;
  register Vertex **A;
  register long i, d, Dn;

  min = Q;
  if(min != NULL){   
    f = min->filho;
    while(f != NULL){ /* se |min| tem filhos */
     /* para cada filho |v| de |min| */
        v = f;
        f = f->direita;
        if( v == f) f = NULL;
        remove_da_lista(v);  /* remove |v| da lista |child| */      
        insere_na_lista(Q,v); /* insere |v| na lista |root| */
        v->pai = NULL;
    }
    remove_da_lista(min); /* remove |min| da lista |root| */ 
        
    if(min->direita == min) Q = NULL;
    else{
      Q = Q->direita;
      @<Consolidate@>@;
    }
  }
  return min;
}

@ O bloco |@<Consolidate@>| é responsável por reduzir o número de raízes de $\L$, ou
seja, reduzir o número de arborescências. Ele consiste em 
executar repetidamente os seguintes passos, até que todo vértice 
da lista |root| tenha graus distintos:
\begin{enumerate}[(1)]
\item encontre duas raízes |x| e |y| na lista |root| com o mesmo
grau. Supõe-se que |x->dist| $\leq$ |y->dist|; e
\item junte (link) |y| a |x|, removendo |y| da lista |root|, e
adicionando |y| como um filho de |x|.
\end{enumerate}
A operação (2) é feita em |@<Link arborescência |y| com a arborescência |x|@>|
@<Consolidate@>=
  Dn = 1 + 8*sizeof(long);  /* 1+log(n): número máximo de arborescências */
  if( (A = (Vertex **)malloc(Dn*sizeof(Vertex*))) == NULL){
      printf("%s\n", err_message[ERROR_2]); exit(0);
  }
  for(i = 0; i < Dn; i++) /* $A[d]$ guarda vértices de grau $d$ */ 
    A[i] = NULL;

  v = Q;
  do{
    x = v;
    v = v->direita;

    if(x == v) v = NULL;
    remove_da_lista(x);      /* remove |x| da lista |root| */
  
    d = (int)x->grau_marca/2;  /* $2*grau + marca$ */
    while((d < Dn) && (A[d] != NULL)){
      y = A[d];
      if(x->dist > y->dist){
        aux = x;
        x = y;
        y = aux;
      }
      @<Link arborescência |y| com a arborescência |x|@>@;
      A[d] = NULL;
      d++;
    }
    A[d] = x->direita = x->esquerda = x;
  }while( v != NULL);

  Q = NULL;
  for(i = 0; i < Dn; i++){
    if(A[i] != NULL){
      if(Q == NULL) Q = A[i]->direita = A[i]->esquerda = A[i];
      else{
        insere_na_lista(Q,A[i]);  /* adiciona A[i] na lista de root */
        if( A[i]->dist < Q->dist)
          Q = A[i];
      }
    }
  }
  free(A);

@ @<Link arborescência |y| com a arborescência |x|@>=
  remove_da_lista(y);  /* remove |y| da lista |root| */
  f = x->filho;
  if( f ){
    insere_na_lista(f,y);   /* insere |y| como filho de |x| */
  }
  else x->filho = y->esquerda = y->direita = y;
  y->pai = x;
  x->grau_marca += 2;
  y->grau_marca = (y->grau_marca >> 1) << 1; /* parte inteira da divisão por $2$ e \\
  						depois multiplicada por $2$ */

@ Diminuir o potencial de um vértice |v|, ao visitá-lo, pode tornar 
necessário reposicioná-lo em $\L$, de modo que as
propriedades~\ref{prop:ordem-fheap} e~\ref{prop:descendentes} 
continuem sendo respeitadas. Isso é feito chamando-se 
 |@<Remove |v| da lista de filhos de |p|@>|, onde |p| é o pai de |v|.
 Caso |p| esteja perdendo um segundo filho, ainda é necessário chamar a 
função \textit{cascading\_cut} para garantir a propriedade~\ref{prop:descendentes}.
Essa operação gasta tempo amortizado $O(1)$. 
@<Filas de prioridade@>=
void 
decrease_key_fheap(v)
     Vertex *v;
{
  register Vertex *p;

  p = v->pai;
  if( (p != NULL) && (v->dist < p->dist)){
    @<Remove |v| da lista de filhos de |p|@>@;
    cascading_cut(p);
  }
  if (v->dist < Q->dist)
    Q = v;
}

@ @<Remove |v| da lista de filhos de |p|@>=
  if(v->direita == v) p->filho = NULL;
  else{
    if(p->filho == v) p->filho = (p->filho)->direita;
    remove_da_lista(v);  /* remove |v|  da lista de filhos de |p| */
  }
  /* decrementa o grau de p */
  p->grau_marca -= 2;
  insere_na_lista(Q,v);    /* adiciona |v| na lista |root| */
  v->pai = NULL;
  
  v->grau_marca = (v->grau_marca >> 1) << 1; /* parte inteira da divisão por $2$ e \\
  						depois multiplicada por $2$ */

@ A função |cascading_cut| repete o processo de |@<Remove |v| da lista
de filhos de |p|@>| até
encontrar um vértice que ainda não tenha perdido nenhum filho.
@<Funções ...@>=
void 
cascading_cut(v)
     Vertex *v;
{
  register Vertex *p;
  p = v->pai;
  if(p != NULL){
    if( v->grau_marca%2 == 0)
      v->grau_marca++;
    else{
      @<Remove |v| da lista de filhos de |p|@>@;
      cascading_cut(p);
    } 
  }
}
@ 

\begin{lema}{operações fibonacci heap}
\label{lema:operacoes-fheap}
   Na implementação da fila de prioridade $Q$, utilizando um fibonacci
 heap, as operações \textsf{insert} e \textsf{decrease-key} gastam
 tempo amortizado $O(1)$ e a operação \textsf{delete-min} gasta tempo
 amortizado $O( \log n)$. \fimprova
\end{lema}

Portanto, do teorema~\ref{teorema:no-operacoes} e do
lema~\ref{lema:operacoes-fheap}, o tempo gasto pelo
algoritmo de Dijkstra utilizando um fibonacci heap, é
\[
  \underbrace{O(n)}_{\mbox{\textsf{insert}}} + 
  \underbrace{O(m)}_{\mbox{\textsf{decrease-key}}} +
  \underbrace{O(n \log n)}_{\mbox{\textsf{delete-min}}}
  = O(m + n \log n).
\]

\begin{teorema}{}
 A implementação do algoritmo de Dijkstra que utiliza um fibonacci
heap resolve o problema do caminho mínimo em um grafo com $n$ vértices
e $m$ arcos  em tempo $O(m + n \log n)$. \fimprova
\end{teorema}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  Bucket heap
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Bucket heap}
\label{sec:bucket-heap}

Um \defi{bucket heap}\index{heap!bucket} é uma estrutura de dados que
mantêm uma seqüência de vértices num vetor $Q$ de listas ligadas. 
 Para cada posição $k$ do vetor, $Q(k)$ é uma lista ligada de
 vértices. Em cada $Q(k)$, são mantidos os vértices com potencial igual
a $k$\footnote{Note que a ordem entre os vértices em $Q(k)$ não é importante}.

 Observe que $nC$, onde $C$ é o comprimento do maior arco,
 é um limitante superior para qualquer distância no grafo.  
 Portanto, são necessários no máximo $nC + 1$ buckets, já que as distâncias 
podem variar de $0$ a $nC$.
Porém, é possível diminuir o número de buckets para $C + 1$. Observe que:
(1) $\fp(u) \leq \fp(v)$ para cada vértice $u$ em $S$ e $v$ em $\L$
(invariante (dk3)); e
(2) para cada vértice $w$ em $\L$, $\fp(w) = \fp(u) + c(u,w)$ para
algum vértice $u$ em $S$ (invariantes (dk4) e (dk12)). Portanto, de (1)
e (2), $\fp(w) = \fp(u) + c(u,w) \leq \fp(u) + C$, onde $u$ é o vértice escolhido 
no caso 2 do algoritmo de Dijkstra.
 Em outras palavras, toda 
distância tentativa é limitada inferiormente por $\fp(u)$, e
superiormente por $\fp(u) + C$. Conseqüentemente, $C + 1$ buckets são
 suficientes. Resultando na seguinte propriedade.

 \begin{propriedade}{ordem}\index{propriedade!ordem no
 bucket heap}
 \label{prop:bkheap}
  Cada bucket $Q(k \mod (C+1))$ mantêm os vértices com potencial
igual a $k$, onde $C$ é o comprimento do maior arco.
 \end{propriedade}

 Os $C+1$ buckets, numerados de $[0..C]$, simulam as $nC + 1$ posições
 funcionando de maneira circular. A figura~\ref{fig:bkheap} ilustra a
 organização dos buckets.
 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(a)}{(a)}
    \psfrag{(b)}{(b)}
    \psfrag{C}{{\footnotesize $C$}}
    \psfrag{C-1}{{\footnotesize $C - 1$}}
    \psfrag{k}{{\footnotesize $k$}}
    \psfrag{k-1}{{\footnotesize $k - 1$}}
    \psfrag{0}{{\footnotesize $0$}}
    \psfrag{1}{{\footnotesize $1$}}
    \psfrag{2}{{\footnotesize $2$}}
    \psfrag{3}{{\footnotesize $3$}}
    \psfrag{k mod c+1}{\scriptsize $k \mod (C+1)$}
  \includegraphics{fig/dial.eps}
  \caption[{\sf Buckets}]
  {\label{fig:bkheap} A figura (a) enfatiza a organização circular
 dos buckets. (b) mostra que o bucket $k \mod (C+1)$
 guarda o vértice com potencial $k$.}
 \end{center}
 \end{figure}


@ O ponteiro |pos_corrente| indica a posição do bucket que está sendo visitada.
@<Definições@>=
#define pos_corrente @,@,@,@, w.I

@ Para criar o bucket heap $Q$ é utilizada a função
\textit{create\_bkheap}. Redefinimos $Q(k)$ (a definição anterior
está seção~\ref{sec:heap}), de modo que seja o cabeça de lista do
bucket $k$.
@<Filas de prioridade@>=
#undef Q
#define Q(k) (Q + k)
void
create_bkheap(g)
 Graph *g;
{
  register unsigned long i;
  register Vertex *v;
  
  if( (Q = (Vertex *)malloc((C+1)*sizeof(Vertex))) == NULL){
    printf("%s\n", err_message[ERROR_2]); exit(0);
  }
  for(i = 0; i < C + 1; i++){
    Q(i)->direita = Q(i)->esquerda = Q(i); /* endereço $Q+i$ */
  }
  for(v = g->vertices; v < g->vertices + g->n; v++){
    v->direita = v->esquerda = v;
  }
  Q->pos_corrente = 0;
} 

@ As implementações das operações \textsf{insert, delete-min} e
\textsf{decrease-key} são representadas pelas funções \textit{insert\_bkheap,
delete\_min\_bkheap} e \textit{decrease\_key\_bkheap}.
@<Filas de prioridade@>=
 void insert_bkheap(Vertex *v);
 Vertex *delete_min_bkheap();
 void decrease_key_bkheap(Vertex *v);

@  Como a implementação é feita usando $C+1$ buckets, cada vértice |v|
é inserido na posição |v->dist|~$\mod (C+1)$.
Essa operação gasta tempo $O(1)$.
@<Filas de prioridade@>=
void 
insert_bkheap(v)
     Vertex *v;
{
  register unsigned long k;

  k = v->dist%(C+1);
  insere_na_lista(Q(k), v);  
}

@ O vértice com o menor potencial pode ser encontrado na primeira
posição não-vazia de $Q$.
No pior caso, essa operação gasta tempo $O(C)$. 
@<Filas de prioridade@>=
Vertex *
delete_min_bkheap()
{
  register unsigned long k;
  Vertex *u;
  
  /* procura o primeiro bucket não-vazio */
  for(k = Q->pos_corrente; Q(k) == Q(k)->direita; k = ++k%(C+1));
  Q->pos_corrente = k;

  u = Q(k)->direita;
  remove_da_lista(u);
  return u;
} 

@ Diminuir o potencial de um vértice, ao visitá-lo, pode tornar 
necessário  reinseri-lo em $\L$, de modo que a 
propriedade~\ref{prop:bkheap} continue sendo respeitada. 
Essa operação gasta tempo $O(1)$.
@<Filas de prioridade@>=
void 
decrease_key_bkheap(v)
     Vertex *v;
{
  remove_da_lista(v);
  insert_bkheap(v);
}
@

\begin{lema}{operações bucket heap}
\label{lema:operacoes-bkheap}
  Na implementação da fila de prioridade $Q$ utilizando um bucket
 heap, as operações \textsf{insert} e \textsf{decrease-key} gastam tempo $O(1)$
 e \textsf{delete-min} gasta tempo $O(C)$. \fimprova
\end{lema}

Portanto, do teorema~\ref{teorema:no-operacoes} e do
lema~\ref{lema:operacoes-bkheap}, o tempo gasto pelo
algoritmo de Dijkstra utilizando um bucket heap, é
\[
  \underbrace{O(n)}_{\mbox{\textsf{insert}}} + 
  \underbrace{O(m)}_{\mbox{\textsf{decrease-key}}} +
  \underbrace{O(nC)}_{\mbox{\textsf{delete-min}}}
  = O(m + nC).
\]

\begin{teorema}{}
 A implementação do algoritmo de Dijkstra que utiliza um bucket heap
resolve o problema do caminho mínimo em um grafo com $n$ vértices
e $m$ arcos em tempo $O(m + nC)$, onde $C$ é o maior comprimento de um
arco. \fimprova
\end{teorema}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  RADIX HEAP
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Radix heap}

Um \defi{radix heap}\index{heap!radix}, assim como um bucket
heap (seção~\ref{sec:bucket-heap}), é uma estrutura de dados que mantêm uma
seqüência de vértices, num vetor $Q$, onde para cada posição $k$, $Q(k)$ é uma
lista ligada de vértices. Porém, em vez de manter somente vértices com potencial
$k$ na $(k mod (C+1))$-ésima posição do bucket, são mantidos os vértices com
potencial em um determinado intervalo.  Na implementação
 do radix heap, os intervalos são consecutivos e têm largura  
$1, 1, 2, 4, 8, 16, \ldots$ . Logo, 
 \[ \begin{array}{l}
     range(0) =  [0] \\
     range(1) =  [1] \\
     range(2) =  [2..3] \\
     range(3) =  [4..7] \\
     range(4) =  [8..15] \\
     range(K) =  [2^{K-1}..2^{K}-1] \\
    \end{array}
 \]
onde $K = \ceil{\log (nC)}$ e      
 $range(k)$ é o intervalo do bucket $Q(k)$. Portanto, o número de buckets necessários é
$1 + K$. 

 \begin{propriedade}{ordem}\index{propriedade!ordem no
 radix heap}
 \label{prop:rxheap}
  Se $range(k)$ é o intervalo do bucket $Q(k)$, então $Q(k)$ mantêm os vértices  
 com potencial em $range(k)$.
 \end{propriedade}

 Os intervalos dos buckets mudam dinamicamente durante a execução
do algoritmo, rearranjando-se de forma que os vértices com menor
potencial fiquem nos buckets de largura $1$. Por exemplo, supondo que 
o primeiro bucket não-vazio é o $Q(4)$, inicialmente, 
seu respectivo intervalo é $[8..15]$, que é maior do que $1$. 
Então, é necessário fazer a redistribuição dos intervalos da seguinte maneira. 
   \[ \begin{array}{l}
     range(0) =  [8] \\
     range(1) =  [9] \\
     range(2) =  [10..11] \\
     range(3) =  [12..15] \\
     range(4) = \emptyset \\
    \end{array}
 \]
E também, é necessário redistribuir os vértices pertencentes a $Q(4)$ nos 
buckets $Q(0)$ , $Q(1)$, $Q(2)$ e $Q(3)$, assim os vértices que podem
ser examinados estão sempre em $Q(0)$ e $Q(1)$.

@ Na implementação, é suficiente guardar apenas o valor inicial do
intervalo. Esse valor é mantido em |range| e cada vértice |v| será inserido
no bucket |Q(bucket)|.
@<Definições@>=
#define range @,@,@,@, w.I
#define bucket @,@,@,@, x.I

@ A função |log2(x)| calcula o $\floor{\log_2 x}$ para $x \geq 1$.
@<Funções ...@>=
int 
log2(x)
unsigned long x;
{
  register int lg = -1;
  do{
    x = x >> 1;
    lg++;
  }while(x);
 
  return lg;
}

@ Para criar o radix heap $Q$ é utilizada a função |create_rxheap|.
@<Filas de prioridade@>=
void 
create_rxheap(g)
 Graph *g;
{
  register int i, K, range_len;
  register Vertex *v;

  K = log2(infinito) + 1; /* número máximo de buckets */
  if((Q = (Vertex *)malloc((1+K)*sizeof(Vertex))) == NULL){
    printf("%s\n", err_message[ERROR_2]); exit(0);
  }
  Q(0)->direita = Q(0)->esquerda = Q(0);
  Q(0)->range = 0;
  for(i = range_len = 1; i <= K; i++){ 
    Q(i)->direita = Q(i)->esquerda = Q(i);
    Q(i)->range = Q(i-1)->range + range_len; 
    if( i != 1 ) range_len <<= 1; /* |range_len = range_len*2| */
  }
  for(v = g->vertices; v < g->vertices + g->n; v++){
    v->direita = v->esquerda = v;
    v->bucket = K;     /* indica que |v| está em |Q(K)| */
  }
}

@ As implementações das operações \textsf{insert, delete-min} e
\textsf{decrease-key} são representadas pelas funções \textit{insert\_rxheap,
delete\_min\_rxheap} e \textit{decrease\_key\_rxheap}.
@<Filas de prioridade@>=
 void insert_rxheap(Vertex *v);
 Vertex *delete_min_rxheap();
 void decrease_key_rxheap(Vertex *v);

@ A inserção dos vértices é feita respeitando-se os intervalos.
No pior caso, essa operação gasta tempo $O(\log (nC))$.
@<Filas de prioridade@>=
void 
insert_rxheap(v)
     Vertex *v;
{
  register unsigned long k;

  for(k = v->bucket; k > 0 ; k--){   /* encontra o bucket para inserir |v| */
   if(v->dist >= Q(k)->range) break;
  }
  v->bucket = k; 
  insere_na_lista(Q(k), v);
}

@ O vértice com o menor potencial é encontrado em $Q(0)$ ou $Q(1)$. 
Caso não haja vértices nessas posições é necessário fazer a
redistribuição dos intervalos, e reinserir os vértices nos buckets
corretos. No pior caso, essa operação gasta tempo  $O(\log (nC))$.
@<Filas de prioridade@>=
Vertex *
delete_min_rxheap()
{
  register unsigned long range_len, k, i, min;
  register Vertex *u;

  if ( (Q(0) == Q(0)->direita) && (Q(1) == Q(1)->direita) ){
    @<Encontra a posição $k$ do primeiro bucket não-vazio@>@;
    @<Encontra o valor do menor potencial em |Q(k)|@>@;
    @<Redistribui os intervalos@>@;
  }
  k = (Q(0) == Q(0)->direita) ? 1 : 0;
  u =  Q(k)->direita;
  remove_da_lista(u);
  return u;
}

@
@<Encontra a posição $k$ do primeiro bucket não-vazio@>=
for(k = 2; Q(k)->direita == Q(k) ; k++);

@ @<Encontra o valor do menor potencial em |Q(k)|@>=
for(u = Q(k)->direita, min = infinito; u != Q(k); u = u->direita)
     if(u->dist < min) min = u->dist;

@
@<Redistribui os intervalos@>=
Q(0)->range = min;
for(range_len = i = 1; i <= k - 1; i++){
  Q(i)->range = Q(i-1)->range + range_len;
  if(i != 1 ) range_len <<= 1;
}
/* o $k$-ésimo intervalo fica vazio */
Q(k)->range = infinito;
@<Remove e distribui os vértices de |Q(k)| nos buckets anteriores@>@;

@ 
@<Remove e distribui os vértices de |Q(k)| nos buckets anteriores@>=
for(u = Q(k)->direita; Q(k) != u; u = Q(k)->direita){
  remove_da_lista(u);
  i = u->dist - Q(0)->range;
  u->bucket = (i == 0) ? 0 : log2(i) + 1;
  insert_rxheap(u);
}

@ Diminuir o potencial de um vértice, ao visitá-lo, pode tornar 
necessário  reinseri-lo em $\L$, de modo que a 
propriedade~\ref{prop:rxheap} continue sendo respeitada. 
Essa operação gasta tempo $O(1)$, pois o tempo gasto por 
|insert_rxheap|, já inclui as reinserções dos vértices.
@<Filas de prioridade@>=
void 
decrease_key_rxheap(v)
     Vertex *v;
{
  remove_da_lista(v);
  insert_rxheap(v);
}
@  

\begin{lema}{operações radix heap}
\label{lema:operacoes-rxheap}
  Na implementação da fila de prioridade $Q$, utilizando um radix
 heap, as operações \textsf{insert} e \textsf{delete-min} gastam 
 tempo $O(\log (nC))$ e a operação \textsf{decrease-key} gasta tempo
 $O(1)$.
\fimprova
\end{lema}

Portanto, do teorema~\ref{teorema:no-operacoes} e do
lema~\ref{lema:operacoes-rxheap}, o tempo gasto pelo
algoritmo de Dijkstra utilizando um radix heap, é
\[
  \underbrace{O(n \log (nC))}_{\mbox{\textsf{insert}}} + 
  \underbrace{O(m)}_{\mbox{\textsf{decrease-key}}} +
  \underbrace{O(n \log (nC))}_{\mbox{\textsf{delete-min}}}
  = O(m + n \log (nC)).
\]

\begin{teorema}{}
 A implementação do algoritmo de Dijkstra que utiliza um radix heap
resolve o problema do caminho mínimo em um grafo com $n$ vértices
e $m$ arcos em tempo $O(m + n \log (nC))$, onde $C$ é o maior
 comprimento de um arco. \fimprova
\end{teorema}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  RESUMO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Eficiência}
\label{sec:eficiencia-fp}

A figura~\ref{tab:tempo-fp} resume o que foi visto neste capítulo, com
relação aos tempos gasto para cada implementação de $Q$. No 
 fibonacci heap, o tempo gasto é amortizado.
\begin{figure}[htb]
  \centering
  \begin{tabular}{^^7cl^^7c^^7cc^^7cc^^7cc^^7cc^^7cc^^7c}\hline
   & heap & \dheap & fibonacci heap & bucket heap & radix heap\\\hline\hline
\textsf{insert}      & $O(\log n)$& $O(\log_{D} n)$
  &$O(1)$&$O(1)$&$O(\log (nC))$ \\\hline
\textsf{delete-min}  & $O(\log n)$& $O(D \log_{D} n)$ &$O(\log n)$&$O(C)$&$O(\log (nC))$\\\hline
\textsf{decrease-key}& $O(\log n)$& $O(\log_{D} n)$ &$O(1)$&$O(1)$&$O(1)$
  \\ \hline \hline
   Dijkstra & $O(m \log n)$ & $O(m\log_{D} n)$ &$O(m + n \log n)$&$O(m
  + nC)$&$O(m +n\log (nC))$ \\ \hline 
  \end{tabular}
  \caption[{\sf Eficiência das implementações de uma fila de prioridade}]
 {Eficiência das implementações de uma fila de prioridade.}
 \label{tab:tempo-fp}
  \end{figure}




