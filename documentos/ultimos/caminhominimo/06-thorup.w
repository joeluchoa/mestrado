\chapter{Algoritmo de Thorup}
\label{cap:thorup}
%\longpage

O algoritmo apresentado neste capítulo, devido a Mikkel
 Thorup~\cite{thorup:sssp-1999}, resolve o seguinte problema do caminho
mínimo restrito a grafos simétricos com funções comprimento
simétricas, em tempo e espaço linear, no modelo RAM:

\begin{quote}
\textbf{Problema} PCMS$(V,A,c,s)$:%
\index{PCMS}\mar{PCMS}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dado um grafo simétrico $(V,A)$, uma função comprimento simétrica $c$ de $A$ em
$\PosInt$ e um vértice $s$, encontrar um 
caminho de comprimento mínimo de $s$ até $t$, para cada vértice~$t$ em $V$.
\end{quote}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%  Conforme o teorema~\ref{teorema:consumo-de-tempo-dinitz}, o algoritmo
%  de Dinitz-Thorup gasta tempo $O(n+m+\Delta)$ mais o tempo necessário
%  para manter o vértice com o menor potencial dentro de cada elemento
%  de uma $\delta$-partição..

Da mesma forma que o algoritmo de Dinitz-Thorup
(capítulo~\ref{cap:dinitz-thorup}), o algoritmo de Thorup utiliza a idéia de
 $\delta$-partição e bucketing, para determinar vértices que podem ser
examinados em qualquer ordem. 
 Em linhas gerais, a fim de evitar o custo computacional de examinar os
vértices do grafo conforme a distância do vértice origem $s$, Thorup juntou a
este bucketing uma certa decomposição hierárquica do grafo e aplicou o
algoritmo de Dinitz-Thorup recursivamente a cada elemento desta decomposição.

%  em conjunto com uma decomposição do grafo, 
%  definida posteriormente, como ``decomposição hierárquica''.  

% De fato, o que o algoritmo de Mikkel Thorup faz é aplicar a idéia do 
% algoritmo de Dinitz-Thorup de maneira recursivamente em cada elemento de
% decomposição.

% , utilizando-se da 
% ``decomposição hierárquica'' do grafo. 
 
% No algoritmo de Thorup, o tempo de manter
%  os vértices com potencial mínimo é eliminado utilizando-se a
%  recursividade, e $\Delta$ é escolhido de maneira que seja proporcional
%  a $m + n$. 
 
\section{Família laminar e representação arbórea}
\label{sec:laminar}

Seja $V$ um conjunto finito. 
Uma família $\Lcal$ de partes de $V$ 
é \defi{laminar}\index{familia@@família laminar} se para todo par $X$
e $Y$ de elementos de $\Lcal$ vale que $X \subseteq Y$ ou $Y \subseteq
X$ ou $X \cap Y = \emptyset$.
Se $X$ e $Y$ são elementos de $\Lcal$ tais que $X$ é um
subconjunto maximal  
propriamente contido em $Y$ então é dito que $X$ é
\defi{filho}\index{elemento!filho} de $Y$ e $Y$ é \defi{pai}\index{elemento!pai} de $X$.

Uma \defi{representação arbórea}\index{representacao arborea@@representação
  arbórea} de uma família laminar $\Lcal$ é um grafo $(\Lcal, \Acal)$ 
tal que $(Y,X)$ é um arco em $\Acal$ se e somente se $X$ é um filho de
$Y$. Logo, $(\Lcal, \Acal)$ é a união de arborescências.
A ilustração de uma família laminar e sua representação arbórea
pode ser vista na figura~\ref{fig:arborescencia}.
 \begin{figure}[htbp]
 \begin{center}
 \psfrag{(a)}{(a)}
  \psfrag{(b)}{(b)}
  \psfrag{X}{\footnotesize {\sc x}}
 \includegraphics{fig/laminar_arbo.eps}
  \caption[{\sf Família laminar e representação arbórea}]
  {\label{fig:arborescencia} A figura (a) mostra o diagrama de Venn de uma
  família laminar $\Lcal$. (b) é a representação arbórea $(\Lcal,
  \Acal)$. O nível de $X$ é $2$ e a altura de $(\Lcal, \Acal)$ é $3$.} 
 \end{center}
 \end{figure}   
Um elemento $X$ em $(\Lcal, \Acal)$ é dito uma
\defi{folha}\index{elemento!folha} se $X$ é uma 
folha da arborescência de $(\Lcal, \Acal)$ que contém~$X$. Os
  elementos em $\Lcal$ que não são folhas são chamados de
  \defi{internos}\index{elemento!interno}.

Os \defi{ancestrais}\index{ancestrais de um elemento} de um elemento $X$ são todos os
elementos de $\Lcal$ no caminho da raiz da arborescência contendo $X$  
até $X$.

O \defi{nível}\index{nivel@@nível de um elemento} de um elemento $X$ de
$\Lcal$ é o comprimento do caminho da raiz da arborescência de $(\Lcal,
\Acal)$ que contém $X$  até $X$. A \defi{altura}\index{altura da
arborescencia@@altura da arborescência} 
de $\Lcal$ é o maior nível de um elemento $X$ de $\Lcal$.
 
Uma família $\Lcal$ de partes de $V$ é
$W$-\defi{completa}\index{familia@@família laminar!$W$-completa} para
alguma parte $W$ de $V$ se: 
(c1) $\Lcal$ é laminar; (c2) $V$ está em $\Lcal$; e 
(c3) $\{v\} \in \Lcal$ se e somente se $v \in W$. 
%(c3) os elementos de $\{ \{v\} \tq v \in V \}$ que estão em $\Lcal$ são
%precisamente os elementos de $\{ \{w\} \tq w \in W \}$.
Se $\Lcal$ é $W$-completa, então sua representação arbórea $(\Lcal, \Acal)$
é uma arborescência com raiz~$V$.
\section{Decomposição hierárquica}
\label{sec:hierarquica}
Sejam $(V,A)$ um grafo e $c$ uma função comprimento de $A$ em $\PosInt$.
Seja $\Lcal$ uma família $W$-completa e seja $\delta$ uma função que
associa a cada elemento interno $X$ de $\Lcal$ um inteiro positivo
$\delta(X)$.
É dito que $\Lcal$ forma uma \defi{$\delta$-decomposição
$W$-hierárquica}\index{$\delta$-decomposicao@@$\delta$-decomposição $W$-hierárquica} de
$(V,A)$ em relação a $c$, se para cada elemento $X$ de $\Lcal$ vale
que:
 \begin{enumerate}[({h}1)]
 \item o grafo $(X,A(X))$ é conexo, exceto, possivelmente, se $X = V$; e
 \item cada aresta com pontas em filhos distintos de $X$ tem
comprimento pelo menos $\delta(X)$.
 \end{enumerate} 

 Quando a função $\delta$ ou o conjunto $W$ forem evidentes ou
 irrelevantes serão omitidos. Assim, algumas vezes é escrito
 simplesmente decomposição hierárquica, ou $\delta$-decomposição
 hierárquica.

 Do ponto de vista da implementação do algoritmo descrito neste capítulo, é conveniente
 que, para cada $X$ em $\Lcal$, $\delta(X)$ seja um número da forma
 $2^k$, para algum $k$. A
 figura~\ref{fig:decente} ilustra a condição (h2) e a 
figura~\ref{fig:dec-hierarquica} mostra a decomposição hierárquica de
um grafo.

%Sejam $(V,A)$ um grafo, $c$ uma função comprimento de $A$ em $\PosInt$ e
%$\delta$ um inteiro positivo.
%Recordemos que uma partição de $V$ é uma
%\defi{$\delta$-partição}\index{$\delta$-particao@@$\delta$-partição}% 
%\mar{$\delta$-partição}   
%se todo arco com ponta inicial e ponta final em  
%elementos distintos da partição tem comprimento pelo menos $\delta$.

% Seja $C$ o maior comprimento de um arco em $V$. Sejam $\delta_0 = C+1$ e
% $\delta_i = 2^{h - i}$, para $i = 1, 2, \ldots, h$, onde $h$ é a
% altura de $\Lcal$. Uma família laminar $W$-completa $\Lcal$ de partes de $V$ forma uma
% \defi{decomposição $W$-hierárquica}\index{decomposicao
% $W$-hierarquica@@decomposição $W$-hierárquica} (de $(V,A)$ em relação
% a $c$) se para cada elemento $X$ de $\Lcal$ vale que:
% \begin{enumerate}[({h}1)]
% \item $(X,A(X))$ é um grafo conexo, exceto, possivelmente, se $X = V$;
% \item se $X$ tem nível $t$ então todo arco com ambas as pontas em $X$
% tem comprimento inferior a~$\delta_t$;~e
% \item se $X$ tem nível $t$ e não é folha, então seus filhos formam uma
% $\delta_{t+1}$-partição. 
% \end{enumerate} 

% É dito simplesmente que $\Lcal$ é uma decomposição hierárquica quando o conjunto
%$W$ for irrelevante. A figura~\ref{fig:decente} ilustra as condições (h2) e (h3) e a
%figura~\ref{fig:dec-hierarquica} mostra a decomposição hierárquica de
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
  \caption[{\sf Decomposição hierárquica (condição (h2))}]
  {\label{fig:decente} Decomposição hierárquica (condição (h2)).} 
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
\caption[{\sf Exemplos de decomposições hierárquicas}]
 {\label{fig:dec-hierarquica} (a) e (d) mostram grafos simétricos. A
figura (b) mostra a $\delta$-decomposição~$V$-hierárquica do grafo em
(a), onde $\delta(V) = 2,\ \delta(X) = 1\ \mbox{e}\ \delta(Y) = 1$, e (c)
mostra a correspondente representação arbórea. De maneira análoga, (e)
exibe a $\delta$-decomposição $V$-hierárquica do grafo em (d), onde
$\delta(V) = 4,\ \delta(X) = 2\ \mbox{e}\ \delta(Y) = 1$, e (f) ilustra a
correspondente representação arbórea.}
 \end{center}
 \end{figure}
 
