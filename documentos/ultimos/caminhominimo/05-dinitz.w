\chapter{Algoritmo de Dinitz-Thorup}
\label{cap:dinitz-thorup}
\longpage

O algoritmo apresentado neste capítulo é um primeiro passo para o projeto de
um algoritmo linear, no modelo RAM, para o problema do caminho mínimo
(PCM)\mar{PCM} restrito a grafos simétricos com funções comprimento
simétricas.  

Um componente fundamental no algoritmo de Dijkstra é a escolha apropriada do
próximo vértice a ser examinado: escolha um vértice $u$ em um certo conjunto
$\L$ de vértices visitados tal que o potencial ou distância tentativa 
$\fp(u)$ associada a $u$ é
mínimo. Devido a esta escolha, tem-se que os vértices do grafo são examinados
em ordem crescente de distância a partir de um dado vértice
origem\footnote{Esta ordem é conseqüência do invariante da
  monotonicidade~\iten{dk3} do algoritmo de Dijkstra.}  e que qualquer
implementação do algoritmo de Dijkstra, no modelo comparação-adição, faz
$\Omega(n \log n)$ comparações (seção~\ref{sec:complexidade-dijk}). Assim,
qualquer variante do algoritmo de Dijkstra que tem a pretensão de executar um
número de operações proporcional ao tamanho do grafo não pode ser tão seletiva
em relação ao próximo vértice a ser examinado.

Dinitz~\cite{dinitz:1978} observou que se $\delta$ é o menor comprimento de um
arco então, no algoritmo de Dijkstra, pode-se escolher o próximo vértice a ser
examinado da seguinte maneira: escolha $u$ em $\L$ tal que
\[\min\{\fp(v) \tq v \in \L\} \leq \fp(u) \leq \min\{\fp(v) \tq v \in \L\}+\delta.  \]
Dinitz combinou esta observação a uma partição (bucketing) dos vértices do
grafo a fim de determinar um conjunto de vértices que podem ser examinados em
qualquer ordem: os vértices com potenciais em\footnote{Para $\delta = 0$
  a observação de Dinitz coincide com a implementação do algoritmo de Dijkstra.} 
$[\min\{\fp(v) \tq v \in \L\}..\min\{\fp(v) \tq v \in \L\}+\delta]$.



% articionando os vértices
% em $\L$ de em buckets de acordo com o valor $\lceil \fp(u)/\delta\rceil$
% pode-se examinar os vértices no bucket minimal em qualquer ordem.


% A fim de evitar o limitante inferior do algoritmo de Dijkstra devido a
% ordenação intrínsica 


O algoritmo que nesta dissertação é chamado de algoritmo de
  Dinitz-Thorup\index{algoritmo de!Dinitz-Thorup} foi apresentado por
Thorup~\cite{thorup:sssp-1999}.  Este algoritmo combina dois ingredientes, a
saber, a idéia de bucketing de Dinitz para determinar vértices que podem ser
examinados em qualquer ordem e uma certa decomposição do grafo proposta por
Thorup, descrita na próxima seção.  Este algoritmo é um estágio intermediário
entre o algoritmo de Dijkstra (capítulo~\ref{cap:dijkstra}) 
e algoritmo de Thorup, estudado no próximo capítulo.

\section{Partições, variante do PCM e elementos maduros}
\label{sec:dinitz-particao}

Seja $(V,A)$ um grafo, $c$ uma função comprimento de $A$ em $\NonnegInt$ e
$\delta$ um número inteiro. 
Uma partição $\Pcal$ de $V$ é uma %%%% $V_{1}, \ldots,V_{k}$ de $V$ é uma
\defi{$\delta$-partição}\index{$\delta$-particao@@$\delta$-partição}%
\mar{ \tiny $\delta$-partição \normalsize}   
(em relação a $c$) se todo arco com ponta inicial e ponta final em 
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
  \caption[{\sf $\delta$-partição}]
  {\label{fig:d_particao} Ilustração de uma $\delta$-partição 
   $\Pcal = \{X, Y, Z, W\}$.}
\end{center}
\end{figure}


%  \begin{lema}{Dinitz}
%  \label{lema:dinitz}
%   Seja uma $\delta$-partição $V_{1}, \ldots,V_{k}$ de $V$. 
%   Se, para algum $i$, 
%   $$min \{ \fp(u) \tq u \in V_{i} \backslash S \} \leq 
%     min \{ \fp(u) \tq u \in V \backslash S \} + \delta$$
%   então $\fp(u) - \fp(s) = c(P^{u})$, onde $P^{u}$ é um caminho mínimo
%   de $s$ a $u$.
%  \end{lema}

O algoritmo descrito na próxima seção resolve a seguinte variante do problema do
caminho mínimo:
\begin{quote}
\textbf{Problema} PCMV$(V,A,c,\delta,\Pcal,s)$:%
\index{PCMV}\mar{PCMV}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dado um grafo $(V,A)$, uma função comprimento $c$ de $A$ em
$\NonnegInt$, um inteiro positivo $\delta$, uma $\delta$-partição
$\Pcal$ e um vértice $s$, encontrar um caminho de comprimento
mínimo de $s$ até $t$, para cada vértice~$t$ em $V$.
\end{quote}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Um algoritmo para o PCMV pode ser facilmente adaptado para resolver o PCM:
basta tomar $\Pcal := \{ \{v\} \tq v \in V \}$ e $\delta := \min\{c(u,v) \tq uv
\in A\}$.  

