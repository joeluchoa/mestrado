\chapter{Implementa��es de Filas de Prioridade}
\label{cap:implementacao-fila-prioridade}
O algoritmo de Dijkstra, segundo o teorema~\ref{teorema:no-operacoes}, 
realiza uma seq��ncia de $n$ \textsf{insert}, $n$ \textsf{delete-min}
e no m�ximo $m$ \textsf{decrease-key} opera��es, em um grafo com $n$
v�rtices e $m$ arcos. Logo, o consumo de tempo do algoritmo de Dijkstra
pode variar conforme a implementa��o de cada uma dessas opera��es da
fila de prioridade.

 % Logo, para melhorar a complexidade desse algoritmo
 %� preciso ``acelerar'' o processo de escolher o v�rtice com o menor
 %potencial.

 %Uma maneira de se fazer isso � guardar os v�rtices de maneira organizada, tal
 %que, encontrar o v�rtice com o menor potencial seja r�pido, e ainda 
 %n�o gaste muito tempo para examinar os arcos. Isso pode ser feito
 %fazendo-se uso da uma fila de prioridade.
 
Existem muitos trabalhos envolvendo implementa��es de filas de
 prioridade com o intuito de reduzir o tempo gasto pelo algoritmo 
de Dijkstra. Para citar alguns bons exemplos temos
~\cite{ahuja:radixheap, boris:buckets, FredTarjan:Fibonacci}.

% Como visto na se��o~\ref{sec:filadeprioridade}, uma fila de prioridade
% � um tipo abstrato de dados que consiste de uma cole��o de itens,
% cada um, com um valor ou prioridade associada. Nesta disserta��o, as
% estruturas de dados utilizadas para implementar filas de prioridade,
% utilizam v�rtices para representar os itens e fun��es potencial para
% representar o valor associado a cada item. Cada implementa��o,
% envolve a codifica��o, em \CWEB, das opera��es insert, delete-min e
% decrease-key. 

 As estruturas de dados utilizadas na implementa��o das filas de
prioridade podem ser divididas em duas categorias, conforme as
opera��es elementares utilizadas:
\begin{enumerate}[(1)]
\item (modelo de compara��o) estruturas baseadas em compara��es; e
\item (modelo RAM) estruturas baseadas em ``bucketing''.
\end{enumerate}

\defi{Bucketing}\index{bucketing} � um m�todo de
 organiza��o dos dados que particiona um conjunto em partes chamadas
 \defi{buckets}\index{bucket}. No que diz respeito ao algoritmo de
 Dijkstra, cada bucket agrupa v�rtices de um grafo relacionados
 atrav�s de prioridades, que nesse caso, s�o os potenciais.

 Neste cap�tulo, s�o descritas as implementa��es das estruturas de dados 
\textit{heap, \dheap} e \textit{fibonacci heap} que s�o baseadas em
compara��es e as estruturas
\textit{bucket heap}\footnote{Na literatura, a implementa��o do
 algoritmo que utiliza buckets � conhecida como implementa��o de
Dial~\cite{dial:buckets}.}
e \textit{radix heap} que trabalham no modelo RAM. Nas implementa��es,
 cada item da fila ser� um v�rtice e a prioridade desse v�rtice ser� um
valor num�rico, o seu potencial. As implementa��es foram baseadas nos
livros, Network Flows~\cite{ahuja:netflows},
Introduction to Algorithms~\cite{clr:introalg-1999}, 
The Stanford GraphBase~\cite{knuth:sgb} 
e no livro de Schrijver~\cite{sch:comb}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  HEAP
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Heap}
\label{sec:heap}

  Um \defi{heap}\index{heap} � uma estrutura de dados que mant�m uma 
 seq��ncia de itens, onde cada item � acessado atrav�s de um �ndice
 num�rico. No nosso caso, os itens s�o v�rtices, que ser�o dispostos em
 um vetor $\L$ conforme o seu potencial. A organiza��o dos v�rtices em
 $\L$ respeita a seguinte propriedade:
 \begin{propriedade}{ordem}\index{propriedade!ordem no heap}
  \label{prop:heap-ordem}
  \[ \fp(\L[\floor{i/2}]) \leq \fp(\L[i]), 
     \ \mbox{para cada posi��o} \  i \  
     \mbox{em} \  [2..qsize], \]  
 onde |qsize| representa o n�mero de v�rtices em $\L$. 
  \end{propriedade} 

Intuitivamente, o vetor $\L$ tamb�m pode ser visto como uma �rvore bin�ria,
%~\footnote{arboresc�ncia onde cada v�rtice � ponta inicial
%de exatamente dois arcos.} 
onde cada posi��o do vetor representa um
v�rtice da �rvore. A figura~\ref{fig:heap} ilustra essa representa��o.
 
 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(a)}{(a)}
    \psfrag{(b)}{(b)}
  \includegraphics{fig/heap.eps}
  \caption[{\sf Heap}]
  {\label{fig:heap} (a) um heap visto como uma �rvore bin�ria;
  (b) o mesmo heap visto como um vetor.} 
 \end{center}
 \end{figure}

