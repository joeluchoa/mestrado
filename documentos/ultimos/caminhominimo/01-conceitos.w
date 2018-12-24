\chapter{Preliminares}

Neste cap�tulo apresentaremos a maior parte das nota��es e defini��es que ser�o
usadas intensivamente ao longo desta disserta��o.

A maior parte das defini��es e nota��es encontradas nestas preliminares seguem
de perto as de  Feofiloff~\cite{pf:aula}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O: NOTA��O B�SICA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Nota��o b�sica}
O conjunto dos n�meros inteiros ser� denotado por
$\Int$\index{$\Int$}\mar{$\Int$}. 
O conjunto dos n�meros inteiros n�o-negativos ser�  
$\NonnegInt$\index{$\NonnegInt$}\mar{$\NonnegInt$} e 
 positivos $\PosInt$\index{$\PosInt$}\mar{$\PosInt$}.

� escrito $S$ como uma \defi{parte}\index{parte de um conjunto} 
de um conjunto $V$ significando que $S$ � um subconjunto de $V$.

Uma \defi{lista}\index{lista} 
� uma seq��ncia $\seq{v_1,v_2, \ldots, v_k}$ de itens. O item $v_1$ �
o primeiro da lista e o item $v_k$ � o �ltimo. Uma
\defi{pilha}\index{pilha} � uma lista que s� aceita remo��es do 
�ltimo item e inser��es ap�s o �ltimo item. A a��o de
remover um item de uma pilha ser� chamada de
\defi{desempilhar}\index{desempilhar} e a a��o de inserir um novo item ser�
chamada de \defi{empilhar}\index{empilhar}. Para pilhas, dizemos que
$v_k$ � o item no topo da pilha.

Um \defi{intervalo}\index{intervalo} 
$[j..k]$\index{$[j..k]$}\mar{$[j..k]$} 
� uma seq��ncia de inteiros $j, j+1, \ldots,k$.  Se $i$ � um n�mero em $[j..k]$,
ent�o $i$ � um n�mero inteiro tal que $j \leq i \leq k$.
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O: GRAFOS 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Teoria dos grafos}

Esta se��o introduz os conceitos de  grafos, grafos sim�tricos, passeios,
ciclos, arboresc�ncias e outros elementos b�sicos da teoria dos
grafos. Tamb�m s�o discutidas as diferentes maneiras de representarmos um
grafo no computador.
 
\section*{\large{Grafos e grafos sim�tricos}}

Um \defi{grafo}\index{grafo} � um objeto da forma $(V,A)$, 
onde $V$ � um conjunto finito e $A$ � um conjunto de pares ordenados 
de elementos de $V$. 

Os elementos de $V$ s�o chamados \defi{v�rtices}\index{vertice@@v�rtice} e os
elementos de $A$ s�o chamados \defi{arcos}\index{arco}.  Para cada arco
$(u,v)$, os v�rtices $u$ e $v$ representam a ponta inicial e a ponta final de
$(u,v)$, respectivamente.  Um arco $(u,v)$ tamb�m poder� ser denotado por
$uv$.

Um grafo � \defi{sim�trico}\index{grafo!simetrico@@sim�trico} 
se para cada arco $uv$ existe tamb�m o arco $vu$. Diremos �s vezes
que o arco $vu$ � \defi{reverso}\index{arco!reverso} 
 do arco $uv$ e que o par $\{(u,v),(v,u)\}$ � uma \defi{aresta}\index{aresta}.
 
Um grafo pode ser naturalmente representado atrav�s de um
 diagrama, como o da figura~\ref{fig:grafo}, onde os v�rtices s�o
 pequenas bolas e os arcos s�o as flechas ligando estas bolas. 

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
    (d) s�o mostrados exemplos de grafos. Na figura (b) � ilustrado um
grafo sim�trico e em (c) uma arboresc�ncia. }
 \end{center}
 \end{figure}
 
 Denotaremos, quando n�o houver ambig�idade, por $n$\mar{$n$}\index{$n$} e
 $m$\mar{$m$}\index{$m$} os n�meros $|V|$ e $|A|$, respectivamente.  O
 \defi{tamanho do grafo}\index{tamanho de!um grafo} � o n�mero $m+n$.

\section*{\large{Cortes e conjuntos induzidos}}

Seja $(V,A)$ um grafo e $S$ e $\L$ partes\footnote{Comumente ser�
  escrito \textit{parte} significando \textit{subconjunto.}} de $V$.
Ser� denotado por $A(S,\L)$\index{$A(S,\L)$}\mar{$A(S,\L)$}, ou
simplesmente $(S,\L)$\index{$(S,\L)$}\mar{$(S,\L)$}, o conjunto dos arcos
com ponta inicial em $S$ e ponta final em $\L$. Quando $\L$ for o conjunto
$V\setminus S$ ser� usada a abrevia��o $A(S)$ significando $A(S,\L)$.
%Abreviar-se-a $A({s})$ por $A(s)$.
Por $A[S]$\index{$A[S]$}\mar{$A[S]$} entenda-se o conjunto dos arcos
com ambas as pontas em $S$. 