% O algoritmo descrito na próxima seção resolve o seguinte variante do problema do
% caminho mínimo:
% \begin{quote}
% \textbf{Problema} PCMS$(V,A,c,\Hcal,s)$:%
% \index{PCMS}\mar{PCMS}
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dado um grafo $(V,A)$, uma função comprimento simétrica $c$ de $A$ em
% $\PosInt$, uma decomposição hierárquica $\Hcal$ e um vértice $s$, encontrar um 
% caminho de comprimento mínimo de $s$ até $t$, para cada vértice~$t$ em $V$.
% \end{quote}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Para resolver o PCMS o algoritmo de Thorup, como os algoritmos de
 Dijkstra e Dinitz-Thorup, mantém, entre outros objetos, uma função
 potencial $\fp{}$ (distância tentativa) e o conjunto~$Q$ dos vértices
 visitados. Além disso, também mantém uma
 $\delta$-decomposição hierárquica $\Lcal$. Se $X$ é um elemento de 
 $\Lcal$, então $X$ é \defi{maduro}\index{elemento!maduro} se $Q \cap 
 X \neq \emptyset$ e 
 \[ X = V \ \ \mbox{ou}\ \  \min\{\fp(v)  \tq  v \in Q \cap Y\} \leq 
         \min\{\fp(v)  \tq  v \in Q \cap X\} \leq
         \min\{\fp(v) \tq v \in Q \cap Y\} + \delta(Y)/2,\]
onde $Y$ é o pai de $X$.
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
 $\Lcal$. O número dentro de cada elemento $X$ de $\Lcal$ é o menor
 potencial de um vértice de $X \in Q$. A seta pontilhada indica quais são
 os elementos maduros.} 
 \end{center}
 \end{figure}

% O valor $\min\{\fp(v) \tq v \in Q \cap X\}$, é o
% \defi{potencial}\index{potencial de um conjunto} de $X$, denotado por
% $\fp(X)$; se $Q \cap X = \emptyset$ então $\fp(X) = nC + 1$.
 
%Um elemento $X$ de uma decomposição hierárquica $\Lcal$ é
% \defi{maduro}\index{maduro!decomposição hierárquica} se $X$ é um filho 
%maduro, se o pai de $X$ é um filho maduro, e assim sucessivamente até 
%a raiz de $\Lcal$. O conjunto $V$ é, por definição, maduro.
% Se $X$ é filho maduro, o pai de $X$ é filho maduro, o avô de $X$ é filho
% maduro, e assim sucessivamente, então dizemos que $X$ é
% \defi{maduro}\index{maduro}.
%\begin{lema}{Thorup}%
%\index{lema de Thorup}
% \label{lema:thorup}
%  Se $X$ é maduro e $v \in X \cap Q$ tal que $\fp(v)$ é mínimo 
%então $\fp(v) - \fp(s) = c(P)$, onde $P$ é um caminho mínimo
%de $s$ a $v$. 
% \end{lema}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  DESCRIÇÃO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Descrição}
\label{sec:thorup-descricao}

O algoritmo de Thorup resolve o PCMS e devolve os mesmos certificados
que o algoritmo de Dijkstra e Dinitz-Thorup, a saber, 
uma função predecessor codificando os
caminhos compactamente e uma função potencial viável atestando a minimalidade
dos caminhos e a eventual não acessibilidade de alguns vértices. 
O algoritmo de Thorup aplica, de certa forma, recursivamente o algoritmo de
Dinitz-Thorup, a fim 
de examinar um vértice $v$ se e somente se
$\{v\}$ e todos os seus ancestrais são maduros. A função $\delta$ da
$\delta$-decomposição $V$-hierárquica $\Lcal$ utilizada pelo
algoritmo, 
deve ser tal que, se $X$ é filho de $Y$ então $\delta(X) \leq
\delta(Y)/2$. A seção~\ref{sec:construcao-hierarquica} é descrito como
$\delta$ e $\Lcal$ são convenientemente construídos.
\newpage
\begin{quote} 
\textbf{Algoritmo de Thorup.}\index{algoritmo de!Thorup}
Recebe um grafo $(V,A)$, uma função comprimento simétrica~$c$ de $A$ em $\PosInt$,
e um vértice $s$ e devolve
uma função predecessor $\pred$ e uma função potencial $\fp$ que respeita $c$
tais que, para cada vértice $t$, se $t$ é acessível a partir de~$s$, então
$\pred$ determina um caminho de $s$ a $t$ que tem comprimento 
$\fp(t) - \fp(s)$, caso contrário, $\fp(t)-\fp(s) = nC+1$, 
onde $C := \max\{ c(u,v) \tq uv \in A\}.$
\end{quote}

Cada iteração começa com 
uma função potencial $\fp{}$, 
uma função predecessor $\pred$,
partes $S, \L$ e $U$  de $V$, 
uma decomposição $(Q \cup U)$-hierárquica $\Lcal$, e 
uma pilha $L = \seq{X_{0}, X_{1}, \ldots, X_{t}}$ de elementos de
$\Lcal$, tais que $X_{i+1}$ é filho de $X_{i}$, para $i = 0, \ldots, t-1$.

No início da primeira iteração  
$\fp(s) = 0$ e $\fp(v) = nC + 1$ para cada vértice $v$ distinto de $s$,
$\pred(v) = v$ para cada vértice $v$, 
$S = \emptyset$,
$\L = \{s\}$,
$U = V \setminus \{s\}$, 
$\Lcal$ é uma decomposição $V$-hierárquica de $(V,A)$ em relação a $c$ e 
$L = \seq{V}$. [O algoritmo supõe que se $X$ é filho de $Y$, então
$\delta(X) \leq \delta(Y)/2$.]

A ação em cada iteração depende do elemento $X$ no topo da pilha $L$ e
consiste em:
\balgor
 \item \textbf{Caso 1:} $X$ não é maduro.

 \item \x \textbf{Caso 1A:} $X = V$.
  
   \x Devolva $\fp{}$ e $\pred$ e pare.

 \item \x \textbf{Caso 1B:} $X \neq V$ e $X$ é folha.

   \x Seja $\Lcal'$ a decomposição $(Q \cup U)$-hierárquica obtida
   após a remoção de $X$ de $\Lcal$.

   \x Seja $L'$ a pilha obtida após desempilhar $X$ de $L$.

   \x Comece nova iteração com $\Lcal'$ e $L'$ nos papéis de $\Lcal$ e $L$.
 
 \item \x \textbf{Caso 1C:} $X \neq V$ e $X$ não é folha.

   \x Seja $L'$ a pilha obtida após desempilhar $X$ de $L$.

   \x Comece nova iteração com $L'$ no papel de $L$.


  \item \textbf{Caso 2:} $X$ é maduro.

   \item \x \textbf{Caso 2A:} $X = \{u\}$, para algum $u$ em $V$ [isto é, $X$
   é folha].

   \x $S' := S \cup \{u\}$.

   \x $\L' := \L \setminus \{u\}$.
 
   \x $U'  := U$.

   \x Para cada $v$ em $V$ faça $\fp'(v) := \fp(v)$ e $\pred'(v) := \pred(v)$.

   \x Para cada arco $uv$ faça 

   \xx Se\ $\fp(v) > \fp(u) + c(u,v)$ então 

   \xxx $\fp'(v) := \fp(u) + c(u,v)$, $\pred'(v) := u$ e 
        remova\footnote{É
     possível que $v$ já pertença a $\L'$ e não esteja em $U'$. Nesse caso estas
     últimas duas instruções são redundantes.} $v$ de $U'$ e acrescente a $\L'$.

   \x Seja $\Lcal'$ a decomposição $(Q' \cup U')$-hierárquica obtida
   após a remoção de $\{u\}$ de $\Lcal$.

   \x Seja $L'$ a pilha obtida após desempilhar $X$ de $L$.

   \x Comece nova iteração com $\fp'$, $\pred'$, $S', \L'$,  $U'$,
   $\Lcal'$ e $L'$ nos papéis de $\fp{}$, $\pred$, $S, \L$, $U$,
   $\Lcal$ e $L$.

  \item \x \textbf{Caso 2B:} $^^7cX^^7c > 1$ [isto é, $X$ não é folha].

   \x Seja $X'$ um filho maduro de $X$.

   \x Seja $L'$ a pilha obtida após empilhar $X'$ em $L$.
 
   \x Comece nova iteração com $L'$ no papel de $L$. \qed
\ealgor

 Diremos que o algoritmo \defi{visita}\index{visitar um elemento} um
 elemento $X$ de $\Lcal$ sempre que $X$ é empilhado em $L$. O
 algoritmo visita apenas elementos maduros, entretanto, um elemento em
 $L$ pode deixar de ser maduro durante a visita a algum dos seus
 descendentes. As
 figuras~\ref{fig:sim_thorup_desc},~\ref{fig:sim_thorup_desc2},
~\ref{fig:sim_thorup_desc3},~\ref{fig:sim_thorup_desc4}
 e~\ref{fig:sim_thorup_desc5} mostram a simulação do algoritmo de
 Thorup no exemplo da figura~\ref{fig:dec-hierarquica}(a).

 Considere uma iteração em que ocorre o caso~2A. Suponha que no início da
 iteração $L = \seq{X_0, X_1, \ldots, X_t}$, onde $X_0 = V$ e $X_t = X