@ Na implementa��o, o vetor $\L$ � simulado utilizando-se o campo
utilit�rio |x| da estrutura do \SGB{} (se��o~\ref{sec:sgb}), ou seja, 
|(Q + i)->x.V| aponta para o v�rtice da posi��o |i|. Para simplificar 
a nota��o, |(Q + i)->x.V| � definido como |Q(i)|. 
Al�m do mais, se |Q(i)| aponta para o v�rtice |v|, ent�o 
|v->posicao = i|.

@<Defini��es@>=
#define Q(i) @,@,@,@, (Q + i)->x.V
#define posicao @,@,@,@, w.I

@ @<Vari�veis globais@>=
Vertex *Q;             /* heap */

@ Para criar o heap $\L$ � utilizada a fun��o \textit{create\_heap}.
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

@  As implementa��es das opera��es \textsf{insert, delete-min} e
\textsf{decrease-key}, s�o representadas pelas fun��es \textit{insert\_heap,
delete\_min\_heap} e \textit{decrease\_key\_heap}.
@<Filas de prioridade@>=
 void insert_heap(Vertex *v);
 Vertex *delete_min_heap();
 void decrease_key_heap(Vertex *v);

@ %Implementa��o da opera��o \textsf{insert}. 
O tempo gasto para inserir um v�rtice no heap � $O(1)$, 
somado ao tempo consumido pela opera��o |decrease_key_heap|. Essa opera��o
funciona como se o �ltimo v�rtice tivesse seu potencial alterado
(diminu�do), ent�o � necess�rio o reposicionamento deste v�rtice em
$Q$, de modo que a propriedade~\ref{prop:heap-ordem} continue sendo respeitada.
@<Filas de prioridade@>=
void 
insert_heap(v)
     Vertex *v;
{
  v->posicao = qsize + 1;
  decrease_key_heap(v);
}

@ %Implementa��o da opera��o \textsf{delete-min}.
Em um heap, o v�rtice com o menor potencial se encontra na
primeira posi��o, ou seja, em |Q(1)|. Por�m, ap�s sua remo��o, �
preciso encontrar o novo v�rtice com potencial m�nimo. No pior caso,
essa opera��o gasta tempo $O(\log qsize)$.
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

@ %Implementa��o da opera��o \textsf{decrease-key}.
Diminuir o potencial de um v�rtice, ao visit�-lo, 
 pode tornar necess�rio reposicion�-lo em
$\L$, de modo que a propriedade~\ref{prop:heap-ordem} continue sendo
respeitada. 
No pior caso, essa opera��o gasta tempo $O(\log qsize)$.
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

\begin{lema}{opera��es heap}
\label{lema:operacoes-heap}
 Na implementa��o da fila de prioridade $Q$, utilizando um heap,
 cada opera��o \textsf{insert}, \textsf{delete-min} e
\textsf{decrease-key}, gasta tempo $O(\log n)$. \fimprova
\end{lema}

Portanto, do teorema~\ref{teorema:no-operacoes} e do
lema~\ref{lema:operacoes-heap}, o tempo gasto pelo
algoritmo de Dijkstra utilizando um heap, �

\[
  \underbrace{O(n \log n)}_{\mbox{\textsf{insert}}} + 
  \underbrace{O(m \log n)}_{\mbox{\textsf{decrease-key}}} +
  \underbrace{O(n \log n)}_{\mbox{\textsf{delete-min}}}
  = O(m \log n).
\]

\begin{teorema}{}
 A implementa��o do algoritmo de Dijkstra que utiliza um heap resolve o
 problema do caminho m�nimo em um grafo com $n$ v�rtices e $m$ arcos
 em tempo $O(m \log n)$. \fimprova
\end{teorema}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  D-HEAP
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{\dheap}
\label{sec:dheap}

Um \defi{\dheap}\index{heap!\dheap}, assim como o heap 
(se��o~\ref{sec:heap}), � uma estrutura de dados que mant�m uma
seq��ncia de v�rtices, num vetor $\L$,  dispostos de maneira organizada
em rela��o a fun��o potencial, de maneira que:  
 \begin{propriedade}{ordem}\index{propriedade!ordem no \dheap}
   \label{prop:dheap-ordem}
   \[ \fp(\L[\ceil{(i-1)/\D}]) \leq \fp(\L[i]), 
      \ \mbox{para cada posi��o} \  i \  
      \mbox{em} \  [2..qsize], \]
  onde |qsize| representa o n�mero de v�rtices em $\L$ e $\D$ � o
maior n�mero de filhos de um v�rtice. 
 \end{propriedade} 

