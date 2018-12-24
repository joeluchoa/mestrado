\chapter{Preliminares}

Neste capítulo apresentaremos a maior parte das notações e definições que serão
usadas intensivamente ao longo desta dissertação.

A maior parte das definições e notações encontradas nestas preliminares seguem
de perto as de  Feofiloff~\cite{pf:aula}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO: NOTAÇÃO BÁSICA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Notação básica}
O conjunto dos números inteiros será denotado por
$\Int$\index{$\Int$}\mar{$\Int$}. 
O conjunto dos números inteiros não-negativos será  
$\NonnegInt$\index{$\NonnegInt$}\mar{$\NonnegInt$} e 
 positivos $\PosInt$\index{$\PosInt$}\mar{$\PosInt$}.

É escrito $S$ como uma \defi{parte}\index{parte de um conjunto} 
de um conjunto $V$ significando que $S$ é um subconjunto de $V$.

Uma \defi{lista}\index{lista} 
é uma seqüência $\seq{v_1,v_2, \ldots, v_k}$ de itens. O item $v_1$ é
o primeiro da lista e o item $v_k$ é o último. Uma
\defi{pilha}\index{pilha} é uma lista que só aceita remoções do 
último item e inserções após o último item. A ação de
remover um item de uma pilha será chamada de
\defi{desempilhar}\index{desempilhar} e a ação de inserir um novo item será
chamada de \defi{empilhar}\index{empilhar}. Para pilhas, dizemos que
$v_k$ é o item no topo da pilha.

Um \defi{intervalo}\index{intervalo} 
$[j..k]$\index{$[j..k]$}\mar{$[j..k]$} 
é uma seqüência de inteiros $j, j+1, \ldots,k$.  Se $i$ é um número em $[j..k]$,
então $i$ é um número inteiro tal que $j \leq i \leq k$.
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO: GRAFOS 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Teoria dos grafos}

Esta seção introduz os conceitos de  grafos, grafos simétricos, passeios,
ciclos, arborescências e outros elementos básicos da teoria dos
grafos. Também são discutidas as diferentes maneiras de representarmos um
grafo no computador.
 
\section*{\large{Grafos e grafos simétricos}}

Um \defi{grafo}\index{grafo} é um objeto da forma $(V,A)$, 
onde $V$ é um conjunto finito e $A$ é um conjunto de pares ordenados 
de elementos de $V$. 

Os elementos de $V$ são chamados \defi{vértices}\index{vertice@@vértice} e os
elementos de $A$ são chamados \defi{arcos}\index{arco}.  Para cada arco
$(u,v)$, os vértices $u$ e $v$ representam a ponta inicial e a ponta final de
$(u,v)$, respectivamente.  Um arco $(u,v)$ também poderá ser denotado por
$uv$.

Um grafo é \defi{simétrico}\index{grafo!simetrico@@simétrico} 
se para cada arco $uv$ existe também o arco $vu$. Diremos às vezes
que o arco $vu$ é \defi{reverso}\index{arco!reverso} 
 do arco $uv$ e que o par $\{(u,v),(v,u)\}$ é uma \defi{aresta}\index{aresta}.
 
Um grafo pode ser naturalmente representado através de um
 diagrama, como o da figura~\ref{fig:grafo}, onde os vértices são
 pequenas bolas e os arcos são as flechas ligando estas bolas. 

\begin{figure}[htbp]
 \begin{center}
    \psfrag{(a)}{(a)}
    \psfrag{(b)}{(b)}
    \psfrag{(c)}{(c)}
    \psfrag{(d)}{(d)}
    \psfrag{a}{{\footnotesize $a$}}
    \psfrag{b}{{\footnotesize $b$}}
    \psfrag{c}{{\footnotesize $c$}}
    \psfrag{d}{{\footnotesize $d$}}
    \psfrag{e}{{\footnotesize $e$}}   
    \psfrag{f}{{\footnotesize $f$}}
  \includegraphics{fig/grafo.eps}
  \caption[{\sf Exemplos de grafos}]{\label{fig:grafo} Em (a), (b), (c) e 
    (d) são mostrados exemplos de grafos. Na figura (b) é ilustrado um
grafo simétrico e em (c) uma arborescência. }
 \end{center}
 \end{figure}
 
 Denotaremos, quando não houver ambigüidade, por $n$\mar{$n$}\index{$n$} e
 $m$\mar{$m$}\index{$m$} os números $|V|$ e $|A|$, respectivamente.  O
 \defi{tamanho do grafo}\index{tamanho de!um grafo} é o número $m+n$.

\section*{\large{Cortes e conjuntos induzidos}}

Seja $(V,A)$ um grafo e $S$ e $\L$ partes\footnote{Comumente será
  escrito \textit{parte} significando \textit{subconjunto.}} de $V$.
Será denotado por $A(S,\L)$\index{$A(S,\L)$}\mar{$A(S,\L)$}, ou
simplesmente $(S,\L)$\index{$(S,\L)$}\mar{$(S,\L)$}, o conjunto dos arcos
com ponta inicial em $S$ e ponta final em $\L$. Quando $\L$ for o conjunto
$V\setminus S$ será usada a abreviação $A(S)$ significando $A(S,\L)$.
%Abreviar-se-a $A({s})$ por $A(s)$.
Por $A[S]$\index{$A[S]$}\mar{$A[S]$} entenda-se o conjunto dos arcos
com ambas as pontas em $S$. 

%%% Corte  
Para qualquer parte $S$ de $V$, o \defi{corte determinado
  por}\index{corte} $S$ é o conjunto $A(S)$ e o \defi{conjunto de arcos
  induzidos por}\index{conjunto de arcos induzidos} $S$ é o conjunto
