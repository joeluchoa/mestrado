\chapter{Algoritmo de Dinitz-Thorup}
\label{cap:dinitz-thorup}
\longpage

O algoritmo apresentado neste cap�tulo � um primeiro passo para o projeto de
um algoritmo linear, no modelo RAM, para o problema do caminho m�nimo
(PCM)\mar{PCM} restrito a grafos sim�tricos com fun��es comprimento
sim�tricas.  

Um componente fundamental no algoritmo de Dijkstra � a escolha apropriada do
pr�ximo v�rtice a ser examinado: escolha um v�rtice $u$ em um certo conjunto
$\L$ de v�rtices visitados tal que o potencial ou dist�ncia tentativa 
$\fp(u)$ associada a $u$ �
m�nimo. Devido a esta escolha, tem-se que os v�rtices do grafo s�o examinados
em ordem crescente de dist�ncia a partir de um dado v�rtice
origem\footnote{Esta ordem � conseq��ncia do invariante da
  monotonicidade~\iten{dk3} do algoritmo de Dijkstra.}  e que qualquer
implementa��o do algoritmo de Dijkstra, no modelo compara��o-adi��o, faz
$\Omega(n \log n)$ compara��es (se��o~\ref{sec:complexidade-dijk}). Assim,
qualquer variante do algoritmo de Dijkstra que tem a pretens�o de executar um
n�mero de opera��es proporcional ao tamanho do grafo n�o pode ser t�o seletiva
em rela��o ao pr�ximo v�rtice a ser examinado.

Dinitz~\cite{dinitz:1978} observou que se $\delta$ � o menor comprimento de um
arco ent�o, no algoritmo de Dijkstra, pode-se escolher o pr�ximo v�rtice a ser
examinado da seguinte maneira: escolha $u$ em $\L$ tal que
\[\min\{\fp(v) \tq v \in \L\} \leq \fp(u) \leq \min\{\fp(v) \tq v \in \L\}+\delta.  \]
Dinitz combinou esta observa��o a uma parti��o (bucketing) dos v�rtices do
grafo a fim de determinar um conjunto de v�rtices que podem ser examinados em
qualquer ordem: os v�rtices com potenciais em\footnote{Para $\delta = 0$
  a observa��o de Dinitz coincide com a implementa��o do algoritmo de Dijkstra.} 
$[\min\{\fp(v) \tq v \in \L\}..\min\{\fp(v) \tq v \in \L\}+\delta]$.



% articionando os v�rtices
% em $\L$ de em buckets de acordo com o valor $\lceil \fp(u)/\delta\rceil$
% pode-se examinar os v�rtices no bucket minimal em qualquer ordem.


% A fim de evitar o limitante inferior do algoritmo de Dijkstra devido a
% ordena��o intr�nsica 


O algoritmo que nesta disserta��o � chamado de algoritmo de
  Dinitz-Thorup\index{algoritmo de!Dinitz-Thorup} foi apresentado por
Thorup~\cite{thorup:sssp-1999}.  Este algoritmo combina dois ingredientes, a
saber, a id�ia de bucketing de Dinitz para determinar v�rtices que podem ser
examinados em qualquer ordem e uma certa decomposi��o do grafo proposta por
Thorup, descrita na pr�xima se��o.  Este algoritmo � um est�gio intermedi�rio
entre o algoritmo de Dijkstra (cap�tulo~\ref{cap:dijkstra}) 
e algoritmo de Thorup, estudado no pr�ximo cap�tulo.

\section{Parti��es, variante do PCM e elementos maduros}
\label{sec:dinitz-particao}

Seja $(V,A)$ um grafo, $c$ uma fun��o comprimento de $A$ em $\NonnegInt$ e
$\delta$ um n�mero inteiro. 
Uma parti��o $\Pcal$ de $V$ � uma %%%% $V_{1}, \ldots,V_{k}$ de $V$ � uma
\defi{$\delta$-parti��o}\index{$\delta$-particao@@$\delta$-parti��o}%
\mar{ \tiny $\delta$-parti��o \normalsize}   
(em rela��o a $c$) se todo arco com ponta inicial e ponta final em 
elementos distintos de $\Pcal$ tem comprimento pelo menos $\delta$
(figura~\ref{fig:d_particao}).


\begin{figure}[htbp]
\begin{center}
   \psfrag{>= delta}{{$\geq \delta$}}
    \psfrag{V1}{{$X$}}
    \psfrag{V2}{{$Y$}}
    \psfrag{V3}{{$Z$}}
    \psfrag{V4}{{$W$}}
  \includegraphics{fig/d_particao.eps}
  \caption[{\sf $\delta$-parti��o}]
  {\label{fig:d_particao} Ilustra��o de uma $\delta$-parti��o 
   $\Pcal = \{X, Y, Z, W\}$.}
\end{center}
\end{figure}


%  \begin{lema}{Dinitz}
%  \label{lema:dinitz}
%   Seja uma $\delta$-parti��o $V_{1}, \ldots,V_{k}$ de $V$. 
%   Se, para algum $i$, 
%   $$min \{ \fp(u) \tq u \in V_{i} \backslash S \} \leq 
%     min \{ \fp(u) \tq u \in V \backslash S \} + \delta$$
%   ent�o $\fp(u) - \fp(s) = c(P^{u})$, onde $P^{u}$ � um caminho m�nimo
%   de $s$ a $u$.
%  \end{lema}

O algoritmo descrito na pr�xima se��o resolve a seguinte variante do problema do
caminho m�nimo:
\begin{quote}
\textbf{Problema} PCMV$(V,A,c,\delta,\Pcal,s)$:%
\index{PCMV}\mar{PCMV}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dado um grafo $(V,A)$, uma fun��o comprimento $c$ de $A$ em
$\NonnegInt$, um inteiro positivo $\delta$, uma $\delta$-parti��o
$\Pcal$ e um v�rtice $s$, encontrar um caminho de comprimento
m�nimo de $s$ at� $t$, para cada v�rtice~$t$ em $V$.
\end{quote}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Um algoritmo para o PCMV pode ser facilmente adaptado para resolver o PCM:
basta tomar $\Pcal := \{ \{v\} \tq v \in V \}$ e $\delta := \min\{c(u,v) \tq uv
\in A\}$.  

Vale a pena chamar a aten��o para o seguinte fato. Do ponto de vista da
defini��o do problema faz sentido permitir $\delta = 0$. Entretanto, os
algoritmos e implementa��es neste e no pr�ximo cap�tulo utilizam $\delta$ como
denominador de express�es. O tipo de divis�o por $\delta$ utilizada se reduz a um
simples shift, que no modelo RAM, consome tempo constante.
        