%Note que a propriedade~\ref{prop:dheap-ordem} � a mesma que
%~\ref{prop:heap-ordem} quando \D{} � igual a $2$. Ou seja, o heap � um caso
%particular do \dheap.

Intuitivamente, o vetor $\L$ pode ser visto como uma �rvore, em que
cada v�rtice pertencente a ele pode ter no m�ximo \D{} filhos. A
figura~\ref{fig:dheap} ilustra a representa��o de um $3$-heap.

 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(a)}{(a)}
    \psfrag{(b)}{(b)}
  \includegraphics{fig/dheap.eps}
  \caption[{\sf \dheap}]
 {\label{fig:dheap} Ilustra��o de um $3$-heap. Em (a) o $3$-heap
� visto como uma �rvore e em (b) como um vetor.} 
 \end{center}
 \end{figure}

@ Na implementa��o, |D| � o maior n�mero de filhos de um v�rtice.
 A escolha de |D| � feita dinamicamente, em rela��o a
$\max\{2,\ceil{m/n}\}$. O motivo pelo qual |D| � escolhido dessa
 maneira � mostrado no final da se��o.  
@<Vari�veis globais@>=
unsigned long D;          /* n�mero m�ximo de filhos de um v�rtice */

@ A fun��o |teto(i,j)| devolve $\ceil{i/j}$. A primeira utilidade da
fun��o � encontrar um valor para~|D|.
@<Fun��es ...@>=
unsigned long 
teto(i, j)
  unsigned long i; 
  unsigned long j;
{
  return ( i%j == 0 ? i/j : i/j + 1); 
}

@ Para criar o \dheap{} $\L$ � utilizada a fun��o
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
  t = teto(g->m/2,g->n);  /*n�mero de arestas � o dobro do n�mero de arcos*/
  D = t > 2? t : 2; 
}
 

@ As implementa��es das opera��es \textsf{insert, delete-min} e
\textsf{decrease-key}, s�o representadas pelas fun��es \textit{insert\_dheap,
delete\_min\_dheap} e \textit{decrease\_key\_dheap}.
@<Filas de prioridade@>=
 void insert_dheap(Vertex *v);
 Vertex *delete_min_dheap();
 void decrease_key_dheap(Vertex *v);

@ Inserir um v�rtice no \dheap{} funciona de forma an�loga a inserir um
v�rtice no heap.
@<Filas de prioridade@>=
void 
insert_dheap(v)
     Vertex *v;
{
  v->posicao = qsize + 1;
  decrease_key_dheap(v);
}