$A[S]$.
 
\section*{\large{Passeios, caminhos e ciclos}}

%%% Passeio 
 Um \defi{passeio}\index{passeio} num grafo $(V,A)$ é qualquer seqüência da forma
 \begin{eqnarray}
 \label{passeio}
 \seq{v_{0}, \alpha_{1}, v_{1}, \ldots, \alpha_{k}, v_{k}}
 \end{eqnarray}
onde $v_{0}, \ldots, v_{k}$ são vértices, $\alpha_{1}, \ldots, \alpha_{k}$ 
são arcos e, para cada $i$, $\alpha_{i}$ é o arco $v_{i-1}v_{i}$. 
O vértice
$v_{0}$ é o \defi{início}\index{inicio@@início de um passeio} do passeio e o $v_{k}$ é seu 
\defi{término}\index{termino@@término de um passeio}.
Um \defi{passeio não-orientado}\index{passeio! nao orientado@@não orientado}
é uma seqüência como~(\ref{passeio}) onde,
para cada $i$, $\alpha_{i}$ é o arco $v_{i-1}v_{i}$ ou o arco
 $v_{i}v_{i-1}$. 

Na figura~\ref{fig:grafo}(a) a seqüência
 $\seq{a, ab, b, be, e, ef, f}$ é um passeio com início em $a$ e 
 término em $f$ e a seqüência $\seq{a, ac, c, ce, e, be, b, bd, d,df,f}$
 é um passeio não-orientado com início em $a$ e término em $f$. 

%%% Ciclo e ciclo não orientado
Um \defi{ciclo}\index{ciclo} é um passeio onde o início e término coincidem.
Um \defi{ciclo não-orientado}\index{ciclo!nao-orientado@@não-orientado} 
é um passeio não-orientado onde o início e término coincidem.
 Na figura~\ref{fig:grafo}(b) a seqüência 
$\seq{a, ab, b, be, e, ec, c, ca, a}$ é um ciclo com início e término
em $a$. Em~\ref{fig:grafo}(a) a seqüência 
$\seq{a, ab, b, be, e, ce, c, ac, a}$ é um ciclo não-orientado
com início e término em $a$. 

%%% Caminhos
Um \defi{caminho}\index{caminho} é um passeio
sem vértices repetidos.
Um \defi{caminho não-orientado}\index{caminho!nao-orientado@@não-orientado} 
é um passeio não-orientado sem vértices repetidos.
Na figura~\ref{fig:grafo}(a) a seqüência
 $\seq{a, ab, b, be, e, ef, f}$ é um caminho com início em $a$ e 
 término em $f$ e a seqüência $\seq{a, ac, c, ce, e, be, b, bd, d, df,
 f}$ é um caminho não-orientado com início em $a$ e término em $f$. 

%%%
Um vértice $t$ é \defi{acessível}\index{acessivel@@acessível} a partir de
um vértice $s$ se existe um caminho de $s$ a $t$. O
\defi{território}\index{terriorio@@território} de um vértice $s$ é o
conjunto de todos os vértices acessíveis a partir de $s$. 
Se $S$ é o território de um vértice, então não
existe arco que saia de $S$, ou seja, $A(S) = \emptyset$.

Um grafo $(V,A)$ é (fortemente) \defi{conexo}\index{conexo} se para todo par $(u,v)$
 de vértices, $u$ é acessível a partir de $v$ e $v$ é acessível a partir de $u$.

\section*{\large{Grafos acíclicos, arborescências e árvores geradoras}}

%%% Grafos aciclicos
Um grafo que não possui ciclos é dito
\defi{acíclico}\index{grafo!aciclico@@acíclico}. Um grafo simétrico é
 acíclico\index{grafo!simetrico aciclico@@simétrico acíclico} 
 se não possui ciclos com pelo menos três arcos.

Um grafo acíclico $(V,A)$ com $|V| = |A| + 1$ é uma
\defi{arborescência}\index{arborescencia@@arborescência} 
se todo vértice, exceto um 
vértice especial chamado de \defi{raiz}\index{raiz da arborescencia@@raiz da
arborescência},
 é ponta final de exatamente um arco.
Uma arborescência está ilustrada na 
figura~\ref{fig:grafo}(c). A raiz dessa arborescência é o
vértice $a$. Se $uv$ é um arco de uma arborescência, 
então $u$ é o \defi{pai}\index{pai} de $v$ e $v$ é
o \defi{filho}\index{filho} de $u$. 
Uma \defi{folha}\index{folha de uma arborescencia@@folha de uma
arborescência}
 de uma arborescência é um vértice
que não é ponta inicial de algum arco. 

