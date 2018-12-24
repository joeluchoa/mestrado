\chapter{Algoritmo de Dijkstra}
\label{cap:dijkstra}

Neste cap�tulo ser� descrito o celebrado algoritmo de
Dijkstra~\cite{dijkstra59:note} que resolve o problema do caminho m�nimo,
apresentado na se��o~\ref{sec:problema-descricao}, ou seja:
\begin{quote}
\textbf{Problema} PCM$(V,A,c,s)$:%
\index{PCM}\mar{PCM}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dado um grafo $(V,A)$, uma fun��o comprimento $c$ de $A$ em $\NonnegInt$ e um
v�rtice $s$, encontrar um caminho de comprimento m�nimo de $s$ at� $t$, para
cada v�rtice~$t$ em $V$.
\end{quote}


%Um caminho $P$ tem \defi{comprimento m�nimo} se $c(P) \leq c(P')$ para todo
%caminho $P'$ que tenha a mesma origem e t�rmino que $P$.

A id�ia geral do algoritmo de Dijkstra para resolver o problema � a seguinte.
O algoritmo � iterativo.  No in�cio de cada itera��o tem-se dois conjuntos
disjuntos de v�rtices $S$ e $\L$. O algoritmo conhece caminhos de $s$ a cada
v�rtice em $S \cup \L$ e para os v�rtices em $S$ o algoritmo sabe que o caminho
conhecido tem comprimento m�nimo. Cada itera��o consiste em remover um v�rtice
apropriado de $\L$, inclu�-lo em $S$ e examin�-lo, acrescentando, eventualmente,
novos v�rtices a~$\L$.

A descri��o abaixo segue de perto a feita por Feofiloff~\cite{pf:aula}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  DESCRI��O
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Descri��o}
\label{sec:dijkstra-descricao}
Para cada v�rtice $t$, acess�vel a partir de um dado v�rtice $s$, o algoritmo
de Dijkstra encontra um caminho de $s$ a $t$ que tem comprimento m�nimo.  Da
condi��o de otimalidade (corol�rio~\ref{corolario:otimalidade}) tem-se
que, 
para provar que um caminho $P$ de um v�rtice $s$ a um v�rtice $t$ tem
comprimento m�nimo, basta exibir uma fun��o potencial vi�vel $\fp$ tal que $c(P)
= \fp(t) - \fp(s)$. Por outro lado, a condi��o de inacessibilidade
(corol�rio~\ref{corolario:inacessibilidade}) diz que se $\fp$ � uma fun��o
potencial vi�vel com $\fp(t) - \fp(s) = nC + 1$, ent�o $t$ n�o � acess�vel a
partir de $s$, onde $n$ � o n�mero de v�rtices do grafo e $C := \max\{c(u,v)
\tq uv \in A\}$. A corre��o do algoritmo de Dijkstra
fornecer� a rec�proca dessas condi��es.

\begin{quote}
  \textbf{Algoritmo de Dijkstra}.  Recebe um grafo $(V,A)$, uma fun��o
  comprimento $c$ de $A$ em $\NonnegInt$
  e um v�rtice $s$ e devolve uma
  fun��o predecessor $\pred$ e uma fun��o potencial $\fp$ que respeita $c$
  tais que, para cada v�rtice $t$, se $t$ � acess�vel a partir de $s$, ent�o
  $\pred$ determina um caminho de $s$ a $t$ que tem comprimento $\fp(t) -
  \fp(s)$, caso contr�rio, $\fp(t)-\fp(s) = nC+1$, 
  onde $C := \max\{ c(u,v) \tq uv \in A\}$ e $n := ^^7cV^^7c$. 
\end{quote}


Cada itera��o come�a com 
uma fun��o potencial $\fp{}$, 
uma fun��o predecessor $\pred$, 
e partes $S, \L$ e $U$ de $V$.

No in�cio da primeira itera��o  
$\fp(s) = 0$ e $\fp(v) = nC + 1$ para cada v�rtice $v$ distinto de $s$, 
$\pred(v) = v$ para cada v�rtice $v$,
$S = \emptyset$,
$\L = \{s\}$ e $U = V \setminus \{s\}$.

Cada itera��o consiste no seguinte.
\balgor
\item\textbf{Caso 1:} \ $\L = \emptyset$.

  Devolva $\fp{}$ e $\pred$ e pare.

\item \textbf{Caso 2:} \ {$\L \neq \emptyset$.}

  Escolha $u$ em $\L$ tal que $\fp(u)$ seja m�nimo.

  $S' := S \cup \{u\}$.

  $\L' := \L \setminus \{u\}$.
 
  $U'  := U$.

  Para cada $v$ em $V$ fa�a $\fp'(v) := \fp(v)$ e $\pred'(v) := \pred(v)$.

  Para cada arco $uv$ fa�a 

 \x Se\ $\fp'(v) > \fp(u) + c(u,v)$ ent�o 

 \xx $\fp'(v) := \fp(u) + c(u,v)$, $\pred'(v) := u$ e remova\footnote{�
 poss�vel que $v$ j� perten�a a $\L'$ e n�o esteja em $U'$. Nesse caso, estas
 �ltimas duas instru��es s�o redundantes.} $v$ de $U'$ e acrescente a $\L'$.
 
 Comece nova itera��o com $\fp'$, $\pred'$, $S'$, $\L'$ e $U'$  