% Seja $\Delta := \floor{(nC + 1)/\delta}$, onde $C := \max\{ c(u,v) \tq uv \in
% A\}$.  Para resolver o PCMV o algoritmo de Dinitz-Thorup mant�m, entre outros
% objetos, uma fun��o potencial $\fp$, um elemento $\L$ de $V$ e mant�m ainda as
% elementos de $\Pcal$ em buckets $B(0),B(1),\ldots,B(\Delta-1)$ tais que $B(i)$
% cont�m as elementos $X$ tais que $\floor{\min\{\fp(v) \tq v \in \L \cap
%   X\}/\delta} = i.$  

Para resolver o PCMV o algoritmo de Dinitz-Thorup, como o algoritmo de
Dijkstra, mant�m, entre outros objetos, uma fun��o potencial $\fp$ e o
conjunto $\L$ dos v�rtices visitados. � dito que um elemento $X$ da
$\delta$-parti��o dada � \defi{maduro}\index{elemento maduro} se $\L \cap
X \neq \emptyset$ e
\[
\min\{ \fp(v) \tq v \in \L \} \leq 
\min\{ \fp(v) \tq v \in \L \cap X\} \leq
\min\{ \fp(v) \tq v \in \L \} + \delta.
\]
A primeira desigualdade acima � �bvia. A segunda desigualdade �, de fato, a condi��o.


% $V$ e mant�m ainda as elementos de $\Pcal$ em buckets
% $B(0),B(1),\ldots,B(\Delta-1)$ tais que $B(i)$ cont�m as elementos $X$ tais que
% $\floor{\min\{\fp(v) \tq v \in \L \cap X\}/\delta} = i.$


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  DESCRI��O
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Descri��o}
\label{sec:dinitz-thorup-descricao}
 
% Em 1978, Dinitz~\cite{dinitz:1978} observou que se $\delta$ 
%for o comprimento do menor arco,
%ent�o no algoritmo de Dijkstra, n�s podemos visitar qualquer 
%v�rtice $v$ que minimiza $\floor{\fp(v)/\delta}$.

O algoritmo de Dinitz-Thorup resolve o PCMV e devolve os mesmos certificados
que o algoritmo de Dijkstra, a saber, uma fun��o predecessor codificando os
caminhos compactamente e uma fun��o potencial vi�vel atestando a minimalidade
dos caminhos e a eventual n�o-acessibilidade de alguns v�rtices. 

%\longpage

% \begin{quote} 
% \textbf{Algoritmo de Dinitz-Thorup.}\index{algoritmo de! Dinitz-Thorup}
% Recebe um grafo $(V,A)$, uma fun��o comprimento $c$ de $A$ em
% $\PosInt$, um inteiro positivo $\delta$, uma $\delta$-parti��o
% $\Pcal$ e um v�rtice $s$,
% e devolve uma
% fun��o predecessor $\pred$ e uma fun��o potencial $\fp$ que respeita $c$
% tais que, para todo v�rtice $t$, se $t$ � acess�vel a partir de $s$, ent�o
% $\pred$ determina um caminho de $s$ a $t$ que tem comprimento $\fp(t) -
% \fp(s)$, caso contr�rio $\fp(t)-\fp(s) = nC+1$, 
% onde $C := \max\{ c(u,v) \tq uv \in A\}.$
% \end{quote}


% Cada itera��o come�a com 
% uma fun��o potencial $\fp{}$, 
% uma fun��o predecessor $\pred$,
% elementos $S, \L$ e $U$  de $V$ e
% buckets $B(0), B(1),\ldots, B(\Delta)$ das elementos de $V$ em $\Pcal$.

% No in�cio da primeira itera��o tem-se que 
% $\fp(s) = 0$ e $\fp(v) = nC + 1$ para cada v�rtice $v$ distinto de $s$,
% $\pred(v) = v$ para cada v�rtice $v$, 
% $S = \emptyset$,  
% $\L = \{s\}$,
% $U = V \setminus S$, 
% $B_{0} = \{X\}$, onde $X$ � a elemento de $\Pcal$ contendo $s$, 
% $B_{1} =\ldots= B_{\Delta-1} = \emptyset$ e $B_{\Delta} = \Pcal - \{X\}$, 
% onde $\Delta := \floor{(nC + 1)/\delta}$.

% \longpage
 
% Cada itera��o consiste em:
% \balgor
% \item \textbf{Caso 1:} \  $B(i) = \emptyset$ para cada $i < \Delta$. 

%  Devolva $\fp$ e $\pred$ e pare.

% \item \textbf{Caso 2:} \  $B(i) \neq \emptyset$ para algum $i < \Delta$.

%   Seja $k$ o menor �ndice $i$ tal que $B(i) \neq \emptyset$.

%   Escolha $X$ em $B(k)$.
 
%   Escolha  $u$ em $\L \cap X$ tal que  $\fp(u)$ � m�nimo.
 
%   $S' := S \cup \{u\}$.
 
%   $\L' := \L \setminus \{u\}$.
 
%   $U'  := U$.

%   Para cada $v$ fa�a $\fp'(v) := \fp(v)$ e $\pred'(v) := \pred(v)$.
 
%   Para cada $i$ fa�a $B'(i) := B(i)$.

%   Para cada arco $uv$ fa�a 

%  \x Se\ $\fp(v) > \fp(u) + c_{uv}$ ent�o 

%  \xx $\fp'(v) := \fp(u) + c_{uv}$ e $\pred'(v) := u$, 
%      remova\footnote{�
%      poss�vel que $v$ j� perten�a a $\L'$ e n�o esteja em $U'$. Nesse caso estas
%      �ltimas duas intru��es s�o redundantes.}  $v$ de $U'$ e acrescente a $\L'$.

%  \xx Seja $Y$ a elemento em $\Pcal$ contendo $v$ e $j$ um �ndice tal que $B'(j)$ cont�m $Y$.

%  \xx Se $\fp'(v) < j \delta$ ent�o 

%  \xxx Remova $Y$ de $B'(j)$ e coloque em $B'(j')$, 
%       onde $j' = \floor{\fp'(v)/\delta}$.

%   Se $X \setminus S' = \emptyset$, ent�o remova $X$ de $B'(k)$ sen�o
  
%   \x Seja $w$ em $X \setminus S'$ tal que $\fp'(w)$ � m�nimo.

%   \x Se $\fp'(w) \geq (k + 1)\delta$ ent�o