Um grafo simétrico acíclico $(V,A')$ com  $|V| - 1$ arestas, é uma 
\defi{árvore geradora}\index{arvore@@árvore!geradora} 
de um grafo simétrico $(V,A)$ se $A' \subseteq A$.

\section*{\large{Representação de grafos no computador}}

Existem pelo menos três maneiras populares de representarmos um grafo no
computador, são elas: (1)~matriz de adjacência; (2)~matriz de
incidência; e (3)~listas de adjacência. Do ponto de vista desta
dissertação, listas de adjacência é a representação mais importante.

\paragraph{Matriz de adjacência.}\index{matriz de!adjacencia@@adjacência}
 Uma matriz de adjacência de um grafo $(V,A)$
é uma matriz com valores em $\{0,1\}$, e indexada por $V \times V$, onde
cada entrada $(u,v)$ da matriz tem valor $1$ se existe no grafo um arco de
$u$ a $v$, e $0$ caso contrário. Para grafos simétricos a matriz de
adjacências é simétrica.  O espaço gasto com esta representação é
proporcional a $n^2$, onde $n$ é o número de vértices do grafo.  Uma matriz de
adjacência é mostrada na figura~\ref{fig:matriz_adj}. 


\begin{figure}[htbp]
 \centering
  \begin{tabular}{c | c | c | c | c |} 
   \multicolumn{1}{c}{} & 
   \multicolumn{1}{c}{$a$} & 
   \multicolumn{1}{c}{$b$} & 
   \multicolumn{1}{c}{$c$} & 
   \multicolumn{1}{c}{$d$}
   \\ \cline{2-5}
  $a$ & $0$ & $1$ & $1$ & $0$\\ \cline{2-5}
  $b$ & $0$ & $0$ & $0$ & $1$\\ \cline{2-5}
  $c$ & $0$ & $1$ & $0$ & $1$\\ \cline{2-5}
  $d$ & $0$ & $0$ & $0$ & $0$\\ \cline{2-5}
 \end{tabular}
  \caption[{\sf Matriz de adjacência de um grafo}]
  {Matriz de adjacência do grafo da figura~\ref{fig:grafo}(d).}
 \label{fig:matriz_adj}
\end{figure}


\paragraph{Matriz de incidência.}%
\index{matriz de!incidencia@@incidência}
 Uma matriz de incidência  de um grafo $(V,A)$ é
uma matriz  com valores em $\{-1,0,+1\}$ e indexada por $V \times A$, 
onde cada entrada $(u,a)$ é $-1$ se $u$ é ponta inicial de $a$, $+1$
se $u$ é ponta final de $a$, e $0$ caso contrário.
O espaço gasto com esta representação é
proporcional a $nm$, onde $n$ é o número de vértices e $m$ é o número de
arcos do grafo. Uma matriz de incidência da
figura~\ref{fig:grafo}(d) pode ser vista em ~\ref{fig:matriz_inc}.

\begin{figure}[htbp]
 \centering
  \begin{tabular}{r | r | r | r | r | r |} 
   \multicolumn{1}{c}{} & 
   \multicolumn{1}{c}{$ab$} & 
   \multicolumn{1}{c}{$ac$} & 
   \multicolumn{1}{c}{$cb$} & 
   \multicolumn{1}{c}{$cd$} & 
   \multicolumn{1}{c}{$bd$}
   \\ \cline{2-6}
  $a$ & $-1$ & $-1$ & $0$ & $0$ &$0$ \\ \cline{2-6}
  $b$ & $+1$ & $0$ & $+1$ & $0$ & $-1$ \\ \cline{2-6}
  $c$ & $0$ & $+1$ & $-1$ &$-1$ &$0$ \\ \cline{2-6}
  $d$ & $0$ & $0$ & $0$ & $+1$ & $+1$\\ \cline{2-6}
 \end{tabular}
  \caption[{\sf Matriz de incidência de um grafo}]
  {Matriz de incidência do grafo da figura~\ref{fig:grafo}(d).}
 \label{fig:matriz_inc}
\end{figure}
 
\paragraph{Listas de adjacência.}%
\index{lista de!adjacencia@@adjacência}
 Na representação de um grafo $(V,A)$ através de listas de adjacência
tem-se, para cada vértice $u$, uma lista dos arcos deixando $u$. Desta forma,
para cada vértice $u$, o conjunto $A(u)$ é representado por uma lista.
O espaço gasto com esta representação é
proporcional a $n+m$, onde $n$ é o número de vértices e $m$ é o número de
arcos do grafo. Uma lista de adjacência está ilustrada na
figura~\ref{fig:lista_adj}.

\begin{figure}[htbp]
 \centering
 \begin{tabular}{ccc}
   $A(a)$: & $ab$, & $ac$ \\
   $A(b)$: & $bd$  &      \\
   $A(c)$: & $cb$, & $cd$ \\
   $A(d)$: &       &      \\
 \end{tabular}
  \caption[{\sf Lista de adjacência de um grafo}]
 {Listas de adjacência do grafo da figura~\ref{fig:grafo}(d).}
 \label{fig:lista_adj}
\end{figure}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  MODELO DE COMPUTAÇÃO 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Modelo de computação}
\label{sec:modelo}

Um \defi{modelo de computação}\index{modelo!de computacao@@de computação} é
uma descrição abstrata e conceitual (não necessariamente realista) de um
computador que será usado para executar um algoritmo. Um modelo de computação
especifica as operações elementares que um algoritmo pode executar e o
critério empregado para medir a quantidade de tempo que cada operação consome.
Exemplo de operações elementares típicas são operações aritméticas entre
números e comparações.  A escolha de um modelo de computação envolve um
compromisso entre realidade e tratabilidade matemática. O modelo escolhido
deve capturar as características do dispositivo computacional e ainda deve ser
suficientemente simples para que permita uma estimativa do número de operações
dos algoritmos escritos para o modelo.

Existem muitos modelos de computação que diferem em seu poder computacional
(isto é, alguns modelos podem realizar computações impossíveis para outros)
e no consumo de tempo  de várias operações.
Nesta dissertação estamos interessados em dois modelos de computação:
modelo de comparação-adição
 e modelo Random Access Machine.

O modelo de \defi{comparação-adição-subtração}%
\index{modelo!de comparacao-adicao-subtracao@@de comparação-adição-subtração}
 é mais conhecido como modelo de \defi{compara\-ção-adição},%