= \{u\}.$
Como $\{u\}$ e todos os seus ancestrais são maduros, então
\[
  \begin{array}{ccl}
\min\{\fp(v) \tq v \in Q \cap X_1\} & \leq &\min \{\fp(v) \tq v \in Q\} + \delta(X_0)/2\\
\min\{\fp(v) \tq v \in Q \cap X_2\} & \leq &\min \{\fp(v) \tq v \in Q \cap X_1\} + \delta(X_1)/2\\
                                    & \vdots &\\
\min\{\fp(v) \tq v \in Q \cap X_t\} & \leq &\min \{\fp(v) \tq v \in Q
\cap X_{t-1}\} + \delta(X_{t-1})/2\\ 
\end{array}
\]
 Portanto, para cada vértice $v$ em $Q$, vale que $\fp(u) \leq \fp(v) +
 (\delta(V) + \delta(X_1) + \cdots +  \delta(X_{t-1}))/2 < \fp(v) +
 \delta(V)$. 
A segunda desigualdade vale, pois $\delta(X_i) \leq \delta(X_{i-1})/2$ para cada $i$
em $[1..t-1]$. Esta observação é a
 essência do invariante (th1) da próxima seção.

%\balgor
% \item \textbf{Caso 1:} $X$ é folha de $\Lcal$.
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
%   \x Para cada $v$ em $V$ faça $\fp'(v) := \fp(v)$ e $\pred'(v) := \pred(v)$.
%
 %  \x Para cada arco $uv$ faça 
%
 %  \xx Se\ $\fp(v) > \fp(u) + c_{uv}$ então 
%
 %  \xxx $\fp'(v) := \fp(u) + c_{uv}$ e $\pred'(v) := u$,
  %      remova $v$ de $U'$ e acrescente a $\L'$.
%
 %  \x Seja $\Lcal'$ a decomposição $(Q' \cup U')$-hierárquica obtida
  % após a remoção de $\{u\}$ de $\Lcal$.
%
 %  \x Seja $L'$ a pilha obtida após desempilhar $X$ de $L$.
%
 %  \x Comece nova iteração com $\fp'$, $\pred'$, $S', \L'$,  $U'$,
  % $\Lcal'$ e $L'$ nos papéis de $\fp{}$, $\pred$, $S, \L$, $U$,
   %$\Lcal$ e $L$.
%
 %  \item \x \textbf{Caso 1C:} $X \neq V$ e $^^7cX^^7c > 1$.
%
 %  \x Seja $\Lcal'$ a decomposição $(Q \cup U)$-hierárquica obtida
  % após a remoção de $X$ de $\Lcal$.
%
 %  \x Seja $L'$ a pilha obtida após desempilhar $X$ de $L$.
%
 %  \x Comece nova iteração com $\Lcal'$ e $L'$ nos papéis de $\Lcal$ e $L$.
%
 % \item \textbf{Caso 2:} $X$ não é folha de $\Lcal$.
%
 % \item \x \textbf{Caso 2A:} $X$ é maduro.
 %
 %  \x Seja $X'$ um filho maduro de $X$.
%
 %  \x Seja $L'$ a pilha obtida após empilhar $X'$ em $L$.
 %
  % \x Comece nova iteração com $L'$ no papel de $L$.
%
 % \item \x \textbf{Caso 2B:} $X$ não é maduro.
%
 %  \x Seja $L'$ a pilha obtida após desempilhar $X$ de $L$.