@  Assim como no heap~\ref{sec:heap}, o v�rtice com o menor potencial
pode ser encontrado na primeira posi��o, ou seja, em |Q(1)|. 
E ap�s sua remo��o, � preciso encontrar o novo v�rtice com potencial m�nimo.  
No pior caso, essa opera��o gasta tempo  $O(D \log_{D} qsize)$
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
  /*os filhos do v�rtice da posic�o $p$, s�o encontrados nas posi��es
                     $pD - D + 2, \ldots, \min \{n, pD + 1\}$ */
  f = p*D - D + 2; 
  while(f <= (qsize-1)){
    @<Encontra filho |f| de |p| tal que $\fp(f)$ seja m�nimo@>@;
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
@<Encontra filho |f| de |p| tal que $\fp(f)$ seja m�nimo@>=
ultimo_filho = (qsize - 1) < p*D + 1? (qsize - 1) : p*D + 1;
for(i = f + 1; i <= ultimo_filho ; i++)
     if( Q(f)->dist  > Q(i)->dist ) 
       f = i;

@ Diminuir o potencial de um v�rtice, ao visit�-lo, pode tornar 
necess�rio   
reposicion�-lo em $\L$, de modo que a 
propriedade~\ref{prop:dheap-ordem} continue sendo respeitada.
No pior caso, essa opera��o gasta tempo $O(\log_{D} qsize)$.
@<Filas de prioridade@>=
void 
decrease_key_dheap(v)
     Vertex *v;
{
  register unsigned long p, f;

  f = v->posicao;
  p = teto(f-1,D);  /* pai de um v�rtice � encontrado na posi��o 
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

\begin{lema}{opera��es \dheap}
\label{lema:operacoes-dheap}
  Na implementa��o da fila de prioridade $Q$, utilizando um \dheap,
  cada opera��o \textsf{insert} e \textsf{decrease-key} gasta tempo
  $O(\log_{D} n)$ e a opera��o \textsf{delete-min} gasta tempo 
  $O(D \log_{D} n)$, onde $D = \max\{2,\ceil{m/n}\}$. \fimprova
\end{lema}

Portanto, do teorema~\ref{teorema:no-operacoes} e do
lema~\ref{lema:operacoes-dheap}, o tempo gasto pelo
algoritmo de Dijkstra utilizando um \dheap, �

\[
  \underbrace{O(n \log_{D} n)}_{\mbox{\textsf{insert}}} + 
  \underbrace{O(m \log_{D} n)}_{\mbox{\textsf{decrease-key}}} +
  \underbrace{O(nD \log_{D} n)}_{\mbox{\textsf{delete-min}}}
  = O(m \log_{D} n).
\]

Note que o valor escolhido para |D| na implementa��o � �timo, 
pois para grafos esparsos, isto �, quando $m = O(n)$, o tempo gasto � 
$O(n \log n)$,  e para grafos n�o-esparsos, isto �, quando 
$m = \Omega(n^{1 + \epsilon})$ para algum $\epsilon > 0$, o tempo gasto �  
$O(m \log_{D} n) = O((m \log n)/(\log D)) = O((m \log n)/(\log n^{\epsilon})) = 
O((m \log n)/(\epsilon \log n)) = O(m/\epsilon) = O(m)$. 
A �ltima igualdade � verdadeira desde que $\epsilon$ seja uma
constante. Portanto, o tempo gasto � $O(m)$ que � �timo.

\begin{teorema}{}
 A implementa��o do algoritmo de Dijkstra que utiliza um \dheap{} resolve o
 problema do caminho m�nimo em um grafo com $n$ v�rtices e $m$ arcos
 em tempo $O(m \log_{D} n)$. \fimprova
\end{teorema}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  FIBONACCI HEAP
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Fibonacci heap}
\label{sec:fibonacci}

 Um \defi{fibonacci heap}\index{heap!fibonacci} � um conjunto de
 arboresc�ncias que respeitam as seguintes propriedades: 
 \begin{propriedade}{ordem}\index{propriedade!ordem no
 fibonacci heap}
 \label{prop:ordem-fheap}
  Para cada par $(p,f)$, em uma mesma arboresc�ncia, onde $p$ � o 
pai do v�rtice $f$, $\fp(p) \leq \fp(f)$ (an�loga a propriedade~\ref{prop:heap-ordem}).
 \end{propriedade}

 \begin{propriedade}{descendentes}\index{propriedade!n�mero de
  descendentes de um v�rtice no fibonacci heap}
  \label{prop:descendentes}
  Para cada v�rtice $p$, os filhos de $p$ podem ser ordenados de maneira que 
 o $i$-�simo filho tenha pelo menos $i-2$ filhos. 
 \end{propriedade}

 Dizemos que o \defi{grau}\index{grau de um v�rtice} de um v�rtice �
 o seu n�mero de filhos.
 Como conseq��ncia da propriedade~\ref{prop:descendentes} pode-se
 notar que todo v�rtice de grau $k$  
 possui pelo menos $F_{k+2}$ descendentes (incluindo ele mesmo),
onde $F_k$ � o n�mero de fibonacci, 
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
 
 A implementa��o de um fibonacci heap � feita atrav�s de uma lista
ligada $\L$, como ilustrada na figura~\ref{fig:fibonacci}.
 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(a)}{(a)}
    \psfrag{(b)}{(b)}
  \includegraphics{fig/fibonacci.eps}
  \caption[{\sf Fibonacci heap}]
 {\label{fig:fibonacci} Em (a)~� exibido um fibonacci heap composto por
 tr�s arboresc�ncias. A linha pontilhada enfatiza o fato do fibonacci
heap ser formado pelo conjunto das arboresc�ncias. Em
 (b)~� ilustrada a representa��o em forma de lista, mostrando os
ponteiros da estrutura.} 
 \end{center}
 \end{figure}


% \begin{lema}{n�mero m�ximo de filhos}
% Todo v�rtice num fibonacci Heap tem no m�ximo $1 + 2\log n$ filhos.
%\end{lema}
%\begin{prova}
%\end{prova}


@ A lista $\L$ pode ser dividida em dois tipos de listas:
 (1) (|root|) uma lista formada pelas ra�zes das
 arboresc�ncias; e
 (2) (|child|) lista formada por filhos de um mesmo v�rtice.
Cada v�rtice num fibonacci heap cont�m sete campos, que s�o: 
 ponteiros |pai|, |filho|, |direita|, |esquerda|, que representam
listas duplamente ligadas circulares (lista |root| e |child|);
|grau_marca|, que guarda o n�mero $2*grau + marca$, onde o 
|grau| � o grau do v�rtice e |marca| tem valor $1$ se o v�rtice
(exceto o raiz) j� perdeu algum filho, e $0$ caso contr�rio.
Os campos |predecessor| ($\psi$) e |dist| ($\fp$) s�o os mesmos utilizados
anteriormente.
 Note que a estrutura Vertex do \SGB{} tem seis
campos utilit�rios. Ent�o, para implementar o fibonacci heap foi
redefinida a estrutura \tipo{Vertex} do \SGB{} para sete campos. \normalsize

@<Defini��es@>=
#define pai @,@,@,@, t.V
#define filho @,@,@,@, w.V
#define direita @,@,@,@, y.V
#define esquerda @,@,@,@, z.V
#define grau_marca @,@,@,@, x.I

@ As fun��es a seguir s�o respons�veis por inserir e remover v�rtices
de uma lista. A fun��o |insere_na_lista| insere na lista |l| o v�rtice
|v| e a fun��o |remove_da_lista| remove o v�rtice |v| da lista.
@<Fun��es ...@>=
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

@ Para criar o fibonacci heap $\L$ � utilizada a fun��o
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

@ As implementa��es das opera��es \textsf{insert, delete-min} e
\textsf{decrease-key} s�o representadas pelas fun��es \textit{insert\_fheap,
delete\_min\_fheap} e \textit{decrease\_key\_fheap}.
@<Filas de prioridade@>=
 void insert_fheap(Vertex *v);
 Vertex *delete_min_fheap();
 void decrease_key_fheap(Vertex *v);

@ Inserir um v�rtice no fibonacci heap significa coloc�-lo na lista
|root|.  No pior caso, essa opera��o gasta tempo  $O(1)$.
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

@ O v�rtice com o menor potencial no fibonacci heap se encontra na
primeira posi��o, ou seja, |Q| aponta para o v�rtice com potencial
m�nimo. Remover esse v�rtice implica em
adicionar seus filhos � lista |root|, e em seguida � necess�rio
utilizar o bloco |@<Consolidate@>|, para atualizar o n�mero de
arboresc�ncias
e encontrar o novo v�rtice com potencial m�nimo.
Essa opera��o gasta tempo amortizado $O(\log qsize)$. 
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

@ O bloco |@<Consolidate@>| � respons�vel por reduzir o n�mero de ra�zes de $\L$, ou
seja, reduzir o n�mero de arboresc�ncias. Ele consiste em 
executar repetidamente os seguintes passos, at� que todo v�rtice 
da lista |root| tenha graus distintos:
\begin{enumerate}[(1)]
\item encontre duas ra�zes |x| e |y| na lista |root| com o mesmo
grau. Sup�e-se que |x->dist| $\leq$ |y->dist|; e
\item junte (link) |y| a |x|, removendo |y| da lista |root|, e
adicionando |y| como um filho de |x|.
\end{enumerate}
A opera��o (2) � feita em |@<Link arboresc�ncia |y| com a arboresc�ncia |x|@>|
@<Consolidate@>=
  Dn = 1 + 8*sizeof(long);  /* 1+log(n): n�mero m�ximo de arboresc�ncias */
  if( (A = (Vertex **)malloc(Dn*sizeof(Vertex*))) == NULL){
      printf("%s\n", err_message[ERROR_2]); exit(0);
  }
  for(i = 0; i < Dn; i++) /* $A[d]$ guarda v�rtices de grau $d$ */ 
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
      @<Link arboresc�ncia |y| com a arboresc�ncia |x|@>@;
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

@ @<Link arboresc�ncia |y| com a arboresc�ncia |x|@>=
  remove_da_lista(y);  /* remove |y| da lista |root| */
  f = x->filho;
  if( f ){
    insere_na_lista(f,y);   /* insere |y| como filho de |x| */
  }
  else x->filho = y->esquerda = y->direita = y;
  y->pai = x;
  x->grau_marca += 2;
  y->grau_marca = (y->grau_marca >> 1) << 1; /* parte inteira da divis�o por $2$ e \\
  						depois multiplicada por $2$ */

@ Diminuir o potencial de um v�rtice |v|, ao visit�-lo, pode tornar 
necess�rio reposicion�-lo em $\L$, de modo que as
propriedades~\ref{prop:ordem-fheap} e~\ref{prop:descendentes} 
continuem sendo respeitadas. Isso � feito chamando-se 
 |@<Remove |v| da lista de filhos de |p|@>|, onde |p| � o pai de |v|.
 Caso |p| esteja perdendo um segundo filho, ainda � necess�rio chamar a 
fun��o \textit{cascading\_cut} para garantir a propriedade~\ref{prop:descendentes}.
Essa opera��o gasta tempo amortizado $O(1)$. 
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
  
  v->grau_marca = (v->grau_marca >> 1) << 1; /* parte inteira da divis�o por $2$ e \\
  						depois multiplicada por $2$ */

@ A fun��o |cascading_cut| repete o processo de |@<Remove |v| da lista
de filhos de |p|@>| at�
encontrar um v�rtice que ainda n�o tenha perdido nenhum filho.
@<Fun��es ...@>=
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

\begin{lema}{opera��es fibonacci heap}
\label{lema:operacoes-fheap}
   Na implementa��o da fila de prioridade $Q$, utilizando um fibonacci
 heap, as opera��es \textsf{insert} e \textsf{decrease-key} gastam
 tempo amortizado $O(1)$ e a opera��o \textsf{delete-min} gasta tempo
 amortizado $O( \log n)$. \fimprova
\end{lema}

Portanto, do teorema~\ref{teorema:no-operacoes} e do
lema~\ref{lema:operacoes-fheap}, o tempo gasto pelo
algoritmo de Dijkstra utilizando um fibonacci heap, �
\[
  \underbrace{O(n)}_{\mbox{\textsf{insert}}} + 
  \underbrace{O(m)}_{\mbox{\textsf{decrease-key}}} +
  \underbrace{O(n \log n)}_{\mbox{\textsf{delete-min}}}
  = O(m + n \log n).
\]

\begin{teorema}{}
 A implementa��o do algoritmo de Dijkstra que utiliza um fibonacci
heap resolve o problema do caminho m�nimo em um grafo com $n$ v�rtices
e $m$ arcos  em tempo $O(m + n \log n)$. \fimprova
\end{teorema}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  Bucket heap
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Bucket heap}
\label{sec:bucket-heap}

Um \defi{bucket heap}\index{heap!bucket} � uma estrutura de dados que
mant�m uma seq��ncia de v�rtices num vetor $Q$ de listas ligadas. 
 Para cada posi��o $k$ do vetor, $Q(k)$ � uma lista ligada de
 v�rtices. Em cada $Q(k)$, s�o mantidos os v�rtices com potencial igual
a $k$\footnote{Note que a ordem entre os v�rtices em $Q(k)$ n�o � importante}.

 Observe que $nC$, onde $C$ � o comprimento do maior arco,
 � um limitante superior para qualquer dist�ncia no grafo.  
 Portanto, s�o necess�rios no m�ximo $nC + 1$ buckets, j� que as dist�ncias 
podem variar de $0$ a $nC$.
Por�m, � poss�vel diminuir o n�mero de buckets para $C + 1$. Observe que:
(1) $\fp(u) \leq \fp(v)$ para cada v�rtice $u$ em $S$ e $v$ em $\L$
(invariante (dk3)); e
(2) para cada v�rtice $w$ em $\L$, $\fp(w) = \fp(u) + c(u,w)$ para
algum v�rtice $u$ em $S$ (invariantes (dk4) e (dk12)). Portanto, de (1)
e (2), $\fp(w) = \fp(u) + c(u,w) \leq \fp(u) + C$, onde $u$ � o v�rtice escolhido 
no caso 2 do algoritmo de Dijkstra.
 Em outras palavras, toda 
dist�ncia tentativa � limitada inferiormente por $\fp(u)$, e
superiormente por $\fp(u) + C$. Conseq�entemente, $C + 1$ buckets s�o
 suficientes. Resultando na seguinte propriedade.

 \begin{propriedade}{ordem}\index{propriedade!ordem no
 bucket heap}
 \label{prop:bkheap}
  Cada bucket $Q(k \mod (C+1))$ mant�m os v�rtices com potencial
igual a $k$, onde $C$ � o comprimento do maior arco.
 \end{propriedade}

 Os $C+1$ buckets, numerados de $[0..C]$, simulam as $nC + 1$ posi��es
 funcionando de maneira circular. A figura~\ref{fig:bkheap} ilustra a
 organiza��o dos buckets.
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
  {\label{fig:bkheap} A figura (a) enfatiza a organiza��o circular
 dos buckets. (b) mostra que o bucket $k \mod (C+1)$
 guarda o v�rtice com potencial $k$.}
 \end{center}
 \end{figure}


@ O ponteiro |pos_corrente| indica a posi��o do bucket que est� sendo visitada.
@<Defini��es@>=
#define pos_corrente @,@,@,@, w.I

@ Para criar o bucket heap $Q$ � utilizada a fun��o
\textit{create\_bkheap}. Redefinimos $Q(k)$ (a defini��o anterior
est� se��o~\ref{sec:heap}), de modo que seja o cabe�a de lista do
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
    Q(i)->direita = Q(i)->esquerda = Q(i); /* endere�o $Q+i$ */
  }
  for(v = g->vertices; v < g->vertices + g->n; v++){
    v->direita = v->esquerda = v;
  }
  Q->pos_corrente = 0;
} 