%   \x\x Remova $X$ de $B'(k)$ e coloque em $B'(k')$, 
%   onde $k' = \floor{\fp'(w)/\delta}$.
 
%   Comece nova itera��o com $\fp'$, $\pred'$, $S', \L', U'$ e  
% $B'(0),\ldots,B'(\Delta)$ nos pap�is de 
% $\fp{}$, $\pred$, $S, \L, U$ e $B(0),\ldots,B(\Delta)$. \qed
% \ealgor

\begin{quote} 
\textbf{Algoritmo de Dinitz-Thorup.}\index{algoritmo de! Dinitz-Thorup}
Recebe um grafo $(V,A)$, uma fun��o comprimento $c$ de $A$ em
$\NonnegInt$, um inteiro positivo $\delta$, uma $\delta$-parti��o
$\Pcal$ e um v�rtice $s$,
e devolve uma
fun��o predecessor $\pred$ e uma fun��o potencial $\fp$ que respeita $c$
tais que, para todo v�rtice $t$, se $t$ � acess�vel a partir de $s$, ent�o
$\pred$ determina um caminho de $s$ a $t$ que tem comprimento $\fp(t) -
\fp(s)$, caso contr�rio $\fp(t)-\fp(s) = nC+1$, 
onde $C := \max\{ c(u,v) \tq uv \in A\}.$
\end{quote}


Cada itera��o come�a com 
uma fun��o potencial $\fp{}$, 
uma fun��o predecessor $\pred$,
partes $S, \L$ e $U$  de $V$.

No in�cio da primeira itera��o 
$\fp(s) = 0$ e $\fp(v) = nC + 1$ para cada v�rtice $v$ distinto de $s$,
$\pred(v) = v$ para cada v�rtice $v$, 
$S = \emptyset$,  
$\L = \{s\}$,
$U = V \setminus \{s\}$.
 
Cada itera��o consiste em:
\balgor
\item \textbf{Caso 1:} \  $Q = \emptyset$. 

 Devolva $\fp$ e $\pred$ e pare.

\item \textbf{Caso 2:} \  $Q \neq \emptyset$

  Escolha $X$ em $\Pcal$ tal que $X$ � maduro.

  Escolha  $u$ em $\L \cap X$ tal que  $\fp(u)$ � m�nimo.
 
  $S' := S \cup \{u\}$.
 
  $\L' := \L \setminus \{u\}$.
 
  $U'  := U$.

  Para cada $v$ fa�a $\fp'(v) := \fp(v)$ e $\pred'(v) := \pred(v)$.
 
  Para cada arco $uv$ fa�a 

 \x Se\ $\fp(v) > \fp(u) + c(u,v)$ ent�o 

 \xx $\fp'(v) := \fp(u) + c(u,v)$, $\pred'(v) := u$ e  
     remova\footnote{�
     poss�vel que $v$ j� perten�a a $\L'$ e n�o esteja em $U'$. Nesse caso estas
     �ltimas duas instru��es s�o redundantes.}  $v$ de $U'$ e acrescente a $\L'$.

  Comece nova itera��o com $\fp'$, $\pred'$, $S', \L'$ e $U'$ nos pap�is de 
$\fp{}$, $\pred$, $S, \L$ e $U$. \qed
\ealgor

 
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
    \psfrag{A}{\textsc{x}}
    \psfrag{B}{\textsc{y}}
    \psfrag{C}{\textsc{z}}
    \psfrag{D}{\textsc{w}}
    \psfrag{Bk}{\textsc{b}}
    \psfrag{s}{\small{s}}
    \psfrag{a}{\small{$a$}}
    \psfrag{b}{\small{$b$}}
    \psfrag{c}{\small{$c$}}
    \psfrag{d}{\small{$d$}}
    \psfrag{t}{\small{$t$}}
    \psfrag{0}{\small{$0$}}
    \psfrag{25}{\small{$25$}} 
    \psfrag{1}{\small{$1$}}
    \psfrag{2}{\small{$2$}}
    \psfrag{3}{\small{$3$}}
    \psfrag{4}{\small{$4$}}
    \psfrag{5}{\small{$5$}}
    \psfrag{6}{\small{$6$}}
    \psfrag{7}{\small{$7$}}
    \psfrag{8}{\small{$8$}}
    \normalsize
    \includegraphics{fig/dinitz_simulacao1.eps}
  \caption[{\sf Simula��o do algoritmo de Dinitz-Thorup}]
 {\label{fig:sim_dinitz} Execu��o do algoritmo de Dinitz-Thorup.
 $\iten{a}$ exibe um grafo com comprimentos nos arcos junto com uma
 $3$-parti��o cujos elementos s�o os conjuntos \textsc{x, y, w, z} da figura.
 O v�rtice  inicial � $s$.
 $\iten{b}$ mostra a situa��o no in�cio da
 primeira itera��o.
 Se um arco $uv$ est� sombreado, ent�o $\pred(v) = u$.
 Os potenciais s�o os n�meros pr�ximos a cada v�rtice.  
 Os v�rtices pretos s�o os de $S$, 
 os v�rtices cinzas s�o os de $\L$, 
 e os v�rtices brancos s�o os de $U$.
 $\iten{c}-\iten{g}$ exibem a  situa��o ap�s cada
 itera��o do caso~2. Os valores finais da fun��o potencial $\fp$, 
 e da fun��o predecessor $\pred$, s�o mostrados em $\iten{h}$.
}
\end{center}
\end{figure}


Se $\delta = 0$ o algoritmo de Dinitz-Thorup, em sua forma abstrata, examina
os v�rtices na mesma ordem crescente de dist�ncia que o algoritmo de Dijkstra.
A situa��o de interesse � quando esta ordena��o impl�cita, pela 
dist�ncia a partir da 
origem $s$, pode ser evitada, e isto ocorre quando $\delta$ � um inteiro
positivo (quanto maior, melhor). Uma simula��o do algoritmo de Dinitz-Thorup
est� ilustrada na figura~\ref{fig:sim_dinitz}, onde no momento, os vetores ao
lado dos grafos devem ser ignorados.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  INVARIANTES
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Invariantes}
\label{sec:dinitz-thorup-invariantes}
\index{invariantes do algoritmo de!Dinitz-Thorup}

O algoritmo de Dinitz-Thorup mant�m todos os invariantes do algoritmo de
Dijkstra (se��o~\ref{sec:dijkstra-invariantes}), exceto aquele que � o
respons�vel pela ordem que os v�rtices s�o examinados, o invariante da
monotonicidade~\iten{dk3}.

