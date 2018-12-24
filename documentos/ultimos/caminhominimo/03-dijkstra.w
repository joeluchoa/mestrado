\chapter{Algoritmo de Dijkstra}
\label{cap:dijkstra}

Neste capítulo será descrito o celebrado algoritmo de
Dijkstra~\cite{dijkstra59:note} que resolve o problema do caminho mínimo,
apresentado na seção~\ref{sec:problema-descricao}, ou seja:
\begin{quote}
\textbf{Problema} PCM$(V,A,c,s)$:%
\index{PCM}\mar{PCM}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dado um grafo $(V,A)$, uma função comprimento $c$ de $A$ em $\NonnegInt$ e um
vértice $s$, encontrar um caminho de comprimento mínimo de $s$ até $t$, para
cada vértice~$t$ em $V$.
\end{quote}


%Um caminho $P$ tem \defi{comprimento mínimo} se $c(P) \leq c(P')$ para todo
%caminho $P'$ que tenha a mesma origem e término que $P$.

A idéia geral do algoritmo de Dijkstra para resolver o problema é a seguinte.
O algoritmo é iterativo.  No início de cada iteração tem-se dois conjuntos
disjuntos de vértices $S$ e $\L$. O algoritmo conhece caminhos de $s$ a cada
vértice em $S \cup \L$ e para os vértices em $S$ o algoritmo sabe que o caminho
conhecido tem comprimento mínimo. Cada iteração consiste em remover um vértice
apropriado de $\L$, incluí-lo em $S$ e examiná-lo, acrescentando, eventualmente,
novos vértices a~$\L$.

A descrição abaixo segue de perto a feita por Feofiloff~\cite{pf:aula}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  DESCRIÇÃO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Descrição}
\label{sec:dijkstra-descricao}
Para cada vértice $t$, acessível a partir de um dado vértice $s$, o algoritmo
de Dijkstra encontra um caminho de $s$ a $t$ que tem comprimento mínimo.  Da
condição de otimalidade (corolário~\ref{corolario:otimalidade}) tem-se
que, 
para provar que um caminho $P$ de um vértice $s$ a um vértice $t$ tem
comprimento mínimo, basta exibir uma função potencial viável $\fp$ tal que $c(P)
= \fp(t) - \fp(s)$. Por outro lado, a condição de inacessibilidade
(corolário~\ref{corolario:inacessibilidade}) diz que se $\fp$ é uma função
potencial viável com $\fp(t) - \fp(s) = nC + 1$, então $t$ não é acessível a
partir de $s$, onde $n$ é o número de vértices do grafo e $C := \max\{c(u,v)
\tq uv \in A\}$. A correção do algoritmo de Dijkstra
fornecerá a recíproca dessas condições.

\begin{quote}
  \textbf{Algoritmo de Dijkstra}.  Recebe um grafo $(V,A)$, uma função
  comprimento $c$ de $A$ em $\NonnegInt$
  e um vértice $s$ e devolve uma
  função predecessor $\pred$ e uma função potencial $\fp$ que respeita $c$
  tais que, para cada vértice $t$, se $t$ é acessível a partir de $s$, então
  $\pred$ determina um caminho de $s$ a $t$ que tem comprimento $\fp(t) -
  \fp(s)$, caso contrário, $\fp(t)-\fp(s) = nC+1$, 
  onde $C := \max\{ c(u,v) \tq uv \in A\}$ e $n := ^^7cV^^7c$. 
\end{quote}


Cada iteração começa com 
uma função potencial $\fp{}$, 
uma função predecessor $\pred$, 
e partes $S, \L$ e $U$ de $V$.

No início da primeira iteração  
$\fp(s) = 0$ e $\fp(v) = nC + 1$ para cada vértice $v$ distinto de $s$, 
$\pred(v) = v$ para cada vértice $v$,
$S = \emptyset$,
$\L = \{s\}$ e $U = V \setminus \{s\}$.

Cada iteração consiste no seguinte.
\balgor
\item\textbf{Caso 1:} \ $\L = \emptyset$.

  Devolva $\fp{}$ e $\pred$ e pare.