@ As implementa��es das opera��es \textsf{insert, delete-min} e
\textsf{decrease-key} s�o representadas pelas fun��es \textit{insert\_bkheap,
delete\_min\_bkheap} e \textit{decrease\_key\_bkheap}.
@<Filas de prioridade@>=
 void insert_bkheap(Vertex *v);
 Vertex *delete_min_bkheap();
 void decrease_key_bkheap(Vertex *v);

@  Como a implementa��o � feita usando $C+1$ buckets, cada v�rtice |v|
� inserido na posi��o |v->dist|~$\mod (C+1)$.
Essa opera��o gasta tempo $O(1)$.
@<Filas de prioridade@>=
void 
insert_bkheap(v)
     Vertex *v;
{
  register unsigned long k;

  k = v->dist%(C+1);
  insere_na_lista(Q(k), v);  
}

@ O v�rtice com o menor potencial pode ser encontrado na primeira
posi��o n�o-vazia de $Q$.
No pior caso, essa opera��o gasta tempo $O(C)$. 
@<Filas de prioridade@>=
Vertex *
delete_min_bkheap()
{
  register unsigned long k;
  Vertex *u;
  
  /* procura o primeiro bucket n�o-vazio */
  for(k = Q->pos_corrente; Q(k) == Q(k)->direita; k = ++k%(C+1));
  Q->pos_corrente = k;

  u = Q(k)->direita;
  remove_da_lista(u);
  return u;
} 

