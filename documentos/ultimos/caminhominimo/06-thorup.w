\chapter{Algoritmo de Thorup}
\label{cap:thorup}
%\longpage

O algoritmo apresentado neste cap�tulo, devido a Mikkel
 Thorup~\cite{thorup:sssp-1999}, resolve o seguinte problema do caminho
m�nimo restrito a grafos sim�tricos com fun��es comprimento
sim�tricas, em tempo e espa�o linear, no modelo RAM:

\begin{quote}
\textbf{Problema} PCMS$(V,A,c,s)$:%
\index{PCMS}\mar{PCMS}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dado um grafo sim�trico $(V,A)$, uma fun��o comprimento sim�trica $c$ de $A$ em
$\PosInt$ e um v�rtice $s$, encontrar um 
caminho de comprimento m�nimo de $s$ at� $t$, para cada v�rtice~$t$ em $V$.
\end{quote}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%  Conforme o teorema~\ref{teorema:consumo-de-tempo-dinitz}, o algoritmo
%  de Dinitz-Thorup gasta tempo $O(n+m+\Delta)$ mais o tempo necess�rio
%  para manter o v�rtice com o menor potencial dentro de cada elemento
%  de uma $\delta$-parti��o..

Da mesma forma que o algoritmo de Dinitz-Thorup
(cap�tulo~\ref{cap:dinitz-thorup}), o algoritmo de Thorup utiliza a id�ia de
 $\delta$-parti��o e bucketing, para determinar v�rtices que podem ser
examinados em qualquer ordem. 
 Em linhas gerais, a fim de evitar o custo computacional de examinar os
v�rtices do grafo conforme a dist�ncia do v�rtice origem $s$, Thorup juntou a
este bucketing uma certa decomposi��o hier�rquica do grafo e aplicou o
algoritmo de Dinitz-Thorup recursivamente a cada elemento desta decomposi��o.

%  em conjunto com uma decomposi��o do grafo, 
%  definida posteriormente, como ``decomposi��o hier�rquica''.  

% De fato, o que o algoritmo de Mikkel Thorup faz � aplicar a id�ia do 
% algoritmo de Dinitz-Thorup de maneira recursivamente em cada elemento de
% decomposi��o.

% , utilizando-se da 
% ``decomposi��o hier�rquica'' do grafo. 
 
% No algoritmo de Thorup, o tempo de manter
%  os v�rtices com potencial m�nimo � eliminado utilizando-se a
%  recursividade, e $\Delta$ � escolhido de maneira que seja proporcional
%  a $m + n$. 
 
\section{Fam�lia laminar e representa��o arb�rea}
\label{sec:laminar}

Seja $V$ um conjunto finito. 
Uma fam�lia $\Lcal$ de partes de $V$ 
� \defi{laminar}\index{familia@@fam�lia laminar} se para todo par $X$
e $Y$ de elementos de $\Lcal$ vale que $X \subseteq Y$ ou $Y \subseteq
X$ ou $X \cap Y = \emptyset$.
Se $X$ e $Y$ s�o elementos de $\Lcal$ tais que $X$ � um
subconjunto maximal  
propriamente contido em $Y$ ent�o � dito que $X$ �
\defi{filho}\index{elemento!filho} de $Y$ e $Y$ � \defi{pai}\index{elemento!pai} de $X$.

Uma \defi{representa��o arb�rea}\index{representacao arborea@@representa��o
  arb�rea} de uma fam�lia laminar $\Lcal$ � um grafo $(\Lcal, \Acal)$ 
tal que $(Y,X)$ � um arco em $\Acal$ se e somente se $X$ � um filho de
$Y$. Logo, $(\Lcal, \Acal)$ � a uni�o de arboresc�ncias.
A ilustra��o de uma fam�lia laminar e sua representa��o arb�rea
pode ser vista na figura~\ref{fig:arborescencia}.
 \begin{figure}[htbp]
 \begin{center}
 \psfrag{(a)}{(a)}
  \psfrag{(b)}{(b)}
  \psfrag{X}{\footnotesize {\sc x}}
 \includegraphics{fig/laminar_arbo.eps}
  \caption[{\sf Fam�lia laminar e representa��o arb�rea}]
  {\label{fig:arborescencia} A figura (a) mostra o diagrama de Venn de uma
  fam�lia laminar $\Lcal$. (b) � a representa��o arb�rea $(\Lcal,
  \Acal)$. O n�vel de $X$ � $2$ e a altura de $(\Lcal, \Acal)$ � $3$.} 
 \end{center}
 \end{figure}   
Um elemento $X$ em $(\Lcal, \Acal)$ � dito uma
\defi{folha}\index{elemento!folha} se $X$ � uma 
folha da arboresc�ncia de $(\Lcal, \Acal)$ que cont�m~$X$. Os
  elementos em $\Lcal$ que n�o s�o folhas s�o chamados de
  \defi{internos}\index{elemento!interno}.

Os \defi{ancestrais}\index{ancestrais de um elemento} de um elemento $X$ s�o todos os
elementos de $\Lcal$ no caminho da raiz da arboresc�ncia contendo $X$  
at� $X$.

O \defi{n�vel}\index{nivel@@n�vel de um elemento} de um elemento $X$ de
$\Lcal$ � o comprimento do caminho da raiz da arboresc�ncia de $(\Lcal,
\Acal)$ que cont�m $X$  at� $X$. A \defi{altura}\index{altura da
arborescencia@@altura da arboresc�ncia} 
de $\Lcal$ � o maior n�vel de um elemento $X$ de $\Lcal$.
 
Uma fam�lia $\Lcal$ de partes de $V$ �
$W$-\defi{completa}\index{familia@@fam�lia laminar!$W$-completa} para
alguma parte $W$ de $V$ se: 
(c1) $\Lcal$ � laminar; (c2) $V$ est� em $\Lcal$; e 
(c3) $\{v\} \in \Lcal$ se e somente se $v \in W$. 
%(c3) os elementos de $\{ \{v\} \tq v \in V \}$ que est�o em $\Lcal$ s�o
%precisamente os elementos de $\{ \{w\} \tq w \in W \}$.
Se $\Lcal$ � $W$-completa, ent�o sua representa��o arb�rea $(\Lcal, \Acal)$
� uma arboresc�ncia com raiz~$V$.
\section{Decomposi��o hier�rquica}
\label{sec:hierarquica}
Sejam $(V,A)$ um grafo e $c$ uma fun��o comprimento de $A$ em $\PosInt$.
Seja $\Lcal$ uma fam�lia $W$-completa e seja $\delta$ uma fun��o que
associa a cada elemento interno $X$ de $\Lcal$ um inteiro positivo
$\delta(X)$.
� dito que $\Lcal$ forma uma \defi{$\delta$-decomposi��o
$W$-hier�rquica}\index{$\delta$-decomposicao@@$\delta$-decomposi��o $W$-hier�rquica} de
$(V,A)$ em rela��o a $c$, se para cada elemento $X$ de $\Lcal$ vale
que:
 \begin{enumerate}[({h}1)]
 \item o grafo $(X,A(X))$ � conexo, exceto, possivelmente, se $X = V$; e
 \item cada aresta com pontas em filhos distintos de $X$ tem
comprimento pelo menos $\delta(X)$.
 \end{enumerate} 

 Quando a fun��o $\delta$ ou o conjunto $W$ forem evidentes ou
 irrelevantes ser�o omitidos. Assim, algumas vezes � escrito
 simplesmente decomposi��o hier�rquica, ou $\delta$-decomposi��o
 hier�rquica.

 Do ponto de vista da implementa��o do algoritmo descrito neste cap�tulo, � conveniente
 que, para cada $X$ em $\Lcal$, $\delta(X)$ seja um n�mero da forma
 $2^k$, para algum $k$. A
 figura~\ref{fig:decente} ilustra a condi��o (h2) e a 
figura~\ref{fig:dec-hierarquica} mostra a decomposi��o hier�rquica de
um grafo.

%Sejam $(V,A)$ um grafo, $c$ uma fun��o comprimento de $A$ em $\PosInt$ e
%$\delta$ um inteiro positivo.
%Recordemos que uma parti��o de $V$ � uma
%\defi{$\delta$-parti��o}\index{$\delta$-particao@@$\delta$-parti��o}% 
%\mar{$\delta$-parti��o}   
%se todo arco com ponta inicial e ponta final em  
%elementos distintos da parti��o tem comprimento pelo menos $\delta$.

% Seja $C$ o maior comprimento de um arco em $V$. Sejam $\delta_0 = C+1$ e
% $\delta_i = 2^{h - i}$, para $i = 1, 2, \ldots, h$, onde $h$ � a
% altura de $\Lcal$. Uma fam�lia laminar $W$-completa $\Lcal$ de partes de $V$ forma uma
% \defi{decomposi��o $W$-hier�rquica}\index{decomposicao
% $W$-hierarquica@@decomposi��o $W$-hier�rquica} (de $(V,A)$ em rela��o
% a $c$) se para cada elemento $X$ de $\Lcal$ vale que:
% \begin{enumerate}[({h}1)]
% \item $(X,A(X))$ � um grafo conexo, exceto, possivelmente, se $X = V$;
% \item se $X$ tem n�vel $t$ ent�o todo arco com ambas as pontas em $X$
% tem comprimento inferior a~$\delta_t$;~e
% \item se $X$ tem n�vel $t$ e n�o � folha, ent�o seus filhos formam uma
% $\delta_{t+1}$-parti��o. 
% \end{enumerate} 

% � dito simplesmente que $\Lcal$ � uma decomposi��o hier�rquica quando o conjunto
%$W$ for irrelevante. A figura~\ref{fig:decente} ilustra as condi��es (h2) e (h3) e a
%figura~\ref{fig:dec-hierarquica} mostra a decomposi��o hier�rquica de
%um grafo.
\begin{figure}[htbp]
 \begin{center}
    \psfrag{X}{{$X$}}
    \psfrag{Y}{{$Y$}}
    \psfrag{>= delta}{{$\geq \delta(Y)$}}%{{$\geq \delta_{t}$}}
    \psfrag{< delta}{}%{{$< \delta_{t}$}}
    \psfrag{>= delta+1}{$\geq \delta(X)$}%{{$\geq \delta_{t+1}$}}
    \psfrag{< delta+1}{}%{{$< \delta_{t+1}$}}
  \includegraphics{fig/decente.eps}
  \caption[{\sf Decomposi��o hier�rquica (condi��o (h2))}]
  {\label{fig:decente} Decomposi��o hier�rquica (condi��o (h2)).} 
 \end{center}
 \end{figure}

  \begin{figure}[htbp]
 \begin{center}
    \psfrag{(a)}{(a)}
    \psfrag{(b)}{(b)}
    \psfrag{(c)}{(c)}
    \psfrag{(d)}{(d)}
    \psfrag{(e)}{(e)}
    \psfrag{(f)}{(f)}
    \psfrag{0}{\scriptsize 0}
    \psfrag{1}{\scriptsize 1}
    \psfrag{2}{\scriptsize 2}
    \psfrag{3}{\scriptsize 3}
    \psfrag{4}{\scriptsize 4}
    \psfrag{7}{\scriptsize 7}
    \psfrag{8}{\scriptsize 8}
    \psfrag{10}{\scriptsize 10}
    \psfrag{>= 7}{\scriptsize $\geq 4$}
    \psfrag{>= 3}{\scriptsize $\geq 2$}
    \psfrag{>= 2}{\scriptsize $\geq 2$}
    \psfrag{>= 1}{\scriptsize $\geq 1$}
    \psfrag{s}{\scriptsize a}
    \psfrag{a}{\scriptsize b}
    \psfrag{b}{\scriptsize c}
    \psfrag{c}{\scriptsize d}
    \psfrag{d}{\scriptsize e}
    \psfrag{t}{\scriptsize f}
    \psfrag{x}{\scriptsize \textsc{v}}
    \psfrag{y}{\scriptsize \textsc{x}}
    \psfrag{z}{\scriptsize \textsc{y}}
    \normalsize
  \includegraphics{fig/dec_hierarquica.eps}
\caption[{\sf Exemplos de decomposi��es hier�rquicas}]
 {\label{fig:dec-hierarquica} (a) e (d) mostram grafos sim�tricos. A
figura (b) mostra a $\delta$-decomposi��o~$V$-hier�rquica do grafo em
(a), onde $\delta(V) = 2,\ \delta(X) = 1\ \mbox{e}\ \delta(Y) = 1$, e (c)
mostra a correspondente representa��o arb�rea. De maneira an�loga, (e)
exibe a $\delta$-decomposi��o $V$-hier�rquica do grafo em (d), onde
$\delta(V) = 4,\ \delta(X) = 2\ \mbox{e}\ \delta(Y) = 1$, e (f) ilustra a
correspondente representa��o arb�rea.}
 \end{center}
 \end{figure}
 