\index{modelo!de comparacao-adicao@@de comparação-adição} já que a
subtração pode ser simulada através de adições~\cite{petti:computing}.
Este modelo consiste, entre outras coisas, de $m$ números inteiros ou reais,
inicialmente armazenados em variáveis $v_{1}, \ldots, v_{m}$.  Cada variável
$v_{i}$, com $i$ em $[1..m]$, pode guardar um número inteiro ou real e somente pode ser
manipulada por comparações, da forma\  "$v_{i} < v_{j}$" \ e adições, da forma
\ "$v_{i} := v_{j} + v_{k}$". No modelo de \defi{comparação},%
\index{modelo!de comparacao@@de comparação} a única operação de
interesse é a comparação. 

Em um grande número de algoritmos para o problema do caminho mínimo, 
é comum utilizar o modelo de comparação-adição.
Enquanto esse modelo é mais elegante, por ser mais generalista, 
os computadores reais possuem outras operações que gastam tempo 
constante além das comparações e adições, motivando o interesse pelo
modelo RAM.

O modelo \defi{$\word$ Random Access Machine} % 
\index{modelo!Random Access Machine}
 (\defi{RAM})\index{RAM}\mar{RAM}, ou simplesmente modelo RAM, 
supõe que cada palavra de memória do computador tem $\word$ bits, capaz
de manter um inteiro em $[-2^{\word -1}..2^{\word - 1} - 1]$ 
e que toda distância num grafo cabe em uma palavra.
Neste modelo, as operações realizadas em tempo constantes são: \textit{comparação},
\textit{adição}, \textit{subtração}, \textit{bitwise lógico}, \textit{shift}
arbitrário dos bits e {\it multiplicação}.
Além disso, supõe-se que o número de
palavras de memória do computador, que podem ser endereçadas em tempo
constante, é $2^{\word}$.  Isto significa que é exigido que $\word$
 seja suficientemente grande para que a mémoria comporte os dados do problema.
%pelo menos $\log(m + n) + c$ para algum $c > 1$, assim os dados
%do problema pertencem a memória que é endereçável em tempo constante.


Os projetos de algoritmos neste modelo são de grande interesse, 
 pois oferecem melhorias assintóticas significativas e fazem sentido
do ponto de vista prático. 
Porém,  ainda não se espera que eles sejam mais rápidos quando executados 
nessa corrente geração de CPU's, que normalmente
admitem operações em dados de 32-bits, e no máximo de 64-bits. 
 Os novos algoritmos necessitam que o tamanho de $\word$ seja grande,
 como analisado por Rahman e Raman~\cite{rahman:experimental}.
Por outro lado, segundo eles, acredita-se 
que os novos hardwares em desenvolvimento devem transformar esses avanços teóricos
em práticos.

Dos algoritmos que serão apresentados, o de Dijkstra trabalha sobre o 
modelo de comparação-adição e o de Dinitz-Thorup e o de Thorup trabalham sobre o
modelo RAM.

A palavra \defi{complexidade}\index{complexidade} é utilizada nesta dissertação
como sinônimo de ``recurso computacional necessário''.  Assim, por
\defi{complexidade de um problema}\index{complexidade de! problema} entenda-se
um número de operações elementares necessárias para resolver o problema em um
certo modelo.  Esta é uma medida intrínseca da dificuldade para resolver o
problema.  Já por \defi{complexidade de um algoritmo}\index{complexidade de!
  algoritmo} entenda-se um número de operações elementares realizadas, no pior
caso, por qualquer implementação do algoritmo em um certo modelo.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  FILAS DE PRIORIDADE
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Filas de prioridade} 
\label{sec:filadeprioridade}

Sempre que dados são representados em um computador, os seguintes aspectos
são considerados:
\begin{enumerate}[(1)]
 \item a maneira que essas informações (ou objetos do
 mundo real) são modelados como objetos matemáticos; 
 \item o conjunto de operações definidas sobre estes
 objetos matemáticos; 
 \item a maneira na qual estes objetos serão armazenados
 (representados) na memória de um computador; 
 \item os algoritmos que são usados para executar as
 operações sobre os objetos com a representação escolhida. 
\end{enumerate}
 Para entender melhor esses aspectos é preciso entender a diferença entre
 os seguintes termos: tipo de dados, tipo abstrato de dados e estrutura de dados.
 
O \defi{tipo de dado}\index{tipo!de dado} de uma variável é o conjunto de valores 
que esta variável pode assumir. Por exemplo, uma variável do tipo
boolean só pode assumir 
os valores \textsc{true} e \textsc{false}. 

Os itens (1) e (2) acima dizem respeito ao
\defi{tipo abstrato de dados}%
\index{tipo!abstrato}, ou seja, ao modelo matemático junto com uma
coleção de operações 
definidas sobre este modelo. Um exemplo de tipo abstrato de dados é o conjunto 
dos números inteiros com as operações de adição, subtração, 
multiplicação e divisão sobre inteiros. 

Já os itens (3) e (4) estão relacionados a
aspectos de implementação. 

Para representar um tipo abstrato de dados em um computador usa-se uma 
\defi{estrutura de dados}\index{estrutura de dados}, que é uma coleção
de variáveis, 
possivelmente de diferentes tipos, relacionadas de diversas maneiras. 

 Uma \defi{fila de prioridade}\index{fila de prioridade}%