@ Diminuir o potencial de um v�rtice, ao visit�-lo, pode tornar 
necess�rio  reinseri-lo em $\L$, de modo que a 
propriedade~\ref{prop:bkheap} continue sendo respeitada. 
Essa opera��o gasta tempo $O(1)$.
@<Filas de prioridade@>=
void 
decrease_key_bkheap(v)
     Vertex *v;
{
  remove_da_lista(v);
  insert_bkheap(v);
}
@

\begin{lema}{opera��es bucket heap}
\label{lema:operacoes-bkheap}
  Na implementa��o da fila de prioridade $Q$ utilizando um bucket
 heap, as opera��es \textsf{insert} e \textsf{decrease-key} gastam tempo $O(1)$
 e \textsf{delete-min} gasta tempo $O(C)$. \fimprova
\end{lema}

Portanto, do teorema~\ref{teorema:no-operacoes} e do
lema~\ref{lema:operacoes-bkheap}, o tempo gasto pelo
algoritmo de Dijkstra utilizando um bucket heap, �
\[
  \underbrace{O(n)}_{\mbox{\textsf{insert}}} + 
  \underbrace{O(m)}_{\mbox{\textsf{decrease-key}}} +
  \underbrace{O(nC)}_{\mbox{\textsf{delete-min}}}
  = O(m + nC).
\]