% O algoritmo descrito na pr�xima se��o resolve o seguinte variante do problema do
% caminho m�nimo:
% \begin{quote}
% \textbf{Problema} PCMS$(V,A,c,\Hcal,s)$:%
% \index{PCMS}\mar{PCMS}
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dado um grafo $(V,A)$, uma fun��o comprimento sim�trica $c$ de $A$ em
% $\PosInt$, uma decomposi��o hier�rquica $\Hcal$ e um v�rtice $s$, encontrar um 
% caminho de comprimento m�nimo de $s$ at� $t$, para cada v�rtice~$t$ em $V$.
% \end{quote}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Para resolver o PCMS o algoritmo de Thorup, como os algoritmos de
 Dijkstra e Dinitz-Thorup, mant�m, entre outros objetos, uma fun��o
 potencial $\fp{}$ (dist�ncia tentativa) e o conjunto~$Q$ dos v�rtices
 visitados. Al�m disso, tamb�m mant�m uma
 $\delta$-decomposi��o hier�rquica $\Lcal$. Se $X$ � um elemento de 
 $\Lcal$, ent�o $X$ � \defi{maduro}\index{elemento!maduro} se $Q \cap 
 X \neq \emptyset$ e 
 \[ X = V \ \ \mbox{ou}\ \  \min\{\fp(v)  \tq  v \in Q \cap Y\} \leq 
         \min\{\fp(v)  \tq  v \in Q \cap X\} \leq
         \min\{\fp(v) \tq v \in Q \cap Y\} + \delta(Y)/2,\]
onde $Y$ � o pai de $X$.
A figura~\ref{fig:fmaduro} mostra exemplos de elementos maduros.
 \begin{figure}[htbp]
 \begin{center}
    \psfrag{>=8}{\footnotesize {$\geq 8$}}
    \psfrag{>=4}{\footnotesize {$\geq 4$}}
    \psfrag{>=2}{\footnotesize {$\geq 2$}}
    \psfrag{8}{\footnotesize {$8$}}
    \psfrag{12}{\footnotesize {$12$}}
    \psfrag{14}{\footnotesize {$14$}}
    \psfrag{15}{\footnotesize {$15$}}
    \psfrag{16}{\footnotesize {$16$}}
    \psfrag{17}{\footnotesize {$17$}}
    \psfrag{19}{\footnotesize {$19$}}
    \psfrag{Filho maduro}{}
  \includegraphics{fig/filho_maduro.eps}
  \caption[{\sf Filhos maduros}]
 {\label{fig:fmaduro} As elipses representam elementos de
 $\Lcal$. O n�mero dentro de cada elemento $X$ de $\Lcal$ � o menor
 potencial de um v�rtice de $X \in Q$. A seta pontilhada indica quais s�o
 os elementos maduros.} 
 \end{center}
 \end{figure}

% O valor $\min\{\fp(v) \tq v \in Q \cap X\}$, � o
% \defi{potencial}\index{potencial de um conjunto} de $X$, denotado por
% $\fp(X)$; se $Q \cap X = \emptyset$ ent�o $\fp(X) = nC + 1$.
 
%Um elemento $X$ de uma decomposi��o hier�rquica $\Lcal$ �
% \defi{maduro}\index{maduro!decomposi��o hier�rquica} se $X$ � um filho 
%maduro, se o pai de $X$ � um filho maduro, e assim sucessivamente at� 
%a raiz de $\Lcal$. O conjunto $V$ �, por defini��o, maduro.
% Se $X$ � filho maduro, o pai de $X$ � filho maduro, o av� de $X$ � filho
% maduro, e assim sucessivamente, ent�o dizemos que $X$ �
% \defi{maduro}\index{maduro}.
%\begin{lema}{Thorup}%
%\index{lema de Thorup}
% \label{lema:thorup}
%  Se $X$ � maduro e $v \in X \cap Q$ tal que $\fp(v)$ � m�nimo 
%ent�o $\fp(v) - \fp(s) = c(P)$, onde $P$ � um caminho m�nimo
%de $s$ a $v$. 
% \end{lema}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  DESCRI��O
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Descri��o}
\label{sec:thorup-descricao}

O algoritmo de Thorup resolve o PCMS e devolve os mesmos certificados
que o algoritmo de Dijkstra e Dinitz-Thorup, a saber, 
uma fun��o predecessor codificando os
caminhos compactamente e uma fun��o potencial vi�vel atestando a minimalidade
dos caminhos e a eventual n�o acessibilidade de alguns v�rtices. 
O algoritmo de Thorup aplica, de certa forma, recursivamente o algoritmo de
Dinitz-Thorup, a fim 
de examinar um v�rtice $v$ se e somente se
$\{v\}$ e todos os seus ancestrais s�o maduros. A fun��o $\delta$ da
$\delta$-decomposi��o $V$-hier�rquica $\Lcal$ utilizada pelo
algoritmo, 
deve ser tal que, se $X$ � filho de $Y$ ent�o $\delta(X) \leq
\delta(Y)/2$. A se��o~\ref{sec:construcao-hierarquica} � descrito como
$\delta$ e $\Lcal$ s�o convenientemente constru�dos.
\newpage
\begin{quote} 
\textbf{Algoritmo de Thorup.}\index{algoritmo de!Thorup}
Recebe um grafo $(V,A)$, uma fun��o comprimento sim�trica~$c$ de $A$ em $\PosInt$,
e um v�rtice $s$ e devolve
uma fun��o predecessor $\pred$ e uma fun��o potencial $\fp$ que respeita $c$
tais que, para cada v�rtice $t$, se $t$ � acess�vel a partir de~$s$, ent�o
$\pred$ determina um caminho de $s$ a $t$ que tem comprimento 
$\fp(t) - \fp(s)$, caso contr�rio, $\fp(t)-\fp(s) = nC+1$, 
onde $C := \max\{ c(u,v) \tq uv \in A\}.$
\end{quote}

Cada itera��o come�a com 
uma fun��o potencial $\fp{}$, 
uma fun��o predecessor $\pred$,
partes $S, \L$ e $U$  de $V$, 
uma decomposi��o $(Q \cup U)$-hier�rquica $\Lcal$, e 
uma pilha $L = \seq{X_{0}, X_{1}, \ldots, X_{t}}$ de elementos de
$\Lcal$, tais que $X_{i+1}$ � filho de $X_{i}$, para $i = 0, \ldots, t-1$.

No in�cio da primeira itera��o  
$\fp(s) = 0$ e $\fp(v) = nC + 1$ para cada v�rtice $v$ distinto de $s$,
$\pred(v) = v$ para cada v�rtice $v$, 
$S = \emptyset$,
$\L = \{s\}$,
$U = V \setminus \{s\}$, 
$\Lcal$ � uma decomposi��o $V$-hier�rquica de $(V,A)$ em rela��o a $c$ e 
$L = \seq{V}$. [O algoritmo sup�e que se $X$ � filho de $Y$, ent�o
$\delta(X) \leq \delta(Y)/2$.]

A a��o em cada itera��o depende do elemento $X$ no topo da pilha $L$ e
consiste em:
\balgor
 \item \textbf{Caso 1:} $X$ n�o � maduro.

 \item \x \textbf{Caso 1A:} $X = V$.
  
   \x Devolva $\fp{}$ e $\pred$ e pare.

 \item \x \textbf{Caso 1B:} $X \neq V$ e $X$ � folha.

   \x Seja $\Lcal'$ a decomposi��o $(Q \cup U)$-hier�rquica obtida
   ap�s a remo��o de $X$ de $\Lcal$.

   \x Seja $L'$ a pilha obtida ap�s desempilhar $X$ de $L$.

   \x Comece nova itera��o com $\Lcal'$ e $L'$ nos pap�is de $\Lcal$ e $L$.
 
 \item \x \textbf{Caso 1C:} $X \neq V$ e $X$ n�o � folha.

   \x Seja $L'$ a pilha obtida ap�s desempilhar $X$ de $L$.

   \x Comece nova itera��o com $L'$ no papel de $L$.


  \item \textbf{Caso 2:} $X$ � maduro.

   \item \x \textbf{Caso 2A:} $X = \{u\}$, para algum $u$ em $V$ [isto �, $X$
   � folha].

   \x $S' := S \cup \{u\}$.

   \x $\L' := \L \setminus \{u\}$.
 
   \x $U'  := U$.

   \x Para cada $v$ em $V$ fa�a $\fp'(v) := \fp(v)$ e $\pred'(v) := \pred(v)$.

   \x Para cada arco $uv$ fa�a 

   \xx Se\ $\fp(v) > \fp(u) + c(u,v)$ ent�o 

   \xxx $\fp'(v) := \fp(u) + c(u,v)$, $\pred'(v) := u$ e 
        remova\footnote{�
     poss�vel que $v$ j� perten�a a $\L'$ e n�o esteja em $U'$. Nesse caso estas
     �ltimas duas instru��es s�o redundantes.} $v$ de $U'$ e acrescente a $\L'$.

   \x Seja $\Lcal'$ a decomposi��o $(Q' \cup U')$-hier�rquica obtida
   ap�s a remo��o de $\{u\}$ de $\Lcal$.

   \x Seja $L'$ a pilha obtida ap�s desempilhar $X$ de $L$.

   \x Comece nova itera��o com $\fp'$, $\pred'$, $S', \L'$,  $U'$,
   $\Lcal'$ e $L'$ nos pap�is de $\fp{}$, $\pred$, $S, \L$, $U$,
   $\Lcal$ e $L$.

  \item \x \textbf{Caso 2B:} $^^7cX^^7c > 1$ [isto �, $X$ n�o � folha].

   \x Seja $X'$ um filho maduro de $X$.

   \x Seja $L'$ a pilha obtida ap�s empilhar $X'$ em $L$.
 
   \x Comece nova itera��o com $L'$ no papel de $L$. \qed
\ealgor

 Diremos que o algoritmo \defi{visita}\index{visitar um elemento} um
 elemento $X$ de $\Lcal$ sempre que $X$ � empilhado em $L$. O
 algoritmo visita apenas elementos maduros, entretanto, um elemento em
 $L$ pode deixar de ser maduro durante a visita a algum dos seus
 descendentes. As
 figuras~\ref{fig:sim_thorup_desc},~\ref{fig:sim_thorup_desc2},
~\ref{fig:sim_thorup_desc3},~\ref{fig:sim_thorup_desc4}
 e~\ref{fig:sim_thorup_desc5} mostram a simula��o do algoritmo de
 Thorup no exemplo da figura~\ref{fig:dec-hierarquica}(a).

 Considere uma itera��o em que ocorre o caso~2A. Suponha que no in�cio da
 itera��o $L = \seq{X_0, X_1, \ldots, X_t}$, onde $X_0 = V$ e $X_t = X
= \{u\}.$
Como $\{u\}$ e todos os seus ancestrais s�o maduros, ent�o
\[
  \begin{array}{ccl}
\min\{\fp(v) \tq v \in Q \cap X_1\} & \leq &\min \{\fp(v) \tq v \in Q\} + \delta(X_0)/2\\
\min\{\fp(v) \tq v \in Q \cap X_2\} & \leq &\min \{\fp(v) \tq v \in Q \cap X_1\} + \delta(X_1)/2\\
                                    & \vdots &\\
\min\{\fp(v) \tq v \in Q \cap X_t\} & \leq &\min \{\fp(v) \tq v \in Q
\cap X_{t-1}\} + \delta(X_{t-1})/2\\ 
\end{array}
\]
 Portanto, para cada v�rtice $v$ em $Q$, vale que $\fp(u) \leq \fp(v) +
 (\delta(V) + \delta(X_1) + \cdots +  \delta(X_{t-1}))/2 < \fp(v) +
 \delta(V)$. 
A segunda desigualdade vale, pois $\delta(X_i) \leq \delta(X_{i-1})/2$ para cada $i$
em $[1..t-1]$. Esta observa��o � a
 ess�ncia do invariante (th1) da pr�xima se��o.

%\balgor
% \item \textbf{Caso 1:} $X$ � folha de $\Lcal$.
%
% \item \x \textbf{Caso 1A:} $X = V$.
%  
%   \x Devolva $\fp{}$ e $\pred$ e pare.
%
% \item \x \textbf{Caso 1B:} $X = \{u\}$, para algum $u$ em $V$.
%
%   \x $S' := S \cup \{u\}$.
%
%  \x $\L' := \L \setminus \{u\}$.
 %
%   \x $U'  := U$.
%
%   \x Para cada $v$ em $V$ fa�a $\fp'(v) := \fp(v)$ e $\pred'(v) := \pred(v)$.
%
 %  \x Para cada arco $uv$ fa�a 
%
 %  \xx Se\ $\fp(v) > \fp(u) + c_{uv}$ ent�o 
%
 %  \xxx $\fp'(v) := \fp(u) + c_{uv}$ e $\pred'(v) := u$,
  %      remova $v$ de $U'$ e acrescente a $\L'$.
%
 %  \x Seja $\Lcal'$ a decomposi��o $(Q' \cup U')$-hier�rquica obtida
  % ap�s a remo��o de $\{u\}$ de $\Lcal$.
%
 %  \x Seja $L'$ a pilha obtida ap�s desempilhar $X$ de $L$.
%
 %  \x Comece nova itera��o com $\fp'$, $\pred'$, $S', \L'$,  $U'$,
  % $\Lcal'$ e $L'$ nos pap�is de $\fp{}$, $\pred$, $S, \L$, $U$,
   %$\Lcal$ e $L$.