No lugar do invariante da monotonicidade o algoritmo de Dinitz-Thorup mant�m
os dois invariantes a seguir, onde o primeiro envolve a parti��o $\Pcal$ e o
segundo envolve o n�mero $\delta$.

\begin{enumerate}
\item[$\iten{dt1}$] (monotonicidade local) para cada parte $X$ de $V$ em
 $\Pcal$  e para cada $u$ em $S \cap X$, $v$ em $\L \cap X$ e
 $w$ em $U \cap X$ vale que\footnote{Se alguma das intersec��es �
vazia, considere apenas as desigualdades que fazem sentido.}
\[
d(u) \leq d(v) < d(w) = nC + 1.
\]

\item[$\iten{dt2}$] (monotonicidade relaxada) para cada $u$ em $S$, $v$ em
  $\L$ e $w$ em $U$ vale que
\[
d(u) \leq d(v) + \delta < d(w) = nC + 1.
\]
\end{enumerate}
Os invariantes est�o ilustrados na figura~\ref{fig:invariantes-dinitz}


%%% Figura representando os invariantes.
\begin{figure}[htbp]
 \begin{center}
    \psfrag{X}{\textsc{x}}
    \psfrag{Y}{\textsc{y}}
    \psfrag{Z}{\textsc{z}}
    \psfrag{S}{{$S$}}
    \psfrag{Q}{{$\L$}}
    \psfrag{U}{{$U$}}
    \psfrag{d(u)}{{$\fp(u)$}}
    \psfrag{d(v)}{{$\fp(v)$}}
    \psfrag{d(v)+delta}{{$\fp(v) + \delta$}}
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
  \includegraphics{fig/invariante_dinitz.eps}
  \caption[{\sf Invariantes do algoritmo de Dinitz-Thorup}]
  {\label{fig:invariantes-dinitz}Ilustra��o dos invariantes. $X,Y$ e
    $Z$ s�o os elementos da $\delta$-parti��o. 
    Figura~(a) mostra a
    estrutura do grafo em rela��o � parti��o $S,\L$ e $U$ de $V$
    (invariantes \iten{dk1} e \iten{dk2}), onde os arcos que cruzam as linhas
    tracejadas t�m comprimento pelo menos $\delta$. (b) e (c) exibem a rela��o de ordem 
    envolvendo os potenciais dos v�rtices, as partes $S,\L$ e $U$ bem como os
    elementos $X,Y$ e $Z$ da $\delta$-parti��o (invariantes~\iten{dt1} e~\iten{dt2}). 
    Em~(d) os arcos
    determinados pela fun��o predecessor $\pred$ s�o exibidos (invariantes
    \iten{dk4}, \iten{dk5} e \iten{dk6}).}
 \end{center}
 \end{figure}


O algoritmo mant�m os invariantes \iten{dk1} e \iten{dk2} de estrutura, os
invariantes \iten{dk4}, \iten{dk5} e \iten{dk6} envolvendo a fun��o
predecessor e $\{S,\L,U\}$, os invariantes de \iten{dk7} a \iten{dk11} dos
arcos onde a fun��o potencial respeita ou desrespeita $c$ e o
invariante~\iten{dk12} das folgas complementares.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Al�m desses, o algoritmo de
%Dinitz-Thorup ainda mant�m alguns invariantes envolvendo a parti��o $\Pcal$.

A seguir est�o as demonstra��es de~\iten{dt1} e~\iten{dt2} e uma nova
demonstra��o de \iten{dk9}, j� que a demonstra��o de~\iten{dk9}, apresentada no
cap�tulo~\ref{cap:dijkstra}, faz uso do invariante da monotonicidade, que
no, algoritmo de Dinitz-Thorup, foi substituido pelos invariantes~\iten{dt1}
e~\iten{dt2}. 

\begin{provainv}{\iten{dt1}}
  Considere uma itera��o em que ocorre o caso~2.  Ao final da
  itera��o tem-se que $\fp'(v) \neq \fp(v)$ se e somente se $v$ est� em 
  $\L'   \subseteq (\L \setminus \{u\}) \cup U$
 e $uv$ � um arco do grafo com $\fp(v)-\fp(u) > c(u,v)$.  Ademais, 
  se $\fp'(v) \neq \fp(v)$ ent�o $\fp'(v) = \fp(u) + c(u,v) < \fp(v)$.
  
  Do invariante~\iten{dt1} sabe-se que para cada $x$ em $S \cap X$, $y$ em $\L
  \cap X$ e $z$ em $U \cap X$ vale que $d(x) \leq d(y) < d(z) =nC+1$. Assim,
  pela escolha de $X$ e $u$ (e como $c$ � uma fun��o de $A$ em $\NonnegInt$),
  ap�s examinar o v�rtice~$u$ tem-se que