Vale a pena chamar a atenção para o seguinte fato. Do ponto de vista da
definição do problema faz sentido permitir $\delta = 0$. Entretanto, os
algoritmos e implementações neste e no próximo capítulo utilizam $\delta$ como
denominador de expressões. O tipo de divisão por $\delta$ utilizada se reduz a um
simples shift, que no modelo RAM, consome tempo constante.
        
% Seja $\Delta := \floor{(nC + 1)/\delta}$, onde $C := \max\{ c(u,v) \tq uv \in
% A\}$.  Para resolver o PCMV o algoritmo de Dinitz-Thorup mantém, entre outros
% objetos, uma função potencial $\fp$, um elemento $\L$ de $V$ e mantém ainda as
% elementos de $\Pcal$ em buckets $B(0),B(1),\ldots,B(\Delta-1)$ tais que $B(i)$
% contém as elementos $X$ tais que $\floor{\min\{\fp(v) \tq v \in \L \cap
%   X\}/\delta} = i.$  

Para resolver o PCMV o algoritmo de Dinitz-Thorup, como o algoritmo de
Dijkstra, mantém, entre outros objetos, uma função potencial $\fp$ e o
conjunto $\L$ dos vértices visitados. É dito que um elemento $X$ da
$\delta$-partição dada é \defi{maduro}\index{elemento maduro} se $\L \cap
X \neq \emptyset$ e
\[
\min\{ \fp(v) \tq v \in \L \} \leq 
\min\{ \fp(v) \tq v \in \L \cap X\} \leq
\min\{ \fp(v) \tq v \in \L \} + \delta.
\]
A primeira desigualdade acima é óbvia. A segunda desigualdade é, de fato, a condição.


% $V$ e mantém ainda as elementos de $\Pcal$ em buckets
% $B(0),B(1),\ldots,B(\Delta-1)$ tais que $B(i)$ contém as elementos $X$ tais que
% $\floor{\min\{\fp(v) \tq v \in \L \cap X\}/\delta} = i.$


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  DESCRIÇÃO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Descrição}
\label{sec:dinitz-thorup-descricao}
 
% Em 1978, Dinitz~\cite{dinitz:1978} observou que se $\delta$ 
%for o comprimento do menor arco,
%então no algoritmo de Dijkstra, nós podemos visitar qualquer 
%vértice $v$ que minimiza $\floor{\fp(v)/\delta}$.

O algoritmo de Dinitz-Thorup resolve o PCMV e devolve os mesmos certificados
que o algoritmo de Dijkstra, a saber, uma função predecessor codificando os
caminhos compactamente e uma função potencial viável atestando a minimalidade
dos caminhos e a eventual não-acessibilidade de alguns vértices. 

%\longpage

% \begin{quote} 
% \textbf{Algoritmo de Dinitz-Thorup.}\index{algoritmo de! Dinitz-Thorup}
% Recebe um grafo $(V,A)$, uma função comprimento $c$ de $A$ em
% $\PosInt$, um inteiro positivo $\delta$, uma $\delta$-partição
% $\Pcal$ e um vértice $s$,
% e devolve uma
% função predecessor $\pred$ e uma função potencial $\fp$ que respeita $c$
% tais que, para todo vértice $t$, se $t$ é acessível a partir de $s$, então
% $\pred$ determina um caminho de $s$ a $t$ que tem comprimento $\fp(t) -
% \fp(s)$, caso contrário $\fp(t)-\fp(s) = nC+1$, 
% onde $C := \max\{ c(u,v) \tq uv \in A\}.$
% \end{quote}


% Cada iteração começa com 
% uma função potencial $\fp{}$, 
% uma função predecessor $\pred$,
% elementos $S, \L$ e $U$  de $V$ e
% buckets $B(0), B(1),\ldots, B(\Delta)$ das elementos de $V$ em $\Pcal$.

% No início da primeira iteração tem-se que 
% $\fp(s) = 0$ e $\fp(v) = nC + 1$ para cada vértice $v$ distinto de $s$,
% $\pred(v) = v$ para cada vértice $v$, 
% $S = \emptyset$,  
% $\L = \{s\}$,
% $U = V \setminus S$, 
% $B_{0} = \{X\}$, onde $X$ é a elemento de $\Pcal$ contendo $s$, 
% $B_{1} =\ldots= B_{\Delta-1} = \emptyset$ e $B_{\Delta} = \Pcal - \{X\}$, 
% onde $\Delta := \floor{(nC + 1)/\delta}$.

% \longpage
 
% Cada iteração consiste em:
% \balgor
% \item \textbf{Caso 1:} \  $B(i) = \emptyset$ para cada $i < \Delta$. 

%  Devolva $\fp$ e $\pred$ e pare.

% \item \textbf{Caso 2:} \  $B(i) \neq \emptyset$ para algum $i < \Delta$.

%   Seja $k$ o menor índice $i$ tal que $B(i) \neq \emptyset$.

%   Escolha $X$ em $B(k)$.
 
%   Escolha  $u$ em $\L \cap X$ tal que  $\fp(u)$ é mínimo.
 
%   $S' := S \cup \{u\}$.
 
%   $\L' := \L \setminus \{u\}$.
 
%   $U'  := U$.

%   Para cada $v$ faça $\fp'(v) := \fp(v)$ e $\pred'(v) := \pred(v)$.
 
%   Para cada $i$ faça $B'(i) := B(i)$.

%   Para cada arco $uv$ faça 

%  \x Se\ $\fp(v) > \fp(u) + c_{uv}$ então 

%  \xx $\fp'(v) := \fp(u) + c_{uv}$ e $\pred'(v) := u$, 
%      remova\footnote{É
%      possível que $v$ já pertença a $\L'$ e não esteja em $U'$. Nesse caso estas
%      últimas duas intruções são redundantes.}  $v$ de $U'$ e acrescente a $\L'$.