%%% Corte  
Para qualquer parte $S$ de $V$, o \defi{corte determinado
  por}\index{corte} $S$ � o conjunto $A(S)$ e o \defi{conjunto de arcos
  induzidos por}\index{conjunto de arcos induzidos} $S$ � o conjunto
$A[S]$.
 
\section*{\large{Passeios, caminhos e ciclos}}

%%% Passeio 
 Um \defi{passeio}\index{passeio} num grafo $(V,A)$ � qualquer seq��ncia da forma
 \begin{eqnarray}
 \label{passeio}
 \seq{v_{0}, \alpha_{1}, v_{1}, \ldots, \alpha_{k}, v_{k}}
 \end{eqnarray}
onde $v_{0}, \ldots, v_{k}$ s�o v�rtices, $\alpha_{1}, \ldots, \alpha_{k}$ 
s�o arcos e, para cada $i$, $\alpha_{i}$ � o arco $v_{i-1}v_{i}$. 
O v�rtice
$v_{0}$ � o \defi{in�cio}\index{inicio@@in�cio de um passeio} do passeio e o $v_{k}$ � seu 
\defi{t�rmino}\index{termino@@t�rmino de um passeio}.
Um \defi{passeio n�o-orientado}\index{passeio! nao orientado@@n�o orientado}
� uma seq��ncia como~(\ref{passeio}) onde,
para cada $i$, $\alpha_{i}$ � o arco $v_{i-1}v_{i}$ ou o arco
 $v_{i}v_{i-1}$. 

Na figura~\ref{fig:grafo}(a) a seq��ncia
 $\seq{a, ab, b, be, e, ef, f}$ � um passeio com in�cio em $a$ e 
 t�rmino em $f$ e a seq��ncia $\seq{a, ac, c, ce, e, be, b, bd, d,df,f}$
 � um passeio n�o-orientado com in�cio em $a$ e t�rmino em $f$. 

%%% Ciclo e ciclo n�o orientado
Um \defi{ciclo}\index{ciclo} � um passeio onde o in�cio e t�rmino coincidem.
Um \defi{ciclo n�o-orientado}\index{ciclo!nao-orientado@@n�o-orientado} 
� um passeio n�o-orientado onde o in�cio e t�rmino coincidem.
 Na figura~\ref{fig:grafo}(b) a seq��ncia 
$\seq{a, ab, b, be, e, ec, c, ca, a}$ � um ciclo com in�cio e t�rmino
em $a$. Em~\ref{fig:grafo}(a) a seq��ncia 
$\seq{a, ab, b, be, e, ce, c, ac, a}$ � um ciclo n�o-orientado
com in�cio e t�rmino em $a$. 

%%% Caminhos
Um \defi{caminho}\index{caminho} � um passeio
sem v�rtices repetidos.
Um \defi{caminho n�o-orientado}\index{caminho!nao-orientado@@n�o-orientado} 
� um passeio n�o-orientado sem v�rtices repetidos.
Na figura~\ref{fig:grafo}(a) a seq��ncia
 $\seq{a, ab, b, be, e, ef, f}$ � um caminho com in�cio em $a$ e 
 t�rmino em $f$ e a seq��ncia $\seq{a, ac, c, ce, e, be, b, bd, d, df,
 f}$ � um caminho n�o-orientado com in�cio em $a$ e t�rmino em $f$. 

%%%
Um v�rtice $t$ � \defi{acess�vel}\index{acessivel@@acess�vel} a partir de
um v�rtice $s$ se existe um caminho de $s$ a $t$. O
\defi{territ�rio}\index{terriorio@@territ�rio} de um v�rtice $s$ � o
conjunto de todos os v�rtices acess�veis a partir de $s$. 
Se $S$ � o territ�rio de um v�rtice, ent�o n�o
existe arco que saia de $S$, ou seja, $A(S) = \emptyset$.

Um grafo $(V,A)$ � (fortemente) \defi{conexo}\index{conexo} se para todo par $(u,v)$
 de v�rtices, $u$ � acess�vel a partir de $v$ e $v$ � acess�vel a partir de $u$.

\section*{\large{Grafos ac�clicos, arboresc�ncias e �rvores geradoras}}

%%% Grafos aciclicos
Um grafo que n�o possui ciclos � dito
\defi{ac�clico}\index{grafo!aciclico@@ac�clico}. Um grafo sim�trico �
 ac�clico\index{grafo!simetrico aciclico@@sim�trico ac�clico} 
 se n�o possui ciclos com pelo menos tr�s arcos.

Um grafo ac�clico $(V,A)$ com $|V| = |A| + 1$ � uma
\defi{arboresc�ncia}\index{arborescencia@@arboresc�ncia} 
se todo v�rtice, exceto um 
v�rtice especial chamado de \defi{raiz}\index{raiz da arborescencia@@raiz da
arboresc�ncia},
 � ponta final de exatamente um arco.
Uma arboresc�ncia est� ilustrada na 
figura~\ref{fig:grafo}(c). A raiz dessa arboresc�ncia � o
v�rtice $a$. Se $uv$ � um arco de uma arboresc�ncia, 
ent�o $u$ � o \defi{pai}\index{pai} de $v$ e $v$ �
o \defi{filho}\index{filho} de $u$. 
Uma \defi{folha}\index{folha de uma arborescencia@@folha de uma
arboresc�ncia}
 de uma arboresc�ncia � um v�rtice