~é um tipo abstrato de dados que consiste de 
uma coleção de itens, cada um com um valor ou prioridade
associada. Algumas das operações permitidas em uma fila de prioridade são:
\begin{description}
\item \textsf{insert$(v, x)$}: Adiciona o vértice $v$ com valor $x$
na coleção.
\item \textsf{delete$(v)$}: Remove o vértice $v$ da coleção.
\item \textsf{delete-min$()$}: Devolve o vértice com o menor valor 
e o remove da coleção.
\item \textsf{decrease-key$(v, x)$}: Muda para $x$ o valor associado
ao vértice $v$; supõe-se que $x$ não é maior que o valor corrente
associado a $v$. Note que \textsf{decrease-key} sempre pode ser
implementado como um \textsf{delete}
seguido por um \textsf{insert}.
\end{description}
 
 Uma seqüência de operações é chamada \defi{monótona}\index{monotona@@monótona}
se os valores devolvidos por sucessivos \textsf{delete-min}'s são
não-decrescentes. O algoritmo de Dijkstra, descrito no capítulo~\ref{cap:dijkstra} 
realiza uma seqüência monótona de operações.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  LINGUAGEM ALGORITMICA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Linguagem algorítmica e invariantes} 
\label{sec:linguagem}

A linguagem algorítmica adotada nesta dissertação é a de
Feofiloff~\cite{pf:aula,pf:proglin}. 
Abaixo encontra-se um exemplo onde esta notação é utilizada. 

\begin{quote}
\textbf{Algoritmo busca seqüencial.} 
Recebe um inteiro positivo $n$, um vetor de números inteiros $v[0..n-1]$ 
e um inteiro $x$ e devolve \textsc{true} se existe um índice $i$ em
$[0..n-1]$ tal que $v[i] = x$, e, em caso contrário, devolve \textsc{false}.
\end{quote}

O algoritmo é iterativo e no início de cada iteração tem-se um inteiro $i$ em
$[0..n]$. No início da primeira iteração $i = 0$.

Cada iteração consiste no seguinte.

\begin{description}
\item\textbf{Caso 1}: $i = n$.

  Devolva \textsc{false} e pare.

\item\textbf{Caso 2}: $i < n$. 

\begin{description}
  \item\textbf{Caso 2A}: $v[i] = x$.
   
    Devolva \textsc{true} e pare.

  \item\textbf{Caso 2B}: $v[i] \neq x$.

    $i' := i + 1$.

    Comece uma nova iteração com $i'$ no papel de $i$. \qed
\end{description}
\end{description}

   
A ordem em que os casos são enunciados é irrelevante: em cada iteração,
qualquer um dos casos aplicáveis pode ser executado.  Os casos podem não ser
mutuamente exclusivos, e a definição de um caso \textit{não} supõe
implicitamente que os demais não se aplicam.  Serão utilizadas ainda
expressões como ``Escolha um $i$ em $[1..n]$'', quando não faz diferença
qual o valor escolhido.  Portanto, a descrição de um algoritmo não é
completamente determinística.

A correção dos algoritmos descritos nesta dissertação baseia-se em 
demonstrações da validade
de invariantes. Estes invariantes são afirmações
envolvendo objetos mantidos pelo algoritmo que são válidos no início de
cada iteração. Exemplos de invariantes para o algoritmo descrito acima são:

\begin{enumerate}[({i}1)]
\item $i$ é um valor em $[0..n]$.

\item para todo $j$ em $[0..i-1]$, vale que $v[j] \neq x$.
\end{enumerate}

Deve-se demonstrar que os invariantes valem no início de cada
iteração; não faremos isto para o presente exemplo. 

Invariantes nos
ajudam a entender e demonstrar a correção de algoritmos.
No exemplo em questão vê-se facilmente que quando o algoritmo devolve
\textsc{true}, no caso~2A, ele não está mentindo, ou seja, existe $i$
em $[0..n-1]$
tal que $v[i]=x$. Ademais, quando $i=n$, do invariante (i2), tem-se que
 $v[j] \neq x$ para todo $j$ em $[0..i-1]= [0..n-1]$, e portanto, no
caso~1, 
o algoritmo corretamente devolve \textsc{false}. Finalmente, o algoritmo
  pára, já que em cada iteração em que não ocorrem os casos~1 e 2A, o
  caso~2B ocorre, e portanto, o valor de $i$ é acrescido de 1.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  CWEB
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Programação literária e \CWEB{}} 

 Knuth~\cite{knuth:literate} descreve programação literária da seguinte maneira:

``\defi{Programação literária}\index{programacao literaria@@programação
literária} é uma metodologia que combina linguagem de
programação com documentação, deste modo, é possível fazer 
programas mais robustos, mais portáveis, mais facilmente alteráveis, e 
mais divertidos de se escrever do que programas escritos somente
em linguagem de alto nível. A principal idéia é tratar um programa
como parte da literatura, direcionado mais aos seres humanos do que
aos computadores. O programa também é visto como um documento
hypertexto, mais propriamente, como o World Wide Web. Este livro é 
uma antologia de experiências incluindo meus recentes documentos nos 
tópicos relacionados com programação estruturada, bem como o 
artigo no {\it The Computer Journal} que lançou a programação literária.''
 
%Literate programming is a methodology that combines a programming language
%with a documentation language, thereby making programs more robust, more
%portable, more easily maintained, and arguably more fun to write than programs
%that are written only in a high-level language. The main idea is to treat a
%program as a piece of literature, addressed to human beings rather than to a
%computer. The program is also viewed as a hypertext document, rather like the
%World Wide Web. (Indeed, I used the word WEB for this purpose long before CERN
%grabbed it!) This book is an anthology of essays including my early papers on
%related topics such as structured programming, as well as the article in The
%Computer Journal that launched Literate Programming itself. The articles have
%been revised, extended, and brought up to date.