%  \xx Seja $Y$ a elemento em $\Pcal$ contendo $v$ e $j$ um índice tal que $B'(j)$ contém $Y$.

%  \xx Se $\fp'(v) < j \delta$ então 

%  \xxx Remova $Y$ de $B'(j)$ e coloque em $B'(j')$, 
%       onde $j' = \floor{\fp'(v)/\delta}$.

%   Se $X \setminus S' = \emptyset$, então remova $X$ de $B'(k)$ senão
  
%   \x Seja $w$ em $X \setminus S'$ tal que $\fp'(w)$ é mínimo.

%   \x Se $\fp'(w) \geq (k + 1)\delta$ então

%   \x\x Remova $X$ de $B'(k)$ e coloque em $B'(k')$, 
%   onde $k' = \floor{\fp'(w)/\delta}$.
 
%   Comece nova iteração com $\fp'$, $\pred'$, $S', \L', U'$ e  
% $B'(0),\ldots,B'(\Delta)$ nos papéis de 
% $\fp{}$, $\pred$, $S, \L, U$ e $B(0),\ldots,B(\Delta)$. \qed
% \ealgor

\begin{quote} 
\textbf{Algoritmo de Dinitz-Thorup.}\index{algoritmo de! Dinitz-Thorup}
Recebe um grafo $(V,A)$, uma função comprimento $c$ de $A$ em
$\NonnegInt$, um inteiro positivo $\delta$, uma $\delta$-partição
$\Pcal$ e um vértice $s$,
e devolve uma
função predecessor $\pred$ e uma função potencial $\fp$ que respeita $c$
tais que, para todo vértice $t$, se $t$ é acessível a partir de $s$, então
$\pred$ determina um caminho de $s$ a $t$ que tem comprimento $\fp(t) -
\fp(s)$, caso contrário $\fp(t)-\fp(s) = nC+1$, 
onde $C := \max\{ c(u,v) \tq uv \in A\}.$
\end{quote}


Cada iteração começa com 
uma função potencial $\fp{}$, 
uma função predecessor $\pred$,
partes $S, \L$ e $U$  de $V$.

No início da primeira iteração 
$\fp(s) = 0$ e $\fp(v) = nC + 1$ para cada vértice $v$ distinto de $s$,
$\pred(v) = v$ para cada vértice $v$, 
$S = \emptyset$,  
$\L = \{s\}$,
$U = V \setminus \{s\}$.
 
Cada iteração consiste em:
\balgor
\item \textbf{Caso 1:} \  $Q = \emptyset$. 

 Devolva $\fp$ e $\pred$ e pare.

\item \textbf{Caso 2:} \  $Q \neq \emptyset$

  Escolha $X$ em $\Pcal$ tal que $X$ é maduro.

  Escolha  $u$ em $\L \cap X$ tal que  $\fp(u)$ é mínimo.
 
  $S' := S \cup \{u\}$.
 
  $\L' := \L \setminus \{u\}$.
 
  $U'  := U$.

  Para cada $v$ faça $\fp'(v) := \fp(v)$ e $\pred'(v) := \pred(v)$.
 
  Para cada arco $uv$ faça 

 \x Se\ $\fp(v) > \fp(u) + c(u,v)$ então 

 \xx $\fp'(v) := \fp(u) + c(u,v)$, $\pred'(v) := u$ e  
     remova\footnote{É
     possível que $v$ já pertença a $\L'$ e não esteja em $U'$. Nesse caso estas
     últimas duas instruções são redundantes.}  $v$ de $U'$ e acrescente a $\L'$.

  Comece nova iteração com $\fp'$, $\pred'$, $S', \L'$ e $U'$ nos papéis de 
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
  \caption[{\sf Simulação do algoritmo de Dinitz-Thorup}]
 {\label{fig:sim_dinitz} Execução do algoritmo de Dinitz-Thorup.
 $\iten{a}$ exibe um grafo com comprimentos nos arcos junto com uma
 $3$-partição cujos elementos são os conjuntos \textsc{x, y, w, z} da figura.
 O vértice  inicial é $s$.
 $\iten{b}$ mostra a situação no início da
 primeira iteração.
 Se um arco $uv$ está sombreado, então $\pred(v) = u$.
 Os potenciais são os números próximos a cada vértice.  
 Os vértices pretos são os de $S$, 
 os vértices cinzas são os de $\L$, 
 e os vértices brancos são os de $U$.
 $\iten{c}-\iten{g}$ exibem a  situação após cada
 iteração do caso~2. Os valores finais da função potencial $\fp$, 
 e da função predecessor $\pred$, são mostrados em $\iten{h}$.
}
\end{center}
\end{figure}


Se $\delta = 0$ o algoritmo de Dinitz-Thorup, em sua forma abstrata, examina
os vértices na mesma ordem crescente de distância que o algoritmo de Dijkstra.
A situação de interesse é quando esta ordenação implícita, pela 
distância a partir da 
origem $s$, pode ser evitada, e isto ocorre quando $\delta$ é um inteiro
positivo (quanto maior, melhor). Uma simulação do algoritmo de Dinitz-Thorup
está ilustrada na figura~\ref{fig:sim_dinitz}, onde no momento, os vetores ao
lado dos grafos devem ser ignorados.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  INVARIANTES
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Invariantes}
\label{sec:dinitz-thorup-invariantes}
\index{invariantes do algoritmo de!Dinitz-Thorup}