que n�o � ponta inicial de algum arco. 

Um grafo sim�trico ac�clico $(V,A')$ com  $|V| - 1$ arestas, � uma 
\defi{�rvore geradora}\index{arvore@@�rvore!geradora} 
de um grafo sim�trico $(V,A)$ se $A' \subseteq A$.

\section*{\large{Representa��o de grafos no computador}}

Existem pelo menos tr�s maneiras populares de representarmos um grafo no
computador, s�o elas: (1)~matriz de adjac�ncia; (2)~matriz de
incid�ncia; e (3)~listas de adjac�ncia. Do ponto de vista desta
disserta��o, listas de adjac�ncia � a representa��o mais importante.

\paragraph{Matriz de adjac�ncia.}\index{matriz de!adjacencia@@adjac�ncia}
 Uma matriz de adjac�ncia de um grafo $(V,A)$
� uma matriz com valores em $\{0,1\}$, e indexada por $V \times V$, onde
cada entrada $(u,v)$ da matriz tem valor $1$ se existe no grafo um arco de
$u$ a $v$, e $0$ caso contr�rio. Para grafos sim�tricos a matriz de
adjac�ncias � sim�trica.  O espa�o gasto com esta representa��o �
proporcional a $n^2$, onde $n$ � o n�mero de v�rtices do grafo.  Uma matriz de
adjac�ncia � mostrada na figura~\ref{fig:matriz_adj}. 


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
  \caption[{\sf Matriz de adjac�ncia de um grafo}]
  {Matriz de adjac�ncia do grafo da figura~\ref{fig:grafo}(d).}
 \label{fig:matriz_adj}
\end{figure}


\paragraph{Matriz de incid�ncia.}%
\index{matriz de!incidencia@@incid�ncia}
 Uma matriz de incid�ncia  de um grafo $(V,A)$ �
uma matriz  com valores em $\{-1,0,+1\}$ e indexada por $V \times A$, 
onde cada entrada $(u,a)$ � $-1$ se $u$ � ponta inicial de $a$, $+1$
se $u$ � ponta final de $a$, e $0$ caso contr�rio.
O espa�o gasto com esta representa��o �
proporcional a $nm$, onde $n$ � o n�mero de v�rtices e $m$ � o n�mero de
arcos do grafo. Uma matriz de incid�ncia da
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
  \caption[{\sf Matriz de incid�ncia de um grafo}]
  {Matriz de incid�ncia do grafo da figura~\ref{fig:grafo}(d).}
 \label{fig:matriz_inc}
\end{figure}
 
\paragraph{Listas de adjac�ncia.}%
\index{lista de!adjacencia@@adjac�ncia}
 Na representa��o de um grafo $(V,A)$ atrav�s de listas de adjac�ncia
tem-se, para cada v�rtice $u$, uma lista dos arcos deixando $u$. Desta forma,
para cada v�rtice $u$, o conjunto $A(u)$ � representado por uma lista.
O espa�o gasto com esta representa��o �
proporcional a $n+m$, onde $n$ � o n�mero de v�rtices e $m$ � o n�mero de
arcos do grafo. Uma lista de adjac�ncia est� ilustrada na
figura~\ref{fig:lista_adj}.

\begin{figure}[htbp]
 \centering
 \begin{tabular}{ccc}
   $A(a)$: & $ab$, & $ac$ \\
   $A(b)$: & $bd$  &      \\
   $A(c)$: & $cb$, & $cd$ \\
   $A(d)$: &       &      \\
 \end{tabular}
  \caption[{\sf Lista de adjac�ncia de um grafo}]
 {Listas de adjac�ncia do grafo da figura~\ref{fig:grafo}(d).}
 \label{fig:lista_adj}
\end{figure}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  MODELO DE COMPUTA��O 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Modelo de computa��o}
\label{sec:modelo}

Um \defi{modelo de computa��o}\index{modelo!de computacao@@de computa��o} �
uma descri��o abstrata e conceitual (n�o necessariamente realista) de um
computador que ser� usado para executar um algoritmo. Um modelo de computa��o
especifica as opera��es elementares que um algoritmo pode executar e o
crit�rio empregado para medir a quantidade de tempo que cada opera��o consome.
Exemplo de opera��es elementares t�picas s�o opera��es aritm�ticas entre
n�meros e compara��es.  A escolha de um modelo de computa��o envolve um
compromisso entre realidade e tratabilidade matem�tica. O modelo escolhido
deve capturar as caracter�sticas do dispositivo computacional e ainda deve ser
suficientemente simples para que permita uma estimativa do n�mero de opera��es
dos algoritmos escritos para o modelo.

Existem muitos modelos de computa��o que diferem em seu poder computacional
(isto �, alguns modelos podem realizar computa��es imposs�veis para outros)
e no consumo de tempo  de v�rias opera��es.
Nesta disserta��o estamos interessados em dois modelos de computa��o:
modelo de compara��o-adi��o
 e modelo Random Access Machine.