\item \textbf{Caso 2:} \ {$\L \neq \emptyset$.}

  Escolha $u$ em $\L$ tal que $\fp(u)$ seja mínimo.

  $S' := S \cup \{u\}$.

  $\L' := \L \setminus \{u\}$.
 
  $U'  := U$.

  Para cada $v$ em $V$ faça $\fp'(v) := \fp(v)$ e $\pred'(v) := \pred(v)$.

  Para cada arco $uv$ faça 

 \x Se\ $\fp'(v) > \fp(u) + c(u,v)$ então 

 \xx $\fp'(v) := \fp(u) + c(u,v)$, $\pred'(v) := u$ e remova\footnote{É
 possível que $v$ já pertença a $\L'$ e não esteja em $U'$. Nesse caso, estas
 últimas duas instruções são redundantes.} $v$ de $U'$ e acrescente a $\L'$.
 
 Comece nova iteração com $\fp'$, $\pred'$, $S'$, $\L'$ e $U'$  
nos papéis de $\fp{}$, $\pred$, $S$, $\L$ e $U$.
\qed
\ealgor
 
Nas interpretações intuitivas do algoritmo de Dijkstra é comum dizer
que $\fp$ guarda \defi{distâncias tentativas}\index{distancia@@distância!tentativa},
 que $S$ é o conjunto dos vértices
\defi{examinados},\index{vertice@@vértice!examinado} $\L$ é o conjunto dos
vértices \defi{visitados}\index{vertice@@vértice!visitado} e que $U$ é o
conjunto dos vértices
\defi{adormecidos}.\index{vertice@@vértice!adormecido}
A figura~\ref{fig:sim_djk} ilustra o algoritmo de Dijkstra em ação.
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
  \caption[{\sf Simulação do algoritmo de Dijkstra}]
  {\label{fig:sim_djk} Execução do algoritmo de Dijkstra. O vértice
  inicial é $s$. (a) exibe um grafo com comprimento nos arcos. 
  (b) mostra a situação no início da primeira iteração.
Se um arco $(u,v)$ está sombreado, então $\pred(v) = u$.
Os potenciais são os números próximos a cada vértice.  
Os vértices pretos são os de $S$, 
os vértices cinzas são os de $\L$, 
e os vértices brancos estão em $U$.
 (c)-(g) exibem a situação após cada iteração do caso 2.  
 Os valores finais da função potencial $\fp$, 
 e da função predecessor $\pred$, são mostrados em (h).}
 \end{center}
 \end{figure}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  INVARIANTES
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Invariantes}
\label{sec:dijkstra-invariantes}
\index{invariantes do algoritmo de!Dijkstra}

A correção do algoritmo de Dijkstra baseia-se nas demonstrações da validade de
uma série de invariantes, enunciados a seguir. Estes invariantes são afirmações
envolvendo os dados  do problema $V,A,c$ e $s$ e os objetos
$\fp, \pred, S, \L$ e  $U$. As afirmações são
válidas no início de cada iteração do algoritmo e dizem como estes objetos
se relacionam entre si e com os dados do problema.


Os invariantes estão agrupados conforme os objetos envolvidos.
 
\paragraph{Estrutura do grafo.} Os dois invariantes a seguir envolvem somente
as partes $S, \L$ e $U$. A estrutura induzida por estas partições é
ilustrada na figura~\ref{fig:invariantes}(a).
\begin{enumerate}
%%% Estrutura do grafo em relação à partição
\item[(dk1)] (partição) As partes $S, \L$ e $U$ formam uma partição de
  $V$.
 
 
\item[(dk2)] ($A(S,U) = \emptyset$) não existe arco $uv$ com $u$
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
  {\label{fig:invariantes}Ilustração dos invariantes.
    A figura~(a) mostra a estrutura do grafo em relação à partição $S,\L$ e $U$
    de $V$ (invariantes~\iten{dk1} e \iten{dk2}). (b) exibe a relação
    de ordem envolvendo os potenciais dos vértices e as partes $S$, $Q$
    e $U$ (invariante (dk3)). 
    A figura~(c) mostra os arcos
    determinados pela função predecessor $\pred$ (invariantes~\iten{dk4},
    \iten{dk5} e \iten{dk6}). Em (d) os arcos ``pontilhados'' são os que
    desrespeitam $c$, os com o símbolo ``?'' ao lado são os que podem ou não
    respeitar $c$, e o arcos ``cheios'' são os que respeitam $c$ (invariantes
    de \iten{dk7} a \iten{dk11}).}
 \end{center}
 \end{figure}