Donald Knuth\index{Knuth} e Silvio Levy\index{Levy} conceberam o
\defi{\CWEB{}}\index{\CWEB} que é um sistema de programação literária.
Knuth criou \textsc{web} e Levy adaptou o sistema à
linguagem C.  Ele combina programação em C com documentação tipografada
em \LaTeX.  O sistema está descrito no livro ``The \CWEB{} System of Structured
Documentation''~\cite{knuth:cweb}.

% As implementações apresentadas nesta dissertação combinam a
% metodologia de programação literária \CWEB{} com a plataforma
%\SGB{}. A maior parte do código, está descrito no capítulo [???]. 
%No decorrer do texto  será encontrado pequenos trechos 
% de código ilustrando, ``de forma mais computacional'', os algoritmos 
% descritos. 
 
 Para entender como um programa em \CWEB{} deve ser lido, é preciso 
 entender a notação de \defi{blocos de código}\index{bloco}, que são
 representados por
 \begin{center}
  $\langle$\ Nome do bloco \textit{id}\ $\rangle\equiv$\\
código C
\end{center}

 A referência a um bloco de código é feita usando-se 
$\langle \ \mbox{Nome do bloco \textit{id}} \ \rangle$ e 
significa que uma parte de código C será inserida no lugar do mesmo,
ou seja, funciona de forma análoga às macros da linguagem C. 
%O referido bloco pode ser encontrado através do identificador \textit{id}.

 A seguir está um exemplo de programa em \CWEB{}, que implementa o 
algoritmo de busca seqüencial descrito na seção~\ref{sec:linguagem}.
@ Estrutura geral do programa. O fonte C desse programa será 
escrito no arquivo "busca.c".

@(busca.c@>=
@<Arquivos header e definições@>@;
@<Main@>@;

@ Inclusão do arquivo, da biblioteca C, necessário ao programa e
 definição de {\sc true} e {\sc false}.
@<Arquivos ...@>=
#include<stdio.h>
#define TRUE 1
#define FALSE 0

@ Programa principal.
@<Main@>=
int main()
{@+@<Variáveis locais@>@;
  @<Leitura dos parâmetros de entrada@>@;   
  @<Busca seqüencial por |x|@>@;
}

@ @<Variáveis locais@>=
int n;
int v[100];
int x;   
int i;

@ Leitura do inteiro |n|, do vetor $v[0..n-1]$ e do inteiro |x|.

@<Leitura dos parâmetros de entrada@>=
printf("n = ");
scanf("%d",&n);
for(i = 0; i < n; i++)
     scanf("%d", &v[i]);
printf("x = ");     
scanf("%d",&x);

@ 
@<Busca ...@>=
for(i = 0; i < n; i++){
  @<Verifica se $v[i] = x$@>@;
}
@<Não encontrou |x|@>@;

@ Se $v[i] = x$ devolve \textsc{true} e pára. Caso contrário, continua o loop.
@<Verifica se $v[i] = x$@>=
if(v[i] == x) {
  printf("TRUE\n");
  return TRUE;  
}

@  Caso em que $i = n$. Devolve \textsc{false} e para.
@<Não encontrou |x|@>=
  printf("FALSE\n");
  return FALSE;
@
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  SGB
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Stanford Graph Base} 
\label{sec:sgb}
O Stanford Graph Base\index{Stanford Graph Base} (\SGB{}\index{\SGB}) é uma
plataforma para algoritmos combinatórios  concebida
por Knuth~\cite{knuth:sgb}. No \SGB{} um grafo é representado internamente
através de listas de adjacência. 
A implementação dos algoritmos faz uso desta plataforma. A seguir
está uma 
breve apresentação das estruturas e de algumas funções do \SGB{}.

A representação de um grafo utiliza estruturas (\textbf{structs}) para
vértices, arcos e grafos, além de funções básicas para manipular estas
estruturas, como descrito a seguir.

\paragraph{Vértice (\tipo{Vertex}).}\index{Vertex} 
 Cada vértice é representado no \SGB{} através de uma estrutura com 
dois campos padrão e seis campos de utilidade geral (do tipo \tipo{util}): portanto,
um vértice ocupa $32$ bytes na maioria dos sistemas, não contando a
memória necessária para strings suplementares. Os campos padrão são:
\begin{description}
 \item \var{arcs}: apontador para um \tipo{Arc}. Armazena o início de uma lista ligada
                de arcos; e 
 \item \var{name}: apontador para uma cadeia de caracteres
                (string). Identifica simbolicamente cada vértice.
\end{description}
     
Se \var{v} aponta para um \tipo{Vertex} e \var{v$\rightarrow$arcs} é
NULL, então não existem
arcos saindo de \var{v}. Entretanto, se \var{v$\rightarrow$arcs} não é
NULL, ele aponta para uma estrutura do tipo \tipo{Arc}
 representando um arco saindo
 de \var{v}, e esta estrutura \tipo{Arc} tem um campo \var{next} que aponta para o
 próximo arco na lista ligada encabeçada por
\var{v$\rightarrow$arcs}. Tal lista contém todos os arcos saindo de \var{v}.

Os campos para uso geral são chamados \var{u, v, w, x, y, z}. Macros
podem ser usadas para dar a estes campos significado, dependendo da
aplicação.

\tipo{typedef struct vertex\_struct} \{\\
\xx    \tipo{struct} \var{arc\_struct *arcs}; \\
\xx    \tipo{char} \var{*name};\\
\xx    \tipo{util} \var{u, v, w, x, y, z};\\
\x\} \tipo{Vertex};

\paragraph{Arco (\tipo{Arc}).}\index{Arc} 
 Cada arco é representado por uma estrutura do tipo \tipo{Arc}. 