\begin{teorema}{}
 A implementa��o do algoritmo de Dijkstra que utiliza um bucket heap
resolve o problema do caminho m�nimo em um grafo com $n$ v�rtices
e $m$ arcos em tempo $O(m + nC)$, onde $C$ � o maior comprimento de um
arco. \fimprova
\end{teorema}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  RADIX HEAP
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Radix heap}

Um \defi{radix heap}\index{heap!radix}, assim como um bucket
heap (se��o~\ref{sec:bucket-heap}), � uma estrutura de dados que mant�m uma
seq��ncia de v�rtices, num vetor $Q$, onde para cada posi��o $k$, $Q(k)$ � uma
lista ligada de v�rtices. Por�m, em vez de manter somente v�rtices com potencial
$k$ na $(k mod (C+1))$-�sima posi��o do bucket, s�o mantidos os v�rtices com
potencial em um determinado intervalo.  Na implementa��o
 do radix heap, os intervalos s�o consecutivos e t�m largura  
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
 $range(k)$ � o intervalo do bucket $Q(k)$. Portanto, o n�mero de buckets necess�rios �
$1 + K$. 

 \begin{propriedade}{ordem}\index{propriedade!ordem no
 radix heap}
 \label{prop:rxheap}
  Se $range(k)$ � o intervalo do bucket $Q(k)$, ent�o $Q(k)$ mant�m os v�rtices  
 com potencial em $range(k)$.
 \end{propriedade}

 Os intervalos dos buckets mudam dinamicamente durante a execu��o
do algoritmo, rearranjando-se de forma que os v�rtices com menor
potencial fiquem nos buckets de largura $1$. Por exemplo, supondo que 
o primeiro bucket n�o-vazio � o $Q(4)$, inicialmente, 
seu respectivo intervalo � $[8..15]$, que � maior do que $1$. 
Ent�o, � necess�rio fazer a redistribui��o dos intervalos da seguinte maneira. 
   \[ \begin{array}{l}
     range(0) =  [8] \\
     range(1) =  [9] \\
     range(2) =  [10..11] \\
     range(3) =  [12..15] \\
     range(4) = \emptyset \\
    \end{array}
 \]
E tamb�m, � necess�rio redistribuir os v�rtices pertencentes a $Q(4)$ nos 
buckets $Q(0)$ , $Q(1)$, $Q(2)$ e $Q(3)$, assim os v�rtices que podem
ser examinados est�o sempre em $Q(0)$ e $Q(1)$.

@ Na implementa��o, � suficiente guardar apenas o valor inicial do
intervalo. Esse valor � mantido em |range| e cada v�rtice |v| ser� inserido
no bucket |Q(bucket)|.
@<Defini��es@>=
#define range @,@,@,@, w.I
#define bucket @,@,@,@, x.I

@ A fun��o |log2(x)| calcula o $\floor{\log_2 x}$ para $x \geq 1$.
@<Fun��es ...@>=
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