\paragraph{Função potencial e $\{S,\L,U\}$.} 
O próximo invariante reflete o fato do algoritmo examinar os vértices em ordem
não-decrescente da distância a partir de $s$, ilustrado na
figura~\ref{fig:invariantes}(b).
\begin{enumerate}
\item[$\iten{dk3}$] (monotonicidade) para cada $u$ em $S$, $v$ em $\L$ e
 $w$ em $U$ vale que\footnote{A expressão~``$\fp(u) \leq \fp(v) <
\fp(w) = nC + 1$''~deve ser entendida como uma abreviação. Se algum
dos conjuntos envolvidos é vazio, considere as desigualdades que fazem sentido.}
\[
d(u) \leq d(v) < d(w) = nC + 1.
\]
\end{enumerate}

\paragraph{Função predecessor e $\{S,\L,U\}$.}
A estrutura da função predecessor em cada iteração, descrita pelos invariantes
abaixo, está ilustrada na figura~\ref{fig:invariantes}(c). 

%%% Estrutura de \pred com (S,Q,U)
\begin{enumerate}
\item[$\iten{dk4}$] ($\pred(\L) \subseteq S$) Para cada $u$ em $\L$ vale que 
$\pred(u)$ está em $S$.

\item[$\iten{dk5}$] (identidade) Para cada $u$ em $U$ vale que 
$\pred(u)=u$.

\item[$\iten{dk6}$] (estrutura arbórea de $\pred$) A função $\pred$ restrita
  aos vértices em $S\cup \L$ determina uma arborescência em $(V,A)$ com raiz
  $s$.
\end{enumerate}