%
 %  \item \x \textbf{Caso 1C:} $X \neq V$ e $^^7cX^^7c > 1$.
%
 %  \x Seja $\Lcal'$ a decomposi��o $(Q \cup U)$-hier�rquica obtida
  % ap�s a remo��o de $X$ de $\Lcal$.
%
 %  \x Seja $L'$ a pilha obtida ap�s desempilhar $X$ de $L$.
%
 %  \x Comece nova itera��o com $\Lcal'$ e $L'$ nos pap�is de $\Lcal$ e $L$.
%
 % \item \textbf{Caso 2:} $X$ n�o � folha de $\Lcal$.
%
 % \item \x \textbf{Caso 2A:} $X$ � maduro.
 %
 %  \x Seja $X'$ um filho maduro de $X$.
%
 %  \x Seja $L'$ a pilha obtida ap�s empilhar $X'$ em $L$.
 %
  % \x Comece nova itera��o com $L'$ no papel de $L$.
%
 % \item \x \textbf{Caso 2B:} $X$ n�o � maduro.
%
 %  \x Seja $L'$ a pilha obtida ap�s desempilhar $X$ de $L$.
%
 %  \x Comece nova itera��o com $L'$ no papel de $L$. \qed
%\ealgor

 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(a)}{(a)}
    \psfrag{(b)}{(b)}
    \psfrag{(c)}{(c)}
    \psfrag{(d)}{(d)}
    \psfrag{>= 1}{\footnotesize $\geq 1$}
    \psfrag{>= 2}{\footnotesize $\geq 2$}
    \psfrag{0}{\footnotesize 0}
    \psfrag{1}{\footnotesize 1}
    \psfrag{2}{\footnotesize 2}
    \psfrag{3}{\footnotesize 3}
    \psfrag{4}{\footnotesize 4}
    \psfrag{5}{\footnotesize 5}
    \psfrag{6}{\footnotesize 6}
    \psfrag{7}{\footnotesize 7}
    \psfrag{25}{\footnotesize 25}
    \psfrag{s}{\footnotesize $s$}
    \psfrag{a}{\footnotesize $a$}
    \psfrag{b}{\footnotesize $b$}
    \psfrag{c}{\footnotesize $c$}
    \psfrag{d}{\footnotesize $d$}
    \psfrag{t}{\footnotesize $e$}
    \psfrag{x}{\footnotesize \textsc{v}}
    \psfrag{y}{\footnotesize \textsc{x}}
    \psfrag{z}{\footnotesize \textsc{y}}
    \psfrag{L = x}{\footnotesize $L = \seq{\mbox{{\sc v}}}$}
    \psfrag{L = x,{s}}{\footnotesize $L = \seq{\mbox{{\sc v}}, \{ s\}}$}
  \includegraphics{fig/desc_thorup_simulacao.eps}
\caption[{\sf Simula��o do algoritmo de Thorup} (1)]
 {\label{fig:sim_thorup_desc} Execu��o do algoritmo de Thorup.
(a) exibe um grafo com comprimento nos arcos, junto com uma  
$\delta$-decomposi��o $V$-hier�rquica $\Lcal$. O v�rtice inicial � $s$. (b) mostra a
situa��o no in�cio da primeira itera��o. Um n�mero pr�ximo a um
v�rtice ou elemento � o seu potencial. No grafo, os v�rtices pretos
s�o os de $S$, os v�rtices cinzas s�o os de $\L$, e os v�rtices
brancos s�o os de $U$. Na decomposi��o hier�rquica, os elementos
hachurados s�o os que est�o em $L$ e os elementos em preto s�o os que
foram removidos de $\Lcal$. (c) mostra a situa��o ap�s empilhar o
elemento $\{s\}$ (caso~2B) e (d) � a
situa��o ap�s examinar $\{s\}$ (caso~2A).}
 \end{center}
 \end{figure}

 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(e)}{(e)}
    \psfrag{(f)}{(f)}
    \psfrag{(g)}{(g)}
    \psfrag{(h)}{(h)}
    \psfrag{>= 1}{\footnotesize $\geq 1$}
    \psfrag{>= 2}{\footnotesize $\geq 2$}
    \psfrag{0}{\footnotesize 0}
    \psfrag{1}{\footnotesize 1}
    \psfrag{2}{\footnotesize 2}
    \psfrag{3}{\footnotesize 3}
    \psfrag{4}{\footnotesize 4}
    \psfrag{5}{\footnotesize 5}
    \psfrag{6}{\footnotesize 6}
    \psfrag{7}{\footnotesize 7}
    \psfrag{25}{\footnotesize 25}
    \psfrag{s}{\footnotesize $s$}
    \psfrag{a}{\footnotesize $a$}
    \psfrag{b}{\footnotesize $b$}
    \psfrag{c}{\footnotesize $c$}
    \psfrag{d}{\footnotesize $d$}
    \psfrag{t}{\footnotesize $e$}
    \psfrag{x}{\footnotesize \textsc{v}}
    \psfrag{y}{\footnotesize \textsc{x}}
    \psfrag{z}{\footnotesize \textsc{y}}
    \psfrag{L = x}{\footnotesize $L = \seq{\mbox{{\sc v}}}$}
    \psfrag{L = x,y}{\footnotesize $L = \seq{\mbox{{\sc v}}, \mbox{{\sc x}}}$}
    \psfrag{L = x,y,{a}}{\footnotesize $L = \seq{\mbox{{\sc v}},
 \mbox{{\sc x}}, \{ a\}}$}
  \includegraphics{fig/desc_thorup_simulacao2.eps}
\caption[{\sf Simula��o do algoritmo de Thorup} (2)]
 {\label{fig:sim_thorup_desc2} Execu��o do algoritmo de Thorup
(continua��o). Em (e) e (f) ocorre o caso~2B, e em (g) ocorre o caso~2A.
 Note que em (h), {\sc x} n�o � maduro, pois
$3 + (2/2) < 5$, ent�o � desempilhado (caso~1C).
}
 \end{center}
 \end{figure}

 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(i)}{(i)}
    \psfrag{(j)}{(j)}
    \psfrag{(k)}{(k)}
    \psfrag{(l)}{(l)}
    \psfrag{>= 1}{\footnotesize $\geq 1$}
    \psfrag{>= 2}{\footnotesize $\geq 2$}
    \psfrag{0}{\footnotesize 0}
    \psfrag{1}{\footnotesize 1}
    \psfrag{2}{\footnotesize 2}
    \psfrag{3}{\footnotesize 3}
    \psfrag{4}{\footnotesize 4}
    \psfrag{5}{\footnotesize 5}
    \psfrag{6}{\footnotesize 6}
    \psfrag{7}{\footnotesize 7}
    \psfrag{25}{\footnotesize 25}
    \psfrag{s}{\footnotesize $s$}
    \psfrag{a}{\footnotesize $a$}
    \psfrag{b}{\footnotesize $b$}
    \psfrag{c}{\footnotesize $c$}
    \psfrag{d}{\footnotesize $d$}
    \psfrag{t}{\footnotesize $e$}
    \psfrag{x}{\footnotesize \textsc{v}}
    \psfrag{y}{\footnotesize \textsc{x}}
    \psfrag{z}{\footnotesize \textsc{y}}
    \psfrag{L = x,y}{\footnotesize $L = \seq{\mbox{{\sc v}}, \mbox{{\sc x}}}$}
    \psfrag{L = x,z}{\footnotesize $L = \seq{\mbox{{\sc v}},
 \mbox{{\sc y}}}$}
    \psfrag{L = x,z,{c}}{\footnotesize $L = \seq{\mbox{{\sc v}},
 \mbox{{\sc y}}, \{ c\}}$}
    \psfrag{L = x,z,{d}}{\footnotesize $L = \seq{\mbox{{\sc v}},
 \mbox{{\sc y}}, \{ d\}}$}
  \includegraphics{fig/desc_thorup_simulacao3.eps}
\caption[{\sf Simula��o do algoritmo de Thorup} (3)]
 {\label{fig:sim_thorup_desc3} Execu��o do algoritmo de Thorup
(continua��o). Em (i), (j) e (l) ocorre o caso~2B, e em (k) ocorre o caso~2A.}
 \end{center}
 \end{figure}

 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(m)}{(m)}
    \psfrag{(n)}{(n)}
    \psfrag{(o)}{(o)}
    \psfrag{(p)}{(p)}
    \psfrag{>= 1}{\footnotesize $\geq 1$}
    \psfrag{>= 2}{\footnotesize $\geq 2$}
    \psfrag{0}{\footnotesize 0}
    \psfrag{1}{\footnotesize 1}
    \psfrag{2}{\footnotesize 2}
    \psfrag{3}{\footnotesize 3}
    \psfrag{4}{\footnotesize 4}
    \psfrag{5}{\footnotesize 5}
    \psfrag{6}{\footnotesize 6}
    \psfrag{7}{\footnotesize 7}
    \psfrag{25}{\footnotesize 25}
    \psfrag{s}{\footnotesize $s$}
    \psfrag{a}{\footnotesize $a$}
    \psfrag{b}{\footnotesize $b$}
    \psfrag{c}{\footnotesize $c$}
    \psfrag{d}{\footnotesize $d$}
    \psfrag{t}{\footnotesize $e$}
    \psfrag{x}{\footnotesize \textsc{v}}
    \psfrag{y}{\footnotesize \textsc{x}}
    \psfrag{z}{\footnotesize \textsc{y}}
    \psfrag{L = x}{\footnotesize $L = \seq{\mbox{{\sc v}}}$}
    \psfrag{L = x,y}{\footnotesize $L = \seq{\mbox{{\sc v}},
 \mbox{{\sc x}}}$}
     \psfrag{L = x,y,{b}}{\footnotesize $L = \seq{\mbox{{\sc v}},
 \mbox{{\sc x}}, \{ b\}}$}
    \psfrag{L = x,z}{\footnotesize $L = \seq{\mbox{{\sc v}}, \mbox{{\sc y}}}$}
     \psfrag{L = x,z,{d}}{\footnotesize $L = \seq{\mbox{{\sc v}},
 \mbox{{\sc y}}, \{ d\}}$}
  \includegraphics{fig/desc_thorup_simulacao4.eps}
\caption[{\sf Simula��o do algoritmo de Thorup} (4)]
 {\label{fig:sim_thorup_desc4} Execu��o do algoritmo de Thorup
(continua��o). Em (m) ocorre o caso~2A, em (n) o caso~1B e em (o) e (p)
o caso~2B.}
 \end{center}
 \end{figure}

 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(q)}{(q)}
    \psfrag{(r)}{(r)}
    \psfrag{(s)}{(s)}
    \psfrag{(t)}{(t)}
    \psfrag{>= 1}{\footnotesize $\geq 1$}
    \psfrag{>= 2}{\footnotesize $\geq 2$}
    \psfrag{0}{\footnotesize 0}
    \psfrag{1}{\footnotesize 1}
    \psfrag{2}{\footnotesize 2}
    \psfrag{3}{\footnotesize 3}
    \psfrag{4}{\footnotesize 4}
    \psfrag{5}{\footnotesize 5}
    \psfrag{6}{\footnotesize 6}
    \psfrag{7}{\footnotesize 7}
    \psfrag{25}{\footnotesize 25}
    \psfrag{s}{\footnotesize $s$}
    \psfrag{a}{\footnotesize $a$}
    \psfrag{b}{\footnotesize $b$}
    \psfrag{c}{\footnotesize $c$}
    \psfrag{d}{\footnotesize $d$}
    \psfrag{t}{\footnotesize $e$}
    \psfrag{x}{\footnotesize \textsc{v}}
    \psfrag{y}{\footnotesize \textsc{x}}
    \psfrag{z}{\footnotesize \textsc{y}}
    \psfrag{L = x}{\footnotesize $L = \seq{\mbox{{\sc v}}}$}
    \psfrag{L = x,y}{\footnotesize $L = \seq{\mbox{{\sc v}}, \mbox{{\sc x}}}$}
    \psfrag{L = x,{t}}{\footnotesize $L = \seq{\mbox{{\sc v}}, \{
 e\}}$}
  \includegraphics{fig/desc_thorup_simulacao5.eps}
\caption[{\sf Simula��o do algoritmo de Thorup} (5)]
 {\label{fig:sim_thorup_desc5} Execu��o do algoritmo de Thorup
(continua��o). Em (q) ocorre o caso~2A, em (r) o caso~1B,  em (s) o
caso~2B, e em (t) ocorre o caso~2A.}
 \end{center}
 \end{figure}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  INVARIANTES
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage
\section{Invariantes}
\label{sec:thorup-invariantes}\index{invariantes do algoritmo de!Thorup}

O algoritmo de Thorup, a exemplo do algoritmo de Dinitz-Thorup
 (cap�tulo~\ref{cap:dinitz-thorup}), mant�m
todos os invariantes do algoritmo de 
Dijkstra (se��o~\ref{sec:dijkstra-invariantes}), exceto aquele que � o
respons�vel pela ordem que os v�rtices s�o examinados, o invariante da
monotonicidade~\iten{dk3}.