\[
\fp'(x) \leq \fp(u) \leq \fp'(y) < \fp'(z) = nC + 1
\] 
para cada $x$ em $S' \cap X= (S \cup \{u\}) \cap X$, $y$ em $\L' \cap X$ e $z$ em
$U'\cap X$.

  Seja agora $Y$ um elemento em $\Pcal$ distinto de $X$. 
  Sejam $x$ um v�rtice em $S' \cap Y = (S \cup \{u\}) \cap Y$, 
        $y$ um v�rtice em $\L' \cap Y$ e 
        $z$ um v�rtice em $U' \cap Y$. 
  Se $\fp'(y) = \fp(y)$, ent�o pelo invariante \iten{dt1} vale que 
  \[ \fp'(x) = \fp(x) \leq \fp(y) = \fp'(y) < \fp'(z) = nC + 1. \] 
Suponha  que 
    $\fp'(y) < \fp(y)$ e nesse caso  $\fp'(y) = \fp(u) + c(u,y) \geq \fp(u) +
          \delta$. 
Do invariante~\iten{dt2} sabe-se que $\fp(x) \leq \fp(u) + \delta$ e portanto,
\[
\fp'(x) = \fp(x) \leq \fp(u) + \delta \leq \fp'(y) < \fp'(z) = nC+1.
\]  
O que conclui a demonstra��o do invariante \iten{dt1}.
\end{provainv}


\begin{provainv}{\iten{dt2}}
  Considere uma itera��o em que ocorre o caso~2.  
  � claro que ao final da itera��o vale que $\fp'(w) = nC + 1$, para
  cada $w$ em $U'$. Al�m disso, 
  combinando os invariantes \iten{dk4}, \iten{dk5} e \iten{dk6} que envolvem a
  fun��o predecessor e $\{S,Q,U\}$ e o invariante~\iten{dk12} das folgas
  complementares, obtem-se que 
  \[ \fp'(v) + \delta \leq \fp(v) + \delta \leq (n-1)C + \delta < nC + 1 = \fp'(w),
\] 
para cada $v$ em $\L'$ e $w$ em $U'$. Assim, nos concentraremos em verificar que 
para cada $x$ em $S'$ e $y$ em $\L'$, ao final da itera��o, vale que $\fp'(x)
\leq \fp'(y) + \delta$. 

Seja $x$ um v�rtice em $S'$ e $y$ um v�rtice em $\L'$.  
Se ao final da itera��o, $\fp'(y) = \fp(y)$, ent�o pela escolha de $X$ e $u$ e pelo
invariante~\iten{dt2}
tem-se que 
\[
\fp'(x) = \fp(x) \leq \fp(y) + \delta = \fp'(y) + \delta.
\]

Assim, suponha que, ao final da itera��o, vale que $\fp'(y) < \fp(y)$. Portanto, 
$\fp(u) \leq \fp(u) + c(u,y) = \fp'(y) $.  
Do invariante (dt2), tem-se que $\fp(x)  \leq \fp(u) + \delta$. Portanto, 
\[
\fp'(x) = \fp(x) \leq \fp(u) + \delta \leq \fp'(y) + \delta.
\]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ser vale 
% Se $x$ e $y$ est�o em
% uma mesma parte de $\Pcal$ ent�o, pelo invariante~\iten{dt1}, n�o h� o que
% demonstrar.  Se $\fp'(y) = \fp(y)$ ent�o, pelo invariante~\iten{dt2}, tamb�m
% n�o h� o que demonstrar, j� que $\fp'(x) = \fp(x)$.  Assim, pode-se supor que
% $x$ e $y$ est�o em partes distintas de $\Pcal$ e que $\fp'(y) \neq \fp(y)$.
% Neste caso, vale que $\fp'(y) = \fp(u) + c(u,y) \geq \fp(u) + \delta$.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pela escolha de $X$ e $u$ tem-se que $\fp(x)  \leq \fp(u) + \delta$. Portanto, 
% \[
% \fp'(x) = \fp(x) \leq \fp(u) + \delta \leq \fp'(y) + \delta.
% \]
\end{provainv}

\begin{provainv}{\iten{dk9}}
  Novamente, considere uma itera��o em que ocorre o caso~2.
  Do invariante~\iten{dt1}, obtem-se que no final da itera��o vale que $\fp'(x)
  - \fp'(y) \leq 0$ para cada $x$ em $S' \cap Y= (S \cup \{u\}) \cap Y$, 
  $y$ em $\L' \cap Y$, onde $Y$ � um elemento de $\Pcal$. Ademais,
  do invariante \iten{dt2}, sabe-se que $\fp'(x) - \fp'(y) \leq \delta$ para
  cada $x$ em $S' \cap Y$ e $y$ em $\L' \cap Z$, onde $Y$ e $Z$ s�o elementos
  distintos de $\Pcal$.
  Portanto, como os comprimentos dos arcos s�o n�o-negativos e $\Pcal$ � uma
  $\delta$-parti��o, $\fp'$ respeita
  $c$ em $A(\L',S')$.
  
  O processo de examinar $u$ faz com que $\fp'$ respeite $c$ em cada arco com
  ponta inicial em $u$. Do invariante~\iten{dk9} sabe-se que $\fp$ respeita $c$
  em $A(S,\L)$.  Assim, como $\fp'(v) = \fp(v)$ para cada $v$ em $S'$ e
  $\fp'(v) \leq \fp(v)$ para cada $v$ em $\L'$, conclui-se
  que $\fp'$ respeita $c$ em $A(S',\L')$.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \begin{eqnarray}
% \label{eq:min}
% \fp'(u) - \fp'(v) = \fp(u) - \fp(v) \leq c(v,u),
% \end{eqnarray}
% j� que $c$ � uma fun��o de $A$ em $\NonnegInt$ e pela escolha de $u$ tem-se
% que $\fp(u) \leq \fp(v)$ para todo $v$ em $\L$. Assim, de (\ref{eq:min}) e do
% invariante \iten{dk7} pode-se concluir que $\fp'$ respeita $c$ em
% $A(\L,S')$. Finalmente, ap�s o v�rtice 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% No in�cio da itera��o tem-se que $\fp$ respeita $c$ em $A[S]$ (invariante
% \iten{dk7}) e em $A(\L,S)$. Desta forma, no final de uma itera��o em que ocorre
% o caso~2 cale que $\fp'$ respeita $c$ em $A[S']$, pois $S' = S \cup \{u\}$ e
%$\fp'(v)=\fp(v)$ para todo $v$ em $S'$.
\end{provainv}
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  CORRE��O
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Corre��o}
\label{sec:dinitz-thorup-correcao}

A corre��o do algoritmo de Dinitz-Thorup � facilmente demonstrada atrav�s dos
invariantes apresentados. Mais ainda, a demonstra��o da corre��o do algoritmo
de Dinitz-Thorup � textualmente a mesma da corre��o do algoritmo de
 Dijkstra (se��o~\ref{sec:dijkstra-correcao}), 
j� que este �ltimo n�o utiliza o invariante da monotonicidade~\iten{dk3}.
 
%A seguir � denotado por $U$ a parte
%$V\setminus(S\cup\L)$ de $V$.
 
\begin{teorema}{teorema da corre��o}
\label{teo:correcao-dinitz}
%O algoritmo de Dijkstra 
%recebe um grafo $(V,A)$, uma fun��o comprimento $c$ de
%$A$ em $\NonnegInt$ e um v�rtice $s$ e 
Para cada v�rtice $t$ acess�vel a
partir de $s$ o algoritmo de Dinitz-Thorup devolve um caminho de $s$ a $t$ que tem
comprimento m�nimo.
\end{teorema}
 
\begin{prova}
Textualmente a mesma do teorema~\ref{teo:correcao-dijkstra}.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suponha que  $\pred$ e $\fp$ s�o as fun��es devolvidas pelo algoritmo.
% %%%% L = vazio
% Quando o algoritmo p�ra tem-se que $\L = \emptyset$ e do invariante \iten{dk1}
% vale que $S$ e $U$ � uma parti��o de $V$.
 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%% S � o conjunto de v�rtices acess�veis 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ao final do algoritmo, $S$ � o conjunto de v�rtices acess�veis a partir de $s$.