O algoritmo de Dinitz-Thorup mantém todos os invariantes do algoritmo de
Dijkstra (seção~\ref{sec:dijkstra-invariantes}), exceto aquele que é o
responsável pela ordem que os vértices são examinados, o invariante da
monotonicidade~\iten{dk3}.

No lugar do invariante da monotonicidade o algoritmo de Dinitz-Thorup mantém
os dois invariantes a seguir, onde o primeiro envolve a partição $\Pcal$ e o
segundo envolve o número $\delta$.

\begin{enumerate}
\item[$\iten{dt1}$] (monotonicidade local) para cada parte $X$ de $V$ em
 $\Pcal$  e para cada $u$ em $S \cap X$, $v$ em $\L \cap X$ e
 $w$ em $U \cap X$ vale que\footnote{Se alguma das intersecções é
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
Os invariantes estão ilustrados na figura~\ref{fig:invariantes-dinitz}


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
  {\label{fig:invariantes-dinitz}Ilustração dos invariantes. $X,Y$ e
    $Z$ são os elementos da $\delta$-partição. 
    Figura~(a) mostra a
    estrutura do grafo em relação à partição $S,\L$ e $U$ de $V$
    (invariantes \iten{dk1} e \iten{dk2}), onde os arcos que cruzam as linhas
    tracejadas têm comprimento pelo menos $\delta$. (b) e (c) exibem a relação de ordem 
    envolvendo os potenciais dos vértices, as partes $S,\L$ e $U$ bem como os
    elementos $X,Y$ e $Z$ da $\delta$-partição (invariantes~\iten{dt1} e~\iten{dt2}). 
    Em~(d) os arcos
    determinados pela função predecessor $\pred$ são exibidos (invariantes
    \iten{dk4}, \iten{dk5} e \iten{dk6}).}
 \end{center}
 \end{figure}


O algoritmo mantém os invariantes \iten{dk1} e \iten{dk2} de estrutura, os
invariantes \iten{dk4}, \iten{dk5} e \iten{dk6} envolvendo a função
predecessor e $\{S,\L,U\}$, os invariantes de \iten{dk7} a \iten{dk11} dos
arcos onde a função potencial respeita ou desrespeita $c$ e o
invariante~\iten{dk12} das folgas complementares.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Além desses, o algoritmo de
%Dinitz-Thorup ainda mantém alguns invariantes envolvendo a partição $\Pcal$.

A seguir estão as demonstrações de~\iten{dt1} e~\iten{dt2} e uma nova
demonstração de \iten{dk9}, já que a demonstração de~\iten{dk9}, apresentada no
capítulo~\ref{cap:dijkstra}, faz uso do invariante da monotonicidade, que
no, algoritmo de Dinitz-Thorup, foi substituido pelos invariantes~\iten{dt1}
e~\iten{dt2}. 

\begin{provainv}{\iten{dt1}}
  Considere uma iteração em que ocorre o caso~2.  Ao final da
  iteração tem-se que $\fp'(v) \neq \fp(v)$ se e somente se $v$ está em 
  $\L'   \subseteq (\L \setminus \{u\}) \cup U$
 e $uv$ é um arco do grafo com $\fp(v)-\fp(u) > c(u,v)$.  Ademais, 
  se $\fp'(v) \neq \fp(v)$ então $\fp'(v) = \fp(u) + c(u,v) < \fp(v)$.
  
  Do invariante~\iten{dt1} sabe-se que para cada $x$ em $S \cap X$, $y$ em $\L
  \cap X$ e $z$ em $U \cap X$ vale que $d(x) \leq d(y) < d(z) =nC+1$. Assim,
  pela escolha de $X$ e $u$ (e como $c$ é uma função de $A$ em $\NonnegInt$),
  após examinar o vértice~$u$ tem-se que
\[
\fp'(x) \leq \fp(u) \leq \fp'(y) < \fp'(z) = nC + 1
\] 
para cada $x$ em $S' \cap X= (S \cup \{u\}) \cap X$, $y$ em $\L' \cap X$ e $z$ em
$U'\cap X$.

  Seja agora $Y$ um elemento em $\Pcal$ distinto de $X$. 
  Sejam $x$ um vértice em $S' \cap Y = (S \cup \{u\}) \cap Y$, 
        $y$ um vértice em $\L' \cap Y$ e 
        $z$ um vértice em $U' \cap Y$. 
  Se $\fp'(y) = \fp(y)$, então pelo invariante \iten{dt1} vale que 
  \[ \fp'(x) = \fp(x) \leq \fp(y) = \fp'(y) < \fp'(z) = nC + 1. \] 
Suponha  que 
    $\fp'(y) < \fp(y)$ e nesse caso  $\fp'(y) = \fp(u) + c(u,y) \geq \fp(u) +
          \delta$. 
Do invariante~\iten{dt2} sabe-se que $\fp(x) \leq \fp(u) + \delta$ e portanto,
\[
\fp'(x) = \fp(x) \leq \fp(u) + \delta \leq \fp'(y) < \fp'(z) = nC+1.
\]  
O que conclui a demonstração do invariante \iten{dt1}.
\end{provainv}


\begin{provainv}{\iten{dt2}}
  Considere uma iteração em que ocorre o caso~2.  
  É claro que ao final da iteração vale que $\fp'(w) = nC + 1$, para
  cada $w$ em $U'$. Além disso, 
  combinando os invariantes \iten{dk4}, \iten{dk5} e \iten{dk6} que envolvem a
  função predecessor e $\{S,Q,U\}$ e o invariante~\iten{dk12} das folgas
  complementares, obtem-se que 
  \[ \fp'(v) + \delta \leq \fp(v) + \delta \leq (n-1)C + \delta < nC + 1 = \fp'(w),
\] 
para cada $v$ em $\L'$ e $w$ em $U'$. Assim, nos concentraremos em verificar que 
para cada $x$ em $S'$ e $y$ em $\L'$, ao final da iteração, vale que $\fp'(x)
\leq \fp'(y) + \delta$. 

Seja $x$ um vértice em $S'$ e $y$ um vértice em $\L'$.  
Se ao final da iteração, $\fp'(y) = \fp(y)$, então pela escolha de $X$ e $u$ e pelo
invariante~\iten{dt2}
tem-se que 
\[
\fp'(x) = \fp(x) \leq \fp(y) + \delta = \fp'(y) + \delta.
\]

Assim, suponha que, ao final da iteração, vale que $\fp'(y) < \fp(y)$. Portanto, 
$\fp(u) \leq \fp(u) + c(u,y) = \fp'(y) $.  
Do invariante (dt2), tem-se que $\fp(x)  \leq \fp(u) + \delta$. Portanto, 
\[
\fp'(x) = \fp(x) \leq \fp(u) + \delta \leq \fp'(y) + \delta.
\]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ser vale 
% Se $x$ e $y$ estão em
% uma mesma parte de $\Pcal$ então, pelo invariante~\iten{dt1}, não há o que
% demonstrar.  Se $\fp'(y) = \fp(y)$ então, pelo invariante~\iten{dt2}, também
% não há o que demonstrar, já que $\fp'(x) = \fp(x)$.  Assim, pode-se supor que
% $x$ e $y$ estão em partes distintas de $\Pcal$ e que $\fp'(y) \neq \fp(y)$.
% Neste caso, vale que $\fp'(y) = \fp(u) + c(u,y) \geq \fp(u) + \delta$.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pela escolha de $X$ e $u$ tem-se que $\fp(x)  \leq \fp(u) + \delta$. Portanto, 
% \[
% \fp'(x) = \fp(x) \leq \fp(u) + \delta \leq \fp'(y) + \delta.
% \]
\end{provainv}

\begin{provainv}{\iten{dk9}}
  Novamente, considere uma iteração em que ocorre o caso~2.
  Do invariante~\iten{dt1}, obtem-se que no final da iteração vale que $\fp'(x)
  - \fp'(y) \leq 0$ para cada $x$ em $S' \cap Y= (S \cup \{u\}) \cap Y$, 
  $y$ em $\L' \cap Y$, onde $Y$ é um elemento de $\Pcal$. Ademais,
  do invariante \iten{dt2}, sabe-se que $\fp'(x) - \fp'(y) \leq \delta$ para
  cada $x$ em $S' \cap Y$ e $y$ em $\L' \cap Z$, onde $Y$ e $Z$ são elementos
  distintos de $\Pcal$.
  Portanto, como os comprimentos dos arcos são não-negativos e $\Pcal$ é uma
  $\delta$-partição, $\fp'$ respeita
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
% já que $c$ é uma função de $A$ em $\NonnegInt$ e pela escolha de $u$ tem-se
% que $\fp(u) \leq \fp(v)$ para todo $v$ em $\L$. Assim, de (\ref{eq:min}) e do
% invariante \iten{dk7} pode-se concluir que $\fp'$ respeita $c$ em
% $A(\L,S')$. Finalmente, após o vértice 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% No início da iteração tem-se que $\fp$ respeita $c$ em $A[S]$ (invariante
% \iten{dk7}) e em $A(\L,S)$. Desta forma, no final de uma iteração em que ocorre
% o caso~2 cale que $\fp'$ respeita $c$ em $A[S']$, pois $S' = S \cup \{u\}$ e
%$\fp'(v)=\fp(v)$ para todo $v$ em $S'$.
\end{provainv}
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  CORREÇÃO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Correção}
\label{sec:dinitz-thorup-correcao}