@ Para criar o radix heap $Q$ � utilizada a fun��o |create_rxheap|.
@<Filas de prioridade@>=
void 
create_rxheap(g)
 Graph *g;
{
  register int i, K, range_len;
  register Vertex *v;

  K = log2(infinito) + 1; /* n�mero m�ximo de buckets */
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
    v->bucket = K;     /* indica que |v| est� em |Q(K)| */
  }
}

@ As implementa��es das opera��es \textsf{insert, delete-min} e
\textsf{decrease-key} s�o representadas pelas fun��es \textit{insert\_rxheap,
delete\_min\_rxheap} e \textit{decrease\_key\_rxheap}.
@<Filas de prioridade@>=
 void insert_rxheap(Vertex *v);
 Vertex *delete_min_rxheap();
 void decrease_key_rxheap(Vertex *v);

@ A inser��o dos v�rtices � feita respeitando-se os intervalos.
No pior caso, essa opera��o gasta tempo $O(\log (nC))$.
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

@ O v�rtice com o menor potencial � encontrado em $Q(0)$ ou $Q(1)$. 
Caso n�o haja v�rtices nessas posi��es � necess�rio fazer a
redistribui��o dos intervalos, e reinserir os v�rtices nos buckets
corretos. No pior caso, essa opera��o gasta tempo  $O(\log (nC))$.
@<Filas de prioridade@>=
Vertex *
delete_min_rxheap()
{
  register unsigned long range_len, k, i, min;
  register Vertex *u;

  if ( (Q(0) == Q(0)->direita) && (Q(1) == Q(1)->direita) ){
    @<Encontra a posi��o $k$ do primeiro bucket n�o-vazio@>@;
    @<Encontra o valor do menor potencial em |Q(k)|@>@;
    @<Redistribui os intervalos@>@;
  }
  k = (Q(0) == Q(0)->direita) ? 1 : 0;
  u =  Q(k)->direita;
  remove_da_lista(u);
  return u;
}

@
@<Encontra a posi��o $k$ do primeiro bucket n�o-vazio@>=
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
/* o $k$-�simo intervalo fica vazio */
Q(k)->range = infinito;
@<Remove e distribui os v�rtices de |Q(k)| nos buckets anteriores@>@;

@ 
@<Remove e distribui os v�rtices de |Q(k)| nos buckets anteriores@>=
for(u = Q(k)->direita; Q(k) != u; u = Q(k)->direita){
  remove_da_lista(u);
  i = u->dist - Q(0)->range;
  u->bucket = (i == 0) ? 0 : log2(i) + 1;
  insert_rxheap(u);
}

@ Diminuir o potencial de um v�rtice, ao visit�-lo, pode tornar 
necess�rio  reinseri-lo em $\L$, de modo que a 
propriedade~\ref{prop:rxheap} continue sendo respeitada. 
Essa opera��o gasta tempo $O(1)$, pois o tempo gasto por 
|insert_rxheap|, j� inclui as reinser��es dos v�rtices.
@<Filas de prioridade@>=
void 
decrease_key_rxheap(v)
     Vertex *v;
{
  remove_da_lista(v);
  insert_rxheap(v);
}
@  

\begin{lema}{opera��es radix heap}
\label{lema:operacoes-rxheap}
  Na implementa��o da fila de prioridade $Q$, utilizando um radix
 heap, as opera��es \textsf{insert} e \textsf{delete-min} gastam 
 tempo $O(\log (nC))$ e a opera��o \textsf{decrease-key} gasta tempo
 $O(1)$.
\fimprova
\end{lema}

Portanto, do teorema~\ref{teorema:no-operacoes} e do
lema~\ref{lema:operacoes-rxheap}, o tempo gasto pelo
algoritmo de Dijkstra utilizando um radix heap, �
\[
  \underbrace{O(n \log (nC))}_{\mbox{\textsf{insert}}} + 
  \underbrace{O(m)}_{\mbox{\textsf{decrease-key}}} +
  \underbrace{O(n \log (nC))}_{\mbox{\textsf{delete-min}}}
  = O(m + n \log (nC)).
\]

\begin{teorema}{}
 A implementa��o do algoritmo de Dijkstra que utiliza um radix heap
resolve o problema do caminho m�nimo em um grafo com $n$ v�rtices
e $m$ arcos em tempo $O(m + n \log (nC))$, onde $C$ � o maior
 comprimento de um arco. \fimprova
\end{teorema}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  RESUMO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Efici�ncia}
\label{sec:eficiencia-fp}

A figura~\ref{tab:tempo-fp} resume o que foi visto neste cap�tulo, com
rela��o aos tempos gasto para cada implementa��o de $Q$. No 
 fibonacci heap, o tempo gasto � amortizado.
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
  \caption[{\sf Efici�ncia das implementa��es de uma fila de prioridade}]
 {Efici�ncia das implementa��es de uma fila de prioridade.}
 \label{tab:tempo-fp}
  \end{figure}