nos pap�is de $\fp{}$, $\pred$, $S$, $\L$ e $U$.
\qed
\ealgor
 
Nas interpreta��es intuitivas do algoritmo de Dijkstra � comum dizer
que $\fp$ guarda \defi{dist�ncias tentativas}\index{distancia@@dist�ncia!tentativa},
 que $S$ � o conjunto dos v�rtices
\defi{examinados},\index{vertice@@v�rtice!examinado} $\L$ � o conjunto dos
v�rtices \defi{visitados}\index{vertice@@v�rtice!visitado} e que $U$ � o
conjunto dos v�rtices
\defi{adormecidos}.\index{vertice@@v�rtice!adormecido}
A figura~\ref{fig:sim_djk} ilustra o algoritmo de Dijkstra em a��o.
\begin{figure}[htbp]
 \begin{center}
    \psfrag{(a)}{(a)}
    \psfrag{(b)}{(b)}
    \psfrag{(c)}{(c)}
    \psfrag{(d)}{(d)}
    \psfrag{(e)}{(e)}
    \psfrag{(f)}{(f)}
    \psfrag{(g)}{(g)}
    \psfrag{(h)}{(h)}
    \psfrag{s}{{$s$}}
    \psfrag{a}{{$a$}}
    \psfrag{b}{{$b$}}
    \psfrag{c}{{$c$}}
    \psfrag{d}{{$d$}}
    \psfrag{t}{{$t$}}
    \psfrag{0}{{$0$}}
    \psfrag{1}{{$1$}}
    \psfrag{2}{{$2$}}
    \psfrag{3}{{$3$}}
    \psfrag{4}{{$4$}}
    \psfrag{5}{{$5$}}
    \psfrag{6}{{$6$}}
    \psfrag{7}{{$7$}}
    \psfrag{25}{{$25$}}
    \includegraphics{fig/dijk_simulacao1.eps}
  \caption[{\sf Simula��o do algoritmo de Dijkstra}]
  {\label{fig:sim_djk} Execu��o do algoritmo de Dijkstra. O v�rtice
  inicial � $s$. (a) exibe um grafo com comprimento nos arcos. 
  (b) mostra a situa��o no in�cio da primeira itera��o.
Se um arco $(u,v)$ est� sombreado, ent�o $\pred(v) = u$.
Os potenciais s�o os n�meros pr�ximos a cada v�rtice.  
Os v�rtices pretos s�o os de $S$, 
os v�rtices cinzas s�o os de $\L$, 
e os v�rtices brancos est�o em $U$.
 (c)-(g) exibem a situa��o ap�s cada itera��o do caso 2.  
 Os valores finais da fun��o potencial $\fp$, 
 e da fun��o predecessor $\pred$, s�o mostrados em (h).}
 \end{center}
 \end{figure}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  INVARIANTES
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Invariantes}
\label{sec:dijkstra-invariantes}
\index{invariantes do algoritmo de!Dijkstra}

A corre��o do algoritmo de Dijkstra baseia-se nas demonstra��es da validade de
uma s�rie de invariantes, enunciados a seguir. Estes invariantes s�o afirma��es
envolvendo os dados  do problema $V,A,c$ e $s$ e os objetos
$\fp, \pred, S, \L$ e  $U$. As afirma��es s�o
v�lidas no in�cio de cada itera��o do algoritmo e dizem como estes objetos
se relacionam entre si e com os dados do problema.


Os invariantes est�o agrupados conforme os objetos envolvidos.
 
\paragraph{Estrutura do grafo.} Os dois invariantes a seguir envolvem somente
as partes $S, \L$ e $U$. A estrutura induzida por estas parti��es �
ilustrada na figura~\ref{fig:invariantes}(a).
\begin{enumerate}
%%% Estrutura do grafo em rela��o � parti��o
\item[(dk1)] (parti��o) As partes $S, \L$ e $U$ formam uma parti��o de
  $V$.
 
 
\item[(dk2)] ($A(S,U) = \emptyset$) n�o existe arco $uv$ com $u$
em $S$ e $v$ em $U$.
\end{enumerate}
 