% De fato, pelo invariante \iten{dk2}
% sabe-se que nenhum v�rtice de $U$ � acess�vel a partir de $s$ j� que $A(S,U) =
% \emptyset$,  e pelo invariante \iten{dk6} tem-se que para cada v�rtice $t$ em
% $S$ a fun��o $\pred$ 
% determina uma caminho de $s$ a $t$; j� que $\pred$ determina uma arboresc�ncia 
% em $(S,A[S])$ com raiz em $s$.

% Como $\L = \emptyset$ e $A(S,U) = \emptyset$, ent�o dos invariantes \iten{dk7}
% a \iten{dk10} conclu�-se que a fun��o potencial $\fp$ � vi�vel.

% Resta apenas verificar que cada caminho $P$ de $s$ a um v�rtice $t$ em $S$
% determinado por $\pred$ � um caminho que tem comprimento m�nimo.
% Do invariante \iten{dk12} obtem-se que $c(P) = \fp(t) - \fp(s)$. Finalmente,
% como $\fp$ � vi�vel, pelo condi��o de otimalidade conclu�-se que $P$ tem
% comprimento m�nimo.
\end{prova}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  EFICI�NCIA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Efici�ncia}
\label{sec:dinitz-thorup-eficiencia}

Como no algoritmo de Dijkstra,  $\fp', \pred', S', \L'$ e $U'$ foram
introduzidos na descri��o do algoritmo por meras raz�es t�cnicas.
Em termos de efici�ncia, n�o h�
necessidade de levar em considera��o as instru��es que inicializam estes
objetos. A descri��o pode ser feita inteiramente em
termos de $\fp, \pred, S, \L$ e $U$.


Uma poss�vel implementa��o do algoritmo de Dinitz-Thorup � a seguinte.
Seja $\Delta := \floor{(nC + 1)/\delta}$.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Seja $\Delta$ o
% menor inteiro tal que $\Delta\delta \geq nC+1$, onde $C := \max\{ c(u,v) \tq
% uv \in A\}$. Para $\delta > 0$ esta defini��o � equivalente $\Delta :=
% \floor{(nC + 1)/\delta}$.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Os elementos de $\Pcal$ s�o mantidos em buckets
$B(0),B(1),\ldots,B(\Delta)$. Para cada $i$ em $[0..\Delta-1]$, $B(i)$ cont�m
os elementos maduros $X$ de $\Pcal$ tais que
\[ i\delta \leq \min\{\fp(v) \tq v \in \L \cap X\} \leq (i+1)\delta -1,\]
ou, equivalentemente, \[i = \floor{  \min\{\fp(v) \tq v \in \L \cap X\}/ \delta }.\] 
O bucket $B(\Delta)$
cont�m os elementos $X$ de $\Pcal$ tais que $Q \cap X = \emptyset$ e $U \cap X
\neq \emptyset$.  
Desta forma, $Q = \emptyset$ se e somente se $B(i) = \emptyset$ para cada $i$ em
$[0..\Delta-1]$.

Em cada itera��o, para escolher um elemento maduro $X$ da
$\delta$-parti��o $\Pcal$ basta encontrar o menor $k$ em $[0..\Delta-1]$ tal que $B(k)$ �
n�o-vazio. Devido ao invariante das folgas relaxadas~\iten{dt2}, os elementos
maduros podem ser escolhidos pelo algoritmo a medida que os buckets s�o visitados na ordem
$B(0),B(1),\ldots,B(\Delta-1)$. As opera��es principais envolvendo os buckets
s�o remo��es e inser��es. Suponha que cada  bucket �
representado atrav�s de uma lista ligada. Assim, cada opera��o de remo��o e inser��o de
elementos de $\Pcal$ em buckets pode ser realizada, no modelo RAM,  em tempo
constante: para determinar o bucket $B(k)$ que cont�m um certo elemento $X$ de $\Pcal$ basta
computar $k = \floor{\min\{ \fp(v) \tq v \in  X \setminus S\}/\delta}$.
Portanto, o consumo total de tempo das opera��es envolvendo os buckets �
proporcional a $n+m+\Delta$. 
Na simula��o do algoritmo de Dinitz-Thorup, ilustrada na
figura~\ref{fig:sim_dinitz},  os buckets s�o representados pelo vetor ao
lado de cada grafo.

\begin{teorema}{consumo de tempo}
\label{teorema:consumo-de-tempo-dinitz}
O algoritmo de Dinitz-Thorup, quando executado, no modelo RAM, em
um grafo com $n$ v�rtices e $m$ arcos, gasta tempo $O(n+m+\Delta)$ mais o
tempo necess�rio para manter o v�rtice com menor potencial em $X \setminus S$,
para cada $X$ na $\delta$-parti��o, onde $\Delta = \floor{(nC +
1)/\delta}$ e $C$ � o maior comprimento de um arco. \fimprova
\end{teorema}


% Seja $\Delta := \floor{(nC + 1)/\delta}$, onde $C := \max\{ c(u,v) \tq uv \in
% A\}$. Com sugerido por Dinitz, � considerada a implementa��o envolve a
% parti��o que mant�m os elementos de $\Pcal$ em buckets
% $B(0),B(1),\ldots,B(\Delta)$.  O bucket $B(i)$ cont�m as partes maduras $X$ de
% $V$ em $\Pcal$ tal que $\floor{\min\{\fp(v) \tq v \in \L \cap X\}/\delta} =
% i.$, para $i=0,1,\ldots,\Delta-1$. O bucket $B(\Delta)$ cont�m os elementos
% $X$ de $\Pcal$ tal que $X$ n�o � maduro e $X\setminus S \neq emptyset$.
  

% Uma bjetos, uma fun��o potencial $\fp$, um parte $\L$ de $V$ e mant�m ainda as
% partes de $\Pcal$ em buckets $B(0),B(1),\ldots,B(\Delta-1)$ tais que $B(i)$
% cont�m as partes $X$ tais que $\floor{\min\{\fp(v) \tq v \in \L \cap
%   X\}/\delta} = i.$  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  CWEB
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Vers�o em \CWEB}
\label{sec:dinitz-thorup-cweb}