O modelo de \defi{compara��o-adi��o-subtra��o}%
\index{modelo!de comparacao-adicao-subtracao@@de compara��o-adi��o-subtra��o}
 � mais conhecido como modelo de \defi{compara\-��o-adi��o},%
\index{modelo!de comparacao-adicao@@de compara��o-adi��o} j� que a
subtra��o pode ser simulada atrav�s de adi��es~\cite{petti:computing}.
Este modelo consiste, entre outras coisas, de $m$ n�meros inteiros ou reais,
inicialmente armazenados em vari�veis $v_{1}, \ldots, v_{m}$.  Cada vari�vel
$v_{i}$, com $i$ em $[1..m]$, pode guardar um n�mero inteiro ou real e somente pode ser
manipulada por compara��es, da forma\  "$v_{i} < v_{j}$" \ e adi��es, da forma
\ "$v_{i} := v_{j} + v_{k}$". No modelo de \defi{compara��o},%
\index{modelo!de comparacao@@de compara��o} a �nica opera��o de
interesse � a compara��o. 

Em um grande n�mero de algoritmos para o problema do caminho m�nimo, 
� comum utilizar o modelo de compara��o-adi��o.
Enquanto esse modelo � mais elegante, por ser mais generalista, 
os computadores reais possuem outras opera��es que gastam tempo 
constante al�m das compara��es e adi��es, motivando o interesse pelo
modelo RAM.

O modelo \defi{$\word$ Random Access Machine} % 
\index{modelo!Random Access Machine}
 (\defi{RAM})\index{RAM}\mar{RAM}, ou simplesmente modelo RAM, 
sup�e que cada palavra de mem�ria do computador tem $\word$ bits, capaz
de manter um inteiro em $[-2^{\word -1}..2^{\word - 1} - 1]$ 
e que toda dist�ncia num grafo cabe em uma palavra.
Neste modelo, as opera��es realizadas em tempo constantes s�o: \textit{compara��o},
\textit{adi��o}, \textit{subtra��o}, \textit{bitwise l�gico}, \textit{shift}
arbitr�rio dos bits e {\it multiplica��o}.
Al�m disso, sup�e-se que o n�mero de
palavras de mem�ria do computador, que podem ser endere�adas em tempo
constante, � $2^{\word}$.  Isto significa que � exigido que $\word$
 seja suficientemente grande para que a m�moria comporte os dados do problema.
%pelo menos $\log(m + n) + c$ para algum $c > 1$, assim os dados
%do problema pertencem a mem�ria que � endere��vel em tempo constante.


Os projetos de algoritmos neste modelo s�o de grande interesse, 
 pois oferecem melhorias assint�ticas significativas e fazem sentido
do ponto de vista pr�tico. 
Por�m,  ainda n�o se espera que eles sejam mais r�pidos quando executados 
nessa corrente gera��o de CPU's, que normalmente
admitem opera��es em dados de 32-bits, e no m�ximo de 64-bits. 
 Os novos algoritmos necessitam que o tamanho de $\word$ seja grande,
 como analisado por Rahman e Raman~\cite{rahman:experimental}.
Por outro lado, segundo eles, acredita-se 
que os novos hardwares em desenvolvimento devem transformar esses avan�os te�ricos
em pr�ticos.

Dos algoritmos que ser�o apresentados, o de Dijkstra trabalha sobre o 
modelo de compara��o-adi��o e o de Dinitz-Thorup e o de Thorup trabalham sobre o
modelo RAM.

A palavra \defi{complexidade}\index{complexidade} � utilizada nesta disserta��o
como sin�nimo de ``recurso computacional necess�rio''.  Assim, por
\defi{complexidade de um problema}\index{complexidade de! problema} entenda-se
um n�mero de opera��es elementares necess�rias para resolver o problema em um
certo modelo.  Esta � uma medida intr�nseca da dificuldade para resolver o
problema.  J� por \defi{complexidade de um algoritmo}\index{complexidade de!
  algoritmo} entenda-se um n�mero de opera��es elementares realizadas, no pior
caso, por qualquer implementa��o do algoritmo em um certo modelo.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  FILAS DE PRIORIDADE
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Filas de prioridade} 
\label{sec:filadeprioridade}

Sempre que dados s�o representados em um computador, os seguintes aspectos
s�o considerados:
\begin{enumerate}[(1)]
 \item a maneira que essas informa��es (ou objetos do
 mundo real) s�o modelados como objetos matem�ticos; 
 \item o conjunto de opera��es definidas sobre estes
 objetos matem�ticos; 
 \item a maneira na qual estes objetos ser�o armazenados
 (representados) na mem�ria de um computador; 
 \item os algoritmos que s�o usados para executar as
 opera��es sobre os objetos com a representa��o escolhida. 
\end{enumerate}
 Para entender melhor esses aspectos � preciso entender a diferen�a entre
 os seguintes termos: tipo de dados, tipo abstrato de dados e estrutura de dados.
 
O \defi{tipo de dado}\index{tipo!de dado} de uma vari�vel � o conjunto de valores 
que esta vari�vel pode assumir. Por exemplo, uma vari�vel do tipo
boolean s� pode assumir 
os valores \textsc{true} e \textsc{false}. 