%%% Figura representando os invariantes.
\begin{figure}[htbp]
 \begin{center}
    \psfrag{S}{{$S$}}
    \psfrag{Q}{{$\L$}}
    \psfrag{U}{{$U$}}
    \psfrag{d(u)}{{$\fp(u)$}}
    \psfrag{d(v)}{{$\fp(v)$}}
    \psfrag{d(w)}{{$\fp(w) = nC+1$}}
    \psfrag{<=}{{$\leq$}}
    \psfrag{<}{{$<$}}
    \psfrag{u}{{$u$}}
    \psfrag{v}{{$v$}}
    \psfrag{w}{{$w$}}
    \psfrag{(a)}{(a)}
    \psfrag{(b)}{(b)}
    \psfrag{(c)}{(c)}
    \psfrag{(d)}{(d)}
  \includegraphics{fig/invariante.eps}
  \caption[{\sf Invariantes do algoritmo de Dijsktra}]
  {\label{fig:invariantes}Ilustra��o dos invariantes.
    A figura~(a) mostra a estrutura do grafo em rela��o � parti��o $S,\L$ e $U$
    de $V$ (invariantes~\iten{dk1} e \iten{dk2}). (b) exibe a rela��o
    de ordem envolvendo os potenciais dos v�rtices e as partes $S$, $Q$
    e $U$ (invariante (dk3)). 
    A figura~(c) mostra os arcos
    determinados pela fun��o predecessor $\pred$ (invariantes~\iten{dk4},
    \iten{dk5} e \iten{dk6}). Em (d) os arcos ``pontilhados'' s�o os que
    desrespeitam $c$, os com o s�mbolo ``?'' ao lado s�o os que podem ou n�o
    respeitar $c$, e o arcos ``cheios'' s�o os que respeitam $c$ (invariantes
    de \iten{dk7} a \iten{dk11}).}
 \end{center}
 \end{figure}

\paragraph{Fun��o potencial e $\{S,\L,U\}$.} 
O pr�ximo invariante reflete o fato do algoritmo examinar os v�rtices em ordem
n�o-decrescente da dist�ncia a partir de $s$, ilustrado na
figura~\ref{fig:invariantes}(b).
\begin{enumerate}
\item[$\iten{dk3}$] (monotonicidade) para cada $u$ em $S$, $v$ em $\L$ e
 $w$ em $U$ vale que\footnote{A express�o~``$\fp(u) \leq \fp(v) <
\fp(w) = nC + 1$''~deve ser entendida como uma abrevia��o. Se algum
dos conjuntos envolvidos � vazio, considere as desigualdades que fazem sentido.}
\[
d(u) \leq d(v) < d(w) = nC + 1.
\]
\end{enumerate}

\paragraph{Fun��o predecessor e $\{S,\L,U\}$.}
A estrutura da fun��o predecessor em cada itera��o, descrita pelos invariantes
abaixo, est� ilustrada na figura~\ref{fig:invariantes}(c). 

%%% Estrutura de \pred com (S,Q,U)
\begin{enumerate}
\item[$\iten{dk4}$] ($\pred(\L) \subseteq S$) Para cada $u$ em $\L$ vale que 
$\pred(u)$ est� em $S$.

\item[$\iten{dk5}$] (identidade) Para cada $u$ em $U$ vale que 
$\pred(u)=u$.

\item[$\iten{dk6}$] (estrutura arb�rea de $\pred$) A fun��o $\pred$ restrita
  aos v�rtices em $S\cup \L$ determina uma arboresc�ncia em $(V,A)$ com raiz
  $s$.
\end{enumerate}