@ Conforme visto na se��o anterior,
a implementa��o do algoritmo de Dinitz-Thorup usa os buckets 
$B(0), B(1),\ldots, B(\Delta)$ 
para manter os elementos de uma dada $\delta$-parti��o $\Pcal$, que neste caso, 
� representada por um grafo |p|, cujos v�rtices s�o os elementos de $\Pcal$.
A figura~\ref{fig:rep_particao} mostra a representa��o de $\Pcal$ interpretada
pelo programa.
\begin{figure}[htbp]
\begin{center}
    \psfrag{V1}{$V_1$}
    \psfrag{V2}{$V_2$}
    \psfrag{V3}{$V_k$}
    \psfrag{P1}{$p_1$}
    \psfrag{P2}{$p_2$}
    \psfrag{P3}{$p_k$}
    \includegraphics{fig/rep_particao.eps}
  \caption[{\sf Representa��o de uma $\delta$-parti��o na implementa��o}]
 {\label{fig:rep_particao} Cada elemento $V_{i}$ da $\delta$-parti��o
    $\Pcal$ � representado por um v�rtice $p_{i}$ do grafo $p$. Cada
    arco de $p$ tem ponta inicial em algum v�rtice $p_i$ e ponta
    final em algum v�rtice do grafo de entrada. Os arcos
    pontilhados s�o os arcos do grafo de entrada e t�m comprimento
    pelo menos~$\delta$.}
\end{center}
\end{figure}
%Para resolver o PCMV o algoritmo de Dinitz-Thorup mant�m, entre outros objetos, 
%uma fun��o potencial $\fp$, um parte $\L$ de $V$ e mant�m ainda as partes
%de $\Pcal$ em buckets $B(0),B(1),\ldots,B(\Delta)$, onde 
%$\Delta = \floor{(nC + 1)/\delta}$ e $C := \max\{c(u,v) \tq uv \in A\}$.  
%Cada $B(i)$ cont�m as partes $X$ tais que
%\[\floor{\min\{\fp(v) \tq v \in X \cap \L\}/\delta} = i.\]

@<Vari�veis globais@>=
Vertex *B;   /* bucket */

@ A implementa��o utiliza os seguintes ponteiros para cada v�rtice: |prox_elemento| e 
|ant_elemento| que mant�m uma lista de elementos da $\delta$-parti��o $\Pcal$ em cada $B(i)$; o
ponteiro |elemento| indica, para cada v�rtice de $G$ (grafo de
entrada), a qual elemento de $\Pcal$\footnote{Na implementa��o um
elemento de $\Pcal$ � um v�rtice de $p$.} ele pertence; 
|maduro| aponta para os v�rtices de $G$ que minimizam $\fp$ em
cada elemento de $\Pcal$; e |status| indica se um v�rtice de $G$ ou
elemento de $\Pcal$ foi examinado ou n�o.
@<Defini��es@>=
#define prox_elemento @,@,@,@, s.V  /* pr�xima elemento da lista */
#define ant_elemento @,@,@,@, t.V   /* elemento anterior da lista */
#define elemento @,@,@,@, y.V       /* aponta para o elemento de $\Pcal$ que cont�m o v�rtice */
#define maduro @,@,@,@, x.V     /* pr�ximo v�rtice que pode ser examinado */
#define status @,@,@,@, z.I
#define B(i) @, (B + i)


@ Conforme as implementa��es de filas de prioridade 
(cap�tulo~\ref{cap:implementacao-fila-prioridade}),
na implementa��o do algoritmo de Dinitz-Thorup tamb�m teremos as opera��es  
\textsf{insert, delete-min} e \textsf{decrease-key} que s�o representadas pelas 
fun��es |insert_dinitz|, |delete_min_dinitz| e |decrease_key_dinitz|.

A fun��o |insert_dinitz|,
 insere um elemento |x| de |p| no bucket |B(i)|. 
%lembrando que
%\[i = \floor{\min\{\fp(v) \tq v \in x \cap \L\}/\delta}.\]
O tempo gasto por essa fun��o � $O(1)$.
@<Fun��es ...@>=
void
insert_dinitz(x,i)
  Vertex *x;
  long i;
{
  x->ant_elemento = B(i);
  x->prox_elemento =  B(i)->prox_elemento;
  (B(i)->prox_elemento)->ant_elemento = x;
  B(i)->prox_elemento = x;
}

@ A fun��o |delete_min_dinitz| remove 
o v�rtice, que tem o menor potencial, do elemento |x|  
e escolhe o novo v�rtice cujo potencial � m�nimo. Se todos os v�rtices de |x| 
j� foram examinados, |x->status == EXAMINADO|. Caso contr�rio, |x->maduro| aponta
para o v�rtice com o menor potencial. O tempo gasto por essa fun��o � $O(^^7cx^^7c)$,
onde $^^7cx^^7c$ � o n�mero de v�rtices de |x|.
@<Fun��es ...@>=
Vertex *
delete_min_dinitz(x)
Vertex *x;
{
  register Vertex *u, *v;
  register Arc *a;

  u = x->maduro;
  u->status = EXAMINADO;

  /* Escolhe o novo m�nimo de |x| */
  x->dist = infinito;
  x->maduro = NULL;
  for(a = x->arcs; a; a = a->next){ /* percorre os v�rtices do elemento |x| */
    v = a->tip;
    if(v->status == EXAMINADO) continue;
    if(v->dist <= x->dist){
      x->dist = v->dist;
      x->maduro = v;
    }
  }
  if(x->maduro == NULL) x->status = EXAMINADO;
  return u;
}

@ A fun��o |decrease_key_dinitz| remove, usando a fun��o
|remove_elemento|, e move, caso necess�rio, 
 um elemento |y| do bucket atual
 para o bucket $B(\floor{\fp(v)/\delta})$, 
onde |v| � um v�rtice que pertence ao elemento |y|. 
O tempo gasto por essa fun��o � $O(1)$.
@<Fun��es ...@>=
void remove_elemento(x)
     Vertex *x;
{
(x->prox_elemento)->ant_elemento = x->ant_elemento;
(x->ant_elemento)->prox_elemento = x->prox_elemento;
}
void
decrease_key_dinitz(v, dt)
     Vertex *v;
     long dt;
{
  register Vertex *y;
  register long i, j;
  
  y = v->elemento; /* |y| � o elemento que cont�m |v| */

  if(v->dist < y->dist){
    j = (long)y->dist/dt;   /* guarda a posi��o antiga */
    
    y->dist = v->dist;
    y->maduro = v;    
    
    i = (long)v->dist/dt; /* $\floor{\fp(v)/\delta}$ */
    if( i < j ){
      remove_elemento(y); /*  remove |y| do bucket atual */ @;
      insert_dinitz(y,i);/* insere |y| em |B(i)| */  
    }
  } 
}