Cada \tipo{Arc} tem três campos padrão e dois campos para uso geral. 
Portanto, esta estrutura ocupa $20$
bytes na maioria dos computadores. Os campos padrão são:

\begin{description}
 \item  \var{tip}: um apontador para um \tipo{Vertex}; 
 \item  \var{next}: um apontador para um \tipo{Arc}; e 
 \item  \var{len}: um inteiro (long). 
\end{description}

Se \var{a} aponta para um \tipo{Arc} em uma lista de arcos saindo de \var{v}, 
ele representa um arco de comprimento \var{a$\rightarrow$len}, indo de \var{v} até 
\var{a$\rightarrow$tip}, e o próximo arco saindo de
\var{v} na lista é representado por \var{a$\rightarrow$next}. 

Os campos para uso geral são chamados \var{a} e \var{b}.

\tipo{typedef struct arc\_struct} \{\\
\xx    \tipo{struct} \var{vertex\_struct *tip}; \\
\xx    \tipo{struct} \var{arc\_struct *next}; \\
\xx    \tipo{long} \var{len}; \\
\xx    \tipo{util} \var{a,b}; \\
\x\} \tipo{Arc};
  
\paragraph{Grafo (\tipo{Graph}).}\index{Graph} 
 Estamos agora preparados para olhar a estrutura do tipo
 \tipo{Graph}. Esta estrutura pode ser passada para um algoritmo que
 trabalha sobre grafos. 

Uma estrutura do tipo \tipo{Graph} tem sete campos padrão e seis
campos para uso geral. Os campos padrão são:

\begin{description}
  \item \var{vertices}: um apontador para um vetor de \tipo{Vertex}; 
  \item \var{n}: o número total de vértices; 
  \item \var{m}: o número total de arcos; 
  \item \var{id}: um identificador simbólico para o grafo; 
  \item \var{util\_types}: uma representação simbólica do tipo em cada
  campo para uso geral; 
  \item \var{data}: aponta para a área usada para armazenar arcos e strings; 
  \item \var{aux\_data}: aponta para a área usada para informação auxiliar. 
\end{description}
Os campos para uso geral são \var{uu, vv, ww, xx, yy, zz}. Exemplo:

\tipo{typedef struct graph\_struct} \{\\
\xx  \tipo{Vertex} \var{*vertices};\\
\xx \tipo{long} \var{n};\\
\xx  \tipo{long} \var{m};\\
\xx  \tipo{char} \var{id[ID\_FIELD\_SIZE]};\\
\xx  \tipo{char} \var{util\_types[15]};\\
\xx  \tipo{Area} \var{data};\\
\xx  \tipo{Area} \var{aux\_data};\\
\xx  \tipo{util} \var{uu,vv,ww,xx,yy,zz};\\
\x\} \tipo{Graph};
 
Como uma conseqüência destas convenções, nós visitamos todos os arcos
de um grafo \var{g}{} usando o seguinte trecho de programa:

    \tipo{Vertex} \var{*v};\\
\x  \tipo{Arc} \var{*a};

    \var{for (v = g$\rightarrow$vertices; v $<$ g$\rightarrow$vertices +
          g$\rightarrow$n; v++)}\\
\xx \var{for (a = v$\rightarrow$arcs; a; a = a$\rightarrow$next)}\\
\xxx  \var{visite(v,a);}

\paragraph{Campos para uso geral (util).} 
 As estruturas \tipo{Vertex}, \tipo{Arc} e \tipo{Graph} possuem vários
campos para uso geral chamados de \tipo{util}, que são ou não usados
dependendo da aplicação. Cada campo de uso geral
é do tipo \tipo{union}, que pode armazenar vários tipos de
apontadores ou um inteiro longo. 

Os sufixos \var{.V, .A, .G e .S} no nome de uma variável de uso geral
representa um apontador para um \tipo{Vertex}, \tipo{Arc},
\tipo{Graph} ou uma string,
respectivamente. O sufixo \var{.I} significa que a variável é um inteiro
(longo).

\tipo{typedef union} \{\\
\xx  \tipo{struct} \var{vertex\_struct *V};\\
\xx  \tipo{struct} \var{arc\_struct *A};\\
\xx  \tipo{struct} \var{graph\_struct *G};\\
\xx  \tipo{char} \var{*S};\\
\xx  \tipo{long} \var{I};\\
\x\} \tipo{util};

\paragraph{Campo \var{util\_types}.}  
 O campo \var{util\_types} deve sempre armazenar uma string de
comprimento~$14$, seguida do usual '/0' (caracter nulo). Os primeiros seis
caracteres do \var{util\_types} especificam o uso dos campos de uso geral
\var{u, v, w, x, y, z}; os próximos dois caracteres dão o formato dos
campos de uso geral da
estrutura \tipo{Arc}; os últimos seis dão o formato dos campos de uso
geral da estrutura \tipo{Graph}. Cada caracter deve ser um \var{I}
(denotando um inteiro longo), \var{S}
(denotando um apontador para uma string), \var{V}
 (denotando um apontador para um \tipo{Vertex}), \var{A} 
(denotando um apontador para um \tipo{Arc}), ou \var{Z} (denotando um
campo que não está sendo usado). O valor default de \var{util\_types} é 
\var{"ZZZZZZZZZZZZZ"}, quando nenhum campo para uso geral está sendo usado. 

Por exemplo, suponha que um grafo bipartido \var{g} usa o campo
\var{g$\rightarrow$uu.I} para guardar o tamanho da primeira partição. Suponha
ainda que \var{g} tem uma string
em cada campo de uso geral \var{a} de cada \tipo{Arc} e usa o campo para uso
geral \var{w} de cada \tipo{Vertex} para apontar para um \tipo{Arc}. 
Se \var{g} não usa nenhum dos demais
campos de uso geral, então o seu \var{util\_types} deve conter 
\var{"ZZAZZZSZIZZZZZ".}