Os itens (1) e (2) acima dizem respeito ao
\defi{tipo abstrato de dados}%
\index{tipo!abstrato}, ou seja, ao modelo matem�tico junto com uma
cole��o de opera��es 
definidas sobre este modelo. Um exemplo de tipo abstrato de dados � o conjunto 
dos n�meros inteiros com as opera��es de adi��o, subtra��o, 
multiplica��o e divis�o sobre inteiros. 

J� os itens (3) e (4) est�o relacionados a
aspectos de implementa��o. 

Para representar um tipo abstrato de dados em um computador usa-se uma 
\defi{estrutura de dados}\index{estrutura de dados}, que � uma cole��o
de vari�veis, 
possivelmente de diferentes tipos, relacionadas de diversas maneiras. 

 Uma \defi{fila de prioridade}\index{fila de prioridade}%
~� um tipo abstrato de dados que consiste de 
uma cole��o de itens, cada um com um valor ou prioridade
associada. Algumas das opera��es permitidas em uma fila de prioridade s�o:
\begin{description}
\item \textsf{insert$(v, x)$}: Adiciona o v�rtice $v$ com valor $x$
na cole��o.
\item \textsf{delete$(v)$}: Remove o v�rtice $v$ da cole��o.
\item \textsf{delete-min$()$}: Devolve o v�rtice com o menor valor 
e o remove da cole��o.
\item \textsf{decrease-key$(v, x)$}: Muda para $x$ o valor associado
ao v�rtice $v$; sup�e-se que $x$ n�o � maior que o valor corrente
associado a $v$. Note que \textsf{decrease-key} sempre pode ser
implementado como um \textsf{delete}
seguido por um \textsf{insert}.
\end{description}
 
 Uma seq��ncia de opera��es � chamada \defi{mon�tona}\index{monotona@@mon�tona}
se os valores devolvidos por sucessivos \textsf{delete-min}'s s�o
n�o-decrescentes. O algoritmo de Dijkstra, descrito no cap�tulo~\ref{cap:dijkstra} 
realiza uma seq��ncia mon�tona de opera��es.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  LINGUAGEM ALGORITMICA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Linguagem algor�tmica e invariantes} 
\label{sec:linguagem}

A linguagem algor�tmica adotada nesta disserta��o � a de
Feofiloff~\cite{pf:aula,pf:proglin}. 
Abaixo encontra-se um exemplo onde esta nota��o � utilizada. 

\begin{quote}
\textbf{Algoritmo busca seq�encial.} 
Recebe um inteiro positivo $n$, um vetor de n�meros inteiros $v[0..n-1]$ 
e um inteiro $x$ e devolve \textsc{true} se existe um �ndice $i$ em
$[0..n-1]$ tal que $v[i] = x$, e, em caso contr�rio, devolve \textsc{false}.
\end{quote}

O algoritmo � iterativo e no in�cio de cada itera��o tem-se um inteiro $i$ em
$[0..n]$. No in�cio da primeira itera��o $i = 0$.

Cada itera��o consiste no seguinte.

\begin{description}
\item\textbf{Caso 1}: $i = n$.

  Devolva \textsc{false} e pare.

\item\textbf{Caso 2}: $i < n$. 

\begin{description}
  \item\textbf{Caso 2A}: $v[i] = x$.
   
    Devolva \textsc{true} e pare.

  \item\textbf{Caso 2B}: $v[i] \neq x$.

    $i' := i + 1$.

    Comece uma nova itera��o com $i'$ no papel de $i$. \qed
\end{description}
\end{description}

   
A ordem em que os casos s�o enunciados � irrelevante: em cada itera��o,
qualquer um dos casos aplic�veis pode ser executado.  Os casos podem n�o ser
mutuamente exclusivos, e a defini��o de um caso \textit{n�o} sup�e
implicitamente que os demais n�o se aplicam.  Ser�o utilizadas ainda
express�es como ``Escolha um $i$ em $[1..n]$'', quando n�o faz diferen�a
qual o valor escolhido.  Portanto, a descri��o de um algoritmo n�o �
completamente determin�stica.

A corre��o dos algoritmos descritos nesta disserta��o baseia-se em 
demonstra��es da validade
de invariantes. Estes invariantes s�o afirma��es
envolvendo objetos mantidos pelo algoritmo que s�o v�lidos no in�cio de
cada itera��o. Exemplos de invariantes para o algoritmo descrito acima s�o:

\begin{enumerate}[({i}1)]
\item $i$ � um valor em $[0..n]$.

\item para todo $j$ em $[0..i-1]$, vale que $v[j] \neq x$.
\end{enumerate}

Deve-se demonstrar que os invariantes valem no in�cio de cada
itera��o; n�o faremos isto para o presente exemplo. 

Invariantes nos
ajudam a entender e demonstrar a corre��o de algoritmos.
No exemplo em quest�o v�-se facilmente que quando o algoritmo devolve
\textsc{true}, no caso~2A, ele n�o est� mentindo, ou seja, existe $i$
em $[0..n-1]$
tal que $v[i]=x$. Ademais, quando $i=n$, do invariante (i2), tem-se que
 $v[j] \neq x$ para todo $j$ em $[0..i-1]= [0..n-1]$, e portanto, no