%
 %  \x Comece nova iteração com $L'$ no papel de $L$. \qed
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
\caption[{\sf Simulação do algoritmo de Thorup} (1)]
 {\label{fig:sim_thorup_desc} Execução do algoritmo de Thorup.
(a) exibe um grafo com comprimento nos arcos, junto com uma  
$\delta$-decomposição $V$-hierárquica $\Lcal$. O vértice inicial é $s$. (b) mostra a
situação no início da primeira iteração. Um número próximo a um
vértice ou elemento é o seu potencial. No grafo, os vértices pretos
são os de $S$, os vértices cinzas são os de $\L$, e os vértices
brancos são os de $U$. Na decomposição hierárquica, os elementos
hachurados são os que estão em $L$ e os elementos em preto são os que
foram removidos de $\Lcal$. (c) mostra a situação após empilhar o
elemento $\{s\}$ (caso~2B) e (d) é a
situação após examinar $\{s\}$ (caso~2A).}
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
\caption[{\sf Simulação do algoritmo de Thorup} (2)]
 {\label{fig:sim_thorup_desc2} Execução do algoritmo de Thorup
(continuação). Em (e) e (f) ocorre o caso~2B, e em (g) ocorre o caso~2A.
 Note que em (h), {\sc x} não é maduro, pois
$3 + (2/2) < 5$, então é desempilhado (caso~1C).
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
\caption[{\sf Simulação do algoritmo de Thorup} (3)]
 {\label{fig:sim_thorup_desc3} Execução do algoritmo de Thorup
(continuação). Em (i), (j) e (l) ocorre o caso~2B, e em (k) ocorre o caso~2A.}
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
\caption[{\sf Simulação do algoritmo de Thorup} (4)]
 {\label{fig:sim_thorup_desc4} Execução do algoritmo de Thorup
(continuação). Em (m) ocorre o caso~2A, em (n) o caso~1B e em (o) e (p)
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
\caption[{\sf Simulação do algoritmo de Thorup} (5)]
 {\label{fig:sim_thorup_desc5} Execução do algoritmo de Thorup
(continuação). Em (q) ocorre o caso~2A, em (r) o caso~1B,  em (s) o
caso~2B, e em (t) ocorre o caso~2A.}
 \end{center}
 \end{figure}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  INVARIANTES
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage
\section{Invariantes}
\label{sec:thorup-invariantes}\index{invariantes do algoritmo de!Thorup}

O algoritmo de Thorup, a exemplo do algoritmo de Dinitz-Thorup
 (capítulo~\ref{cap:dinitz-thorup}), mantém
todos os invariantes do algoritmo de 
Dijkstra (seção~\ref{sec:dijkstra-invariantes}), exceto aquele que é o
responsável pela ordem que os vértices são examinados, o invariante da
monotonicidade~\iten{dk3}.

No lugar do invariante da monotonicidade do algoritmo de Dijkstra, o
algoritmo de Thorup mantém 
os dois invariantes a seguir, que dizem respeito aos 
elementos de $\Lcal$ e à $\delta$-decomposição hierárquica. Note que a
função $\delta$ do algoritmo é tal que, se $X$ é filho de $Y$, então
$\delta(X) \leq \delta(Y)/2$.

%junto com os valores $\delta_0, \delta_1, \ldots, \delta_{h}$, onde
%$\delta_0 = C+1$, $\delta_i = 2^{h - i}$, para $i = 1, \ldots, h$, 
%onde $h$ é a altura de $\Lcal$.

\begin{enumerate}[({th}1)]
\item (monotonicidade local relaxada) para cada parte $X$ de $V$ em
$\Lcal$ e para cada $u$ em $S \cap X$, $v$ em $Q \cap X$ e $w$ em $U
\cap X$ vale que\footnote{A expressão "$\fp(u) \leq \fp(v) + \delta(X) <
\fp(w) = nC +1$"~deve ser entendida como uma abreviação. Se algum dos
conjuntos envolvidos é vazio, considere apenas as desigualdades que fazem sentido.}
\[
d(u) \leq d(v) + \delta(X) < d(w) = nC + 1. 
\]

\item (monotonicidade relaxada telescópica) para cada $u$ em $S$, $v$ em $Q$ e
$w$ em $U$ vale que 
\[
 d(u)  \leq d(v) + (\delta(X_k) + \delta(X_{k+1}) + \cdots + \delta(X_{t-1}))/2  
  < d(w) = nC + 1
\]
onde $X_k$ é o ancestral de maior nível comum a $\{u\}$ e $\{v\}$  e
$\seq{X_k, X_{k+1}, \ldots, X_{t-1}, X_t = \{u\}}$ é o caminho de
$X_k$ a $\{u\}$ na representação arbórea de $\Lcal$.
\end{enumerate}

 A seguir estão as demonstrações do invariante da monotonicidade local
 relaxada~(th1) e da monotonicidade relaxada telescópica~(th2). Mais
 adiante, está uma nova demonstração do invariante (dk9), que utiliza
 (th1) no lugar de (dk3) (ou (dt1) e (dt2) do algoritmo de Dinitz-Thorup).

 Note que o caso~2A é o único que altera os conjuntos $S$, $Q$ e $U$. 
 \begin{provainv}{\iten{th1}}
 A demonstração é análoga à demonstração do invariante (dt1). Basta
 considerarmos uma iteração em que ocorre o caso~2A. Seja $Y$ um elemento
 de $\Lcal$. Se no final da iteração $w$ está em $U' \cap Y$, então é evidente
 que no final da iteração vale que $\fp'(w) = \fp(w) = nC +1$. Além
 disso, combinando os invariantes (dk4), (dk5) e (dk6) que dizem
 respeito a função predecessor e $\{S, Q, U\}$ e o invariante das
 folgas complementares, obtém-se que 
\[
 \fp'(v) + \delta(Y) \leq \fp(v) + \delta(Y) \leq (n-1)C + \delta(Y) < nC
 +1 = \fp'(w)
\]
 para cada $v$ em $(Q' \cap Y)$.

  Assim, nos concentramos em verificar
 que para cada $x$ em $S' \cap Y$ e $y$ em $Q' \cap Y$, ao final da
 iteração, vale que $\fp'(x) \leq \fp(y) + \delta(Y)$. 
 
 Seja $x$ um vértice em $S' \cap Y$ e $y$ um vértice em $Q' \cap
 Y$. Se $\fp'(y) = \fp(y)$, então como $X = \{u\}$ e todos os seus
 ancestrais são maduros e pelo invariante (th1) tem-se que
\[
 \fp'(x) = \fp(x) \leq \fp(y) + \delta(Y) = \fp'(y) + \delta(Y).
\]

Suponha que $\fp'(y) < \fp(y)$. Portanto, 
\[
  \fp(u) \leq \fp(u) + c(u,y) = \fp'(y).
\]
 Como $\Lcal$ é uma decomposição hierárquica e do
 invariante (th1), vale que $\fp(x) \leq \fp(u) + \delta(Y)$. Portanto,
 \[
  \fp'(x) = \fp(x) \leq \fp(u) + \delta(Y) \leq \fp'(y) + \delta(Y).
 \]
 \end{provainv}

 \begin{provainv}{\iten{th2}}
 Considere uma iteração em que ocorre o caso 2B. Seja $w$ um vértice
 em $U'$. Ao final da iteração $\fp'(w) = \fp(w) = nC +
 1$. Combinando-se os invariantes (dk4), (dk5) e (dk6) com o
 invariante das folgas complementares (dk12) obtém-se que 
\begin{eqnarray*}
\fp'(v) + (\delta(X_k) + \cdots + \delta(X_{t-1}))/2 & \leq & \fp(v) + (\delta(X_k) + \cdots
+ \delta(X_{t-1}))/2\\
 & \leq & (n-1)C +(\delta(X_k) + \cdots + \delta(X_{t-1}))/2 \\
 & < & nC + 1 = \fp'(w)
\end{eqnarray*}
para cada $v$ em $Q'$ e $X_{i+1}$ é filho de $X_i$ para $i = k,
\ldots, t-2$.

Assim, resta demonstrar que para cada $x$ em
 $S$ e $y$ em $Q$, vale que 
\[ \fp(x) \leq \fp(y) + (\delta(X_k) + \cdots +
 \delta(X_{t-1}))/2.\]

 Seja $x$ um vértice em $S'$ e $y$ um vértice em $Q'$.
 Se ao final da iteração $\fp'(y) = \fp(y)$,
 então pelo invariante (th2) e como $\{u\}$ e todos os seus ancestrais
 são maduros, tem-se que
\[
\fp'(x) = \fp(x) \leq \fp(y) + (\delta(X_k) + \cdots + \delta(X_{t-1}))/2 = \fp'(y)
+ (\delta(X_k) + \cdots + \delta(X_{t-1}))/2.
\] 
Logo, podemos supor que ao final da iteração vale que $\fp'(y) <
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
 Considere uma iteração em que ocorre o caso~2B. Seja $yx$ um arco
 qualquer em $A(Q',S')$ ao final da iteração. Seja $X$ em $\Lcal$ o
 ancestral comum de $\{x\}$ e $\{y\}$ de maior nível. Suponha que o
 nível de $X$ é $t-1$. Do invariante (th1) obtem-se que
\[
 \fp'(x) \leq \fp'(y) + \delta(X)/2.
\]

Assim, como $\Lcal$ é uma decomposição hierárquica, então $\fp'(x) -
 \fp'(y) \leq \delta(X)/2 \leq c(y,x)$.
 Portanto, ao final da iteração, $\fp$ respeita $c$ em $A(Q', S')$.

 O processo de examinar $u$ faz com que $\fp'$ respeite $c$ em cada arco com
  ponta inicial em $u$. Do invariante~\iten{dk9} sabe-se que $\fp$ respeita $c$
  em $A(S,\L)$.  Assim, como $\fp'(v) = \fp(v)$ para cada $v$ em $S'$ e
  $\fp'(v) \leq \fp(v)$ para cada $v$ em $\L'$, concluí-se
  que $\fp'$ respeita $c$ em $A(S',\L')$.
 \end{provainv}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  CORREÇÃO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\section{Correção}
\label{sec:thorup-correcao}

 A correção do algoritmo de Thorup é facilmente demonstrada através
 dos seus invariantes, e é textualmente idêntica a demonstração da
 correção do algoritmo de Dijkstra (seção ~\ref{teo:correcao-dijkstra}), 
 já que este último não utiliza o invariante da
 monotonicidade~(dk3). Note que na última iteração do algoritmo de
 Thorup, quando ocorre o caso~1A, tem-se que $Q$ é vazio, pois se $X =
 V$ não é maduro, então $Q \cap V = \emptyset$.

\begin{teorema}{teorema da correção}
\label{teo:correcao-thorup}
Para cada vértice $t$ acessível a
partir de $s$ o algoritmo de Thorup devolve um caminho de $s$ a $t$ que tem
comprimento mínimo. \fimprova
\end{teorema}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  EFICIÊNCIA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\section{Eficiência}
\label{sec:thorup-eficiencia}

 Seja $(V,A,c,s)$ uma instância do PCMS. Denotamos por $n$ e
 $m$ o número de vértices e arestas de $(V,A)$. Uma implementação
 eficiente do algoritmo de Thorup deve resolver eficientemente os
 seguintes problemas:
 \begin{enumerate}[({p}1)]
 \item (pré-processamento) construção da $\delta$-decomposição $V$-hierárquica
       $\Lcal$ de $(V,A)$ 
 em relação a~$c$;
 \item (caso~2A) atualizar os potenciais e manter $\min\{\fp(v) \tq v \in Q \cap
 X\}$ para cada $X$ em $\Lcal$; e 
 \item (caso~2B) escolher o próximo elemento maduro a ser visitado.
 \end{enumerate}

\section*{{\large Construção da decomposição hierárquica}}

O problema (p1) é resolvido por um pré-processamento do algoritmo, que é 
feito em tempo $O(m + n)$ utilizando-se os trabalhos de Andersson,
Hagerup,  Nilsson e Raman~\cite{andersson:sorting}, Fredman e
Willard~\cite{fredman:mst} e Gabow e Tarjan~\cite{gabow:setunion}.
A implementação do algoritmo mantém a decomposição hierárquica $\Lcal$ através de
sua representação arbórea $(\Lcal, \Acal)$. A construção de
$(\Lcal,\Acal)$ está descrita na próxima seção.

 Além de construir uma $\delta$-decomposição $V$-hierárquica o
 pré-processamento também devolve uma floresta geradora $(V,T)$ de $(V,A)$ tal
 que
  \begin{enumerate}
  \item[(h3)] cada aresta de $T$ com pontas em filhos distintos de algum $X$ em
  $\Lcal$ tem comprimento inferior a  $2\delta(X)$.
  \end{enumerate}

 As condições (h2) e (h3) juntas implicam que cada aresta de $T$ com pontas em
 filhos distintos de algum elemento $X$ de $\Lcal$, tem seu comprimento em
 $[\delta(X)..2\delta(X)-1]$.

 É evidente que, para cada $X$ em $\Lcal$, o valor
\[
\sum_{uv \in T(X)} c(u,v)
\]
é um limitante superior para o \defi{diâmetro}\index{diametro@@diâmetro} do
grafo $(X,A(X))$, isto é, para o comprimento do maior caminho em
$(X,A(X))$.
 
\section*{{\large Atualização dos potenciais}}

A operação que precisa ser realizada eficientemente é
\begin{quote}
 atualizar $\min\{\fp(v) \tq v \in Q \cap X\}$ sempre que o potencial
 $\fp(v)$ de um vértice $v$ em $Q \cap X$ é decrescido.
\end{quote}
onde $X$ é um elemento da decomposição
$\Lcal$. Thorup~\cite{thorup:sssp-1999} descreve como esta operação
pode ser implementada em tempo amortizado constante.

Em linhas gerais, a idéia de Thorup é a seguinte. 
Seja $v_1, \ldots, v_n$ uma ordenação dos vértices em $Q$ induzida por
uma ordem arbitrária dos elementos internos da representação arbórea
$(\Lcal,\Acal)$. No início de cada iteração do algoritmo, para cada
elemento $X$ em $\Lcal$, os elementos $\{ \{v\} \tq v \in Q \cap X\}$
são folhas de $(\Lcal, \Acal)$ que têm $X$ como ancestral. Estas
folhas formam um segmento contíguo de $v_1, \ldots, v_n$.

Thorup descreve como, utilizando-se os atomic heaps de Fredman e
Willard~\cite{fredman:mst}, é possível manter uma partição dinâmica de
$v_1, \ldots, v_n$ em segmentos contíguos de tal forma que, para cada
$X$ em $\Lcal$, tenha-se que 
\[
\min\{\fp(v) \tq v \in Q \cap X\} = \min\{\fp(v_i) \tq i \in [k..l]\}
\]
onde $k$ e $l$ dependem de $X$.

\section*{{\large Escolha de um elemento maduro}}

A fim de escolher o próximo elemento maduro a ser visitado pelo
algoritmo, pode-se proceder de maneira análoga ao algoritmo de
Dinitz-Thorup, como apresentado a seguir.

Cada elemento interno $Y$ em $\Lcal$ mantém os seus filhos em buckets 
$B(Y,0), B(Y, 1), \ldots, B(Y, \Delta(Y))$. Para cada $i$ em
$[0..\Delta(Y)]$, $B(Y,i)$ contém os filhos $X$ de $Y$ tal que 
\[
 i\delta(Y)/2 \leq \min\{\fp(v) \tq v \in Q \cap X\} \leq (i+1)\delta(Y)/2.
\]
O bucket $B(Y,\Delta(Y))$ contém os
filhos $X$ de $Y$ tal que $Q \cap X = \emptyset$ e $U \cap X \neq
\emptyset$.

Em cada iteração em que ocorre o caso~2B, para escolher o filho maduro
$X'$ de $X$ a ser visitado, basta encontrar o menor $k$ em $[0..\Delta(X)-1]$ tal que
$B(X, k)$ é não-vazio. Devido ao invariante da monotonicidade local
relaxada~\iten{th1}, os elementos maduros podem ser escolhidos pelo
algoritmo a medida que os buckets são visitados na ordem
$B(X, 0),B(X, 1),\ldots,B(X, \Delta(X)-1)$. As operações principais envolvendo os buckets
são remoções e inserções. Suponha que cada  bucket é
representado através de uma lista ligada. Assim, cada operação de remoção e inserção de
filhos de um elemento $X$ em seus buckets pode ser realizada, no modelo RAM,  em tempo
constante: para determinar o bucket $B(X, k)$ que contém um certo
filho $X'$ de $X$ basta computar 
$k = \floor{2\min\{ \fp(v) \tq v \in  X' \setminus S\}/\delta(X)}$.
Portanto, o consumo total de tempo das operações envolvendo os buckets é
proporcional a 
\[ 
 n+m+ \sum_{X \in \Lcal^{*}}(\Delta(X) + 1),
\]
 onde
$\Lcal^{*}$ é o conjunto  
dos elementos internos de $\Lcal$.
Na simulação do algoritmo de Thorup, ilustrada nas
 figuras~\ref{fig:sim_thorup} e ~\ref{fig:sim_thorup2}, 
 os buckets são representados pelo vetor ao lado da decomposição hierárquica.

O valor $\Delta(X)$ deve ser um limitante superior para o número de buckets
associado a $X$. É suficiente tomarmos 
\begin{eqnarray}
\label{eq:delta}
\Delta(X) := {\big \lceil} 2 \sum_{uv \in T(X)} c(u,v)/\delta(X) {\big \rceil} 
\end{eqnarray}
onde (V,T) é a floresta que satisfaz (h3) e foi construída durante o
pré-processamento.
O lema a seguir mostra que com a definição de $\Delta(X)$ conforme a equação~\ref{eq:delta}, o
número total de buckets mantidos pelo algoritmo é inferior a $12n$. Portanto,
o consumo total de tempo e espaço das operações envolvendo os buckets é
  proporcional a
\[ 
n+m+ \sum_{X \in \Lcal^{*}}(\Delta(X) + 1) < n + m +12n = 13n +m = O(n + m).
\]
\begin{lema}{número de buckets}
 \label{lema:no-buckets}
Seja $\Lcal$ a $\delta$-decomposição $V$-hierárquica de $(V,A)$ em relação a
$c$ e $(V,T)$
uma floresta gerada de $(V,A)$ tal que $\delta$ e $(V,T)$ satisfazem (h3).
 O número máximo de
buckets mantidos pelo algoritmo de Thorup é
\end{lema}
\begin{eqnarray*}
\label{eq:no-buckets}
 \sum_{X \in \Lcal^{*}} (\Delta(X) +1) < 12n,
\end{eqnarray*}
onde $\Lcal^{*}$ é o conjunto dos elementos internos de $\Lcal$.

\begin{prova}

 Para cada elemento $X$ em $\Lcal^{*}$ temos que 
\[\Delta(X) + 1 \leq 2 + 2\sum_{uv \in T(X)} c(u,v) / \delta(X).\]

 Como cada elemento $X$ de $\Lcal$ tem pelo menos dois filhos então 
 $\Lcal$ tem no máximo $2n -1$ elementos, então
\begin{eqnarray*}
\sum_{X \in \Lcal^*} (\Delta(X) + 1) & \leq & \sum_{X \in \Lcal^*} 2 +
 2 \sum_{X \in \Lcal^*}\sum_{uv \in T(X)} c(u,v) /\delta(X)  \\
 & \leq & 4n + 2 \sum_{X \in \Lcal^*} \sum_{uv \in T(X)} c(u,v)/ \delta(X) \\
 & = & 4n + 2\sum_{uv \in T} \sum_{X \tq uv
\in T(X)} c(u,v)/\delta(X).
\end{eqnarray*}

Considere uma aresta $uv$ em $T$. Seja $X_0 , \ldots, X_t$ uma ordenação dos
elementos de $\Lcal$ que contém $u$ e $v$ tal que $X_{i+1}$ é filho de $X_i$,
para $i = 0, \ldots, t-1$. Temos que 
\begin{eqnarray*}
\sum_{X \tq uv \in T(X)} c(u,v)/ \delta(X) & < & \sum_{X \tq uv \in T(X)}
2\delta(X_t)/\delta(X)\\
& = & 2 {\big (} \delta(X_t)/\delta(X_t) +
\delta(X_t)/\delta(X_{t-1}) + \cdots + \delta(X_t)/\delta(X_0) {\big )}\\
& < & 2 {\big (} 1 + 1/2 + 1/4 +\cdots {\big )}\\
& < & 4, 
\end{eqnarray*}
onde a primeira desigualdade é devida a (h3) e onde a segunda é devida ao fato
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

\section*{\large Número de iterações}
O caso~1A ocorre apenas uma vez. 
Inicialmente, a $\delta$-decomposição $V$-hierárquica $\Lcal$ tem no máximo
$2n-1$ elementos. Logo, os casos~1B e 2A juntos ocorrem no máximo $2n$ vezes,
pois em cada ocorrência de um desses casos um elemento é removido de $\Lcal$.

Para estimarmos o número de ocorrências dos casos~1C e 2B, basta considerarmos
o número de operações empilha e desempilha, de elementos não folhas, realizadas
  em $L$. Consideraremos apenas o número de operações desempilha, já que o
  número de operações empilha é um a mais do que o número de operações
  desempilha
 (o algoritmo pára com
  $L = \seq {V}$). Quando um elemento não-folha $X$ é empilhado em $L =
  \seq{X_0, X_1, \ldots, X_t}$ temos que $X$ é maduro e portanto, 
  $Q \cap X \neq \emptyset$ e 
\[
\min\{\fp(v) \tq v \in Q \cap X\} \leq \min \{ \fp(v) \tq v \in Q \cap X_t\} +
\delta(X_t)/2.
\]
O elemento $X$ é desempilhado de $\Lcal$ por uma das seguintes razões:
\begin{enumerate}[({r}1)]
\item $Q \cap X = \emptyset$; ou
\item $\min\{\fp(v) \tq v \in Q \cap X\} >
\min\{\fp(v) \tq v \in Q \cap X_t\} + \delta(X_t)/2$.

O número total de vezes que desempilhamos um elemento pela razão (r1) é no
máximo $n$ (o número de elementos internos de $\Lcal$ é no máximo $n$).
\end{enumerate}
Sempre que um elemento é desempilhado pela razão (r2), este elemento é
removido de um bucket e inserido em outro bucket de $X_t$. Como o número total de operações
envolvendo buckets é limitado por $13n + m$, então o número total de vezes que
um elemento é desempilhado pela razão (r2) é no máximo $13n + m$.
Portanto, o número total de ocorrências dos casos 1C e 2B juntos é no máximo $2(n + 13n
+m) = 28n + 2m.$

Resumindo, o número total de iterações realizadas pelo algoritmo é inferior a
$30n + 2m + 1 = O(n + m)$.
Como cada iteração consome tempo amortizado constante temos o seguinte
teorema.

\begin{teorema}{consumo de tempo}
\label{teo:consumo-de-tempo-thorup}
O algoritmo de Thorup, quando executado, no modelo RAM, em um grafo com $n$
vértices e $m$ arcos, gasta tempo $O(n + m)$. \fimprova
\end{teorema} 

%Isto termina a demonstração de~\ref{lema:no-buckets}.

%Devido a~\ref{lema:no-buckets} obtem-se que o consumo total de tempo
%das operações envolvendo os buckets é  
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
\caption[{\sf Simulação da implementação do algoritmo de Thorup}]
 {\label{fig:sim_thorup}{ Execução do algoritmo de Thorup.
(a) exibe a representação arbórea da decomposição $V$-hierárquica do
grafo da figura~\ref{fig:sim_thorup_desc}(a). O vértice inicial é o
$s$. (b) mostra a situação no início da primeira iteração. O número
próximo a um elemento é o seu potencial. Na decomposição hierárquica,
os elementos em cinza são os já visitados. Se forem elementos
internos significam que já possuem bucket. Os pretos são os removidos
da representação arbórea. (c) mostra a situação após criar o bucket de
$V$ e (d) a situação após examinar $\{s\}$. Note que nos elementos que já possuem
bucket, o potencial mínimo é a primeira posição não-vazia do bucket. 
Em (e) ocorre a operação de empilhar o filho
maduro \textsc{y} de $V$ (crie bucket de \textsc{y}). Em (f), $\{s\}$ é
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
\caption[{\sf Simulação da implementação do algoritmo de Thorup (continuação)}]
 {\label{fig:sim_thorup2} Execução do algoritmo de Thorup
(continuação). Como não havia elementos em $B(\mbox{{\sc {y}}},0)$ 
 soma-se um ao mínimo de {\sc y}, como mostrado em (g). Assim, {\sc y} não é mais
maduro. Logo, foi necessário mover {\sc y} de $B(\mbox{{\sc {v}}},1)$
para $B(\mbox{{\sc {y}}},2)$. Por não haver elementos em $B(\mbox{{\sc
{v}}},1)$ o mínimo de {\sc v} é adicionado em um. No momento em (g) é
possível empilhar novamente {\sc v} e em seguida examinar $\{d\}$. As
figuras (i), (j), (k) e (l) são repetições dos casos anteriores.}
 \end{center}
 \end{figure}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  CONSTRUÇÃO DA DECOMPOSIÇÃO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\section{Construção da decomposição hierárquica}
\label{sec:construcao-hierarquica}

 Resumidamente, os ingredientes utilizados para construir a
 $\delta$-decomposição $V$-hierárquica $\Lcal$ de $(V,A)$ em relação a $c$, em tempo linear,
 no modelo RAM, são:
 \begin{itemize}
 \item Encontrar uma árvore geradora mínima em tempo linear. Nesse
 ponto, é utilizado o algoritmo de Fredman e Willard~\cite{fredman:mst};
 \item Conseguir executar cada operação de união de conjuntos disjuntos em tempo
 constante. Para isso, é utilizado o algoritmo de Gabow e
 Tarjan~\cite{gabow:setunion}; e
% casos especiais de uniões de conjuntos disjuntos, que permite fazer
% operações de {\it union-find}\footnote{Normalmente essas operações
%são: $union$, que une dois representantes de conjuntos distintos e $find$, que encontra o
%representante de um conjunto. Pode-se tomar como referência o livro
% CLRS~\cite{clrs:introalg-2001}} em tempo constante; e 
 \item Ordenar em tempo linear. Neste caso, é utilizado o algoritmo
 de Andersson, Hagerup, Nilsson e Raman~\cite{andersson:sorting}.
 \end{itemize} 

 Seja $(V,A)$ um grafo e uma função comprimento simétrica $c$ de $A$ em $\PosInt$.
 O primeiro passo na construção da $\delta$-decomposição
 $V$-hierárquica $\Lcal$ é
construir uma árvore geradora mínima de $(V,A)$. Isso pode ser feito
 em tempo linear, no modelo RAM, conforme descrito
por Fredman e Willard~\cite{fredman:mst}. O método desenvolvido por
eles, é uma aplicação direta de uma estrutura de dados, chamada
{\it atomic heap}, que realiza as operações da fila de
 prioridade, \textsf{insert}, \textsf{delete-min} e
 \textsf{decrease-key} em tempo amortizado constante.

 A idéia do algoritmo é semelhante ao de Dijkstra
 (capítulo~\ref{cap:dijkstra}). A partir de um vértice inicial $s$, encontra um
 caminho de $s$ até $t$, para cada vértice $t$ em $V$ que é acessível a
 partir de $s$. Neste caso, os caminhos encontrados não são
 necessariamente os mínimos, o importante é que a soma das arestas da
 arborescência determinada pela função predecessor tenha comprimento
 mínimo. Da mesma forma que o algoritmo de Dijkstra, 
cada iteração começa com 
uma função potencial $\fp{}$, 
uma função predecessor $\pred$, 
e partes $S, \L$ e $U$ de $V$. Como $Q$ é implementado através de um atomic heap, é
 necessário controlar o número de elementos que são inseridos em
 $Q$. Esse número limite será $\log n$. 

O algoritmo que constrói uma árvore geradora mínima em tempo linear é
dividido em dois passos. O primeiro passo consiste no seguinte:

No início da primeira iteração  
$\fp(v) = nC + 1$ para cada vértice $v$, 
$\pred(v) = v$ para cada vértice $v$,
$S = \emptyset$,
$\L = \emptyset$ e $U = V$.

Então, o passo seguinte é repetido até que $U = \emptyset$.

 No início da primeira iteração 
 escolha $u$ em $U$ tal que $\fp(u) = nC + 1$, faça $\fp(u) := 0$,
 $\L = \{u\}$ e $U := U \setminus \{u\}$.
 
 Cada iteração consiste no seguinte.
\balgor 
 \item \textbf{Caso 1:}\ {$\L = \emptyset$ ou $^^7c Q ^^7c \geq \log n$}
  
  Pare.

 \item \textbf{Caso 2:}\ {$\L \neq \emptyset$ e $^^7c Q ^^7c < \log n$}

  Escolha $u$ em $\L$ tal que $\fp(u)$ seja mínimo.

  $S := S \cup \{u\}$.

  $\L := \L \setminus \{u\}$.

  Para cada arco $uv$ faça 
%
 %\x Se $\fp(v) = nC + 1$ então
% 
% \xx $\fp(v) := c(u,v)$, remova $v$ de $U$ e acrescente a $\L$.
%
% \x Senão se $c(u,v) < \fp(v)$ então 
 
 \x Se $c(u,v) < \fp(v)$ então 
 
 \xx $\fp(v) := c(u,v)$, $\pred(v) := u$ e remova\footnote{É
     possível que $v$ já pertença a $\L$ e não esteja em $U$. Nesse
 caso estas últimas duas instruções são redundantes.} $v$ de $U$ e
 acrescente a $\L$.

 Comece nova iteração.
\ealgor

  Como as operação em $Q$ são feitas em tempo amortizado constante,
devido ao uso do atomic heap, o primeiro passo gasta tempo $O(m + n)$, onde
$n$ é o número de vértices e $m$ é o número de arcos.

 Para o segundo passo, a parte $S$ é condensada como se fosse um único vértice,
resultando em um grafo com $n'= O(m/\log n)$ vértices. Utilizado o mesmo
algoritmo acima no grafo condensado, mas trocando o atomic heap por um fibonacci heap
(seção ~\ref{sec:fibonacci})\footnote{Note que agora não é necessário
controlar o número de elementos inseridos em $Q$.}, a árvore geradora
mínima é obtida em tempo $O(m + n' \log n') = O(m)$.

 A principal motivação para trabalhar com uma árvore geradora mínima em 
vez do grafo é devido ao método desenvolvido por 
Gabow e Tarjan~\cite{gabow:setunion}, que mostra como 
pré-processar uma árvore, em tempo linear, para tornar possível cada
 operação {\it union-find}\footnote{Normalmente essas operações
 são: $union$, que une dois representantes de conjuntos distintos e $find$, que encontra o
 representante de um conjunto. Pode-se tomar como referência o livro
 CLRS~\cite{clrs:introalg-2001}} gastar tempo constante. Essas operações são utilizadas
na construção das $\delta(X)$-partições (seção~\ref{sec:hierarquica}),
onde $X$ é um elemento de $\Lcal$.
% Como descrito anteriormente
% , cada elemento $X$ de uma decomposição 
% $W$-hierárquica, pertencem a  uma $\delta_i$-partição, onde
% $i$ é o nível de $X$ e $\delta_{i}  =  2^{h - i}$, sendo $h$ a
% altura de $\Lcal$. No algoritmo de
% Thorup, cada nível $i$ da decomposição hierárquica forma uma
% $\delta_i$-partição, e toda 
% aresta com pontas final e inicial em um mesmo elemento $X$ de uma
% $\delta_i$-partição tem comprimento menor que $\delta_{i}$.
 Do ponto de vista do algoritmo descrito neste capítulo, 
para cada $X$ em $\Lcal$, $\delta(X)$ é um número da forma $2^k$, para
algum $k$.
A construção de $\Lcal$, começa construindo partes $X$, conexas
 maximais, induzidas por arestas de comprimento em 
$[2^0..2^1 - 1]$. Cada parte $X$ será um elemento interno de $\Lcal$, onde
$\delta(X) = 2^0$. Em seguida, são construídas as partes $X$, conexas
 maximais, induzidas por arestas de comprimento $[2^1..2^{2}-1]$, 
logo $\delta(X) = 2^1$. De maneira geral, a cada passo $i$, as partes $X$
são formadas pelas arestas de comprimento em $[2^i..2^{i+1}-1]$, e
$\delta(X) = 2^i$.

 Observe que os comprimentos da arestas em $[2^i..2^{i+1}-1]$
 possuem o mesmo \defi{most significant bit}\index{most significant
 bit}\mar{msb} (msb),
 já que o msb de um inteiro $x$ é $\floor{\log_2 x}$.   
 Por exemplo, considere o intervalo $[4,5,6,7]$. Então, o msb dos
 números nesse intervalo é $2$. 

 De fato, o que é usado para construir os elementos internos de $\Lcal$, é o msb
 do comprimento das arestas. 
 Embora o msb não é obtido diretamente, ele pode ser calculado, no
 modelo RAM, usando-se um número constante de operações. 
 O msb de um número $x$ pode ser calculado da seguinte forma:
 (1) converta $x$ para um número em ponto flutuante.  
 Conforme o padrão IEEE~\cite{sun:floatingpoint} 
 um número em ponto flutuante é representado internamente pelo
 computador da seguinte maneira: $23$ bits
 para a fração ou mantissa, \textit{f}; $8$ bits para o expoente,
 \textit{e}; e um bit para o sinal, \textit{s}, como ilustrado na
 figura~\ref{fig:float}.
 Além disso, todos os expoentes são armazenados depois de serem
 adicionados a um valor de deslocamento (ou bias), que é 
$0 \times 7\mbox{\texttt{FH}}$ em hexadecimal, ou $127$ em binário; 
(2) desloque (shift) $23$ ($0 \times 17$) bits à direita; e (3)
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
  \caption[{\sf Representação de um número em ponto flutuante}]
 {\label{fig:float} Representação de um número em ponto flutuante.}
 \end{center}
 \end{figure}
%%% \[(-1)^s \times 2^{e-127} \times 1.f\]
@ O calculo do msb é feito pela função |msb|. Para poder lidar com o
código binário do número ponto flutuante, é utilizado um pequeno
trecho em código assembler. Os tutoriais~\cite{asm:linux, asm:gcc}
ajudaram a conectar o assembler a linguagem C.
@<Funções auxiliares@>=
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

Agora, seja $a_1, \ldots, a_{n-1}$ a ordenação das arestas da árvore
geradora mínima de acordo com o $msb(a_i)$, obtida em tempo linear,
 utilizando o algoritmo {\it packed merging},
desenvolvido por Andersson {\it et al.}~\cite{andersson:sorting}. 
%Hagerup, Nilsson e Raman

O algoritmo abaixo constrói a $\delta$-decomposição $V$-hierárquica $\Lcal$ de
$(V, A)$ em relação a $c$ em tempo linear, no modelo RAM:
\begin{quote}
 Para $i$ de $1$ até $n-2$ faça

\x Seja $uv = a_i$.

\x $u := find(u)$ e $v := find(v)$.

\x $union(u,v)$.

\x $Y := Y \cup \{find(u)\}$.

\x Se $msb(a_i) < msb(a_{i+1})$ então

\xx Para todo $v \in Y$ faça

\xx Seja $X$ um elemento de $\Lcal$ que contém as arestas do conjunto
representado por $v$.

\xxx $\delta(X) := 2^{msb(a_i)}$.

\xx $Y := \emptyset$.

\end{quote}

 Em conclusão, temos o seguinte teorema:
\begin{teorema}{construção de uma decomposição hierárquica}
 \label{teo:construcao-decomposicao-hierarquica}
 Seja $(V,A)$ um grafo e uma função comprimento simétrica $c$ de $A$
  em $\PosInt$. Uma $\delta$-decomposição $V$-hierárquica de $(V,A)$ em
  relação a $c$ é construída em tempo $O(m + n)$. \fimprova   
\end{teorema}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A figura~\ref{fig:hierarquica} ilustra a construção de uma
 decomposição hierárquica.
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
\caption[{\sf Construção de uma decomposição hierárquica}]
 {\label{fig:hierarquica} (a) mostra um grafo simétrico. Em (b) o
mesmo grafo com os comprimentos em relação ao msb. (c) mostra uma
possível árvore geradora mínima em relação ao msb dos
comprimentos. As curvas da figura (d) representam um nível da
 $\delta$-decomposição $V$-hierárquica. (e) mostra a
$\delta$-decomposição $V$-hierárquica do grafo em (a). 
 (f) ilustra a correspondente representação arbórea.}
 \end{center}
 \end{figure}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  VERSÃO CWEB
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\section{Versão em \CWEB{}}

@ Esta implementação do algoritmo de Thorup, difere do projeto do algoritmo
linear de Thorup~\cite{thorup:sssp-1999}, mas aplica as mesmas idéias. 
Por exemplo, não são utilizados os atomic heaps desenvolvido por Fredman
e Tarjan~\cite{fredman:mst}. Do ponto de vista prático, acredita-se
que mesmo fazendo uso dessa estrutura, não proporcionaria melhorias
computacionais, pois conforme Thorup~\cite{thorup:sssp-1999}
menciona, os atomic heaps são definidos somente para $n >
2^{12^{20}}$ e seu interesse é principalmente teórico.

 Conforme visto na seção~\ref{sec:thorup-eficiencia}, uma implementação
do algoritmo de Thorup envolve resolver três problemas: (p1)
construção da $\delta$-decomposição $V$-hierárquica $\Lcal$ de $(V,A)$
 em relação a $c$; (p2) atualizar os potenciais e
manter $\min\{\fp(v) \tq v \in Q \cap  X\}$ para cada $X$ em $\Lcal$;
e (p3) escolher o próximo elemento maduro para ser visitado.

 Na implementação apresentada, os problemas são solucionados da seguinte maneira:
\begin{quote}
\item[{\bf Construção da decomposição hierárquica.}] A construção da
$\delta$-decomposição $V$-hierárquica, é feita a partir da árvore geradora mínima do grafo
dado. Lembrando que o importante é o msb do comprimento dos arcos
(seção~\ref{sec:construcao-hierarquica}). O algoritmo utilizado para
resolver o problema AGM é o de Kruskal utilizando a estrutura {\it
union-find}~\cite{clrs:introalg-2001}. No algoritmo de Kruskal
é necessário a ordenação dos arcos, que é feita utilizando-se um
bucket sort. Assim, como os arcos são ordenados em relação ao msb dos
comprimentos, essa etapa pode ser feita em tempo $O(\log C + m)$, onde
$C$ é o comprimento do maior arco. Após a ordenação, o algoritmo de
Kruskal/{\it union-find}, para encontrar uma árvore geradora mínima,
 gasta tempo $O(m \alpha(m,n))$, onde $\alpha$
é a inversa da função de Ackermann. Como a construção da
decomposição hierárquica é feita ao mesmo tempo que se determina a
árvore geradora mínima, o tempo gasto é $O(\log C + \alpha(m,n)m)$.
\item[{\bf Atualização dos potenciais.}]
Na decomposição hierárquica, o $\min\{\fp(v) \tq v \in Q \cap  X\}$, 
para algum $X$ em $\Lcal$ é igual ao $\min\{\fp(v) \tq v \in Q \cap
X'\}$, onde $X'$ é um descendente folha de $X$. 
Como $\min\{\fp(v) \tq v \in Q \cap X'\}$ pode diminuir, os elementos $X$,
ancestrais de $X'$ devem ser atualizados. Na implementação, utilizamos
o método mais natural, isto é,  quando $\min\{\fp(v) \tq v \in Q \cap
X'\}$ diminui, o novo valor é propagado para cima enquanto
necessário. No pior caso, o tempo gasto na atualização dos potenciais
é, claramente, a altura de $\Lcal$, que é limitada por $\log r$, onde $r$ é a
razão entre o maior e o menor comprimento de um arco. Portanto, o
tempo gasto, em cada atualização é $O(\log r)$. Como observado por Pettie e
Ramachandran~\cite{pettie:experimental} na prática, poucos ancestrais
precisam ser atualizados.
\item[{\bf Escolha de um elemento maduro.}]
 A escolha de um elemento maduro é feita através da utilização de
buckets, conforme descrito na
seção~\ref{sec:thorup-eficiencia}. Portanto, o tempo total gasto nessa
etapa é $O(m + n)$.
% Na implementação, é utilizado deslocamento de bits
%(shifts). Por exemplo, $\fp(v)$\ |>>|\ $\delta$ significa
%$\floor{\fp(v)/\delta}$.
\end{quote}
A implementação do algoritmo de Thorup está dividida em dois blocos:
@<Algoritmo de Thorup@>=
 @<Construa a decomposição hierárquica do grafo@>@;
 @<Examine os vértices utilizando a decomposição hierárquica@>@;

@ O bloco a seguir, corresponde a decomposição hierárquica.
@<Definições@>=
#define prox_sort @,@,@,@, a.A /* próximo arco na ordem será |a->prox_sort| */
#define from @,@,@,@, b.V /* uma arco vai de |a->from| para |a->tip| */

@ Os arcos são ordenados, de acordo com o msb dos comprimentos,
utilizando-se um bucket sort. A ordenação dos arcos é mantida no vetor
|sort|. Então, cada posição $i$ de |sort| mantém os arcos com
comprimento $2^i$.  
@<Variáveis globais@>=
Arc *sort[100];  /* cabeças de listas ($100$ é suficiente) */

@ O decomposição hierárquica é mantida, em |arb|, na forma da sua representação
arbórea. 
@<Construa a decomposição hierárquica do grafo@>=
Graph *
krusk(g)
     Graph *g;
{@+@<Variáveis de |krusk|@>@;@#
 
 @<Ordene os arcos colocando-os nos buckets $sort[0], \ldots, sort[msbC]$@>@;

 @<Coloque cada vértice em um conjunto distinto e inicializa a arborescência@>@; 

 conj = n;
 for (i = 0; i <= msbC ; i++){
    for (a = sort[i]; a && (conj > 1); a = a->prox_sort) {
      u = a->from;  v = a->tip;
      @<Caso |u| e |v| estejam no mesmo conjunto, comece nova iteração@>@;
      @<Faça a união dos conjuntos que contém |u| e |v| e construa a arborescência@>@;
      if(CONEXO) conj--;
    }
 }
 @<Devolva a arborescência@>@;
}

@ @<Variáveis de |krusk|@>=
register Graph *arb; /* estrutura arbórea */
register Arc *a, *aux;
register unsigned long msbC; /* msb(C) */
register unsigned long n;
register unsigned long conj;
register long i;
register long delta_atual;     /* $\delta$-partição que está em construção  */
register Vertex *u,*v,*w,*arbv; 
register Vertex *livre; /* posição de arb que pode ser usada */

@ O algoritmo de Kruskal seleciona os arcos, um a um, 
em ordem crescente de comprimento e de forma que não formem ciclos.
Cada posição $i$ de |sort| guarda os arcos que tem o |msb| do comprimento igual a $i$.
@<Ordene os arcos colocando-os nos buckets $sort[0], \ldots, sort[msbC]$@>=
msbC = msb(C);
for (i = 0; i <= msbC; i++) sort[i] = NULL;

n = g->n;
for (v = g->vertices; v < g->vertices + n; v++){
  for (a = v->arcs; a ; a = a->next) {
    /* só guarda os arcos que apontam pra frente */
    if(a->tip < v) continue;
    a->from = v;
    i = msb(a->len);
    a->prox_sort = sort[i];
    sort[i] = a;
  }
}

@ A construção de |arb| envolve o uso dos ponteiros: |rep|, que é
usado pelos vértices em |g| indicando qual elemento, em |arb|, eles
pertencem; |bksize| indica o número máximo de posições de um bucket e
|delta| as $\delta$-partições.
@<Definições@>=
#define rep @,@,@,@, x.V    /* aponta para o representante do conjunto */
#define bksize @,@,@,@, r.I  /* soma dos arcos de um elemento ($\Delta$) */
#define delta @,@,@,@, w.I   /* $\delta$ de uma partição da decomposição hierárquica */

@ Inicializações dos ponteiros dos vértices, do grafo dado |g|, e daqueles
responsáveis pela construção da representação arbórea |arb|.
@<Coloque cada vértice em um conjunto distinto e inicializa a arborescência@>=
arb = gb_new_graph(n);
/* Nomeia aos vértices da arborescência*/
for(arbv = arb->vertices, v = g->vertices, i = 0; arbv < arb->vertices + n; arbv++, v++){
  arbv->elemento = arbv->rep = arbv;
  v->bksize = arbv->bksize = 0;
  v->elemento = v->rep = v; 
  v->delta = VERTICE_DE_G;
}
livre = arb->vertices; /* próxima posição livre (novo elemento)*/

@ Os dois blocos seguintes, dizem respeito à estrutura {\it union-find}.\\
{\it find}: A função |find_set| encontra o representante de um conjunto.
@<Funções auxiliares@>=
Vertex*
find_set(v)
     Vertex *v;
{
  if (v != v->rep) 
    v->rep = find_set(v->rep);
  return (v->rep); 
}

@ {\it union}: Verifica se o representante do conjunto que contém o
vértice |u| é o mesmo que o do vértice |v|. Em caso afirmativo, 
significa que |u| e |v| pertencem ao mesmo conjunto. Logo, não é
possível adicionar o arco $uv$, aos arcos que estão compondo a árvore geradora
mínima,  pois com este, um ciclo seria formado.
@<Caso |u| e |v| ...@>=
u = find_set(u);
v = find_set(v);
if (u == v) continue;

@ Caso o representante do conjunto que contém |u| e o que contém |v|
sejam diferentes, o arco $uv$ irá compor a árvore geradora
mínima, e os representantes dos conjuntos serão unidos, de três
possíveis maneiras, conforme ilustrado na figura~\ref{fig:uniao}.
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
\caption[{\sf União de dois elementos na construção da decomposição hierárquica}]
 {\label{fig:uniao} As figuras (a), (b) e (c) mostram os três casos
possíveis na união de dois elementos. Em (a) um novo elemento é criado
e tem como filhos os elementos $u$ e $v$. (b) é a situação em que os
filhos de $v$ se tornam filhos de $u$. A figura (c) ilustra o caso em  
que $u$ é colocado como filho de $v$.}
 \end{center}
 \end{figure}  
@<Faça a união dos ...@>=
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
  @<Junte |u| e |v| em um único elemento@>@;
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

@ @<Junte |u| e |v| em um único elemento@>=
for(aux = v->arcs; aux; aux = aux->next){
  gb_new_arc(u,aux->tip); /* transfere os arcos de v para u */
  aux->tip->elemento = u;
}
v->rep = u; /* fazendo isso não preciso ajustar os ponteiros |rep| dos níveis abaixo */
v->arcs = NULL;

u->bksize += a->len + v->bksize;

if(REPORT) nelementos--;

@ @<Coloque |u| como filho de |v|@>=
gb_new_arc(v,u);
u->elemento = v;
u->rep = v;
v->bksize += a->len + u->bksize;

@ Antes de retornar a representação arbórea |arb| da decomposição
hierárquica de |g|, é preciso calcular os valores de |bksize|, que 
 limitam o tamanho dos buckets de cada elemento.
@<Devolva a arborescência@>=
if(livre == arb->vertices) return NULL; /* não tem nenhum elemento */

for(v = arb->vertices; v <= livre; v++){
  if(v->arcs != NULL) v->bksize =  ((v->bksize >> v->delta)+2);
}
return arb;


@ O bloco a seguir, corresponde e examinar os vértices, fazendo uso da
decomposição hierárquica.
@<Variáveis globais@>=
int desempilha = 0; /* número de vezes que o programa desempilha vértices */
int atualiza_acima = 0; /* número de vezes que subiu na arborescência para atualizar */
int nao_maduro = 0; /* número de vezes que os elementos se tornaram não maduros */
int nelementos = 0; /* número de nós da arborescência (sem contar os vértices de g) */
Vertex **BK;        /* Bucket */

@ @<Definições@>=
#define dx @,@,@,@, q.I         /* menor valor de um elemento */
#define prox_topo @,@,@,@, x.V  /* próximo elemento no topo da pilha */
#define id(i)  (i - arb->vertices)
#define BK(i,j) @,@,@,  (*( BK + id(i) ) + j)

@ A função |insere_elemento|, insere |v| no bucket |BK(u,i)|. 
@<Funções auxiliares@>=
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

@ A implementação tenta ser a mais próxima possível da 
descrição (seção~\ref{sec:thorup-descricao}).
@<Examine os vértices utilizando a decomposição hierárquica@>=
void
thorup(g, arb, s)
     Graph *g;
     Graph *arb;
     Vertex *s;
     
{@+@<Variáveis de |thorup|@>@;@#
        
 @<Inicializações para |thorup|@>@;
 
 @<Encontre a raiz |root| da arborescência@>@;
 
 topo =  root; /* |root| fica no topo da pilha */
 
 while(1){
   x = topo;

   if( (x->arcs == NULL) && (x->delta != VERTICE_DE_G)) {
   /* |x| é uma folha e não é madura (não pode ser um vértice de |g|)*/ 
      if(x == root) {
        /* Caso 1A: raiz não é madura */ 
        free(BK[id(x)]); /* já posso desalocar o bucket de |x| */
        break;
      }
      else{
        /* Caso 1B: |x| não é maduro e é folha */
        @<Desempilhe@>@;
        remove_elemento(x);  /* remove |x| do bucket */
        free(BK[id(x)]); /* já posso desalocar o bucket de |x| */
        continue;
      }
    }
   if(x->delta == VERTICE_DE_G){ /* Caso 2A: x é vértice de g */
     @<Examine a folha |x|@>@;
     @<Desempilhe@>@;
     remove_elemento(x);  /* remove |x| do bucket */
     continue;
   }
   if(x->status == NAO_VISITADO){
     /* elemento ainda não foi visitado (ainda não tem bucket)*/
     @<Crie um bucket para |x|@>@;
   }

   fmaduro = BK(x,x->dist - x->dx)->prox_elemento; /* verifica se |x| tem filho maduro */
   
   if(fmaduro != BK(x,x->dist - x->dx)){
     /* Caso 2B: |x| é maduro e |fmaduro| é seu filho maduro */
     @<Empilhe o filho maduro de |x|@>@;
     continue;
   }
   
   x->dist++;

   if(x->dist == (x->bksize + x->dx) )/*o bucket de |x| está vazio (|x| virou folha)*/
	x->arcs = NULL;
   
   else{
     /* Caso 1C: |x| não é maduro e não é folha */
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

@ @<Variáveis de |thorup|@>=
register Arc *a;
register Vertex *v, *x, *w, *arbv;
register Vertex *topo, *root, *fmaduro;
register unsigned long n;
register unsigned long i, k;
register unsigned long dist_antes;
register unsigned long dif;

@ @<Inicializações para |thorup|@>=
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

@ @<Encontre a raiz |root| da arborescência@>=
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
  /* Inicializa cabeça de lista */
  BK(x,i)->ant_elemento = BK(x,i)->prox_elemento = BK(x,i);
}

for(a = x->arcs; a; a = a->next){
  v = a->tip;

  i = (v->dist >> x->delta); /* posição do bucket para ser inserido */
  
  i -= x->dx; /* preciso fazer o deslocamento, pois só aloquei x->bksize posições */

  if(i < x->bksize) insere_elemento(arb,v,x,i); /* insere |v| no BK*/
}

@ @<Examine a folha |x|@>=
for(a = x->arcs; a; a = a->next){
  v = a->tip;
  
  if(v->dist - x->dist > a->len ){/* se a função potencial não é viável */
    atualiza_fp++;

    dist_antes = v->dist; /* guardo o valor do potencial não viável */
    
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
  if( v->dist >= w->dist) break; /* não preciso atualizar o mínimo */
  
  dist_antes  = w->dist;
  
  w->dist = v->dist; /* atualiza mínimo do elemento |w| */
  
  if(REPORT) atualiza_acima++;
  
  v = w;
}

@ @<Mude |x| de bucket@>=
  if(x != root){
    w = x->elemento;
    remove_elemento(x); /* remove |x| do bucket */
    
    i -= w->dx;  /* preciso fazer a correção */
    if( i < w->bksize) insere_elemento(arb, x, w, i); /* move |x| para o |BK(w,i)| */
    else x->arcs = NULL; /* elemento |x| não pode ter mais filhos */
    
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
Portanto, essa implementação do algoritmo de Thorup gasta tempo
\[
  \underbrace{O(\log C + m \alpha(m,n))}_{\mbox{dec. hierárquica}} + 
  \underbrace{O(m \log r)}_{\mbox{atualizar}} +
  \underbrace{O(n + m)}_{\mbox{examinar}} 
  = O(n + \log C + m \alpha(m,n) + m \log r).
\]

\begin{teorema}{}
 A implementação do algoritmo de Thorup resolve o
 PCMS em um grafo com $n$ vértices e $m$ arcos
 em tempo $O(n + \log C + m \alpha(m,n) + m \log r)$, onde
 $\alpha(m,n)$ é a inversa da função de Ackermann, $C$ é o maior
 comprimento de um arco e $r$ é a razão entre o maior e o menor
 comprimento de um arco. \fimprova
\end{teorema}