A correção do algoritmo de Dinitz-Thorup é facilmente demonstrada através dos
invariantes apresentados. Mais ainda, a demonstração da correção do algoritmo
de Dinitz-Thorup é textualmente a mesma da correção do algoritmo de
 Dijkstra (seção~\ref{sec:dijkstra-correcao}), 
já que este último não utiliza o invariante da monotonicidade~\iten{dk3}.
 
%A seguir é denotado por $U$ a parte
%$V\setminus(S\cup\L)$ de $V$.
 
\begin{teorema}{teorema da correção}
\label{teo:correcao-dinitz}
%O algoritmo de Dijkstra 
%recebe um grafo $(V,A)$, uma função comprimento $c$ de
%$A$ em $\NonnegInt$ e um vértice $s$ e 
Para cada vértice $t$ acessível a
partir de $s$ o algoritmo de Dinitz-Thorup devolve um caminho de $s$ a $t$ que tem
comprimento mínimo.
\end{teorema}
 
\begin{prova}
Textualmente a mesma do teorema~\ref{teo:correcao-dijkstra}.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suponha que  $\pred$ e $\fp$ são as funções devolvidas pelo algoritmo.
% %%%% L = vazio
% Quando o algoritmo pára tem-se que $\L = \emptyset$ e do invariante \iten{dk1}
% vale que $S$ e $U$ é uma partição de $V$.
 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%% S é o conjunto de vértices acessíveis 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ao final do algoritmo, $S$ é o conjunto de vértices acessíveis a partir de $s$.