caso~1, 
o algoritmo corretamente devolve \textsc{false}. Finalmente, o algoritmo
  p�ra, j� que em cada itera��o em que n�o ocorrem os casos~1 e 2A, o
  caso~2B ocorre, e portanto, o valor de $i$ � acrescido de 1.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  CWEB
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Programa��o liter�ria e \CWEB{}} 

 Knuth~\cite{knuth:literate} descreve programa��o liter�ria da seguinte maneira:

``\defi{Programa��o liter�ria}\index{programacao literaria@@programa��o
liter�ria} � uma metodologia que combina linguagem de
programa��o com documenta��o, deste modo, � poss�vel fazer 
programas mais robustos, mais port�veis, mais facilmente alter�veis, e 
mais divertidos de se escrever do que programas escritos somente
em linguagem de alto n�vel. A principal id�ia � tratar um programa
como parte da literatura, direcionado mais aos seres humanos do que
aos computadores. O programa tamb�m � visto como um documento
hypertexto, mais propriamente, como o World Wide Web. Este livro � 
uma antologia de experi�ncias incluindo meus recentes documentos nos 
t�picos relacionados com programa��o estruturada, bem como o 
artigo no {\it The Computer Journal} que lan�ou a programa��o liter�ria.''
 
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
\defi{\CWEB{}}\index{\CWEB} que � um sistema de programa��o liter�ria.
Knuth criou \textsc{web} e Levy adaptou o sistema �
linguagem C.  Ele combina programa��o em C com documenta��o tipografada
em \LaTeX.  O sistema est� descrito no livro ``The \CWEB{} System of Structured
Documentation''~\cite{knuth:cweb}.

% As implementa��es apresentadas nesta disserta��o combinam a
% metodologia de programa��o liter�ria \CWEB{} com a plataforma
%\SGB{}. A maior parte do c�digo, est� descrito no cap�tulo [???]. 
%No decorrer do texto  ser� encontrado pequenos trechos 
% de c�digo ilustrando, ``de forma mais computacional'', os algoritmos 
% descritos. 
 
 Para entender como um programa em \CWEB{} deve ser lido, � preciso 
 entender a nota��o de \defi{blocos de c�digo}\index{bloco}, que s�o
 representados por
 \begin{center}
  $\langle$\ Nome do bloco \textit{id}\ $\rangle\equiv$\\
c�digo C
\end{center}

 A refer�ncia a um bloco de c�digo � feita usando-se 
$\langle \ \mbox{Nome do bloco \textit{id}} \ \rangle$ e 
significa que uma parte de c�digo C ser� inserida no lugar do mesmo,
ou seja, funciona de forma an�loga �s macros da linguagem C. 
%O referido bloco pode ser encontrado atrav�s do identificador \textit{id}.

 A seguir est� um exemplo de programa em \CWEB{}, que implementa o 
algoritmo de busca seq�encial descrito na se��o~\ref{sec:linguagem}.
@ Estrutura geral do programa. O fonte C desse programa ser� 
escrito no arquivo "busca.c".

@(busca.c@>=
@<Arquivos header e defini��es@>@;
@<Main@>@;

@ Inclus�o do arquivo, da biblioteca C, necess�rio ao programa e
 defini��o de {\sc true} e {\sc false}.
@<Arquivos ...@>=
#include<stdio.h>
#define TRUE 1
#define FALSE 0

@ Programa principal.
@<Main@>=
int main()
{@+@<Vari�veis locais@>@;
  @<Leitura dos par�metros de entrada@>@;   
  @<Busca seq�encial por |x|@>@;
}

@ @<Vari�veis locais@>=
int n;
int v[100];
int x;   
int i;

@ Leitura do inteiro |n|, do vetor $v[0..n-1]$ e do inteiro |x|.

@<Leitura dos par�metros de entrada@>=
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
@<N�o encontrou |x|@>@;

@ Se $v[i] = x$ devolve \textsc{true} e p�ra. Caso contr�rio, continua o loop.
@<Verifica se $v[i] = x$@>=
if(v[i] == x) {
  printf("TRUE\n");
  return TRUE;  
}

@  Caso em que $i = n$. Devolve \textsc{false} e para.
@<N�o encontrou |x|@>=
  printf("FALSE\n");
  return FALSE;
@
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  SGB
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Stanford Graph Base} 
\label{sec:sgb}
O Stanford Graph Base\index{Stanford Graph Base} (\SGB{}\index{\SGB}) � uma
plataforma para algoritmos combinat�rios  concebida
por Knuth~\cite{knuth:sgb}. No \SGB{} um grafo � representado internamente
atrav�s de listas de adjac�ncia. 
A implementa��o dos algoritmos faz uso desta plataforma. A seguir
est� uma 
breve apresenta��o das estruturas e de algumas fun��es do \SGB{}.

A representa��o de um grafo utiliza estruturas (\textbf{structs}) para
v�rtices, arcos e grafos, al�m de fun��es b�sicas para manipular estas
estruturas, como descrito a seguir.

\paragraph{V�rtice (\tipo{Vertex}).}\index{Vertex} 
 Cada v�rtice � representado no \SGB{} atrav�s de uma estrutura com 