\paragraph{Arcos onde a fun��o potencial respeita ou desrespeita $c$.}
Com excess�o feita aos arcos com ambas as pontas em $\L$, o algoritmo sabe se
$\fp$ respeita ou `desrespeita' $c$ em cada um dos demais arcos do grafo.
Isto n�o � nenhuma surpresa, tendo em vista que os v�rtices em $\L$ tiveram
seus potenciais alterados e os arcos com ambas as pontas em $\L$ ainda n�o
foram examinados. A situa��o encontra-se ilustrada na
figura~\ref{fig:invariantes}(d).

%%%% Estrutura dos arcos onde $d$ respeita $c$.
\begin{enumerate}
\item[$\iten{dk7}$] ($\fp$ respeita $c$ em $A[S]$)
 Para cada arco $uv$ com $u$ e $v$ em $S$ vale que 
\[
d(v) - d(u) \leq c(u,v).
\]


\item[$\iten{dk8}$] ($\fp$ respeita $c$ em $A[U]$) 
Para cada arco $uv$ com $u$ e $v$ em $U$ vale que 
\[
d(v) - d(u) = (nC+1) - (nC+1) = 0 \leq c(u,v).
\]

\item[$\iten{dk9}$] ($\fp$ respeita $c$ em $A(S,\L)$ e $A(\L,S)$) 
 Para cada arco $uv$ com $u$ em $S$ e $v$ em $\L$ ou 
                             $u$ em $\L$ e $v$ em $S$ vale que 
\[
d(v) - d(u) \leq c(u,v).
\]

\item[$\iten{dk10}$] ($d$ respeita $c$ em $A(U,S)$ e $A(U,\L)$)
Para cada arco $uv$ com $u$ em $U$ e $v$ em $S \cup \L$ vale que 
\[
d(v) - d(u) = d(v) - (nC + 1) < c(u,v).
\]

\item[$\iten{dk11}$] ($d$ desrespeita $c$ em $A(\L,U)$)
Para cada arco $uv$ com $u$ em $\L$ e $v$ em $U$ vale que 
\[
d(v) - d(u) = (nC + 1) - d(u) > c(u,v).
\]
\end{enumerate}

%%%% Liga $\pred$ com $\fp$
%\noindent
\paragraph{Fun��o potencial e fun��o predecessor}
\begin{enumerate}
\item[$\iten{dk12}$] (folgas complementares) 
para cada arco $uv$ tal que $\pred(v) = u$ vale que 
\[
d(v) - d(u) =  c(u,v).
\]

%\item[\iten{i0}] para cada $u$ em $S$, $\fp(u) - \fp(s) = c(P)$, onde
% $P$ � o caminho de comprimento m�nimo de $s$ a $u$ determinado por $\pred$.
%\item[\iten{i1}] para cada $u$ em $S$ e $v$ em $V \backslash S$,
%$\fp(u) \leq \fp(v)$ 
\end{enumerate}

%Supondo-se que as afirma��es acima valem no in�cio da �ltima itera��o � f�cil
%demosntrar a corre��o do algoritmo. 

 
%%%% DEMONSTRA��ES


 Para demonstrar que as afirma��es acima s�o leg�timos invariantes
%que cada uma destas vale no in�cio de cada itera��o 
deve-se  demonstrar que:
\begin{enumerate}
\item[(a)] as afirma��es  valem no in�cio da primeira itera��o; e
\item[(b)] se as afirma��es valem no in�cio de uma itera��o em que  
ocorre o caso~2, ent�o as afirma��es tamb�m valem ao final da itera��o
com $\fp', \pred', S', \L'$ e $U'$
nos pap�is de $\fp, \pred, S, \L$ e $U$.
\end{enumerate}
De (a) e (b) conclui-se que as afirma��es tamb�m valem no in�cio da �ltima
itera��o; quando ocorre o caso~1. Supondo-se, � claro, que mais cedo
ou mais tarde o caso~1 sempre ocorre.
 
� evidente que cada uma das afirma��es valem no in�cio da primeira itera��o e
n�o � dif�cil verificar~(b) para cada umas das afirma��es. A seguir est�o as
demonstra��es de \iten{dk1}, \iten{dk2}, \iten{dk3}, \iten{dk7} e \iten{dk9} a
t�tulo de ilustra��o.  Nas demonstra��es, s�o feitas refer�ncias ao
procedimento de examinar um v�rtice ou arco como descrito na
se��o~\ref{sec:examinar}.
 
\begin{provainv}{\iten{dk1}}
  Considere uma itera��o em que ocorre o caso~2.  No in�cio da itera��o, $\{S,
  \L, U\}$ � uma parti��o de $V$. Portanto, antes do algoritmo examinar o
  v�rtice $u$ tem-se que $\{S', \L', U'\}$ � uma parti��o de $V$, j� que $S' =
  S \setminus \{u\}$, $\L' = \L \cup \{u\}$, e $U' = U$. Durante o exame de cada
  arco, os v�rtices eventualmente removidos de $U'$ s�o a seguir inseridos em
  $\L'$. Logo, no final da itera��o, $\{S', \L', U'\}$ forma uma parti��o de~$V$.
\end{provainv}
 
\begin{provainv}{\iten{dk2}}
  Considere uma itera��o em que ocorre o caso~2.  No in�cio da itera��o tem-se
  que $A(S,U) = \emptyset$. Imediatamente antes do v�rtice $u$ ser examinado
  vale que $S' = S \cup \{u\}$ e $U' = U$. Do invariante~\iten{dk11}
  sabe-se que, 
  para cada arco $uv$ com $u$ em $S'$ e $v$ em $U'$, 
\[
d(v) - d(u) > c(u,v).
\]    
Assim, cada arco $uv$ com $v$ em $U'$ ser�, durante o exame do arco $uv$,
removido de $U'$ e acrescentado a $\L'$. Portanto, no final da itera��o, tem-se
que $A(S',U') = \emptyset$.
\end{provainv}

� importante notar que na demonstra��o de \iten{dk3} e \iten{dk9}
que � utilizada a
escolha apropriada do v�rtice $u$: $\fp(u) \leq \fp(v)$ para cada $v$ em $\L$.
 
\begin{provainv}{\iten{dk3}}
  Considere uma itera��o em que ocorre o caso~2.  Note que ao final da
  itera��o tem-se que $\fp'(v) \neq \fp(v)$ se e somente se $v$ est� em $\L'
  \subseteq (\L \setminus \{u\}) \cup U$ e $uv$ � um arco do grafo com
  $\fp(v)-\fp(u) > c(u,v)$. Ademais,  
  se $\fp'(v) \neq \fp(v)$ ent�o $\fp'(v) = \fp(u) + c(u,v) < \fp(v)$.
  
  Do invariante~\iten{dk3} sabe-se que para cada $x$ em $S$, $y$ em $\L$ e $z$
  em $U$ vale que $d(x) \leq d(y) < d(z) = nC+1$. Assim, pela escolha de $u$ (e como
  $c$ � uma fun��o de $A$ em $\NonnegInt$), ap�s examinar o v�rtice~$u$ tem-se que 
\[
\fp'(x)  \leq \fp (u) \leq \fp'(y) < \fp'(z) = nC + 1
\] 
para cada $x$ em $S'= S \cup \{u\}$, $y$ em $\L'$ e $z$ em $U'$.
\end{provainv}

\begin{provainv}{\iten{dk7}}
  No in�cio da itera��o tem-se que $\fp$ respeita $c$ em $A[S]$ (invariante
  \iten{dk7}), em $A(S,Q)$, e em $A(\L,S)$. Desta forma, no final de
  uma itera��o em que
  ocorre o caso~2 vale que $\fp'$ respeita $c$ em $A[S']$, pois $S' = S \cup
  \{u\}$ e $\fp'(v)=\fp(v)$ para todo $v$ em $S'$.
\end{provainv}
 
\begin{provainv}{\iten{dk9}}
  Novamente, considere uma itera��o em que ocorre o caso~2.  Da demonstra��o
  do invariante~\iten{dk3}, obtem-se que no final da itera��o vale que $\fp'(x)
  - \fp'(y) \leq 0$ para cada $x$ em $S'= S \cup \{u\}$, $y$ em $\L'$.
  Portanto, como os comprimentos dos arcos s�o n�o-negativos, $\fp'$ respeita
  $c$ em $A(\L',S')$.
  
  O processo de examinar $u$ faz com que $\fp'$ respeite $c$ em cada arco com
  ponta inicial em $u$. Do invariante~\iten{dk9} sabe-se que $\fp$ respeita
  $c$ em $A(S,\L)$.  Assim, como $\fp'(v) = \fp(v)$ para cada $v$ em $S'$ e 
  $\fp'(v) \leq \fp(v)$ para cada $v$ em $\L'$,
  conclu�-se que $\fp'$ respeita $c$ em $A(S',\L')$.

% \begin{eqnarray}
% \label{eq:min}
% \fp'(u) - \fp'(v) = \fp(u) - \fp(v) \leq c(v,u),
% \end{eqnarray}
% j� que $c$ � uma fun��o de $A$ em $\NonnegInt$ e pela escolha de $u$ tem-se
% que $\fp(u) \leq \fp(v)$ para todo $v$ em $\L$. Assim, de (\ref{eq:min}) e do
% invariante \iten{dk7} pode-se concluir que $\fp'$ respeita $c$ em
% $A(\L,S')$. Finalmente, ap�s o v�rtice 

% No in�cio da itera��o tem-se que $\fp$ respeita $c$ em $A[S]$ (invariante
% \iten{dk7}) e em $A(\L,S)$. Desta forma, no final de uma itera��o em que ocorre
% o caso~2 cale que $\fp'$ respeita $c$ em $A[S']$, pois $S' = S \cup \{u\}$ e
%$\fp'(v)=\fp(v)$ para todo $v$ em $S'$.
\end{provainv}
 

 

%Suponha agora que os invariantes valem no in�cio de uma itera��o em que ocorre o
%caso 2.

%DEMONSTRA��O DE \iten{i0}: No in�cio dessa itera��o, sabemos que para cada $w$ em $S$ vale que  
%$\fp(w) - \fp(s) = c(P')$, onde $P'$ � o caminho de $s$ a $w$. 
%Seja $u$ o v�rtice com menor potencial escolhido durante
%a execu��o do caso 2. Em particular, para algum $w$ em $S$, $wu$ � um
%arco em $A$, pois $u$ est� em $\L$.
%Logo, existe um caminho $P$ de $s$ a $u$, e pelo Lema~\ref{lema:dualidade}
%vale que $\fp(u) - \fp(s) \leq c(P)$. Suponha que existe $u'$ em $V
%\backslash S$
%tal que $\fp(u') - \fp(s) < c(P)$. 
%Ent�o, $\fp(u') \leq \fp(u)$ contrariando a hip�tese de que $\fp(u)$ � m�nimo.
%Portanto, $\fp(u) - \fp(s) = c(P)$. E pelo
%Corol�rio~\ref{corolario:otimalidade},
%$P$ � um caminho de comprimento m�nimo de $s$ a $u$.

%No final da itera��o, vamos ter $u$ pertencente a $S'$. Assim que, $S'$ passar a
%valer $S$, o resultado segue. \fimprova

%DEMONSTRA��O DE \iten{i1}: No final dessa itera��o vamos ter $u$ pertencente a $S'$,
%e $\fp(u) \leq \fp'(v)$ para cada $v$ em $V \backslash S'$, pois $\fp(u)$ �
%m�nimo. Ent�o, $\fp'$ e $S'$ passam a valer $\fp$ e $S$. Como
%desejado. \fimprova


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  CORRE��O
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Corre��o}
\label{sec:dijkstra-correcao}

A corre��o do algoritmo de Dijkstra � facilmente demonstrada atrav�s dos
invariantes apresentados.  
 
%A seguir � denotado por $U$ a parte
%$V\setminus(S\cup\L)$ de $V$.
 
\begin{teorema}{teorema da corre��o}
\label{teo:correcao-dijkstra}
%O algoritmo de Dijkstra 
%recebe um grafo $(V,A)$, uma fun��o comprimento $c$ de
%$A$ em $\NonnegInt$ e um v�rtice $s$ e 
Para cada v�rtice $t$ acess�vel a
partir de $s$ o algoritmo de Dijkstra devolve um caminho de $s$ a $t$ que tem
comprimento m�nimo.
\end{teorema}
 
\begin{prova}
Suponha que  $\pred$ e $\fp$ s�o as fun��es devolvidas pelo algoritmo.
%%%% L = vazio
Quando o algoritmo p�ra tem-se que $\L = \emptyset$ e do invariante \iten{dk1}
vale que $S$ e $U$ � uma parti��o de $V$.
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% S � o conjunto de v�rtices acess�veis 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ao final do algoritmo, $S$ � o conjunto de v�rtices acess�veis a partir de $s$.
De fato, pelo invariante \iten{dk2}
sabe-se que nenhum v�rtice de $U$ � acess�vel a partir de $s$, j� que $A(S,U) =
\emptyset$,  e pelo invariante~\iten{dk6} tem-se que para cada v�rtice $t$ em
$S$ a fun��o $\pred$ 
determina um caminho de $s$ a $t$, j� que $\pred$ determina uma arboresc�ncia 
em $(S,A[S])$ com raiz em $s$.

Como $\L = \emptyset$ e $A(S,U) = \emptyset$, ent�o dos invariantes \iten{dk7}
a \iten{dk10} conclui-se que a fun��o potencial $\fp$ � vi�vel.

Resta apenas verificar que cada caminho $P$ com in�cio em $s$, e 
determinado por $\pred$, tem comprimento m�nimo. Suponha que $t$ em
$S$ � o t�rmino de $P$. 
Do invariante \iten{dk12} obtem-se que $c(P) = \fp(t) - \fp(s)$. Finalmente,
como $\fp$ � vi�vel, pela condi��o de otimalidade conclui-se que $P$ tem
comprimento m�nimo.
\end{prova}

Um corol�rio importante da corre��o do algoritmo � a seguinte especializa��o
do teorema da dualidade de programa��o linear ao PCM.

\begin{teorema}{teorema da dualidade}
\label{teorema:dualidade}
Seja $(V,A)$ um grafo, $c$ uma fun��o comprimento de $A$ em $\NonnegInt$ e $s$
e $t$ v�rtices do grafo. 
Se $t$ � acess�vel a partir de $s$, ent�o vale que
\[
\min \{c(P) \tq \mbox{$P$ � um caminho de $s$ a $t$}\} = \max \{\fp(t) - \fp(s)
  \tq \mbox{$\fp$ � uma fun��o potencial vi�vel} \}. 
\]
\end{teorema} 

\begin{prova}
  Do lema da dualidade~\ref{lema:dualidade} tem-se que para todo caminho $P'$
  e toda fun��o potencial vi�vel $\fp'$ vale que $c(P') \geq \fp'(t) -
  \fp'(s)$.  O algoritmo de Dijkstra devolve um caminho $P$ e uma fun��o
  potencial vi�vel $\fp$ tal que $c(P) = \fp(t) - \fp(s)$. Logo, $P$ � um
  caminho que tem comprimento m�nimo e $\fp$ � uma fun��o potencial vi�vel
  para a qual a diferen�a de potencial entre $s$ e $t$ � m�xima.
\end{prova}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  EFICI�NCIA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Efici�ncia}
\label{sec:dijkstra-eficiencia}
 
% \textbf{N�mero de itera��es.}

Primeiro, � conveniente notar que $\fp', \pred', S', \L'$ e $U'$ foram
introduzidos na descri��o do algoritmo por meras raz�es t�cnicas: ajudam nas
demonstra��es de invariantes. Desta forma, em termos de efici�ncia, n�o h�
necessidade de levar em considera��o as instru��es que inicializam estes
objetos, j� que estas podem ser simplesmente eliminadas da descri��o.
A descri��o pode ser feita inteiramente em
termos de $\fp, \pred, S, \L$ e $U$.

O n�mero de ocorr�ncias do caso 2 � no m�ximo $n$, pois em cada ocorr�ncia �
acrescentado um novo v�rtice a $S$ e $\{S,\L,U\}$ � uma parti��o de $V$.
Portanto, o n�mero de itera��es � no m�ximo
$n+1$.


%\textbf{Efici�ncia no pior caso.} 
 
As duas seguintes opera��es s�o as principais respons�veis pelo consumo de
  tempo assint�tico do algoritmo:
  \begin{description}
  \item{Escolha de um v�rtice com potencial m�nimo.}  Cada
  execu��o desta opera��o gasta tempo $O(n)$.  Como o n�mero de ocorr�ncias do
  caso~2 � no m�ximo $n$, ent�o o tempo total gasto 
   pelo algoritmo para realizar essa opera��o � $O(n^{2})$.

  \item{Atualiza��o do potencial.} Ao examinar um arco o algoritmo
  eventualmente diminui o potencial da ponta final. Essa atualiza��o de
  potencial � realizada n�o mais que $^^7c A(u)^^7c$ vezes ao examinar
  o v�rtice $u$. 
%
%\footnote{conjunto do arcos com ponta inicial em $u$} vezes para  cada
%  v�rtice $u$ em $V$. 
  Ao todo, o algoritmo pode realizar essa opera��o n�o mais que 
  $\sum_{u \in V} ^^7c A(u) ^^7c = m$ 
  vezes. Desde que cada atualiza��o seja feita em tempo constante, o algoritmo
  requer uma quantidade de tempo proporcional a $m$ para atualizar potenciais.
\end{description}

Assim, o consumo de tempo do algoritmo no pior caso � $O(n^{2} + m) = O(n^{2})$.
O teorema abaixo resume a discuss�o.

\begin{teorema}{consumo de tempo}
\label{teorema:consumo-de-tempo}
O algoritmo de Dijkstra, quando executado, no modelo de compara��o-adi��o, em
um grafo com $n$ v�rtices e $m$ arcos, gasta tempo $O(n^2)$. \fimprova
\end{teorema}
 
Para grafos densos, ou seja, grafos onde $m = \Omega(n^{2})$, o consumo de
tempo de $O(n^{2})$ do algoritmo de Dijkstra � �timo, pois, �
necess�rio que todos os arcos do grafo sejam examinados. Entretanto, se $m =
O(n^{2-\epsilon})$ para algum $\epsilon$ positivo, existem m�todos
sofisticados, como o heap de Johnson~\cite{johnson:heap}, o fibonacci
heap de Fredman e Tarjan~\cite{FredTarjan:Fibonacci}, que permitem
diminuir o tempo gasto para encontrar um v�rtice com 
potencial m�nimo, gerando assim implementa��es que consomem menos tempo para
resolver o problema.
   
A maneira mais utilizada para realizar as opera��es acima � atrav�s de
implementa��es de filas de prioridade, que ser� objeto de estudo do
pr�ximo cap�tulo.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  COMPLEXIDADE DO ALGORITMO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Complexidade}
\label{sec:complexidade-dijk}

Fredman e Tarjan~\cite{FredTarjan:Fibonacci} observaram que como o algoritmo
de Dijkstra examina os v�rtices em ordem de dist�ncia a partir de $s$
(invariante~\iten{dk3}) ent�o o algoritmo est�, implicitamente, ordenando estes
valores (ver figura~\ref{fig:liminferior}). Assim, qualquer 
implementa��o do algoritmo de Dijkstra para o modelo de compara��o-adi��o realiza,
 no pior caso, $\Omega(n \log n)$ compara��es. Portanto,
qualquer implementa��o do algoritmo para o modelo de compara��o-adi��o faz
$\Omega(m + n \log n)$ opera��es elementares. 

\begin{teorema}{limitante inferior}
\label{teorema:limitante-inferior}
No modelo de compara��o-adi��o, o algoritmo de Dijkstra, quando
executado em um 
grafo com $n$ v�rtices e $m$ arcos, gasta tempo $\Omega(m + n \log
n)$. \fimprova
\end{teorema}

\begin{figure}[htbp]
 \begin{center}
    \psfrag{x1}{{$x_1$}}
    \psfrag{x2}{{$x_2$}}
    \psfrag{x3}{{$x_3$}}
    \psfrag{x4}{{$x_4$}}
    \psfrag{x5}{{$x_5$}}
    \psfrag{xn}{{$x_n$}}
    \psfrag{a1}{{$\alpha_1$}}
    \psfrag{a2}{{$\alpha_2$}}
    \psfrag{a3}{{$\alpha_3$}}
    \psfrag{a4}{{$\alpha_4$}}
    \psfrag{a5}{{$\alpha_5$}}
    \psfrag{an}{{$\alpha_n$}}
    \psfrag{a1,an}{{$\alpha_1, \ldots, \alpha_n$}}
    \psfrag{sequencia ordenada}{{seq��ncia ordenada}}
  \includegraphics{fig/liminferior.eps}
  \caption[{\sf Algoritmo de Dijsktra ordenando uma seq��ncia}]
  {\label{fig:liminferior} Esquema ilustrando como o algoritmo de
  Dijkstra pode ser utilizado para ordenar uma seq��ncia de n�meros $\alpha_1,\ldots,\alpha_n$.}
 \end{center}
 \end{figure}
 
 Por outro lado, Thorup~\cite{thorup:ram-2000} mostrou que 
 um algoritmo linear para ordena��o pode ser usado em uma
 implementa��o do algoritmo de Dijkstra que executa um n�mero de opera��es
 proporcional ao tamanho do grafo.
 
No pr�ximo cap�tulo ser� mostrada a implementa��o de Fredman e
Tarjan~\cite{FredTarjan:Fibonacci} para modelo de compara��o-adi��o que gasta
tempo $O(m + n \log n)$. O algoritmo de Dijkstra com essa
implementa��o � �timo.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  Vers�o CWEB
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Vers�o em \CWEB}
\label{dijkstra-cweb}

@ Das partes $S$, $\L$ e $U$ descritas na
se��o~\ref{sec:dijkstra-descricao}, as partes $S$ e $U$ n�o entram na
implementa��o. E a parte $\L$ � representada atrav�s de uma fila de
prioridade (se��o~\ref{sec:filadeprioridade}).\\
Para criar $\L$ � utilizada a opera��o \textsf{create\_pq}, e as
opera��es de $\L$ ser�o representadas pelas fun��es \textsf{insert},
\textsf{delete\_min} e \textsf{decrease\_key}. 

@<Filas de prioridade@>=
void  @[@] (*create_pq)();  /* cria $\L$ */
void  @[@] (*insert)();
Vertex *(*delete_min)();
void  @[@] (*decrease_key)();

@ Os itens armazenados em $\L$ s�o v�rtices, e como valor associado a
cada um deles, temos o potencial.
 O potencial em cada v�rtice ser� representado pelo campo |dist|, e o  
predecessor pelo campo |pred|. 

@<Defini��es@>=
#define dist @,@,@,@, v.I
#define pred @,@,@,@, u.V

@ Ser� armazenado na vari�vel |qsize|, o n�mero de v�rtices em $\L$.
@<Vari�veis globais@>=
unsigned long qsize;

@ 
@<Algoritmo de Dijkstra@>=
void 
dijkstra(g, s)
   Graph *g;
   Vertex *s; /* v�rtice inicial */
{@+@<Vari�veis de Dijkstra@>@;
 
 @<Inicializa $\fp$ e $\pred$@>@;
 
 @<Inicializa a fila $\L$ com |s|@>@;
    
 while(@<Fila $\L$ n�o est� vazia@>){@;

   @<Escolha |u| em $\L$ tal que $\fp(u)$ seja m�nimo@>@;
     
   @<Examine o v�rtice |u|@>@;
  
 }

}

@ @<Vari�veis de Dijkstra@>=
register Vertex *v, *u;
register Arc *a;

@  No in�cio da primeira itera��o tem-se que 
$\fp(s) = 0$ e $\fp(v) = nC + 1$ para cada v�rtice $v$ distinto de $s$, 
$\pred(v) = v$ para cada v�rtice $v$. Na implementa��o, $nC + 1$ ser�
representado pela vari�vel |infinito|.
  
@<Inicializa $\fp$ e $\pred$@>=
for(v = g->vertices; v < g->vertices + g->n; v++){
  v->dist = infinito;
  v->pred = v;
}
s->dist = 0;
num_exam = 0;
atualiza_fp = 0;

@ Cria $\L$ e a inicializa com o v�rtice inicial $s$.
@<Inicializa a fila $\L$ com |s|@>=
create_pq(g); qsize = 0;
insert(s);  
qsize++;

@ @<Fila $\L$ n�o est� vazia@>=
 ( qsize > 0)

@ @<Escolha |u| em $\L$ tal que $\fp(u)$ seja m�nimo@>=
 u = delete_min();
 qsize--;

@ Examina todos os arcos da forma $uv$ (se��o~\ref{sec:examinar}). 
@<Examine o v�rtice |u|@>=
for(a = u->arcs; a ; a = a->next){
  v = a->tip;
  @<Examine o arco |uv|@>@;
}
num_exam++;

@ Faz $\fp$ respeitar $c$ em $uv$ (se��o~\ref{sec:examinar}). 
@<Examine o arco |uv|@>=
if(v->dist - u->dist > a->len ){/* se a fun��o potencial n�o � vi�vel */
    atualiza_fp++;
    if (v->dist == infinito){ /* $v$ n�o est� na fila */    
      v->dist = u->dist + a->len;
      v->pred = u;
      insert(v); qsize++;
    }
    else{ /* $v$ j� estava na fila */
      v->dist = u->dist + a->len;
      v->pred = u;
      decrease_key(v);
    }
  }
@ 


O teorema a seguir resume o n�mero de opera��es feitas pela
implementa��o acima, para  manipular a fila de
prioridades $\L$.
\begin{teorema}{n�mero de opera��es}
\label{teorema:no-operacoes}
O algoritmo de Dijkstra, quando executado em um grafo com $n$ v�rtices e 
$m$ arcos, realiza uma seq��ncia de $n$ opera��es \textsf{insert}, $n$ 
opera��es \textsf{delete-min}
e no m�ximo $m$ opera��es \textsf{decrease-key}. \fimprova
\end{teorema}

 Diferentes maneiras de se implementar as fun��es \textsf{insert},
\textsf{delete\_min} e \textsf{decrease\_key} ser�o estudadas no
pr�ximo cap�tulo.