No lugar do invariante da monotonicidade do algoritmo de Dijkstra, o
algoritmo de Thorup mant�m 
os dois invariantes a seguir, que dizem respeito aos 
elementos de $\Lcal$ e � $\delta$-decomposi��o hier�rquica. Note que a
fun��o $\delta$ do algoritmo � tal que, se $X$ � filho de $Y$, ent�o
$\delta(X) \leq \delta(Y)/2$.

%junto com os valores $\delta_0, \delta_1, \ldots, \delta_{h}$, onde
%$\delta_0 = C+1$, $\delta_i = 2^{h - i}$, para $i = 1, \ldots, h$, 
%onde $h$ � a altura de $\Lcal$.

\begin{enumerate}[({th}1)]
\item (monotonicidade local relaxada) para cada parte $X$ de $V$ em
$\Lcal$ e para cada $u$ em $S \cap X$, $v$ em $Q \cap X$ e $w$ em $U
\cap X$ vale que\footnote{A express�o "$\fp(u) \leq \fp(v) + \delta(X) <
\fp(w) = nC +1$"~deve ser entendida como uma abrevia��o. Se algum dos
conjuntos envolvidos � vazio, considere apenas as desigualdades que fazem sentido.}
\[
d(u) \leq d(v) + \delta(X) < d(w) = nC + 1. 
\]

\item (monotonicidade relaxada telesc�pica) para cada $u$ em $S$, $v$ em $Q$ e
$w$ em $U$ vale que 
\[
 d(u)  \leq d(v) + (\delta(X_k) + \delta(X_{k+1}) + \cdots + \delta(X_{t-1}))/2  
  < d(w) = nC + 1
\]
onde $X_k$ � o ancestral de maior n�vel comum a $\{u\}$ e $\{v\}$  e
$\seq{X_k, X_{k+1}, \ldots, X_{t-1}, X_t = \{u\}}$ � o caminho de
$X_k$ a $\{u\}$ na representa��o arb�rea de $\Lcal$.
\end{enumerate}

 A seguir est�o as demonstra��es do invariante da monotonicidade local
 relaxada~(th1) e da monotonicidade relaxada telesc�pica~(th2). Mais
 adiante, est� uma nova demonstra��o do invariante (dk9), que utiliza
 (th1) no lugar de (dk3) (ou (dt1) e (dt2) do algoritmo de Dinitz-Thorup).

 Note que o caso~2A � o �nico que altera os conjuntos $S$, $Q$ e $U$. 
 \begin{provainv}{\iten{th1}}
 A demonstra��o � an�loga � demonstra��o do invariante (dt1). Basta
 considerarmos uma itera��o em que ocorre o caso~2A. Seja $Y$ um elemento
 de $\Lcal$. Se no final da itera��o $w$ est� em $U' \cap Y$, ent�o � evidente
 que no final da itera��o vale que $\fp'(w) = \fp(w) = nC +1$. Al�m
 disso, combinando os invariantes (dk4), (dk5) e (dk6) que dizem
 respeito a fun��o predecessor e $\{S, Q, U\}$ e o invariante das
 folgas complementares, obt�m-se que 
\[
 \fp'(v) + \delta(Y) \leq \fp(v) + \delta(Y) \leq (n-1)C + \delta(Y) < nC
 +1 = \fp'(w)
\]
 para cada $v$ em $(Q' \cap Y)$.

  Assim, nos concentramos em verificar
 que para cada $x$ em $S' \cap Y$ e $y$ em $Q' \cap Y$, ao final da
 itera��o, vale que $\fp'(x) \leq \fp(y) + \delta(Y)$. 
 
 Seja $x$ um v�rtice em $S' \cap Y$ e $y$ um v�rtice em $Q' \cap
 Y$. Se $\fp'(y) = \fp(y)$, ent�o como $X = \{u\}$ e todos os seus
 ancestrais s�o maduros e pelo invariante (th1) tem-se que
\[
 \fp'(x) = \fp(x) \leq \fp(y) + \delta(Y) = \fp'(y) + \delta(Y).
\]

Suponha que $\fp'(y) < \fp(y)$. Portanto, 
\[
  \fp(u) \leq \fp(u) + c(u,y) = \fp'(y).
\]
 Como $\Lcal$ � uma decomposi��o hier�rquica e do
 invariante (th1), vale que $\fp(x) \leq \fp(u) + \delta(Y)$. Portanto,
 \[
  \fp'(x) = \fp(x) \leq \fp(u) + \delta(Y) \leq \fp'(y) + \delta(Y).
 \]
 \end{provainv}

 \begin{provainv}{\iten{th2}}
 Considere uma itera��o em que ocorre o caso 2B. Seja $w$ um v�rtice
 em $U'$. Ao final da itera��o $\fp'(w) = \fp(w) = nC +
 1$. Combinando-se os invariantes (dk4), (dk5) e (dk6) com o
 invariante das folgas complementares (dk12) obt�m-se que 
\begin{eqnarray*}
\fp'(v) + (\delta(X_k) + \cdots + \delta(X_{t-1}))/2 & \leq & \fp(v) + (\delta(X_k) + \cdots
+ \delta(X_{t-1}))/2\\
 & \leq & (n-1)C +(\delta(X_k) + \cdots + \delta(X_{t-1}))/2 \\
 & < & nC + 1 = \fp'(w)
\end{eqnarray*}
para cada $v$ em $Q'$ e $X_{i+1}$ � filho de $X_i$ para $i = k,
\ldots, t-2$.

Assim, resta demonstrar que para cada $x$ em
 $S$ e $y$ em $Q$, vale que 
\[ \fp(x) \leq \fp(y) + (\delta(X_k) + \cdots +
 \delta(X_{t-1}))/2.\]

 Seja $x$ um v�rtice em $S'$ e $y$ um v�rtice em $Q'$.
 Se ao final da itera��o $\fp'(y) = \fp(y)$,
 ent�o pelo invariante (th2) e como $\{u\}$ e todos os seus ancestrais
 s�o maduros, tem-se que
\[
\fp'(x) = \fp(x) \leq \fp(y) + (\delta(X_k) + \cdots + \delta(X_{t-1}))/2 = \fp'(y)
+ (\delta(X_k) + \cdots + \delta(X_{t-1}))/2.
\] 
Logo, podemos supor que ao final da itera��o vale que $\fp'(y) <
 \fp(y)$. Portanto, 
\[
 \fp(u) \leq  \fp(u) + c(u,y) = \fp'(y).
\]
Do invariante (th2) sabe-se que $\fp(x) \leq \fp(u) + (\delta(X_k) +
 \cdots + \delta(X_{t-1}))/2$.
 Portanto,
\[
 \fp'(x) = \fp(x) \leq \fp(u) + (\delta(X_k) + \cdots + \delta(X_{t-1}))/2 \leq
 \fp'(y) + (\delta(X_k) + \cdots + \delta(X_{t-1}))/2 < \fp'(y) + \delta(X_k).
\] 
 \end{provainv}

 \begin{provainv}{\iten{dk9}}
 Considere uma itera��o em que ocorre o caso~2B. Seja $yx$ um arco
 qualquer em $A(Q',S')$ ao final da itera��o. Seja $X$ em $\Lcal$ o
 ancestral comum de $\{x\}$ e $\{y\}$ de maior n�vel. Suponha que o
 n�vel de $X$ � $t-1$. Do invariante (th1) obtem-se que
\[
 \fp'(x) \leq \fp'(y) + \delta(X)/2.
\]

Assim, como $\Lcal$ � uma decomposi��o hier�rquica, ent�o $\fp'(x) -
 \fp'(y) \leq \delta(X)/2 \leq c(y,x)$.
 Portanto, ao final da itera��o, $\fp$ respeita $c$ em $A(Q', S')$.

 O processo de examinar $u$ faz com que $\fp'$ respeite $c$ em cada arco com
  ponta inicial em $u$. Do invariante~\iten{dk9} sabe-se que $\fp$ respeita $c$
  em $A(S,\L)$.  Assim, como $\fp'(v) = \fp(v)$ para cada $v$ em $S'$ e
  $\fp'(v) \leq \fp(v)$ para cada $v$ em $\L'$, conclu�-se
  que $\fp'$ respeita $c$ em $A(S',\L')$.
 \end{provainv}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  CORRE��O
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\section{Corre��o}
\label{sec:thorup-correcao}

 A corre��o do algoritmo de Thorup � facilmente demonstrada atrav�s
 dos seus invariantes, e � textualmente id�ntica a demonstra��o da
 corre��o do algoritmo de Dijkstra (se��o ~\ref{teo:correcao-dijkstra}), 
 j� que este �ltimo n�o utiliza o invariante da
 monotonicidade~(dk3). Note que na �ltima itera��o do algoritmo de
 Thorup, quando ocorre o caso~1A, tem-se que $Q$ � vazio, pois se $X =
 V$ n�o � maduro, ent�o $Q \cap V = \emptyset$.

\begin{teorema}{teorema da corre��o}
\label{teo:correcao-thorup}
Para cada v�rtice $t$ acess�vel a
partir de $s$ o algoritmo de Thorup devolve um caminho de $s$ a $t$ que tem
comprimento m�nimo. \fimprova
\end{teorema}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  EFICI�NCIA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\section{Efici�ncia}
\label{sec:thorup-eficiencia}

 Seja $(V,A,c,s)$ uma inst�ncia do PCMS. Denotamos por $n$ e
 $m$ o n�mero de v�rtices e arestas de $(V,A)$. Uma implementa��o
 eficiente do algoritmo de Thorup deve resolver eficientemente os
 seguintes problemas:
 \begin{enumerate}[({p}1)]
 \item (pr�-processamento) constru��o da $\delta$-decomposi��o $V$-hier�rquica
       $\Lcal$ de $(V,A)$ 
 em rela��o a~$c$;
 \item (caso~2A) atualizar os potenciais e manter $\min\{\fp(v) \tq v \in Q \cap
 X\}$ para cada $X$ em $\Lcal$; e 
 \item (caso~2B) escolher o pr�ximo elemento maduro a ser visitado.
 \end{enumerate}

\section*{{\large Constru��o da decomposi��o hier�rquica}}

O problema (p1) � resolvido por um pr�-processamento do algoritmo, que � 
feito em tempo $O(m + n)$ utilizando-se os trabalhos de Andersson,
Hagerup,  Nilsson e Raman~\cite{andersson:sorting}, Fredman e
Willard~\cite{fredman:mst} e Gabow e Tarjan~\cite{gabow:setunion}.
A implementa��o do algoritmo mant�m a decomposi��o hier�rquica $\Lcal$ atrav�s de
sua representa��o arb�rea $(\Lcal, \Acal)$. A constru��o de
$(\Lcal,\Acal)$ est� descrita na pr�xima se��o.

 Al�m de construir uma $\delta$-decomposi��o $V$-hier�rquica o
 pr�-processamento tamb�m devolve uma floresta geradora $(V,T)$ de $(V,A)$ tal
 que
  \begin{enumerate}
  \item[(h3)] cada aresta de $T$ com pontas em filhos distintos de algum $X$ em
  $\Lcal$ tem comprimento inferior a  $2\delta(X)$.
  \end{enumerate}

 As condi��es (h2) e (h3) juntas implicam que cada aresta de $T$ com pontas em
 filhos distintos de algum elemento $X$ de $\Lcal$, tem seu comprimento em
 $[\delta(X)..2\delta(X)-1]$.

 � evidente que, para cada $X$ em $\Lcal$, o valor
\[
\sum_{uv \in T(X)} c(u,v)
\]
� um limitante superior para o \defi{di�metro}\index{diametro@@di�metro} do
grafo $(X,A(X))$, isto �, para o comprimento do maior caminho em
$(X,A(X))$.
 
\section*{{\large Atualiza��o dos potenciais}}

A opera��o que precisa ser realizada eficientemente �
\begin{quote}
 atualizar $\min\{\fp(v) \tq v \in Q \cap X\}$ sempre que o potencial
 $\fp(v)$ de um v�rtice $v$ em $Q \cap X$ � decrescido.
\end{quote}
onde $X$ � um elemento da decomposi��o
$\Lcal$. Thorup~\cite{thorup:sssp-1999} descreve como esta opera��o
pode ser implementada em tempo amortizado constante.

Em linhas gerais, a id�ia de Thorup � a seguinte. 
Seja $v_1, \ldots, v_n$ uma ordena��o dos v�rtices em $Q$ induzida por
uma ordem arbitr�ria dos elementos internos da representa��o arb�rea
$(\Lcal,\Acal)$. No in�cio de cada itera��o do algoritmo, para cada
elemento $X$ em $\Lcal$, os elementos $\{ \{v\} \tq v \in Q \cap X\}$
s�o folhas de $(\Lcal, \Acal)$ que t�m $X$ como ancestral. Estas
folhas formam um segmento cont�guo de $v_1, \ldots, v_n$.