@ 
@<Algoritmo de Dinitz-Thorup@>=
void 
dinitz(g, dt, p, s)
     Graph *g;
     long dt;     /* arestas com comprimento pelo menos $dt$ */
     Graph *p;  /* |p| � a $dt$-parti��o*/
     Vertex *s;  /* v�rtice inicial */
     
{@+@<Vari�veis de dinitz@>@;

 @<Inicializa��es de dinitz@>@;

 @<Coloque os elementos de |p| nos buckets $B(0), B(1), \ldots, B(dtg)$@>@;

 for(k = 0; k < dtg; k++){

   while(B(k) != B(k)->prox_elemento){
 
     @<Seja |x| um elemento em |B(k)|@>@;

     @<Escolha |u| em |x| tal que $\fp(u)$ seja m�nimo@>@;

     @<Examine v�rtice |u|@>@;

     @<Verifique se |x| deve mudar de bucket@>@;

   }
 } 
 free(B);
}

@ @<Vari�veis de dinitz@>=
register Vertex *v, *u;
register Vertex *x; /* elementos de |p| */
register Arc *a;
register long i, k;
register long dtg = 0; /* $\Delta$ */

@ Inicializa $\fp$ e $\pred$ como no algoritmo de Dijkstra 
(se��o~\ref{dijkstra-cweb}). Al�m disso, o m�nimo de cada parti��o �
inicializado com |infinito|, com exce��o da parti��o que cont�m o
v�rtice inicial |s|.
@<Inicializa��es de dinitz@>=
for(v = g->vertices; v < g->vertices + g->n; v++){
    x = v->elemento;
    x->dist = v->dist = infinito;
    v->pred = v;
    x->status = v->status = NAO_EXAMINADO;
}
s->dist = 0;
(s->elemento)->dist = 0;      /* inicializa o elemento que cont�m |s| */
(s->elemento)->maduro = s; /* $\fp(s)$ � m�nimo no elemento |s->elemento| */ 

@ @<Coloque os elementos de |p| nos buckets $B(0), B(1), \ldots, B(dtg)$@>=
if(dt <= 0){
 printf("%s\n", err_message[ERROR_4]); exit(0);
}
dtg = (long)(infinito/dt) + 1;

if((B = (Vertex *)malloc(dtg*sizeof(Vertex)))== NULL){
  printf("%s\n", err_message[ERROR_2]); exit(0);
}

for(i = 0; i < dtg; i++){
  /* Inicializa cabe�as de lista */
  B(i)->ant_elemento = B(i)->prox_elemento = B(i);
}

for(x = p->vertices; x < p->vertices + p->n; x++){
  i = (long)(x->dist/dt); /* posi��o do bucket em que |x| ser� inserido */
  insert_dinitz(x,i);   /* insere |x| no bucket |B(i)| */
}

@ @<Seja |x| um elemento em |B(k)|@>=
x = B(k)->prox_elemento;

@ @<Escolha |u| em |x| tal que $\fp(u)$ seja m�nimo@>=
u = delete_min_dinitz(x);

@ @<Examine v�rtice |u|@>=
for(a = u->arcs; a ; a = a->next){
  v = a->tip;
  @<Examine a aresta |uv|@>@;
}

@ Faz $\fp$ respeitar $c$ em $uv$ (se��o~\ref{sec:examinar}). 
@<Examine a aresta |uv|@>=
if(v->dist - u->dist > a->len ){/* se a fun��o potencial n�o � vi�vel */
    v->dist = u->dist + a->len;
    v->pred = u;
    decrease_key_dinitz(v, dt);
}

@ 
@<Verifique se |x| deve mudar de bucket@>=
if(x->status == EXAMINADO) {  /* todos os v�rtices de |x| j� foram examinados */
  remove_elemento(x);  /* remove |x| do bucket atual */
}
else{
  i = (long)x->dist/dt;  /* nova posi��o do elemento |x| */ 
  if( i > k){
    remove_elemento(x);  /* remove |x| do bucket atual */
    insert_dinitz(x,i); /* insere |x| no bucket |B(i)| */
  }
}
@

\begin{lema}{opera��es Dinitz-Thorup}
\label{lema:operacoes-dinitz-thorup}
 A implementa��o de Dinitz-Thorup executa as opera��es 
|insert_dinitz| e |decrease_key_dinitz| em tempo $O(1)$ e 
|delete_min_dinitz| em tempo $O(n)$. \fimprova
\end{lema}

Portanto, do teorema~\ref{teorema:consumo-de-tempo-dinitz} e do 
lema~\ref{lema:operacoes-dinitz-thorup}, essa implementa��o do algoritmo de 
Dinitz-Thorup gasta tempo
\[
  \underbrace{O(n)}_{\mbox{\textsf{insert\_dinitz}}} + 
  \underbrace{O(m)}_{\mbox{\textsf{decrease\_key\_dinitz}}} +
  \underbrace{O(n^2)}_{\mbox{\textsf{delete\_min\_dinitz}}} +
  \underbrace{O(\Delta)}_{\mbox{percorrer os buckets}}
  = O(n^2 + m + \Delta).
\]

\begin{teorema}{}
 A implementa��o do algoritmo de Dinitz-Thorup resolve o
 PCMV em um grafo com $n$ v�rtices, $m$ arcos e uma $\delta$-parti��o 
 em tempo $O(n^2 + m + \Delta)$, onde $\Delta = \floor{(nC +
 1)/\delta}$ e $C$ � o maior comprimento de um arco. \fimprova
\end{teorema}
 
% Uma maneira de melhorar o tempo gasto, por essa implementa��o, do 
%algoritmo de Dinitz-Thorup � fazer um bucketing dos v�rtices de cada elemento $X$ 
%de $\Pcal$.
%Tomando $\Pcal := \{\{v\} \tq v \in V\}$  e $\delta := \min\{c(u,v) \tq uv \in A\}$, 
%conforme o algoritmo proposto por Dinitz~\cite{dinitz:1978},
%cada elemento $X$ de $\Pcal$ tem cardinalidade $1$. Portanto, o tempo gasto pelo 
%algoritmo de Dinitz-Thorup ser� $O(n + m + \Delta)$. 
% O algoritmo de Thorup, descrito no pr�ximo cap�tulo, junta essas duas id�ias: 
%procura diminuir o tamanho das elementos de uma $\Pcal$, construindo $\delta$-parti��es
%menores e ainda fazer bucketing dos v�rtices da $\delta$-parti��o, o que torna
%poss�vel escolher, rapidamente, o v�rtice com  potencial m�nimo e ainda limitar
%o n�mero de buckets necess�rios.