% De fato, pelo invariante \iten{dk2}
% sabe-se que nenhum vértice de $U$ é acessível a partir de $s$ já que $A(S,U) =
% \emptyset$,  e pelo invariante \iten{dk6} tem-se que para cada vértice $t$ em
% $S$ a função $\pred$ 
% determina uma caminho de $s$ a $t$; já que $\pred$ determina uma arborescência 
% em $(S,A[S])$ com raiz em $s$.

% Como $\L = \emptyset$ e $A(S,U) = \emptyset$, então dos invariantes \iten{dk7}
% a \iten{dk10} concluí-se que a função potencial $\fp$ é viável.

% Resta apenas verificar que cada caminho $P$ de $s$ a um vértice $t$ em $S$
% determinado por $\pred$ é um caminho que tem comprimento mínimo.
% Do invariante \iten{dk12} obtem-se que $c(P) = \fp(t) - \fp(s)$. Finalmente,
% como $\fp$ é viável, pelo condição de otimalidade concluí-se que $P$ tem
% comprimento mínimo.
\end{prova}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  EFICIÊNCIA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Eficiência}
\label{sec:dinitz-thorup-eficiencia}

Como no algoritmo de Dijkstra,  $\fp', \pred', S', \L'$ e $U'$ foram
introduzidos na descrição do algoritmo por meras razões técnicas.
Em termos de eficiência, não há
necessidade de levar em consideração as instruções que inicializam estes
objetos. A descrição pode ser feita inteiramente em
termos de $\fp, \pred, S, \L$ e $U$.


Uma possível implementação do algoritmo de Dinitz-Thorup é a seguinte.
Seja $\Delta := \floor{(nC + 1)/\delta}$.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Seja $\Delta$ o
% menor inteiro tal que $\Delta\delta \geq nC+1$, onde $C := \max\{ c(u,v) \tq
% uv \in A\}$. Para $\delta > 0$ esta definição é equivalente $\Delta :=
% \floor{(nC + 1)/\delta}$.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Os elementos de $\Pcal$ são mantidos em buckets
$B(0),B(1),\ldots,B(\Delta)$. Para cada $i$ em $[0..\Delta-1]$, $B(i)$ contém
os elementos maduros $X$ de $\Pcal$ tais que
\[ i\delta \leq \min\{\fp(v) \tq v \in \L \cap X\} \leq (i+1)\delta -1,\]
ou, equivalentemente, \[i = \floor{  \min\{\fp(v) \tq v \in \L \cap X\}/ \delta }.\] 
O bucket $B(\Delta)$
contém os elementos $X$ de $\Pcal$ tais que $Q \cap X = \emptyset$ e $U \cap X
\neq \emptyset$.  
Desta forma, $Q = \emptyset$ se e somente se $B(i) = \emptyset$ para cada $i$ em
$[0..\Delta-1]$.

Em cada iteração, para escolher um elemento maduro $X$ da
$\delta$-partição $\Pcal$ basta encontrar o menor $k$ em $[0..\Delta-1]$ tal que $B(k)$ é
não-vazio. Devido ao invariante das folgas relaxadas~\iten{dt2}, os elementos
maduros podem ser escolhidos pelo algoritmo a medida que os buckets são visitados na ordem
$B(0),B(1),\ldots,B(\Delta-1)$. As operações principais envolvendo os buckets
são remoções e inserções. Suponha que cada  bucket é
representado através de uma lista ligada. Assim, cada operação de remoção e inserção de
elementos de $\Pcal$ em buckets pode ser realizada, no modelo RAM,  em tempo
constante: para determinar o bucket $B(k)$ que contém um certo elemento $X$ de $\Pcal$ basta
computar $k = \floor{\min\{ \fp(v) \tq v \in  X \setminus S\}/\delta}$.
Portanto, o consumo total de tempo das operações envolvendo os buckets é
proporcional a $n+m+\Delta$. 
Na simulação do algoritmo de Dinitz-Thorup, ilustrada na
figura~\ref{fig:sim_dinitz},  os buckets são representados pelo vetor ao
lado de cada grafo.

\begin{teorema}{consumo de tempo}
\label{teorema:consumo-de-tempo-dinitz}
O algoritmo de Dinitz-Thorup, quando executado, no modelo RAM, em
um grafo com $n$ vértices e $m$ arcos, gasta tempo $O(n+m+\Delta)$ mais o
tempo necessário para manter o vértice com menor potencial em $X \setminus S$,
para cada $X$ na $\delta$-partição, onde $\Delta = \floor{(nC +
1)/\delta}$ e $C$ é o maior comprimento de um arco. \fimprova
\end{teorema}


% Seja $\Delta := \floor{(nC + 1)/\delta}$, onde $C := \max\{ c(u,v) \tq uv \in
% A\}$. Com sugerido por Dinitz, é considerada a implementação envolve a
% partição que mantém os elementos de $\Pcal$ em buckets
% $B(0),B(1),\ldots,B(\Delta)$.  O bucket $B(i)$ contém as partes maduras $X$ de
% $V$ em $\Pcal$ tal que $\floor{\min\{\fp(v) \tq v \in \L \cap X\}/\delta} =
% i.$, para $i=0,1,\ldots,\Delta-1$. O bucket $B(\Delta)$ contém os elementos
% $X$ de $\Pcal$ tal que $X$ não é maduro e $X\setminus S \neq emptyset$.
  

% Uma bjetos, uma função potencial $\fp$, um parte $\L$ de $V$ e mantém ainda as
% partes de $\Pcal$ em buckets $B(0),B(1),\ldots,B(\Delta-1)$ tais que $B(i)$
% contém as partes $X$ tais que $\floor{\min\{\fp(v) \tq v \in \L \cap
%   X\}/\delta} = i.$  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  CWEB
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Versão em \CWEB}
\label{sec:dinitz-thorup-cweb}