Thorup descreve como, utilizando-se os atomic heaps de Fredman e
Willard~\cite{fredman:mst}, � poss�vel manter uma parti��o din�mica de
$v_1, \ldots, v_n$ em segmentos cont�guos de tal forma que, para cada
$X$ em $\Lcal$, tenha-se que 
\[
\min\{\fp(v) \tq v \in Q \cap X\} = \min\{\fp(v_i) \tq i \in [k..l]\}
\]
onde $k$ e $l$ dependem de $X$.

\section*{{\large Escolha de um elemento maduro}}

A fim de escolher o pr�ximo elemento maduro a ser visitado pelo
algoritmo, pode-se proceder de maneira an�loga ao algoritmo de
Dinitz-Thorup, como apresentado a seguir.

Cada elemento interno $Y$ em $\Lcal$ mant�m os seus filhos em buckets 
$B(Y,0), B(Y, 1), \ldots, B(Y, \Delta(Y))$. Para cada $i$ em
$[0..\Delta(Y)]$, $B(Y,i)$ cont�m os filhos $X$ de $Y$ tal que 
\[
 i\delta(Y)/2 \leq \min\{\fp(v) \tq v \in Q \cap X\} \leq (i+1)\delta(Y)/2.
\]
O bucket $B(Y,\Delta(Y))$ cont�m os
filhos $X$ de $Y$ tal que $Q \cap X = \emptyset$ e $U \cap X \neq
\emptyset$.

Em cada itera��o em que ocorre o caso~2B, para escolher o filho maduro
$X'$ de $X$ a ser visitado, basta encontrar o menor $k$ em $[0..\Delta(X)-1]$ tal que
$B(X, k)$ � n�o-vazio. Devido ao invariante da monotonicidade local
relaxada~\iten{th1}, os elementos maduros podem ser escolhidos pelo
algoritmo a medida que os buckets s�o visitados na ordem
$B(X, 0),B(X, 1),\ldots,B(X, \Delta(X)-1)$. As opera��es principais envolvendo os buckets
s�o remo��es e inser��es. Suponha que cada  bucket �
representado atrav�s de uma lista ligada. Assim, cada opera��o de remo��o e inser��o de
filhos de um elemento $X$ em seus buckets pode ser realizada, no modelo RAM,  em tempo
constante: para determinar o bucket $B(X, k)$ que cont�m um certo
filho $X'$ de $X$ basta computar 
$k = \floor{2\min\{ \fp(v) \tq v \in  X' \setminus S\}/\delta(X)}$.
Portanto, o consumo total de tempo das opera��es envolvendo os buckets �
proporcional a 
\[ 
 n+m+ \sum_{X \in \Lcal^{*}}(\Delta(X) + 1),
\]
 onde
$\Lcal^{*}$ � o conjunto  
dos elementos internos de $\Lcal$.
Na simula��o do algoritmo de Thorup, ilustrada nas
 figuras~\ref{fig:sim_thorup} e ~\ref{fig:sim_thorup2}, 
 os buckets s�o representados pelo vetor ao lado da decomposi��o hier�rquica.

O valor $\Delta(X)$ deve ser um limitante superior para o n�mero de buckets
associado a $X$. � suficiente tomarmos 
\begin{eqnarray}
\label{eq:delta}
\Delta(X) := {\big \lceil} 2 \sum_{uv \in T(X)} c(u,v)/\delta(X) {\big \rceil} 
\end{eqnarray}
onde (V,T) � a floresta que satisfaz (h3) e foi constru�da durante o
pr�-processamento.
O lema a seguir mostra que com a defini��o de $\Delta(X)$ conforme a equa��o~\ref{eq:delta}, o
n�mero total de buckets mantidos pelo algoritmo � inferior a $12n$. Portanto,
o consumo total de tempo e espa�o das opera��es envolvendo os buckets �
  proporcional a
\[ 
n+m+ \sum_{X \in \Lcal^{*}}(\Delta(X) + 1) < n + m +12n = 13n +m = O(n + m).
\]
\begin{lema}{n�mero de buckets}
 \label{lema:no-buckets}
Seja $\Lcal$ a $\delta$-decomposi��o $V$-hier�rquica de $(V,A)$ em rela��o a
$c$ e $(V,T)$
uma floresta gerada de $(V,A)$ tal que $\delta$ e $(V,T)$ satisfazem (h3).
 O n�mero m�ximo de
buckets mantidos pelo algoritmo de Thorup �
\end{lema}
\begin{eqnarray*}
\label{eq:no-buckets}
 \sum_{X \in \Lcal^{*}} (\Delta(X) +1) < 12n,
\end{eqnarray*}
onde $\Lcal^{*}$ � o conjunto dos elementos internos de $\Lcal$.

\begin{prova}

 Para cada elemento $X$ em $\Lcal^{*}$ temos que 
\[\Delta(X) + 1 \leq 2 + 2\sum_{uv \in T(X)} c(u,v) / \delta(X).\]

 Como cada elemento $X$ de $\Lcal$ tem pelo menos dois filhos ent�o 
 $\Lcal$ tem no m�ximo $2n -1$ elementos, ent�o
\begin{eqnarray*}
\sum_{X \in \Lcal^*} (\Delta(X) + 1) & \leq & \sum_{X \in \Lcal^*} 2 +
 2 \sum_{X \in \Lcal^*}\sum_{uv \in T(X)} c(u,v) /\delta(X)  \\
 & \leq & 4n + 2 \sum_{X \in \Lcal^*} \sum_{uv \in T(X)} c(u,v)/ \delta(X) \\
 & = & 4n + 2\sum_{uv \in T} \sum_{X \tq uv
\in T(X)} c(u,v)/\delta(X).
\end{eqnarray*}

Considere uma aresta $uv$ em $T$. Seja $X_0 , \ldots, X_t$ uma ordena��o dos
elementos de $\Lcal$ que cont�m $u$ e $v$ tal que $X_{i+1}$ � filho de $X_i$,
para $i = 0, \ldots, t-1$. Temos que 
\begin{eqnarray*}
\sum_{X \tq uv \in T(X)} c(u,v)/ \delta(X) & < & \sum_{X \tq uv \in T(X)}
2\delta(X_t)/\delta(X)\\
& = & 2 {\big (} \delta(X_t)/\delta(X_t) +
\delta(X_t)/\delta(X_{t-1}) + \cdots + \delta(X_t)/\delta(X_0) {\big )}\\
& < & 2 {\big (} 1 + 1/2 + 1/4 +\cdots {\big )}\\
& < & 4, 
\end{eqnarray*}
onde a primeira desigualdade � devida a (h3) e onde a segunda � devida ao fato
que 
\[
\delta(X_{i+1}) \leq \delta(X_i)/2,\ \mbox{para}\ i = 0, \ldots, t-1.
\]
Logo,
\begin{eqnarray*} 
4n + 2 \sum_{uv \in T} \sum_{X \tq uv \in T(X)} c(u,v)/\delta(X) & <& 4n +2
\sum_{uv \in T} 4 \\
& < & 4n + 8n\\
& = & 12n
\end{eqnarray*}
\end{prova}

\section*{\large N�mero de itera��es}
O caso~1A ocorre apenas uma vez. 
Inicialmente, a $\delta$-decomposi��o $V$-hier�rquica $\Lcal$ tem no m�ximo
$2n-1$ elementos. Logo, os casos~1B e 2A juntos ocorrem no m�ximo $2n$ vezes,
pois em cada ocorr�ncia de um desses casos um elemento � removido de $\Lcal$.

Para estimarmos o n�mero de ocorr�ncias dos casos~1C e 2B, basta considerarmos
o n�mero de opera��es empilha e desempilha, de elementos n�o folhas, realizadas
  em $L$. Consideraremos apenas o n�mero de opera��es desempilha, j� que o
  n�mero de opera��es empilha � um a mais do que o n�mero de opera��es
  desempilha
 (o algoritmo p�ra com
  $L = \seq {V}$). Quando um elemento n�o-folha $X$ � empilhado em $L =
  \seq{X_0, X_1, \ldots, X_t}$ temos que $X$ � maduro e portanto, 
  $Q \cap X \neq \emptyset$ e 
\[
\min\{\fp(v) \tq v \in Q \cap X\} \leq \min \{ \fp(v) \tq v \in Q \cap X_t\} +
\delta(X_t)/2.
\]
O elemento $X$ � desempilhado de $\Lcal$ por uma das seguintes raz�es:
\begin{enumerate}[({r}1)]
\item $Q \cap X = \emptyset$; ou
\item $\min\{\fp(v) \tq v \in Q \cap X\} >
\min\{\fp(v) \tq v \in Q \cap X_t\} + \delta(X_t)/2$.

O n�mero total de vezes que desempilhamos um elemento pela raz�o (r1) � no
m�ximo $n$ (o n�mero de elementos internos de $\Lcal$ � no m�ximo $n$).
\end{enumerate}
Sempre que um elemento � desempilhado pela raz�o (r2), este elemento �
removido de um bucket e inserido em outro bucket de $X_t$. Como o n�mero total de opera��es
envolvendo buckets � limitado por $13n + m$, ent�o o n�mero total de vezes que
um elemento � desempilhado pela raz�o (r2) � no m�ximo $13n + m$.
Portanto, o n�mero total de ocorr�ncias dos casos 1C e 2B juntos � no m�ximo $2(n + 13n
+m) = 28n + 2m.$

Resumindo, o n�mero total de itera��es realizadas pelo algoritmo � inferior a
$30n + 2m + 1 = O(n + m)$.
Como cada itera��o consome tempo amortizado constante temos o seguinte
teorema.

\begin{teorema}{consumo de tempo}
\label{teo:consumo-de-tempo-thorup}
O algoritmo de Thorup, quando executado, no modelo RAM, em um grafo com $n$
v�rtices e $m$ arcos, gasta tempo $O(n + m)$. \fimprova
\end{teorema} 

%Isto termina a demonstra��o de~\ref{lema:no-buckets}.

%Devido a~\ref{lema:no-buckets} obtem-se que o consumo total de tempo
%das opera��es envolvendo os buckets �  
%\[
%n + m + \sum_{X \in \Lcal^*} (\Delta(X) +1) \leq 5n + 5m = O(n + m).
%\]

 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(a)}{(a)}
    \psfrag{(b)}{(b)}
    \psfrag{(c)}{(c)}
    \psfrag{(d)}{(d)}
    \psfrag{(e)}{(e)}
    \psfrag{(f)}{(f)}
    \psfrag{>= 2}{\footnotesize $\geq 2$}
    \psfrag{>= 1}{\footnotesize $\geq 1$}
    \psfrag{0}{\footnotesize 0}
    \psfrag{1}{\footnotesize 1}
    \psfrag{2}{\footnotesize 2}
    \psfrag{3}{\footnotesize 3}
    \psfrag{4}{\footnotesize 4}
    \psfrag{5}{\footnotesize 5}
    \psfrag{6}{\footnotesize 6}
    \psfrag{7}{\footnotesize 7}
    \psfrag{25}{\scriptsize $25$}
    \psfrag{0 }{\footnotesize 0}
    \psfrag{1 }{\footnotesize 1}
    \psfrag{2 }{\footnotesize 2}
    \psfrag{3 }{\footnotesize 3}
    \psfrag{4 }{\footnotesize 4}
    \psfrag{7 }{\footnotesize 7}
    \psfrag{s}{\footnotesize $s$}
    \psfrag{a}{\footnotesize $a$}
    \psfrag{b}{\footnotesize $b$}
    \psfrag{c}{\footnotesize $c$}
    \psfrag{d}{\footnotesize $d$}
    \psfrag{t}{\footnotesize $t$}
    \psfrag{x}{\textsc{v}}
    \psfrag{y}{\textsc{x}}
    \psfrag{z}{\textsc{y}}
  \includegraphics{fig/thorup_simulacao.eps}
\caption[{\sf Simula��o da implementa��o do algoritmo de Thorup}]
 {\label{fig:sim_thorup}{ Execu��o do algoritmo de Thorup.
(a) exibe a representa��o arb�rea da decomposi��o $V$-hier�rquica do
grafo da figura~\ref{fig:sim_thorup_desc}(a). O v�rtice inicial � o
$s$. (b) mostra a situa��o no in�cio da primeira itera��o. O n�mero
pr�ximo a um elemento � o seu potencial. Na decomposi��o hier�rquica,
os elementos em cinza s�o os j� visitados. Se forem elementos
internos significam que j� possuem bucket. Os pretos s�o os removidos
da representa��o arb�rea. (c) mostra a situa��o ap�s criar o bucket de
$V$ e (d) a situa��o ap�s examinar $\{s\}$. Note que nos elementos que j� possuem
bucket, o potencial m�nimo � a primeira posi��o n�o-vazia do bucket. 
Em (e) ocorre a opera��o de empilhar o filho
maduro \textsc{y} de $V$ (crie bucket de \textsc{y}). Em (f), $\{s\}$ �
empilhado e depois examinado. }
}
 \end{center}
 \end{figure}

 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(g)}{(g)}
    \psfrag{(h)}{(h)}
    \psfrag{(i)}{(i)}
    \psfrag{(j)}{(j)}
    \psfrag{(k)}{(k)}
    \psfrag{(l)}{(l)}
    \psfrag{0}{\footnotesize 0}
    \psfrag{1}{\footnotesize 1}
    \psfrag{2}{\footnotesize 2}
    \psfrag{3}{\footnotesize 3}
    \psfrag{4}{\footnotesize 4}
    \psfrag{5}{\footnotesize 5}
    \psfrag{6}{\footnotesize 6}
    \psfrag{7}{\footnotesize 7}
    \psfrag{25}{\footnotesize $25$}
    \psfrag{0 }{\footnotesize 0}
    \psfrag{1 }{\footnotesize 1}
    \psfrag{2 }{\footnotesize 2}
    \psfrag{3 }{\footnotesize 3}
    \psfrag{4 }{\footnotesize 4}
    \psfrag{5 }{\footnotesize 5}
    \psfrag{7 }{\footnotesize 7}
    \psfrag{s}{\footnotesize $s$}
    \psfrag{a}{\footnotesize $a$}
    \psfrag{b}{\footnotesize $b$}
    \psfrag{c}{\footnotesize $c$}
    \psfrag{d}{\footnotesize $d$}
    \psfrag{t}{\footnotesize $t$}
    \psfrag{x}{\textsc{v}}
    \psfrag{y}{\textsc{x}}
    \psfrag{z}{\textsc{y}}
  \includegraphics{fig/thorup_simulacao2.eps}