dois campos padr�o e seis campos de utilidade geral (do tipo \tipo{util}): portanto,
um v�rtice ocupa $32$ bytes na maioria dos sistemas, n�o contando a
mem�ria necess�ria para strings suplementares. Os campos padr�o s�o:
\begin{description}
 \item \var{arcs}: apontador para um \tipo{Arc}. Armazena o in�cio de uma lista ligada
                de arcos; e 
 \item \var{name}: apontador para uma cadeia de caracteres
                (string). Identifica simbolicamente cada v�rtice.
\end{description}
     
Se \var{v} aponta para um \tipo{Vertex} e \var{v$\rightarrow$arcs} �
NULL, ent�o n�o existem
arcos saindo de \var{v}. Entretanto, se \var{v$\rightarrow$arcs} n�o �
NULL, ele aponta para uma estrutura do tipo \tipo{Arc}
 representando um arco saindo
 de \var{v}, e esta estrutura \tipo{Arc} tem um campo \var{next} que aponta para o
 pr�ximo arco na lista ligada encabe�ada por
\var{v$\rightarrow$arcs}. Tal lista cont�m todos os arcos saindo de \var{v}.

Os campos para uso geral s�o chamados \var{u, v, w, x, y, z}. Macros
podem ser usadas para dar a estes campos significado, dependendo da
aplica��o.

\tipo{typedef struct vertex\_struct} \{\\
\xx    \tipo{struct} \var{arc\_struct *arcs}; \\
\xx    \tipo{char} \var{*name};\\
\xx    \tipo{util} \var{u, v, w, x, y, z};\\
\x\} \tipo{Vertex};

\paragraph{Arco (\tipo{Arc}).}\index{Arc} 
 Cada arco � representado por uma estrutura do tipo \tipo{Arc}. 
Cada \tipo{Arc} tem tr�s campos padr�o e dois campos para uso geral. 
Portanto, esta estrutura ocupa $20$
bytes na maioria dos computadores. Os campos padr�o s�o:

\begin{description}
 \item  \var{tip}: um apontador para um \tipo{Vertex}; 
 \item  \var{next}: um apontador para um \tipo{Arc}; e 
 \item  \var{len}: um inteiro (long). 
\end{description}

Se \var{a} aponta para um \tipo{Arc} em uma lista de arcos saindo de \var{v}, 
ele representa um arco de comprimento \var{a$\rightarrow$len}, indo de \var{v} at� 
\var{a$\rightarrow$tip}, e o pr�ximo arco saindo de
\var{v} na lista � representado por \var{a$\rightarrow$next}. 

Os campos para uso geral s�o chamados \var{a} e \var{b}.

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

Uma estrutura do tipo \tipo{Graph} tem sete campos padr�o e seis
campos para uso geral. Os campos padr�o s�o:

\begin{description}
  \item \var{vertices}: um apontador para um vetor de \tipo{Vertex}; 
  \item \var{n}: o n�mero total de v�rtices; 
  \item \var{m}: o n�mero total de arcos; 
  \item \var{id}: um identificador simb�lico para o grafo; 
  \item \var{util\_types}: uma representa��o simb�lica do tipo em cada
  campo para uso geral; 
  \item \var{data}: aponta para a �rea usada para armazenar arcos e strings; 
  \item \var{aux\_data}: aponta para a �rea usada para informa��o auxiliar. 
\end{description}
Os campos para uso geral s�o \var{uu, vv, ww, xx, yy, zz}. Exemplo:

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
 
Como uma conseq��ncia destas conven��es, n�s visitamos todos os arcos
de um grafo \var{g}{} usando o seguinte trecho de programa:

    \tipo{Vertex} \var{*v};\\
\x  \tipo{Arc} \var{*a};

    \var{for (v = g$\rightarrow$vertices; v $<$ g$\rightarrow$vertices +
          g$\rightarrow$n; v++)}\\
\xx \var{for (a = v$\rightarrow$arcs; a; a = a$\rightarrow$next)}\\
\xxx  \var{visite(v,a);}

\paragraph{Campos para uso geral (util).} 
 As estruturas \tipo{Vertex}, \tipo{Arc} e \tipo{Graph} possuem v�rios
campos para uso geral chamados de \tipo{util}, que s�o ou n�o usados
dependendo da aplica��o. Cada campo de uso geral
� do tipo \tipo{union}, que pode armazenar v�rios tipos de
apontadores ou um inteiro longo. 

Os sufixos \var{.V, .A, .G e .S} no nome de uma vari�vel de uso geral
representa um apontador para um \tipo{Vertex}, \tipo{Arc},
\tipo{Graph} ou uma string,
respectivamente. O sufixo \var{.I} significa que a vari�vel � um inteiro
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
\var{u, v, w, x, y, z}; os pr�ximos dois caracteres d�o o formato dos
campos de uso geral da
estrutura \tipo{Arc}; os �ltimos seis d�o o formato dos campos de uso
geral da estrutura \tipo{Graph}. Cada caracter deve ser um \var{I}
(denotando um inteiro longo), \var{S}
(denotando um apontador para uma string), \var{V}
 (denotando um apontador para um \tipo{Vertex}), \var{A} 