@ Conforme visto na seção anterior,
a implementação do algoritmo de Dinitz-Thorup usa os buckets 
$B(0), B(1),\ldots, B(\Delta)$ 
para manter os elementos de uma dada $\delta$-partição $\Pcal$, que neste caso, 
é representada por um grafo |p|, cujos vértices são os elementos de $\Pcal$.
A figura~\ref{fig:rep_particao} mostra a representação de $\Pcal$ interpretada
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
  \caption[{\sf Representação de uma $\delta$-partição na implementação}]
 {\label{fig:rep_particao} Cada elemento $V_{i}$ da $\delta$-partição
    $\Pcal$ é representado por um vértice $p_{i}$ do grafo $p$. Cada
    arco de $p$ tem ponta inicial em algum vértice $p_i$ e ponta
    final em algum vértice do grafo de entrada. Os arcos
    pontilhados são os arcos do grafo de entrada e têm comprimento
    pelo menos~$\delta$.}
\end{center}
\end{figure}
%Para resolver o PCMV o algoritmo de Dinitz-Thorup mantém, entre outros objetos, 
%uma função potencial $\fp$, um parte $\L$ de $V$ e mantém ainda as partes
%de $\Pcal$ em buckets $B(0),B(1),\ldots,B(\Delta)$, onde 
%$\Delta = \floor{(nC + 1)/\delta}$ e $C := \max\{c(u,v) \tq uv \in A\}$.  
%Cada $B(i)$ contém as partes $X$ tais que
%\[\floor{\min\{\fp(v) \tq v \in X \cap \L\}/\delta} = i.\]

@<Variáveis globais@>=
Vertex *B;   /* bucket */

@ A implementação utiliza os seguintes ponteiros para cada vértice: |prox_elemento| e 
|ant_elemento| que mantêm uma lista de elementos da $\delta$-partição $\Pcal$ em cada $B(i)$; o
ponteiro |elemento| indica, para cada vértice de $G$ (grafo de
entrada), a qual elemento de $\Pcal$\footnote{Na implementação um
elemento de $\Pcal$ é um vértice de $p$.} ele pertence; 
|maduro| aponta para os vértices de $G$ que minimizam $\fp$ em
cada elemento de $\Pcal$; e |status| indica se um vértice de $G$ ou
elemento de $\Pcal$ foi examinado ou não.
@<Definições@>=
#define prox_elemento @,@,@,@, s.V  /* próxima elemento da lista */
#define ant_elemento @,@,@,@, t.V   /* elemento anterior da lista */
#define elemento @,@,@,@, y.V       /* aponta para o elemento de $\Pcal$ que contém o vértice */
#define maduro @,@,@,@, x.V     /* próximo vértice que pode ser examinado */
#define status @,@,@,@, z.I
#define B(i) @, (B + i)


@ Conforme as implementações de filas de prioridade 
(capítulo~\ref{cap:implementacao-fila-prioridade}),
na implementação do algoritmo de Dinitz-Thorup também teremos as operações  
\textsf{insert, delete-min} e \textsf{decrease-key} que são representadas pelas 
funções |insert_dinitz|, |delete_min_dinitz| e |decrease_key_dinitz|.

A função |insert_dinitz|,
 insere um elemento |x| de |p| no bucket |B(i)|. 
%lembrando que
%\[i = \floor{\min\{\fp(v) \tq v \in x \cap \L\}/\delta}.\]
O tempo gasto por essa função é $O(1)$.
@<Funções ...@>=
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