\caption[{\sf Simula��o da implementa��o do algoritmo de Thorup (continua��o)}]
 {\label{fig:sim_thorup2} Execu��o do algoritmo de Thorup
(continua��o). Como n�o havia elementos em $B(\mbox{{\sc {y}}},0)$ 
 soma-se um ao m�nimo de {\sc y}, como mostrado em (g). Assim, {\sc y} n�o � mais
maduro. Logo, foi necess�rio mover {\sc y} de $B(\mbox{{\sc {v}}},1)$
para $B(\mbox{{\sc {y}}},2)$. Por n�o haver elementos em $B(\mbox{{\sc
{v}}},1)$ o m�nimo de {\sc v} � adicionado em um. No momento em (g) �
poss�vel empilhar novamente {\sc v} e em seguida examinar $\{d\}$. As
figuras (i), (j), (k) e (l) s�o repeti��es dos casos anteriores.}
 \end{center}
 \end{figure}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  CONSTRU��O DA DECOMPOSI��O
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\section{Constru��o da decomposi��o hier�rquica}
\label{sec:construcao-hierarquica}

 Resumidamente, os ingredientes utilizados para construir a
 $\delta$-decomposi��o $V$-hier�rquica $\Lcal$ de $(V,A)$ em rela��o a $c$, em tempo linear,
 no modelo RAM, s�o:
 \begin{itemize}
 \item Encontrar uma �rvore geradora m�nima em tempo linear. Nesse
 ponto, � utilizado o algoritmo de Fredman e Willard~\cite{fredman:mst};
 \item Conseguir executar cada opera��o de uni�o de conjuntos disjuntos em tempo
 constante. Para isso, � utilizado o algoritmo de Gabow e
 Tarjan~\cite{gabow:setunion}; e
% casos especiais de uni�es de conjuntos disjuntos, que permite fazer
% opera��es de {\it union-find}\footnote{Normalmente essas opera��es
%s�o: $union$, que une dois representantes de conjuntos distintos e $find$, que encontra o
%representante de um conjunto. Pode-se tomar como refer�ncia o livro
% CLRS~\cite{clrs:introalg-2001}} em tempo constante; e 
 \item Ordenar em tempo linear. Neste caso, � utilizado o algoritmo
 de Andersson, Hagerup, Nilsson e Raman~\cite{andersson:sorting}.
 \end{itemize} 

 Seja $(V,A)$ um grafo e uma fun��o comprimento sim�trica $c$ de $A$ em $\PosInt$.
 O primeiro passo na constru��o da $\delta$-decomposi��o
 $V$-hier�rquica $\Lcal$ �
construir uma �rvore geradora m�nima de $(V,A)$. Isso pode ser feito
 em tempo linear, no modelo RAM, conforme descrito
por Fredman e Willard~\cite{fredman:mst}. O m�todo desenvolvido por
eles, � uma aplica��o direta de uma estrutura de dados, chamada
{\it atomic heap}, que realiza as opera��es da fila de
 prioridade, \textsf{insert}, \textsf{delete-min} e
 \textsf{decrease-key} em tempo amortizado constante.

 A id�ia do algoritmo � semelhante ao de Dijkstra
 (cap�tulo~\ref{cap:dijkstra}). A partir de um v�rtice inicial $s$, encontra um
 caminho de $s$ at� $t$, para cada v�rtice $t$ em $V$ que � acess�vel a
 partir de $s$. Neste caso, os caminhos encontrados n�o s�o
 necessariamente os m�nimos, o importante � que a soma das arestas da
 arboresc�ncia determinada pela fun��o predecessor tenha comprimento
 m�nimo. Da mesma forma que o algoritmo de Dijkstra, 
cada itera��o come�a com 
uma fun��o potencial $\fp{}$, 
uma fun��o predecessor $\pred$, 
e partes $S, \L$ e $U$ de $V$. Como $Q$ � implementado atrav�s de um atomic heap, �
 necess�rio controlar o n�mero de elementos que s�o inseridos em
 $Q$. Esse n�mero limite ser� $\log n$. 

O algoritmo que constr�i uma �rvore geradora m�nima em tempo linear �
dividido em dois passos. O primeiro passo consiste no seguinte:

No in�cio da primeira itera��o  
$\fp(v) = nC + 1$ para cada v�rtice $v$, 
$\pred(v) = v$ para cada v�rtice $v$,
$S = \emptyset$,
$\L = \emptyset$ e $U = V$.

Ent�o, o passo seguinte � repetido at� que $U = \emptyset$.

 No in�cio da primeira itera��o 
 escolha $u$ em $U$ tal que $\fp(u) = nC + 1$, fa�a $\fp(u) := 0$,
 $\L = \{u\}$ e $U := U \setminus \{u\}$.
 
 Cada itera��o consiste no seguinte.
\balgor 
 \item \textbf{Caso 1:}\ {$\L = \emptyset$ ou $^^7c Q ^^7c \geq \log n$}
  
  Pare.

 \item \textbf{Caso 2:}\ {$\L \neq \emptyset$ e $^^7c Q ^^7c < \log n$}

  Escolha $u$ em $\L$ tal que $\fp(u)$ seja m�nimo.

  $S := S \cup \{u\}$.

  $\L := \L \setminus \{u\}$.

  Para cada arco $uv$ fa�a 
%
 %\x Se $\fp(v) = nC + 1$ ent�o
% 
% \xx $\fp(v) := c(u,v)$, remova $v$ de $U$ e acrescente a $\L$.
%
% \x Sen�o se $c(u,v) < \fp(v)$ ent�o 
 
 \x Se $c(u,v) < \fp(v)$ ent�o 
 
 \xx $\fp(v) := c(u,v)$, $\pred(v) := u$ e remova\footnote{�
     poss�vel que $v$ j� perten�a a $\L$ e n�o esteja em $U$. Nesse
 caso estas �ltimas duas instru��es s�o redundantes.} $v$ de $U$ e
 acrescente a $\L$.

 Comece nova itera��o.
\ealgor

  Como as opera��o em $Q$ s�o feitas em tempo amortizado constante,
devido ao uso do atomic heap, o primeiro passo gasta tempo $O(m + n)$, onde
$n$ � o n�mero de v�rtices e $m$ � o n�mero de arcos.

 Para o segundo passo, a parte $S$ � condensada como se fosse um �nico v�rtice,
resultando em um grafo com $n'= O(m/\log n)$ v�rtices. Utilizado o mesmo
algoritmo acima no grafo condensado, mas trocando o atomic heap por um fibonacci heap
(se��o ~\ref{sec:fibonacci})\footnote{Note que agora n�o � necess�rio
controlar o n�mero de elementos inseridos em $Q$.}, a �rvore geradora
m�nima � obtida em tempo $O(m + n' \log n') = O(m)$.

 A principal motiva��o para trabalhar com uma �rvore geradora m�nima em 
vez do grafo � devido ao m�todo desenvolvido por 
Gabow e Tarjan~\cite{gabow:setunion}, que mostra como 
pr�-processar uma �rvore, em tempo linear, para tornar poss�vel cada
 opera��o {\it union-find}\footnote{Normalmente essas opera��es
 s�o: $union$, que une dois representantes de conjuntos distintos e $find$, que encontra o
 representante de um conjunto. Pode-se tomar como refer�ncia o livro
 CLRS~\cite{clrs:introalg-2001}} gastar tempo constante. Essas opera��es s�o utilizadas
na constru��o das $\delta(X)$-parti��es (se��o~\ref{sec:hierarquica}),
onde $X$ � um elemento de $\Lcal$.
% Como descrito anteriormente
% , cada elemento $X$ de uma decomposi��o 
% $W$-hier�rquica, pertencem a  uma $\delta_i$-parti��o, onde
% $i$ � o n�vel de $X$ e $\delta_{i}  =  2^{h - i}$, sendo $h$ a
% altura de $\Lcal$. No algoritmo de
% Thorup, cada n�vel $i$ da decomposi��o hier�rquica forma uma
% $\delta_i$-parti��o, e toda 
% aresta com pontas final e inicial em um mesmo elemento $X$ de uma
% $\delta_i$-parti��o tem comprimento menor que $\delta_{i}$.
 Do ponto de vista do algoritmo descrito neste cap�tulo, 
para cada $X$ em $\Lcal$, $\delta(X)$ � um n�mero da forma $2^k$, para
algum $k$.
A constru��o de $\Lcal$, come�a construindo partes $X$, conexas
 maximais, induzidas por arestas de comprimento em 
$[2^0..2^1 - 1]$. Cada parte $X$ ser� um elemento interno de $\Lcal$, onde
$\delta(X) = 2^0$. Em seguida, s�o constru�das as partes $X$, conexas
 maximais, induzidas por arestas de comprimento $[2^1..2^{2}-1]$, 
logo $\delta(X) = 2^1$. De maneira geral, a cada passo $i$, as partes $X$
s�o formadas pelas arestas de comprimento em $[2^i..2^{i+1}-1]$, e
$\delta(X) = 2^i$.

 Observe que os comprimentos da arestas em $[2^i..2^{i+1}-1]$
 possuem o mesmo \defi{most significant bit}\index{most significant
 bit}\mar{msb} (msb),
 j� que o msb de um inteiro $x$ � $\floor{\log_2 x}$.   
 Por exemplo, considere o intervalo $[4,5,6,7]$. Ent�o, o msb dos
 n�meros nesse intervalo � $2$. 

 De fato, o que � usado para construir os elementos internos de $\Lcal$, � o msb
 do comprimento das arestas. 
 Embora o msb n�o � obtido diretamente, ele pode ser calculado, no
 modelo RAM, usando-se um n�mero constante de opera��es. 
 O msb de um n�mero $x$ pode ser calculado da seguinte forma:
 (1) converta $x$ para um n�mero em ponto flutuante.  
 Conforme o padr�o IEEE~\cite{sun:floatingpoint} 
 um n�mero em ponto flutuante � representado internamente pelo
 computador da seguinte maneira: $23$ bits
 para a fra��o ou mantissa, \textit{f}; $8$ bits para o expoente,
 \textit{e}; e um bit para o sinal, \textit{s}, como ilustrado na
 figura~\ref{fig:float}.
 Al�m disso, todos os expoentes s�o armazenados depois de serem
 adicionados a um valor de deslocamento (ou bias), que � 