(denotando um apontador para um \tipo{Arc}), ou \var{Z} (denotando um
campo que n�o est� sendo usado). O valor default de \var{util\_types} � 
\var{"ZZZZZZZZZZZZZ"}, quando nenhum campo para uso geral est� sendo usado. 

Por exemplo, suponha que um grafo bipartido \var{g} usa o campo
\var{g$\rightarrow$uu.I} para guardar o tamanho da primeira parti��o. Suponha
ainda que \var{g} tem uma string
em cada campo de uso geral \var{a} de cada \tipo{Arc} e usa o campo para uso
geral \var{w} de cada \tipo{Vertex} para apontar para um \tipo{Arc}. 
Se \var{g} n�o usa nenhum dos demais
campos de uso geral, ent�o o seu \var{util\_types} deve conter 
\var{"ZZAZZZSZIZZZZZ".}

\paragraph{Ilustra��o da representa��o de um grafo no \SGB{}}.
 As figuras~\ref{fig:sgbstruct} e~\ref{fig:sgbgrafo} ilustram as
estruturas do \SGB{} e a representa��o de um grafo. 

%A representa��o do grafo ~\ref{fig:grafo}(d) no \SGB{}
%� mostrada na figura ~\ref{fig:sgb}.
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
  {\label{fig:sgbstruct} Ilustra��o das estruturas \tipo{Graph},
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
  \caption[{\sf Representa��o de um grafo no \SGB}]
  {\label{fig:sgbgrafo} Um grafo e sua representa��o no \SGB{}.}
 \end{center}
 \end{figure}


\paragraph{M�dulo \textsc{GB\_GRAPH} do \SGB{}}.
 Este m�dulo inclui rotinas para alocar e armazenar novos grafos, novos
arcos, novas strings e novas estruturas de dados de todos os tipos. 

\begin{quote}
\var{\#}\tipo{include} \texttt{gb\_graph.h}

\item[\tipo{Graph} \var{*gb\_new\_graph(\tipo{long} n)}.]
Um novo grafo � criado chamando-se \var{gb\_new\_graph(n)}, que
 devolve 
um apontador para um registro do tipo \tipo{Graph} com \var{n} v�rtices e
nenhum arco. 
\item[\tipo{void} \var{gb\_new\_arc(\tipo{Vertex} *u, \tipo{Vertex}
*v, \tipo{long} len)}.]
Cria um novo arco de comprimento \var{len} de \var{u} at� \var{v}. 
O arco passa a ser parte do grafo "corrente". 
O novo arco ser� apontado por \var{u$\rightarrow$arcs}.
\item[\tipo{void} \var{gb\_new\_edge(\tipo{Vertex} *u,
\tipo{Vertex} *v, \tipo{long} len)}.]
Similar a \var{gb\_new\_arc}. Registros para dois arcos s�o criados, um
de \var{u} a \var{v} e outro de \var{v} a \var{u}. 
Os dois arcos aparecem em posi��es
consecutivas na  mem�ria: \var{v$\rightarrow$arcs} �
$\var{u$\rightarrow$arcs} + 1 \ \mbox{quando} \ u < v$. 
\item[\tipo{char} \var{*gb\_save\_string (\tipo{char} *s)}.]
Faz uma c�pia de \var{s} para ser usada no grafo "corrente". 
\item[\tipo{void} \var{gb\_recycle (\tipo{Graph} *g)}.]
Remove o grafo apontado por \var{g} da mem�ria. 
\end{quote}

\paragraph{M�dulo GB\_SAVE do \SGB{}}. 
 Este m�dulo cont�m c�digo para converter grafos da sua representa��o
interna para uma representa��o simb�lica e vice-versa. 
 
\begin{quote}

\var{\#}\tipo{include} \texttt{gb\_save.h}

\item[\tipo{long} \var{save\_graph (\tipo{Graph} *g, \tipo{char} *filename)}.]
Converte o grafo apontado por \var{g} para formato texto e salva o grafo no
arquivo de nome \var{filename}. 
\item[\tipo{Graph} \var{*restore\_graph (\tipo{char} *filename)}.]
Converte um grafo armazenado no arquivo \var{filename} do formato texto para a
representa��o interna do \SGB{}. 
\end{quote}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  IMPLEMENTA��O
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Estrutura da implementa��o}

 As implementa��es de todos os algoritmos discutidos nesta disserta��o 
 est�o escritas em \CWEB{}, e fazem uso da plataforma \SGB{}. 

 A seguir, segue a estrutura geral do programa:

@i gb_types.w
@i boilerplate.w

@c
@<Inclus�o de arquivos header@>@;
@<Defini��es@>@;
@<Vari�veis globais@>@;
@<Fun��es auxiliares@>@;
@<Filas de prioridade@>@;
@<Algoritmo de Dijkstra@>@;
@<Algoritmo de Dinitz-Thorup@>@;
@<Algoritmo de Thorup@>@;
@<Teste da condi��o de otimalidade@>@;
@<Programa principal@>
@ 
%No bloco |@<Algoritmo de Dijkstra@>|, ser� descrito a implementa��o
%do algoritmo de Dijkstra. Como pode ser visto em ~\ref{dijkstra-cweb}.