@ A função |delete_min_dinitz| remove 
o vértice, que tem o menor potencial, do elemento |x|  
e escolhe o novo vértice cujo potencial é mínimo. Se todos os vértices de |x| 
já foram examinados, |x->status == EXAMINADO|. Caso contrário, |x->maduro| aponta
para o vértice com o menor potencial. O tempo gasto por essa função é $O(^^7cx^^7c)$,
onde $^^7cx^^7c$ é o número de vértices de |x|.
@<Funções ...@>=
Vertex *
delete_min_dinitz(x)
Vertex *x;
{
  register Vertex *u, *v;
  register Arc *a;

  u = x->maduro;
  u->status = EXAMINADO;

  /* Escolhe o novo mínimo de |x| */
  x->dist = infinito;
  x->maduro = NULL;
  for(a = x->arcs; a; a = a->next){ /* percorre os vértices do elemento |x| */
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

@ A função |decrease_key_dinitz| remove, usando a função
|remove_elemento|, e move, caso necessário, 
 um elemento |y| do bucket atual
 para o bucket $B(\floor{\fp(v)/\delta})$, 
onde |v| é um vértice que pertence ao elemento |y|. 
O tempo gasto por essa função é $O(1)$.
@<Funções ...@>=
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
  
  y = v->elemento; /* |y| é o elemento que contém |v| */

  if(v->dist < y->dist){
    j = (long)y->dist/dt;   /* guarda a posição antiga */
    
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
     Graph *p;  /* |p| é a $dt$-partição*/
     Vertex *s;  /* vértice inicial */
     
{@+@<Variáveis de dinitz@>@;

 @<Inicializações de dinitz@>@;

 @<Coloque os elementos de |p| nos buckets $B(0), B(1), \ldots, B(dtg)$@>@;

 for(k = 0; k < dtg; k++){

   while(B(k) != B(k)->prox_elemento){
 
     @<Seja |x| um elemento em |B(k)|@>@;

     @<Escolha |u| em |x| tal que $\fp(u)$ seja mínimo@>@;

     @<Examine vértice |u|@>@;

     @<Verifique se |x| deve mudar de bucket@>@;

   }
 } 
 free(B);
}

@ @<Variáveis de dinitz@>=
register Vertex *v, *u;
register Vertex *x; /* elementos de |p| */
register Arc *a;
register long i, k;
register long dtg = 0; /* $\Delta$ */

@ Inicializa $\fp$ e $\pred$ como no algoritmo de Dijkstra 
(seção~\ref{dijkstra-cweb}). Além disso, o mínimo de cada partição é
inicializado com |infinito|, com exceção da partição que contém o
vértice inicial |s|.
@<Inicializações de dinitz@>=
for(v = g->vertices; v < g->vertices + g->n; v++){
    x = v->elemento;
    x->dist = v->dist = infinito;
    v->pred = v;
    x->status = v->status = NAO_EXAMINADO;
}
s->dist = 0;
(s->elemento)->dist = 0;      /* inicializa o elemento que contém |s| */
(s->elemento)->maduro = s; /* $\fp(s)$ é mínimo no elemento |s->elemento| */ 

@ @<Coloque os elementos de |p| nos buckets $B(0), B(1), \ldots, B(dtg)$@>=
if(dt <= 0){
 printf("%s\n", err_message[ERROR_4]); exit(0);
}
dtg = (long)(infinito/dt) + 1;

if((B = (Vertex *)malloc(dtg*sizeof(Vertex)))== NULL){
  printf("%s\n", err_message[ERROR_2]); exit(0);
}

for(i = 0; i < dtg; i++){
  /* Inicializa cabeças de lista */
  B(i)->ant_elemento = B(i)->prox_elemento = B(i);
}

for(x = p->vertices; x < p->vertices + p->n; x++){
  i = (long)(x->dist/dt); /* posição do bucket em que |x| será inserido */
  insert_dinitz(x,i);   /* insere |x| no bucket |B(i)| */
}

@ @<Seja |x| um elemento em |B(k)|@>=
x = B(k)->prox_elemento;

@ @<Escolha |u| em |x| tal que $\fp(u)$ seja mínimo@>=
u = delete_min_dinitz(x);

@ @<Examine vértice |u|@>=
for(a = u->arcs; a ; a = a->next){
  v = a->tip;
  @<Examine a aresta |uv|@>@;
}

@ Faz $\fp$ respeitar $c$ em $uv$ (seção~\ref{sec:examinar}). 
@<Examine a aresta |uv|@>=
if(v->dist - u->dist > a->len ){/* se a função potencial não é viável */
    v->dist = u->dist + a->len;
    v->pred = u;
    decrease_key_dinitz(v, dt);
}

@ 
@<Verifique se |x| deve mudar de bucket@>=
if(x->status == EXAMINADO) {  /* todos os vértices de |x| já foram examinados */
  remove_elemento(x);  /* remove |x| do bucket atual */
}
else{
  i = (long)x->dist/dt;  /* nova posição do elemento |x| */ 
  if( i > k){
    remove_elemento(x);  /* remove |x| do bucket atual */
    insert_dinitz(x,i); /* insere |x| no bucket |B(i)| */
  }
}
@

\begin{lema}{operações Dinitz-Thorup}
\label{lema:operacoes-dinitz-thorup}
 A implementação de Dinitz-Thorup executa as operações 
|insert_dinitz| e |decrease_key_dinitz| em tempo $O(1)$ e 
|delete_min_dinitz| em tempo $O(n)$. \fimprova
\end{lema}

Portanto, do teorema~\ref{teorema:consumo-de-tempo-dinitz} e do 
lema~\ref{lema:operacoes-dinitz-thorup}, essa implementação do algoritmo de 
Dinitz-Thorup gasta tempo
\[
  \underbrace{O(n)}_{\mbox{\textsf{insert\_dinitz}}} + 
  \underbrace{O(m)}_{\mbox{\textsf{decrease\_key\_dinitz}}} +
  \underbrace{O(n^2)}_{\mbox{\textsf{delete\_min\_dinitz}}} +
  \underbrace{O(\Delta)}_{\mbox{percorrer os buckets}}
  = O(n^2 + m + \Delta).
\]

\begin{teorema}{}
 A implementação do algoritmo de Dinitz-Thorup resolve o
 PCMV em um grafo com $n$ vértices, $m$ arcos e uma $\delta$-partição 
 em tempo $O(n^2 + m + \Delta)$, onde $\Delta = \floor{(nC +
 1)/\delta}$ e $C$ é o maior comprimento de um arco. \fimprova
\end{teorema}
 
% Uma maneira de melhorar o tempo gasto, por essa implementação, do 
%algoritmo de Dinitz-Thorup é fazer um bucketing dos vértices de cada elemento $X$ 
%de $\Pcal$.
%Tomando $\Pcal := \{\{v\} \tq v \in V\}$  e $\delta := \min\{c(u,v) \tq uv \in A\}$, 
%conforme o algoritmo proposto por Dinitz~\cite{dinitz:1978},
%cada elemento $X$ de $\Pcal$ tem cardinalidade $1$. Portanto, o tempo gasto pelo 
%algoritmo de Dinitz-Thorup será $O(n + m + \Delta)$. 
% O algoritmo de Thorup, descrito no próximo capítulo, junta essas duas idéias: 
%procura diminuir o tamanho das elementos de uma $\Pcal$, construindo $\delta$-partições
%menores e ainda fazer bucketing dos vértices da $\delta$-partição, o que torna
%possível escolher, rapidamente, o vértice com  potencial mínimo e ainda limitar
%o número de buckets necessários.