$0 \times 7\mbox{\texttt{FH}}$ em hexadecimal, ou $127$ em bin�rio; 
(2) desloque (shift) $23$ ($0 \times 17$) bits � direita; e (3)
 subtraia $127$ ($0 \times 7\mbox{\texttt{F}}$).
 \begin{figure}[htbp]
 \begin{center}
    \psfrag{0}{{$0$}}
    \psfrag{22}{{$22$}}
    \psfrag{23}{{$23$}}
    \psfrag{30}{{$30$}}
    \psfrag{31}{{$31$}}
    \psfrag{BIT #}{\texttt{bit}}
   \psfrag{s}{\textit{s}}
   \psfrag{e}{\textit{e}}
   \psfrag{f}{\textit{f}}
  \includegraphics{fig/float.eps}
  \caption[{\sf Representa��o de um n�mero em ponto flutuante}]
 {\label{fig:float} Representa��o de um n�mero em ponto flutuante.}
 \end{center}
 \end{figure}
%%% \[(-1)^s \times 2^{e-127} \times 1.f\]
@ O calculo do msb � feito pela fun��o |msb|. Para poder lidar com o
c�digo bin�rio do n�mero ponto flutuante, � utilizado um pequeno
trecho em c�digo assembler. Os tutoriais~\cite{asm:linux, asm:gcc}
ajudaram a conectar o assembler a linguagem C.
@<Fun��es auxiliares@>=
int 
msb(x)
     unsigned long x; @;
{@;
  register unsigned long lg;
  register float f;
  
  if(x == 0) return 0;
  
  f = (float)x;
  @/
  if(LINUX){ /* Linux x86 */ @/@,
    __asm__("mov   %1, %0\n\t" @/@,
            "sar   $0x17, %0\n\t" @/@,
            "sub   $0x7F, %0\n\t"@/@,
            : "=r" ( lg )@/@,
            : "r"  ( f )@/@,
            );@/
  }@/
  else{ /* SunOS/Solaris */@/@,
     __asm__("mov   %1, %0\n\t" @/@,
            "srl   %0, 0x17, %0\n\t" @/@,
            "sub   %0, 0x7F, %0\n\t" @/@,
            : "=r" ( lg ) @/@,
            : "r"  ( f ) @/@,
            );@/
  }@/
  return ((int)lg);@/
}
@

Agora, seja $a_1, \ldots, a_{n-1}$ a ordena��o das arestas da �rvore
geradora m�nima de acordo com o $msb(a_i)$, obtida em tempo linear,
 utilizando o algoritmo {\it packed merging},
desenvolvido por Andersson {\it et al.}~\cite{andersson:sorting}. 
%Hagerup, Nilsson e Raman

O algoritmo abaixo constr�i a $\delta$-decomposi��o $V$-hier�rquica $\Lcal$ de
$(V, A)$ em rela��o a $c$ em tempo linear, no modelo RAM:
\begin{quote}
 Para $i$ de $1$ at� $n-2$ fa�a

\x Seja $uv = a_i$.

\x $u := find(u)$ e $v := find(v)$.

\x $union(u,v)$.

\x $Y := Y \cup \{find(u)\}$.

\x Se $msb(a_i) < msb(a_{i+1})$ ent�o

\xx Para todo $v \in Y$ fa�a

\xx Seja $X$ um elemento de $\Lcal$ que cont�m as arestas do conjunto
representado por $v$.

\xxx $\delta(X) := 2^{msb(a_i)}$.

\xx $Y := \emptyset$.

\end{quote}

 Em conclus�o, temos o seguinte teorema:
\begin{teorema}{constru��o de uma decomposi��o hier�rquica}
 \label{teo:construcao-decomposicao-hierarquica}
 Seja $(V,A)$ um grafo e uma fun��o comprimento sim�trica $c$ de $A$
  em $\PosInt$. Uma $\delta$-decomposi��o $V$-hier�rquica de $(V,A)$ em
  rela��o a $c$ � constru�da em tempo $O(m + n)$. \fimprova   
\end{teorema}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A figura~\ref{fig:hierarquica} ilustra a constru��o de uma
 decomposi��o hier�rquica.
 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(a)}{(a)}
    \psfrag{(b)}{(b)}
    \psfrag{(c)}{(c)}
    \psfrag{(d)}{(d)}
    \psfrag{(e)}{(e)}
    \psfrag{(f)}{(f)}
    \psfrag{0}{0}
    \psfrag{1}{1}
    \psfrag{2}{2}
    \psfrag{3}{3}
    \psfrag{4}{4}
    \psfrag{>= 2}{\footnotesize $\geq 2$}
    \psfrag{>= 1}{\footnotesize $\geq 1$}
    \psfrag{s}{\footnotesize $s$}
    \psfrag{a}{\footnotesize $a$}
    \psfrag{b}{\footnotesize $b$}
    \psfrag{c}{\footnotesize $c$}
    \psfrag{d}{\footnotesize $d$}
    \psfrag{t}{\footnotesize $t$}
  \includegraphics{fig/hierarquica.eps}
\caption[{\sf Constru��o de uma decomposi��o hier�rquica}]
 {\label{fig:hierarquica} (a) mostra um grafo sim�trico. Em (b) o
mesmo grafo com os comprimentos em rela��o ao msb. (c) mostra uma
poss�vel �rvore geradora m�nima em rela��o ao msb dos
comprimentos. As curvas da figura (d) representam um n�vel da
 $\delta$-decomposi��o $V$-hier�rquica. (e) mostra a
$\delta$-decomposi��o $V$-hier�rquica do grafo em (a). 
 (f) ilustra a correspondente representa��o arb�rea.}
 \end{center}
 \end{figure}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  VERS�O CWEB
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\section{Vers�o em \CWEB{}}

@ Esta implementa��o do algoritmo de Thorup, difere do projeto do algoritmo
linear de Thorup~\cite{thorup:sssp-1999}, mas aplica as mesmas id�ias. 
Por exemplo, n�o s�o utilizados os atomic heaps desenvolvido por Fredman
e Tarjan~\cite{fredman:mst}. Do ponto de vista pr�tico, acredita-se
que mesmo fazendo uso dessa estrutura, n�o proporcionaria melhorias
computacionais, pois conforme Thorup~\cite{thorup:sssp-1999}
menciona, os atomic heaps s�o definidos somente para $n >
2^{12^{20}}$ e seu interesse � principalmente te�rico.

 Conforme visto na se��o~\ref{sec:thorup-eficiencia}, uma implementa��o
do algoritmo de Thorup envolve resolver tr�s problemas: (p1)
constru��o da $\delta$-decomposi��o $V$-hier�rquica $\Lcal$ de $(V,A)$
 em rela��o a $c$; (p2) atualizar os potenciais e
manter $\min\{\fp(v) \tq v \in Q \cap  X\}$ para cada $X$ em $\Lcal$;
e (p3) escolher o pr�ximo elemento maduro para ser visitado.

 Na implementa��o apresentada, os problemas s�o solucionados da seguinte maneira:
\begin{quote}
\item[{\bf Constru��o da decomposi��o hier�rquica.}] A constru��o da
$\delta$-decomposi��o $V$-hier�rquica, � feita a partir da �rvore geradora m�nima do grafo
dado. Lembrando que o importante � o msb do comprimento dos arcos
(se��o~\ref{sec:construcao-hierarquica}). O algoritmo utilizado para
resolver o problema AGM � o de Kruskal utilizando a estrutura {\it
union-find}~\cite{clrs:introalg-2001}. No algoritmo de Kruskal
� necess�rio a ordena��o dos arcos, que � feita utilizando-se um
bucket sort. Assim, como os arcos s�o ordenados em rela��o ao msb dos
comprimentos, essa etapa pode ser feita em tempo $O(\log C + m)$, onde
$C$ � o comprimento do maior arco. Ap�s a ordena��o, o algoritmo de
Kruskal/{\it union-find}, para encontrar uma �rvore geradora m�nima,
 gasta tempo $O(m \alpha(m,n))$, onde $\alpha$