\paragraph{Arcos onde a função potencial respeita ou desrespeita $c$.}
Com excessão feita aos arcos com ambas as pontas em $\L$, o algoritmo sabe se
$\fp$ respeita ou `desrespeita' $c$ em cada um dos demais arcos do grafo.
Isto não é nenhuma surpresa, tendo em vista que os vértices em $\L$ tiveram
seus potenciais alterados e os arcos com ambas as pontas em $\L$ ainda não
foram examinados. A situação encontra-se ilustrada na
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
\paragraph{Função potencial e função predecessor}
\begin{enumerate}
\item[$\iten{dk12}$] (folgas complementares) 
para cada arco $uv$ tal que $\pred(v) = u$ vale que 
\[
d(v) - d(u) =  c(u,v).
\]

%\item[\iten{i0}] para cada $u$ em $S$, $\fp(u) - \fp(s) = c(P)$, onde
% $P$ é o caminho de comprimento mínimo de $s$ a $u$ determinado por $\pred$.
%\item[\iten{i1}] para cada $u$ em $S$ e $v$ em $V \backslash S$,
%$\fp(u) \leq \fp(v)$ 
\end{enumerate}

%Supondo-se que as afirmações acima valem no início da última iteração é fácil
%demosntrar a correção do algoritmo. 

 
%%%% DEMONSTRAÇÕES


 Para demonstrar que as afirmações acima são legítimos invariantes
%que cada uma destas vale no início de cada iteração 
deve-se  demonstrar que:
\begin{enumerate}
\item[(a)] as afirmações  valem no início da primeira iteração; e
\item[(b)] se as afirmações valem no início de uma iteração em que  
ocorre o caso~2, então as afirmações também valem ao final da iteração
com $\fp', \pred', S', \L'$ e $U'$
nos papéis de $\fp, \pred, S, \L$ e $U$.
\end{enumerate}
De (a) e (b) conclui-se que as afirmações também valem no início da última
iteração; quando ocorre o caso~1. Supondo-se, é claro, que mais cedo
ou mais tarde o caso~1 sempre ocorre.
 
É evidente que cada uma das afirmações valem no início da primeira iteração e
não é difícil verificar~(b) para cada umas das afirmações. A seguir estão as
demonstrações de \iten{dk1}, \iten{dk2}, \iten{dk3}, \iten{dk7} e \iten{dk9} a
título de ilustração.  Nas demonstrações, são feitas referências ao
procedimento de examinar um vértice ou arco como descrito na
seção~\ref{sec:examinar}.
 
\begin{provainv}{\iten{dk1}}
  Considere uma iteração em que ocorre o caso~2.  No início da iteração, $\{S,
  \L, U\}$ é uma partição de $V$. Portanto, antes do algoritmo examinar o
  vértice $u$ tem-se que $\{S', \L', U'\}$ é uma partição de $V$, já que $S' =
  S \setminus \{u\}$, $\L' = \L \cup \{u\}$, e $U' = U$. Durante o exame de cada
  arco, os vértices eventualmente removidos de $U'$ são a seguir inseridos em
  $\L'$. Logo, no final da iteração, $\{S', \L', U'\}$ forma uma partição de~$V$.
\end{provainv}
 
\begin{provainv}{\iten{dk2}}
  Considere uma iteração em que ocorre o caso~2.  No início da iteração tem-se
  que $A(S,U) = \emptyset$. Imediatamente antes do vértice $u$ ser examinado
  vale que $S' = S \cup \{u\}$ e $U' = U$. Do invariante~\iten{dk11}
  sabe-se que, 
  para cada arco $uv$ com $u$ em $S'$ e $v$ em $U'$, 
\[
d(v) - d(u) > c(u,v).
\]    
Assim, cada arco $uv$ com $v$ em $U'$ será, durante o exame do arco $uv$,
removido de $U'$ e acrescentado a $\L'$. Portanto, no final da iteração, tem-se
que $A(S',U') = \emptyset$.
\end{provainv}

É importante notar que na demonstração de \iten{dk3} e \iten{dk9}
que é utilizada a
escolha apropriada do vértice $u$: $\fp(u) \leq \fp(v)$ para cada $v$ em $\L$.
 
\begin{provainv}{\iten{dk3}}
  Considere uma iteração em que ocorre o caso~2.  Note que ao final da
  iteração tem-se que $\fp'(v) \neq \fp(v)$ se e somente se $v$ está em $\L'
  \subseteq (\L \setminus \{u\}) \cup U$ e $uv$ é um arco do grafo com
  $\fp(v)-\fp(u) > c(u,v)$. Ademais,  
  se $\fp'(v) \neq \fp(v)$ então $\fp'(v) = \fp(u) + c(u,v) < \fp(v)$.
  
  Do invariante~\iten{dk3} sabe-se que para cada $x$ em $S$, $y$ em $\L$ e $z$
  em $U$ vale que $d(x) \leq d(y) < d(z) = nC+1$. Assim, pela escolha de $u$ (e como
  $c$ é uma função de $A$ em $\NonnegInt$), após examinar o vértice~$u$ tem-se que 
\[
\fp'(x)  \leq \fp (u) \leq \fp'(y) < \fp'(z) = nC + 1
\] 
para cada $x$ em $S'= S \cup \{u\}$, $y$ em $\L'$ e $z$ em $U'$.
\end{provainv}

\begin{provainv}{\iten{dk7}}
  No início da iteração tem-se que $\fp$ respeita $c$ em $A[S]$ (invariante
  \iten{dk7}), em $A(S,Q)$, e em $A(\L,S)$. Desta forma, no final de
  uma iteração em que
  ocorre o caso~2 vale que $\fp'$ respeita $c$ em $A[S']$, pois $S' = S \cup
  \{u\}$ e $\fp'(v)=\fp(v)$ para todo $v$ em $S'$.
\end{provainv}
 
\begin{provainv}{\iten{dk9}}
  Novamente, considere uma iteração em que ocorre o caso~2.  Da demonstração
  do invariante~\iten{dk3}, obtem-se que no final da iteração vale que $\fp'(x)
  - \fp'(y) \leq 0$ para cada $x$ em $S'= S \cup \{u\}$, $y$ em $\L'$.
  Portanto, como os comprimentos dos arcos são não-negativos, $\fp'$ respeita
  $c$ em $A(\L',S')$.
  
  O processo de examinar $u$ faz com que $\fp'$ respeite $c$ em cada arco com
  ponta inicial em $u$. Do invariante~\iten{dk9} sabe-se que $\fp$ respeita
  $c$ em $A(S,\L)$.  Assim, como $\fp'(v) = \fp(v)$ para cada $v$ em $S'$ e 
  $\fp'(v) \leq \fp(v)$ para cada $v$ em $\L'$,
  concluí-se que $\fp'$ respeita $c$ em $A(S',\L')$.

% \begin{eqnarray}
% \label{eq:min}
% \fp'(u) - \fp'(v) = \fp(u) - \fp(v) \leq c(v,u),
% \end{eqnarray}
% já que $c$ é uma função de $A$ em $\NonnegInt$ e pela escolha de $u$ tem-se
% que $\fp(u) \leq \fp(v)$ para todo $v$ em $\L$. Assim, de (\ref{eq:min}) e do
% invariante \iten{dk7} pode-se concluir que $\fp'$ respeita $c$ em
% $A(\L,S')$. Finalmente, após o vértice 

% No início da iteração tem-se que $\fp$ respeita $c$ em $A[S]$ (invariante
% \iten{dk7}) e em $A(\L,S)$. Desta forma, no final de uma iteração em que ocorre
% o caso~2 cale que $\fp'$ respeita $c$ em $A[S']$, pois $S' = S \cup \{u\}$ e
%$\fp'(v)=\fp(v)$ para todo $v$ em $S'$.
\end{provainv}
 

 

%Suponha agora que os invariantes valem no início de uma iteração em que ocorre o
%caso 2.

%DEMONSTRAÇÃO DE \iten{i0}: No início dessa iteração, sabemos que para cada $w$ em $S$ vale que  
%$\fp(w) - \fp(s) = c(P')$, onde $P'$ é o caminho de $s$ a $w$. 
%Seja $u$ o vértice com menor potencial escolhido durante
%a execução do caso 2. Em particular, para algum $w$ em $S$, $wu$ é um
%arco em $A$, pois $u$ está em $\L$.
%Logo, existe um caminho $P$ de $s$ a $u$, e pelo Lema~\ref{lema:dualidade}
%vale que $\fp(u) - \fp(s) \leq c(P)$. Suponha que existe $u'$ em $V
%\backslash S$
%tal que $\fp(u') - \fp(s) < c(P)$. 
%Então, $\fp(u') \leq \fp(u)$ contrariando a hipótese de que $\fp(u)$ é mínimo.
%Portanto, $\fp(u) - \fp(s) = c(P)$. E pelo
%Corolário~\ref{corolario:otimalidade},
%$P$ é um caminho de comprimento mínimo de $s$ a $u$.

%No final da iteração, vamos ter $u$ pertencente a $S'$. Assim que, $S'$ passar a
%valer $S$, o resultado segue. \fimprova

%DEMONSTRAÇÃO DE \iten{i1}: No final dessa iteração vamos ter $u$ pertencente a $S'$,
%e $\fp(u) \leq \fp'(v)$ para cada $v$ em $V \backslash S'$, pois $\fp(u)$ é
%mínimo. Então, $\fp'$ e $S'$ passam a valer $\fp$ e $S$. Como
%desejado. \fimprova


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  CORREÇÃO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Correção}
\label{sec:dijkstra-correcao}

A correção do algoritmo de Dijkstra é facilmente demonstrada através dos
invariantes apresentados.  
 
%A seguir é denotado por $U$ a parte
%$V\setminus(S\cup\L)$ de $V$.
 
\begin{teorema}{teorema da correção}
\label{teo:correcao-dijkstra}
%O algoritmo de Dijkstra 
%recebe um grafo $(V,A)$, uma função comprimento $c$ de
%$A$ em $\NonnegInt$ e um vértice $s$ e 
Para cada vértice $t$ acessível a
partir de $s$ o algoritmo de Dijkstra devolve um caminho de $s$ a $t$ que tem
comprimento mínimo.
\end{teorema}
 
\begin{prova}
Suponha que  $\pred$ e $\fp$ são as funções devolvidas pelo algoritmo.
%%%% L = vazio
Quando o algoritmo pára tem-se que $\L = \emptyset$ e do invariante \iten{dk1}
vale que $S$ e $U$ é uma partição de $V$.
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% S é o conjunto de vértices acessíveis 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ao final do algoritmo, $S$ é o conjunto de vértices acessíveis a partir de $s$.
De fato, pelo invariante \iten{dk2}
sabe-se que nenhum vértice de $U$ é acessível a partir de $s$, já que $A(S,U) =
\emptyset$,  e pelo invariante~\iten{dk6} tem-se que para cada vértice $t$ em
$S$ a função $\pred$ 
determina um caminho de $s$ a $t$, já que $\pred$ determina uma arborescência 
em $(S,A[S])$ com raiz em $s$.

Como $\L = \emptyset$ e $A(S,U) = \emptyset$, então dos invariantes \iten{dk7}
a \iten{dk10} conclui-se que a função potencial $\fp$ é viável.

Resta apenas verificar que cada caminho $P$ com início em $s$, e 
determinado por $\pred$, tem comprimento mínimo. Suponha que $t$ em
$S$ é o término de $P$. 
Do invariante \iten{dk12} obtem-se que $c(P) = \fp(t) - \fp(s)$. Finalmente,
como $\fp$ é viável, pela condição de otimalidade conclui-se que $P$ tem
comprimento mínimo.
\end{prova}

Um corolário importante da correção do algoritmo é a seguinte especialização
do teorema da dualidade de programação linear ao PCM.

\begin{teorema}{teorema da dualidade}
\label{teorema:dualidade}
Seja $(V,A)$ um grafo, $c$ uma função comprimento de $A$ em $\NonnegInt$ e $s$
e $t$ vértices do grafo. 
Se $t$ é acessível a partir de $s$, então vale que
\[
\min \{c(P) \tq \mbox{$P$ é um caminho de $s$ a $t$}\} = \max \{\fp(t) - \fp(s)
  \tq \mbox{$\fp$ é uma função potencial viável} \}. 
\]
\end{teorema} 

\begin{prova}
  Do lema da dualidade~\ref{lema:dualidade} tem-se que para todo caminho $P'$
  e toda função potencial viável $\fp'$ vale que $c(P') \geq \fp'(t) -
  \fp'(s)$.  O algoritmo de Dijkstra devolve um caminho $P$ e uma função
  potencial viável $\fp$ tal que $c(P) = \fp(t) - \fp(s)$. Logo, $P$ é um
  caminho que tem comprimento mínimo e $\fp$ é uma função potencial viável
  para a qual a diferença de potencial entre $s$ e $t$ é máxima.
\end{prova}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  EFICIÊNCIA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Eficiência}
\label{sec:dijkstra-eficiencia}
 
% \textbf{Número de iterações.}

Primeiro, é conveniente notar que $\fp', \pred', S', \L'$ e $U'$ foram
introduzidos na descrição do algoritmo por meras razões técnicas: ajudam nas
demonstrações de invariantes. Desta forma, em termos de eficiência, não há
necessidade de levar em consideração as instruções que inicializam estes
objetos, já que estas podem ser simplesmente eliminadas da descrição.
A descrição pode ser feita inteiramente em
termos de $\fp, \pred, S, \L$ e $U$.

O número de ocorrências do caso 2 é no máximo $n$, pois em cada ocorrência é
acrescentado um novo vértice a $S$ e $\{S,\L,U\}$ é uma partição de $V$.
Portanto, o número de iterações é no máximo
$n+1$.


%\textbf{Eficiência no pior caso.} 
 
As duas seguintes operações são as principais responsáveis pelo consumo de
  tempo assintótico do algoritmo:
  \begin{description}
  \item{Escolha de um vértice com potencial mínimo.}  Cada
  execução desta operação gasta tempo $O(n)$.  Como o número de ocorrências do
  caso~2 é no máximo $n$, então o tempo total gasto 
   pelo algoritmo para realizar essa operação é $O(n^{2})$.

  \item{Atualização do potencial.} Ao examinar um arco o algoritmo
  eventualmente diminui o potencial da ponta final. Essa atualização de
  potencial é realizada não mais que $^^7c A(u)^^7c$ vezes ao examinar
  o vértice $u$. 
%
%\footnote{conjunto do arcos com ponta inicial em $u$} vezes para  cada
%  vértice $u$ em $V$. 
  Ao todo, o algoritmo pode realizar essa operação não mais que 
  $\sum_{u \in V} ^^7c A(u) ^^7c = m$ 
  vezes. Desde que cada atualização seja feita em tempo constante, o algoritmo
  requer uma quantidade de tempo proporcional a $m$ para atualizar potenciais.
\end{description}

Assim, o consumo de tempo do algoritmo no pior caso é $O(n^{2} + m) = O(n^{2})$.
O teorema abaixo resume a discussão.

\begin{teorema}{consumo de tempo}
\label{teorema:consumo-de-tempo}
O algoritmo de Dijkstra, quando executado, no modelo de comparação-adição, em
um grafo com $n$ vértices e $m$ arcos, gasta tempo $O(n^2)$. \fimprova
\end{teorema}
 
Para grafos densos, ou seja, grafos onde $m = \Omega(n^{2})$, o consumo de
tempo de $O(n^{2})$ do algoritmo de Dijkstra é ótimo, pois, é
necessário que todos os arcos do grafo sejam examinados. Entretanto, se $m =
O(n^{2-\epsilon})$ para algum $\epsilon$ positivo, existem métodos
sofisticados, como o heap de Johnson~\cite{johnson:heap}, o fibonacci
heap de Fredman e Tarjan~\cite{FredTarjan:Fibonacci}, que permitem
diminuir o tempo gasto para encontrar um vértice com 
potencial mínimo, gerando assim implementações que consomem menos tempo para
resolver o problema.
   
A maneira mais utilizada para realizar as operações acima é através de
implementações de filas de prioridade, que será objeto de estudo do
próximo capítulo.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  COMPLEXIDADE DO ALGORITMO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Complexidade}
\label{sec:complexidade-dijk}

Fredman e Tarjan~\cite{FredTarjan:Fibonacci} observaram que como o algoritmo
de Dijkstra examina os vértices em ordem de distância a partir de $s$
(invariante~\iten{dk3}) então o algoritmo está, implicitamente, ordenando estes
valores (ver figura~\ref{fig:liminferior}). Assim, qualquer 
implementação do algoritmo de Dijkstra para o modelo de comparação-adição realiza,
 no pior caso, $\Omega(n \log n)$ comparações. Portanto,
qualquer implementação do algoritmo para o modelo de comparação-adição faz
$\Omega(m + n \log n)$ operações elementares. 

\begin{teorema}{limitante inferior}
\label{teorema:limitante-inferior}
No modelo de comparação-adição, o algoritmo de Dijkstra, quando
executado em um 
grafo com $n$ vértices e $m$ arcos, gasta tempo $\Omega(m + n \log
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
    \psfrag{sequencia ordenada}{{seqüência ordenada}}
  \includegraphics{fig/liminferior.eps}
  \caption[{\sf Algoritmo de Dijsktra ordenando uma seqüência}]
  {\label{fig:liminferior} Esquema ilustrando como o algoritmo de
  Dijkstra pode ser utilizado para ordenar uma seqüência de números $\alpha_1,\ldots,\alpha_n$.}
 \end{center}
 \end{figure}
 
 Por outro lado, Thorup~\cite{thorup:ram-2000} mostrou que 
 um algoritmo linear para ordenação pode ser usado em uma
 implementação do algoritmo de Dijkstra que executa um número de operações
 proporcional ao tamanho do grafo.
 
No próximo capítulo será mostrada a implementação de Fredman e
Tarjan~\cite{FredTarjan:Fibonacci} para modelo de comparação-adição que gasta
tempo $O(m + n \log n)$. O algoritmo de Dijkstra com essa
implementação é ótimo.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  Versão CWEB
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Versão em \CWEB}
\label{dijkstra-cweb}

@ Das partes $S$, $\L$ e $U$ descritas na
seção~\ref{sec:dijkstra-descricao}, as partes $S$ e $U$ não entram na
implementação. E a parte $\L$ é representada através de uma fila de
prioridade (seção~\ref{sec:filadeprioridade}).\\
Para criar $\L$ é utilizada a operação \textsf{create\_pq}, e as
operações de $\L$ serão representadas pelas funções \textsf{insert},
\textsf{delete\_min} e \textsf{decrease\_key}. 

@<Filas de prioridade@>=
void  @[@] (*create_pq)();  /* cria $\L$ */
void  @[@] (*insert)();
Vertex *(*delete_min)();
void  @[@] (*decrease_key)();

@ Os itens armazenados em $\L$ são vértices, e como valor associado a
cada um deles, temos o potencial.
 O potencial em cada vértice será representado pelo campo |dist|, e o  
predecessor pelo campo |pred|. 

@<Definições@>=
#define dist @,@,@,@, v.I
#define pred @,@,@,@, u.V

@ Será armazenado na variável |qsize|, o número de vértices em $\L$.
@<Variáveis globais@>=
unsigned long qsize;

@ 
@<Algoritmo de Dijkstra@>=
void 
dijkstra(g, s)
   Graph *g;
   Vertex *s; /* vértice inicial */
{@+@<Variáveis de Dijkstra@>@;
 
 @<Inicializa $\fp$ e $\pred$@>@;
 
 @<Inicializa a fila $\L$ com |s|@>@;
    
 while(@<Fila $\L$ não está vazia@>){@;

   @<Escolha |u| em $\L$ tal que $\fp(u)$ seja mínimo@>@;
     
   @<Examine o vértice |u|@>@;
  
 }

}

@ @<Variáveis de Dijkstra@>=
register Vertex *v, *u;
register Arc *a;

@  No início da primeira iteração tem-se que 
$\fp(s) = 0$ e $\fp(v) = nC + 1$ para cada vértice $v$ distinto de $s$, 
$\pred(v) = v$ para cada vértice $v$. Na implementação, $nC + 1$ será
representado pela variável |infinito|.
  
@<Inicializa $\fp$ e $\pred$@>=
for(v = g->vertices; v < g->vertices + g->n; v++){
  v->dist = infinito;
  v->pred = v;
}
s->dist = 0;
num_exam = 0;
atualiza_fp = 0;

@ Cria $\L$ e a inicializa com o vértice inicial $s$.
@<Inicializa a fila $\L$ com |s|@>=
create_pq(g); qsize = 0;
insert(s);  
qsize++;

@ @<Fila $\L$ não está vazia@>=
 ( qsize > 0)

@ @<Escolha |u| em $\L$ tal que $\fp(u)$ seja mínimo@>=
 u = delete_min();
 qsize--;

@ Examina todos os arcos da forma $uv$ (seção~\ref{sec:examinar}). 
@<Examine o vértice |u|@>=
for(a = u->arcs; a ; a = a->next){
  v = a->tip;
  @<Examine o arco |uv|@>@;
}
num_exam++;

@ Faz $\fp$ respeitar $c$ em $uv$ (seção~\ref{sec:examinar}). 
@<Examine o arco |uv|@>=
if(v->dist - u->dist > a->len ){/* se a função potencial não é viável */
    atualiza_fp++;
    if (v->dist == infinito){ /* $v$ não está na fila */    
      v->dist = u->dist + a->len;
      v->pred = u;
      insert(v); qsize++;
    }
    else{ /* $v$ já estava na fila */
      v->dist = u->dist + a->len;
      v->pred = u;
      decrease_key(v);
    }
  }
@ 


O teorema a seguir resume o número de operações feitas pela
implementação acima, para  manipular a fila de
prioridades $\L$.
\begin{teorema}{número de operações}
\label{teorema:no-operacoes}
O algoritmo de Dijkstra, quando executado em um grafo com $n$ vértices e 
$m$ arcos, realiza uma seqüência de $n$ operações \textsf{insert}, $n$ 
operações \textsf{delete-min}
e no máximo $m$ operações \textsf{decrease-key}. \fimprova
\end{teorema}

 Diferentes maneiras de se implementar as funções \textsf{insert},
\textsf{delete\_min} e \textsf{decrease\_key} serão estudadas no
próximo capítulo.