\paragraph{Ilustração da representação de um grafo no \SGB{}}.
 As figuras~\ref{fig:sgbstruct} e~\ref{fig:sgbgrafo} ilustram as
estruturas do \SGB{} e a representação de um grafo. 

%A representação do grafo ~\ref{fig:grafo}(d) no \SGB{}
%é mostrada na figura ~\ref{fig:sgb}.
\begin{figure}[htbp]
 \begin{center}
    \psfrag{Graph}{\tipo{Graph}}
    \psfrag{Vertex}{\tipo{Vertex}}
    \psfrag{Arc}{\tipo{Arc}}
    \psfrag{n}{{$n$}}
    \psfrag{m}{{$m$}}
    \psfrag{vertices}{\small{$vertices$}}
    \psfrag{name}{{$name$}}
    \psfrag{arcs}{{$arcs$}}
    \psfrag{next}{{$next$}}
    \psfrag{tip}{{$tip$}}
  \includegraphics{fig/sgbstruct.eps}
  \caption[{\sf Estruturas do \SGB}]
  {\label{fig:sgbstruct} Ilustração das estruturas \tipo{Graph},
    \tipo{Vertex} e \tipo{Arc}.} 
 \end{center}
 \end{figure}


\begin{figure}[htbp]
 \begin{center}
    \psfrag{Graph}{\tipo{Graph}}
    \psfrag{Vertex}{\tipo{Vertex}}
    \psfrag{Arc}{\tipo{Arc}}
    \psfrag{a}{{$a$}}
    \psfrag{b}{{$b$}}
    \psfrag{c}{{$c$}}
    \psfrag{d}{{$d$}}
  \includegraphics{fig/sgbgrafo.eps}
  \caption[{\sf Representação de um grafo no \SGB}]
  {\label{fig:sgbgrafo} Um grafo e sua representação no \SGB{}.}
 \end{center}
 \end{figure}


\paragraph{Módulo \textsc{GB\_GRAPH} do \SGB{}}.
 Este módulo inclui rotinas para alocar e armazenar novos grafos, novos
arcos, novas strings e novas estruturas de dados de todos os tipos. 

\begin{quote}
\var{\#}\tipo{include} \texttt{gb\_graph.h}

\item[\tipo{Graph} \var{*gb\_new\_graph(\tipo{long} n)}.]
Um novo grafo é criado chamando-se \var{gb\_new\_graph(n)}, que
 devolve 
um apontador para um registro do tipo \tipo{Graph} com \var{n} vértices e
nenhum arco. 
\item[\tipo{void} \var{gb\_new\_arc(\tipo{Vertex} *u, \tipo{Vertex}
*v, \tipo{long} len)}.]
Cria um novo arco de comprimento \var{len} de \var{u} até \var{v}. 
O arco passa a ser parte do grafo "corrente". 
O novo arco será apontado por \var{u$\rightarrow$arcs}.
\item[\tipo{void} \var{gb\_new\_edge(\tipo{Vertex} *u,
\tipo{Vertex} *v, \tipo{long} len)}.]
Similar a \var{gb\_new\_arc}. Registros para dois arcos são criados, um
de \var{u} a \var{v} e outro de \var{v} a \var{u}. 
Os dois arcos aparecem em posições
consecutivas na  memória: \var{v$\rightarrow$arcs} é
$\var{u$\rightarrow$arcs} + 1 \ \mbox{quando} \ u < v$. 
\item[\tipo{char} \var{*gb\_save\_string (\tipo{char} *s)}.]
Faz uma cópia de \var{s} para ser usada no grafo "corrente". 
\item[\tipo{void} \var{gb\_recycle (\tipo{Graph} *g)}.]
Remove o grafo apontado por \var{g} da memória. 
\end{quote}

\paragraph{Módulo GB\_SAVE do \SGB{}}. 
 Este módulo contém código para converter grafos da sua representação
interna para uma representação simbólica e vice-versa. 
 
\begin{quote}

\var{\#}\tipo{include} \texttt{gb\_save.h}

\item[\tipo{long} \var{save\_graph (\tipo{Graph} *g, \tipo{char} *filename)}.]
Converte o grafo apontado por \var{g} para formato texto e salva o grafo no
arquivo de nome \var{filename}. 
\item[\tipo{Graph} \var{*restore\_graph (\tipo{char} *filename)}.]
Converte um grafo armazenado no arquivo \var{filename} do formato texto para a
representação interna do \SGB{}. 
\end{quote}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  IMPLEMENTAÇÃO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Estrutura da implementação}

 As implementações de todos os algoritmos discutidos nesta dissertação 
 estão escritas em \CWEB{}, e fazem uso da plataforma \SGB{}. 

 A seguir, segue a estrutura geral do programa:

@i gb_types.w
@i boilerplate.w

@c
@<Inclusão de arquivos header@>@;
@<Definições@>@;
@<Variáveis globais@>@;
@<Funções auxiliares@>@;
@<Filas de prioridade@>@;
@<Algoritmo de Dijkstra@>@;
@<Algoritmo de Dinitz-Thorup@>@;
@<Algoritmo de Thorup@>@;
@<Teste da condição de otimalidade@>@;
@<Programa principal@>
@ 
%No bloco |@<Algoritmo de Dijkstra@>|, será descrito a implementação
%do algoritmo de Dijkstra. Como pode ser visto em ~\ref{dijkstra-cweb}.