� a inversa da fun��o de Ackermann. Como a constru��o da
decomposi��o hier�rquica � feita ao mesmo tempo que se determina a
�rvore geradora m�nima, o tempo gasto � $O(\log C + \alpha(m,n)m)$.
\item[{\bf Atualiza��o dos potenciais.}]
Na decomposi��o hier�rquica, o $\min\{\fp(v) \tq v \in Q \cap  X\}$, 
para algum $X$ em $\Lcal$ � igual ao $\min\{\fp(v) \tq v \in Q \cap
X'\}$, onde $X'$ � um descendente folha de $X$. 
Como $\min\{\fp(v) \tq v \in Q \cap X'\}$ pode diminuir, os elementos $X$,
ancestrais de $X'$ devem ser atualizados. Na implementa��o, utilizamos
o m�todo mais natural, isto �,  quando $\min\{\fp(v) \tq v \in Q \cap
X'\}$ diminui, o novo valor � propagado para cima enquanto
necess�rio. No pior caso, o tempo gasto na atualiza��o dos potenciais
�, claramente, a altura de $\Lcal$, que � limitada por $\log r$, onde $r$ � a
raz�o entre o maior e o menor comprimento de um arco. Portanto, o
tempo gasto, em cada atualiza��o � $O(\log r)$. Como observado por Pettie e
Ramachandran~\cite{pettie:experimental} na pr�tica, poucos ancestrais
precisam ser atualizados.
\item[{\bf Escolha de um elemento maduro.}]
 A escolha de um elemento maduro � feita atrav�s da utiliza��o de
buckets, conforme descrito na
se��o~\ref{sec:thorup-eficiencia}. Portanto, o tempo total gasto nessa
etapa � $O(m + n)$.
% Na implementa��o, � utilizado deslocamento de bits
%(shifts). Por exemplo, $\fp(v)$\ |>>|\ $\delta$ significa
%$\floor{\fp(v)/\delta}$.
\end{quote}
A implementa��o do algoritmo de Thorup est� dividida em dois blocos:
@<Algoritmo de Thorup@>=
 @<Construa a decomposi��o hier�rquica do grafo@>@;
 @<Examine os v�rtices utilizando a decomposi��o hier�rquica@>@;

@ O bloco a seguir, corresponde a decomposi��o hier�rquica.
@<Defini��es@>=
#define prox_sort @,@,@,@, a.A /* pr�ximo arco na ordem ser� |a->prox_sort| */
#define from @,@,@,@, b.V /* uma arco vai de |a->from| para |a->tip| */

@ Os arcos s�o ordenados, de acordo com o msb dos comprimentos,
utilizando-se um bucket sort. A ordena��o dos arcos � mantida no vetor
|sort|. Ent�o, cada posi��o $i$ de |sort| mant�m os arcos com
comprimento $2^i$.  
@<Vari�veis globais@>=
Arc *sort[100];  /* cabe�as de listas ($100$ � suficiente) */

@ O decomposi��o hier�rquica � mantida, em |arb|, na forma da sua representa��o
arb�rea. 
@<Construa a decomposi��o hier�rquica do grafo@>=
Graph *
krusk(g)
     Graph *g;
{@+@<Vari�veis de |krusk|@>@;@#
 
 @<Ordene os arcos colocando-os nos buckets $sort[0], \ldots, sort[msbC]$@>@;

 @<Coloque cada v�rtice em um conjunto distinto e inicializa a arboresc�ncia@>@; 

 conj = n;
 for (i = 0; i <= msbC ; i++){
    for (a = sort[i]; a && (conj > 1); a = a->prox_sort) {
      u = a->from;  v = a->tip;
      @<Caso |u| e |v| estejam no mesmo conjunto, comece nova itera��o@>@;
      @<Fa�a a uni�o dos conjuntos que cont�m |u| e |v| e construa a arboresc�ncia@>@;
      if(CONEXO) conj--;
    }
 }
 @<Devolva a arboresc�ncia@>@;
}

@ @<Vari�veis de |krusk|@>=
register Graph *arb; /* estrutura arb�rea */
register Arc *a, *aux;
register unsigned long msbC; /* msb(C) */
register unsigned long n;
register unsigned long conj;
register long i;
register long delta_atual;     /* $\delta$-parti��o que est� em constru��o  */
register Vertex *u,*v,*w,*arbv; 
register Vertex *livre; /* posi��o de arb que pode ser usada */

@ O algoritmo de Kruskal seleciona os arcos, um a um, 
em ordem crescente de comprimento e de forma que n�o formem ciclos.
Cada posi��o $i$ de |sort| guarda os arcos que tem o |msb| do comprimento igual a $i$.
@<Ordene os arcos colocando-os nos buckets $sort[0], \ldots, sort[msbC]$@>=
msbC = msb(C);
for (i = 0; i <= msbC; i++) sort[i] = NULL;

n = g->n;
for (v = g->vertices; v < g->vertices + n; v++){
  for (a = v->arcs; a ; a = a->next) {
    /* s� guarda os arcos que apontam pra frente */
    if(a->tip < v) continue;
    a->from = v;
    i = msb(a->len);
    a->prox_sort = sort[i];
    sort[i] = a;
  }
}

@ A constru��o de |arb| envolve o uso dos ponteiros: |rep|, que �
usado pelos v�rtices em |g| indicando qual elemento, em |arb|, eles
pertencem; |bksize| indica o n�mero m�ximo de posi��es de um bucket e
|delta| as $\delta$-parti��es.
@<Defini��es@>=
#define rep @,@,@,@, x.V    /* aponta para o representante do conjunto */
#define bksize @,@,@,@, r.I  /* soma dos arcos de um elemento ($\Delta$) */
#define delta @,@,@,@, w.I   /* $\delta$ de uma parti��o da decomposi��o hier�rquica */

@ Inicializa��es dos ponteiros dos v�rtices, do grafo dado |g|, e daqueles
respons�veis pela constru��o da representa��o arb�rea |arb|.
@<Coloque cada v�rtice em um conjunto distinto e inicializa a arboresc�ncia@>=
arb = gb_new_graph(n);
/* Nomeia aos v�rtices da arboresc�ncia*/
for(arbv = arb->vertices, v = g->vertices, i = 0; arbv < arb->vertices + n; arbv++, v++){
  arbv->elemento = arbv->rep = arbv;
  v->bksize = arbv->bksize = 0;
  v->elemento = v->rep = v; 
  v->delta = VERTICE_DE_G;
}
livre = arb->vertices; /* pr�xima posi��o livre (novo elemento)*/

@ Os dois blocos seguintes, dizem respeito � estrutura {\it union-find}.\\
{\it find}: A fun��o |find_set| encontra o representante de um conjunto.
@<Fun��es auxiliares@>=
Vertex*
find_set(v)
     Vertex *v;
{
  if (v != v->rep) 
    v->rep = find_set(v->rep);
  return (v->rep); 
}

@ {\it union}: Verifica se o representante do conjunto que cont�m o
v�rtice |u| � o mesmo que o do v�rtice |v|. Em caso afirmativo, 
significa que |u| e |v| pertencem ao mesmo conjunto. Logo, n�o �
poss�vel adicionar o arco $uv$, aos arcos que est�o compondo a �rvore geradora
m�nima,  pois com este, um ciclo seria formado.
@<Caso |u| e |v| ...@>=
u = find_set(u);
v = find_set(v);
if (u == v) continue;

@ Caso o representante do conjunto que cont�m |u| e o que cont�m |v|
sejam diferentes, o arco $uv$ ir� compor a �rvore geradora
m�nima, e os representantes dos conjuntos ser�o unidos, de tr�s
poss�veis maneiras, conforme ilustrado na figura~\ref{fig:uniao}.
 \begin{figure}[htbp]
 \begin{center}
    \psfrag{(a)}{(a)}
    \psfrag{(b)}{(b)}
    \psfrag{(c)}{(c)}
    \psfrag{u}{\footnotesize $u$}
    \psfrag{v}{\footnotesize $v$}
    \psfrag{u1}{\footnotesize $u_1$}
    \psfrag{un}{\footnotesize $u_i$}
    \psfrag{v1}{\footnotesize $v_1$}
    \psfrag{vn}{\footnotesize $v_j$}
  \includegraphics{fig/union.eps}
\caption[{\sf Uni�o de dois elementos na constru��o da decomposi��o hier�rquica}]
 {\label{fig:uniao} As figuras (a), (b) e (c) mostram os tr�s casos
poss�veis na uni�o de dois elementos. Em (a) um novo elemento � criado
e tem como filhos os elementos $u$ e $v$. (b) � a situa��o em que os
filhos de $v$ se tornam filhos de $u$. A figura (c) ilustra o caso em  
que $u$ � colocado como filho de $v$.}
 \end{center}
 \end{figure}  
@<Fa�a a uni�o dos ...@>=
if(u->delta != VERTICE_DE_G) {
  if( (v->delta == VERTICE_DE_G) || (u > v) ){
    w = u ; u = v; v = w;
  }
} /* u vem antes */

delta_atual = i;

if((u->delta <= v->delta) && (v->delta < delta_atual)){ 
  @<Crie um novo elemento@>@;
}
else if((u->delta == v->delta) && (v->delta == delta_atual)){
  @<Junte |u| e |v| em um �nico elemento@>@;
}
else if( (u->delta < v->delta) && (v->delta == delta_atual) ){ 
  @<Coloque |u| como filho de |v|@>@;
}

@ @<Crie um novo elemento@>=
livre->delta = delta_atual;
gb_new_arc(livre,v); 
gb_new_arc(livre,u);
u->elemento = v->elemento = livre;
u->rep = v->rep = livre;
livre->bksize = u->bksize + v->bksize + a->len;
livre++;
if(REPORT) nelementos++;

@ @<Junte |u| e |v| em um �nico elemento@>=
for(aux = v->arcs; aux; aux = aux->next){
  gb_new_arc(u,aux->tip); /* transfere os arcos de v para u */
  aux->tip->elemento = u;
}
v->rep = u; /* fazendo isso n�o preciso ajustar os ponteiros |rep| dos n�veis abaixo */
v->arcs = NULL;

u->bksize += a->len + v->bksize;

if(REPORT) nelementos--;

@ @<Coloque |u| como filho de |v|@>=
gb_new_arc(v,u);
u->elemento = v;
u->rep = v;
v->bksize += a->len + u->bksize;

@ Antes de retornar a representa��o arb�rea |arb| da decomposi��o
hier�rquica de |g|, � preciso calcular os valores de |bksize|, que 
 limitam o tamanho dos buckets de cada elemento.
@<Devolva a arboresc�ncia@>=
if(livre == arb->vertices) return NULL; /* n�o tem nenhum elemento */

for(v = arb->vertices; v <= livre; v++){
  if(v->arcs != NULL) v->bksize =  ((v->bksize >> v->delta)+2);
}
return arb;


@ O bloco a seguir, corresponde e examinar os v�rtices, fazendo uso da
decomposi��o hier�rquica.
@<Vari�veis globais@>=
int desempilha = 0; /* n�mero de vezes que o programa desempilha v�rtices */
int atualiza_acima = 0; /* n�mero de vezes que subiu na arboresc�ncia para atualizar */
int nao_maduro = 0; /* n�mero de vezes que os elementos se tornaram n�o maduros */
int nelementos = 0; /* n�mero de n�s da arboresc�ncia (sem contar os v�rtices de g) */
Vertex **BK;        /* Bucket */

@ @<Defini��es@>=
#define dx @,@,@,@, q.I         /* menor valor de um elemento */
#define prox_topo @,@,@,@, x.V  /* pr�ximo elemento no topo da pilha */
#define id(i)  (i - arb->vertices)
#define BK(i,j) @,@,@,  (*( BK + id(i) ) + j)

@ A fun��o |insere_elemento|, insere |v| no bucket |BK(u,i)|. 
@<Fun��es auxiliares@>=
void 
insere_elemento(arb,v,u,i)
     Graph *arb;
     Vertex *v;
     Vertex *u;
     unsigned long i;
{
  v->ant_elemento = BK(u,i);                
  v->prox_elemento = BK(u,i)->prox_elemento;
  (BK(u,i)->prox_elemento)->ant_elemento = v;
  BK(u,i)->prox_elemento = v;
}

@ A implementa��o tenta ser a mais pr�xima poss�vel da 
descri��o (se��o~\ref{sec:thorup-descricao}).
@<Examine os v�rtices utilizando a decomposi��o hier�rquica@>=
void
thorup(g, arb, s)
     Graph *g;
     Graph *arb;
     Vertex *s;
     
{@+@<Vari�veis de |thorup|@>@;@#
        
 @<Inicializa��es para |thorup|@>@;
 
 @<Encontre a raiz |root| da arboresc�ncia@>@;
 
 topo =  root; /* |root| fica no topo da pilha */
 
 while(1){
   x = topo;

   if( (x->arcs == NULL) && (x->delta != VERTICE_DE_G)) {
   /* |x| � uma folha e n�o � madura (n�o pode ser um v�rtice de |g|)*/ 
      if(x == root) {
        /* Caso 1A: raiz n�o � madura */ 
        free(BK[id(x)]); /* j� posso desalocar o bucket de |x| */
        break;
      }
      else{
        /* Caso 1B: |x| n�o � maduro e � folha */
        @<Desempilhe@>@;
        remove_elemento(x);  /* remove |x| do bucket */
        free(BK[id(x)]); /* j� posso desalocar o bucket de |x| */
        continue;
      }
    }
   if(x->delta == VERTICE_DE_G){ /* Caso 2A: x � v�rtice de g */
     @<Examine a folha |x|@>@;
     @<Desempilhe@>@;
     remove_elemento(x);  /* remove |x| do bucket */
     continue;
   }
   if(x->status == NAO_VISITADO){
     /* elemento ainda n�o foi visitado (ainda n�o tem bucket)*/
     @<Crie um bucket para |x|@>@;
   }

   fmaduro = BK(x,x->dist - x->dx)->prox_elemento; /* verifica se |x| tem filho maduro */
   
   if(fmaduro != BK(x,x->dist - x->dx)){
     /* Caso 2B: |x| � maduro e |fmaduro| � seu filho maduro */
     @<Empilhe o filho maduro de |x|@>@;
     continue;
   }
   
   x->dist++;

   if(x->dist == (x->bksize + x->dx) )/*o bucket de |x| est� vazio (|x| virou folha)*/
	x->arcs = NULL;
   
   else{
     /* Caso 1C: |x| n�o � maduro e n�o � folha */
     dif = (x->elemento)->delta - x->delta;
     i = x->dist >> dif;
     k = (x->dist - 1) >> dif;
     if( i > k){
       @<Mude |x| de bucket@>@;
       @<Desempilhe@>@;
     }
   }
 }
}

@ @<Vari�veis de |thorup|@>=
register Arc *a;
register Vertex *v, *x, *w, *arbv;
register Vertex *topo, *root, *fmaduro;
register unsigned long n;
register unsigned long i, k;
register unsigned long dist_antes;
register unsigned long dif;

@ @<Inicializa��es para |thorup|@>=
if(arb == NULL) { 
  printf("%s\n", err_message[ERROR_3]); exit(0);
}
n = g->n;

if( (BK = (Vertex **)malloc(n*sizeof(Vertex*))) == NULL){
   printf("%s\n", err_message[ERROR_2]); exit(0);
}
for(v = g->vertices, arbv = arb->vertices; v < g->vertices + n; v++, arbv++){
  v->ant_elemento = v->prox_elemento = v->pred = v;
  arbv->dist = v->dist = infinito;
  arbv->status = v->status = NAO_VISITADO; @/
  arbv->ant_elemento = arbv->prox_elemento = arbv;
}
num_exam = 0;
atualiza_fp = 0;

@ @<Encontre a raiz |root| da arboresc�ncia@>=
s->dist = 0;
for(arbv = s; arbv != arbv->elemento; arbv = arbv->elemento){
  arbv->dist = 0;
}
arbv->dist = 0;
root = arbv;

@ @<Crie um bucket para |x|@>=
x->dist = x->dx = x->dist >> x->delta;

x->status = VISITADO;

if( (BK[id(x)] = (Vertex *)malloc((x->bksize)*sizeof(Vertex))) == NULL){
  printf("%s\n", err_message[ERROR_2]); exit(0);
}

for(i = 0; i < x->bksize; i++){
  /* Inicializa cabe�a de lista */
  BK(x,i)->ant_elemento = BK(x,i)->prox_elemento = BK(x,i);
}

for(a = x->arcs; a; a = a->next){
  v = a->tip;

  i = (v->dist >> x->delta); /* posi��o do bucket para ser inserido */
  
  i -= x->dx; /* preciso fazer o deslocamento, pois s� aloquei x->bksize posi��es */

  if(i < x->bksize) insere_elemento(arb,v,x,i); /* insere |v| no BK*/
}

@ @<Examine a folha |x|@>=
for(a = x->arcs; a; a = a->next){
  v = a->tip;
  
  if(v->dist - x->dist > a->len ){/* se a fun��o potencial n�o � vi�vel */
    atualiza_fp++;

    dist_antes = v->dist; /* guardo o valor do potencial n�o vi�vel */
    
    v->dist = x->dist + a->len;
    v->pred = x;
    @<Atualize o potencial dos elementos@>@;
  }
}
num_exam++;


@ @<Atualize o potencial dos elementos@>=
while (1){
  w = v->elemento;

  if(w->status == VISITADO){

    i = (v->dist >> w->delta);
    
    i -= w->dx;
    
    if( i < w->bksize ){
      
      dist_antes = (dist_antes >> w->delta) - w->dx;
      
      if( i < dist_antes ){@/
        /* remove |v| do bucket */@/
        remove_elemento(v);
        /* move o elemento |v| para o |bucket(w,i)| */ @/
        insere_elemento(arb,v,w,i); 
      }
    }
    break;
  } 
  if( v->dist >= w->dist) break; /* n�o preciso atualizar o m�nimo */
  
  dist_antes  = w->dist;
  
  w->dist = v->dist; /* atualiza m�nimo do elemento |w| */
  
  if(REPORT) atualiza_acima++;
  
  v = w;
}

@ @<Mude |x| de bucket@>=
  if(x != root){
    w = x->elemento;
    remove_elemento(x); /* remove |x| do bucket */
    
    i -= w->dx;  /* preciso fazer a corre��o */
    if( i < w->bksize) insere_elemento(arb, x, w, i); /* move |x| para o |BK(w,i)| */
    else x->arcs = NULL; /* elemento |x| n�o pode ter mais filhos */
    
    if(REPORT) nao_maduro++;
  }

@ @<Empilhe o filho maduro de |x|@>=
w = topo;
topo = fmaduro;
fmaduro->prox_topo = w;

@ @<Desempilhe@>=
topo = topo->prox_topo;
if(REPORT) desempilha++;
@
Portanto, essa implementa��o do algoritmo de Thorup gasta tempo
\[
  \underbrace{O(\log C + m \alpha(m,n))}_{\mbox{dec. hier�rquica}} + 
  \underbrace{O(m \log r)}_{\mbox{atualizar}} +
  \underbrace{O(n + m)}_{\mbox{examinar}} 
  = O(n + \log C + m \alpha(m,n) + m \log r).
\]

\begin{teorema}{}
 A implementa��o do algoritmo de Thorup resolve o
 PCMS em um grafo com $n$ v�rtices e $m$ arcos
 em tempo $O(n + \log C + m \alpha(m,n) + m \log r)$, onde
 $\alpha(m,n)$ � a inversa da fun��o de Ackermann, $C$ � o maior
 comprimento de um arco e $r$ � a raz�o entre o maior e o menor
 comprimento de um arco. \fimprova
\end{teorema}


