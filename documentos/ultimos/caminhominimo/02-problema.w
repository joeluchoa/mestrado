%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  CAPÍTULO. CAMINHO MíNIMO 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\chapter{Problema do caminho mínimo}
\label{cap:problema}

Estão descritos neste capítulo os ingredientes básicos que envolvem o
problema do caminho mínimo, tais como função comprimento, função
potencial, função predecessor, critério de otimalidade, etc. A referência
básica para este capítulo é Feofiloff~\cite{pf:aula}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO: Descrição
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Descrição}
\label{sec:problema-descricao}

Uma \defi{função comprimento}\index{funcao@@função!comprimento} %
\index{comprimento!funcao@@função} em
$(V,A)$ é uma função de $A$ em $\NonnegInt$. Se $c$ é uma função
comprimento em $(V,A)$ e $uv$ está em $A$, então, denotaremos por
$c(u,v)$ o valor de $c$ em $uv$. 
Se $(V,A)$ é um grafo simétrico e $c$ é 
uma função comprimento em $(V,A)$, então $c$ é 
\defi{simétrica}\index{funcao@@função!comprimento simétrica} se
$c(u,v) = c(v,u)$ para todo arco $uv$.
%%%% CZAO
O \defi{maior comprimento}\index{maior
  comprimento} de um arco será denotado por $C$\mar{$C$}, ou seja, 
$C = \max\{c(u,v) \tq uv \in A \}$.

%%% Comprimento de um passeio e passei de comprimento minimo.
Se $P$ é um passeio em um grafo $(V,A)$ e $c$ é uma função comprimento, 
denotaremos por $c(P)$ o \defi{comprimento do caminho} $P$%
\index{comprimento!do caminho}, ou seja, $c(P)$ é o somatório dos comprimentos
de todos os arcos em $P$.  Um passeio $P$ tem \defi{comprimento mínimo} se
$c(P) \leq c(P')$ para todo passeio $P'$ que tenha o mesmo início e término
que $P$.  A \defi{distância}\index{distancia@@distância} de um vértice $s$ a um
vértice $t$ é o menor comprimento de um caminho de $s$ a $t$. 
A distância de $s$ a $t$ em relação a $c$ será denotada por 
$\distc{s,t}$\index{$\distc{s,t}$}\mar{$\distc{s,t}$}, ou
simplesmente, quando a função comprimento estiver subentendida, 
 $\dist{s,t}$\index{$\dist{s,t}$}\mar{$\dist{s,t}$} denota a distância
de $s$ a $t$.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  DEFINIÇÃO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
%\section{Definição do problema}

 Nesta dissertação, estamos interessados no seguinte
 \defi{problema do caminho mínimo}:%
 \index{problema!do caminho minimo@@do caminho mínimo}
\begin{quote}
\textbf{Problema} PCM$(V,A,c,s)$:%
\index{PCM}\mar{PCM}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dado um grafo $(V,A)$, uma função
comprimento $c$ e um vértice $s$, encontrar um caminho de 
comprimento mínimo de $s$ até $t$, para cada vértice $t$ em $V$.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Os caminhos de comprimento mínimo serão devolvidos através de:
% \begin{enumerate}
% \item[\iten{1}] uma função potencial viável $\fp{}$ e
% \item[\iten{2}] uma função predecessor $\pred$ 
% \end{enumerate}
% \textbf{satisfazendo:}

%  se $\fp(t) - \fp(s) < nC$

%  \x então $c(P) = \fp(t) - \fp(s)$,

%  onde $P$ é um caminho de $s$ a $t$ determinado por $\pred$.
\end{quote}
Na literatura, essa versão do problema é conhecida como 
 \textit{single-source shortest path problem.}%
\index{single source@@single-source shortest path}

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO: FUNÇÕES POTENCIAL
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
\section{Funções potencial e critério de otimalidade}
\label{sec:criterio-otimalidade}

Os algoritmos para o problema do caminho mínimo descritos nesta dissertação
fornecem certificados de garantia para as suas respostas. Se um vértice $t$ não
é acessível a partir de $s$, um algoritmo pode, para comprovar este fato,
devolver uma parte $S$ de $V$ tal que $s \in S$, $t \not\in S$ e não existe
$uv$ com $u$ em $S$ e $v$ em $V\setminus S$, i.e, $A(S)= \emptyset$. Este
seria um certificado combinatório da não acessibilidade de $t$ por $s$.
Entretanto, os certificados fornecidos pelos algoritmos, baseados em funções
potencial, serão um atestado compacto para certificar ambos, a minimalidade
dos caminhos fornecidos, e a não acessibilidade de alguns vértices por $s$.

 Uma \defi{função potencial}\index{funcao@@função!potencial}%
\index{potencial!funcao@@função} é uma função de $V$ em $\NonnegInt$.
Se $\fp$ é uma função potencial e $c$ é uma função comprimento, 
então dizemos que $\fp$ \defi{respeita}\index{funcao@@função!potencial
respeita}
 $c$ em uma parte $A'$ de $A$ se 
 \begin{center}
   $\fp(v) - \fp(u) \leq c(u,v)$ para cada arco $uv$ em $A'$.
 \end{center}
Se $\fp$ respeita $c$ em $A$ então diz-se que $\fp$ é 
\defi{viável}\index{funcao@@função!potencial viavel@@potencial viável}. 

Funções potencial viáveis fornecem limitantes inferiores para comprimentos de
caminhos. Suponha que $c$ é uma função comprimento em $(V,A)$ e que $P$ é um
caminho de um vértice $s$ a um vértice $t$. Suponha ainda que $\fp$ é uma
função potencial viável. Vale que
\[
c(P) \geq d(t) - d(s).
\]
De fato, suponha que $P$ é o caminho $\seq{s = v_{0}, \alpha_{1}, v_{1}, \ldots,
  \alpha_{k}, v_{k} = t }$. 
Tem-se que
\[
\begin{array}{ccl}
 c(P)& =    & c(\alpha_{1}) + \ldots + c (\alpha_{k})\\
     & \geq & (\fp(v_{1}) - \fp(v_{0})) + (\fp(v_{2}) - \fp(v_{1})) 
              + \ldots + (\fp(v_{k}) - \fp(v_{k-1}))\\
     & =    & \fp(v_{k}) - \fp(v_{0}) = \fp(t) - \fp(s).
\end{array}
\]
Este fato é resumido através do lema a seguir, que 
é uma particularização do conhecido lema da dualidade de 
programação linear~\cite{pf:proglin}.

\begin{lema}{lema da dualidade}\index{lema!da dualidade}\index{dualidade}
 \label{lema:dualidade}
  Seja $(V,A)$ um grafo e $c$ uma função comprimento sobre~$V$. 
Para todo caminho $P$ em $(V,A)$ e toda função potencial 
viável~$\fp$ sobre~$V$, vale que 
\[
\fp(t) - \fp(s) \leq c(P),
\]
 onde $s$ e $t$ são o início e término de P, respectivamente.
\fimprova
\end{lema}

% Se $\fp$ é uma função potencial al que $\fp(s) = 0$, então para cada
% vértice $t$ o valor de $\fp(t)$ pode ser interpretada como uma distância
% tentativa de $s$ a $t$.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A seguir estão dois corolários imediatos do lema da dualidade.
 
% Um conseqüência i
%  \begin{prova}

%  Seja $\fp$ uma função potencial viável sobre $V$ e 

%  $P = \seq{s = v_{0}, \alpha_{1}, v_{1}, \ldots, \alpha_{k}, v_{k} = t }$ 
%  um caminho em $(V,A)$.

%  Tem-se que
% \[
% \begin{array}{ccl}
%  c(P)& =    & c_{\alpha_{1}} + \ldots + c_{\alpha_{k}}\\
%      & \geq & \fp(v_{1}) - \fp(v_{0}) + \fp(v_{2}) - \fp(v_{1}) 
%               + \ldots +\fp(v_{k}) - \fp(v_{k-1})\\
%      & =    & \fp(v_{k}) - \fp(v_{0}) = \fp(t) - \fp(s)
% \end{array}
% \]
% Portanto, $\fp(t) - \fp(s) \leq c(P)$.
% \end{prova}
% \end{lema}

 Do lema~\ref{lema:dualidade} tem-se imediatamente os seguintes corolários.

\begin{corolario}{condição de inacessibilidade}%
\index{condicao de@@condição de!inacessibilidade}\index{inacessibilidade}
\label{corolario:inacessibilidade}
Se $(V,A)$ é um grafo, $c$ é uma função comprimento, $\fp$ é uma função
potencial viável e $s$ e $t$ são vértices tais que 
\[
d(t) - d(s) \geq nC + 1
\]
então $t$ não é acessível a partir de $s$
\fimprova
\end{corolario}


\begin{corolario}{condição de otimalidade}%
\index{condicao de@@condição de!otimalidade}\index{otimalidade}
\label{corolario:otimalidade}
Seja $(V,A)$ um grafo e $c$ é uma função comprimento.
Para toda função potencial viável e todo caminho $P$ em $(V,A)$
de $s$ a $t$, se $\fp(t) - \fp(s) = c(P)$, então $P$ é um 
caminho de comprimento mínimo.
\fimprova
\end{corolario}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO:  FUNÇÃO PREDECESSOR 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
\section{Funções predecessor e representação de caminhos}
\label{sec:predecessor}

Uma maneira compacta de representar caminhos de um dado vértice até cada um dos
demais vértices de um grafo, é através de funções predecessor.
%%% FUNÇÃO PREDECESSOR 
Uma \defi{função predecessor}%
\index{funcao@@função!predecessor}\index{predecessor!funcao@@função} é uma
função de $V$ em $V$.  Se $(V,A)$ é um grafo, $\pred$ uma função
predecessor sobre $V$ e $v_{0}, v_{1}, \ldots,v_{k}$ são vértices
tais que
\begin{enumerate}
\item[$\iten{1}$] $ v_{0} = \pred(v_{1}), v_{2} = \pred(v_{3}),
  \ldots, v_{k-1} = \pred(v_{k})$; e
          
\item[$\iten{2}$] $\alpha_{i} = v_{i-1}v_{i}$ está em $A$ para $i =
  1, \ldots, k$,
\end{enumerate}
então dizemos que $\seq{v_{0}, \alpha_{1}, v_{1}, \ldots, \alpha_{k},
v_{k}}$ é um \defi{caminho determinado por
$\pred$}\index{caminho!determinado por $\pred$}. 

Seja $\pred$ uma função predecessor e $\Psi := \{ uv \in A \tq u =
\pred(v)\}$. É dito que $\psi$ \defi{determina uma
arborescência}\index{arborescencia@@arborescência!determinada por $\pred$}
quando o grafo $(V,\Psi)$ é uma arborescência.

Os algoritmos descritos nesta dissertação utilizam funções predecessor
para, compactamente, representar todos os caminhos de comprimento mínimo a partir
de um dado vértice, conforme ilustrado na figura~\ref{fig:pred}.

\begin{figure}[htbp]
 \begin{center}
    \psfrag{a}{{$a$}}
    \psfrag{b}{{$b$}}
    \psfrag{c}{{$c$}}
    \psfrag{d}{{$d$}}
    \psfrag{e}{{$e$}}   
    \psfrag{f}{{$f$}}
    \psfrag{TABELA}{
       \begin{tabular}{c ^^7c c}
        vértice & $\pred$ \\ \hline
        $a$      & $a$  \\
        $b$      & $a$ \\
        $c$      & $a$ \\
        $d$      & $b$ \\
        $e$      & $b$ \\
        $f$      & $e$ \\
        \end{tabular}
     }
  \includegraphics{fig/pred.eps}
  \caption[{\sf Representação de caminhos através da função predecessor}]
  {\label{fig:pred} Representação de caminhos através da
    função predecessor $\pred$ com vértice inicial $a$. Os
    números próximos aos arcos representam a função comprimento. Os arcos
    em destaque formam uma arborescência. A tabela ao lado mostra
    os valores de $\pred$.}
 \end{center}
 \end{figure}

  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO: EXAMINANDO UM VÉRTICE
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\section{Examinando arcos e vértices}
\label{sec:examinar}

%%%% Blá inicial
Algoritmos para encontrar caminhos mínimos mantém, tipicamente, além de uma
função predecessor, uma função potencial. 
O valor desta função potencial para cada vértice é um limitante superior para
a distância a partir do vértice $s$. 
Esta função é
intuitivamente interpretada como uma \defi{distância
  tentativa}\index{distancia@@distância!tentativa} a  partir de $s$. 

%%% Examinar arco
Seja $\fp$ uma função potencial e $\pred$ uma função predecessor.
Uma operação básica envolvendo as funções $\pred$ e $\fp$ é
\defi{examinar um arco}\index{examinar um/uma!arco}
(\textit{relaxing}~\cite{clrs:introalg-2001},
 \textit{labeling step}~\cite{tarjan:data}). Examinar um arco $uv$ consiste em
 verificar se $\fp$ respeita  $c$ em $uv$ e, caso não respeite, ou
seja, caso 
\[
\fp(v) - \fp(u) > c(u,v) \ \ \mbox{ou, equivalentemente} \ \ 
\fp(v) > \fp(u) + c(u,v),
\]
fazer 
\[
\fp(v) := \fp(u) + c(u,v) \ \ \mbox{e} \ \ \pred(v) := u.
\]
Intuitivamente, ao examinar um arco $uv$ tenta-se encontrar um "atalho"~para
o caminho de $s$ a $v$ determinado por $\pred$, passando por
$uv$.
O passo de examinar $uv$ pode diminuir o valor da distância
tentativa dos vértices $v$  e atualizar o predecessor, também tentativo,
de $v$ no caminho de comprimento mínimo de $s$ a $v$. 
O consumo de tempo para examinar um arco é constante.


%%%% Examinar vértice
Outra operação básica é \defi{examinar um vértice}%
\index{examinar um/uma!vertice@@vértice}. 
Se $u$ é um vértice, examinar $u$ consiste em examinar todos os arcos da forma $uv$. Em
linguagem algorítmica tem-se
\begin{quote}
\textsf{
  Para cada arco $uv$ faça \\
 \x se\ $\fp(v) > \fp(u) + c(u,v)$ \\
 \xx então\ $\fp(v) := \fp(u) + c(u,v)$ e $\pred(v) := u$.
%
%Para cada arco $uv$ tal que $d(v) > d(u) + c(u,v)$ faça \\
%\x $d(v) := d(u) + c(u,v)$ e $\pred(v) := u$. 
}
\end{quote}
O consumo de tempo para examinar um vértice é proporcional ao número de arcos
com ponta inicial no vértice.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SEÇÃO: COMPLEXIDADE 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\section{Complexidade}
\label{sec:complexidade-agm}
O problema do caminho mínimo (PCM), na sua forma mais geral, ou seja, aceitando 
comprimentos negativos, é NP-difícil: o problema do caminho hamiltoniano pode
facilmente ser reduzido a este problema.  

Existem limitantes inferiores bem "fracos"~ para a complexidade do PCM
no modelo compara\-ção-adição.
Spira e Pan~\cite{spira:onfinding} mostraram que, independente do número de
adições, pelo menos $c n^2$ comparações são necessárias para resolver o
problema em um grafo simétrico completo\footnote{Um grafo simétrico 
$(V,A)$ é \defi{completo}\index{grafo!completo}, se $uv$ e $vu$ estão
em $A$ para todo par de
vértices distintos  $u$ e $v$.} com $n$ vértices, onde $c$ é uma constante
positiva. Limitantes para outros problemas relacionados são listados em Pettie
e Ramachandran~\cite{petti:computing}.

Alguns algoritmos para o PCM utilizam como subrotina um algoritmo para o 
\defi{problema da árvore geradora mínima}, %
\index{problema!da arvore geradora minima@@árvore geradora mínima} 
 que consiste em
\begin{quote}
\textbf{Problema} AGM$(V,A,c)$:%
\index{AGM}\mar{AGM}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dado um grafo simétrico $(V,A)$, uma função
comprimento simétrica $c$, encontrar uma árvore geradora de comprimento mínimo.
\end{quote}
O comprimento de uma árvore é a soma dos comprimentos das suas
arestas.

Pettie e Ramachandran~\cite{petti:computing} observaram que, no pior caso,
o tempo necessário para resolver o problema da árvore geradora mínima, no
modelo de comparação, não é 
superior ao tempo necessário para resolver o problema do caminho mínimo no
modelo de comparação-adição. Desta forma, um algoritmo para o problema do
caminho mínimo, pode utilizar uma subrotina que constrói
uma árvore geradora mínima  
sem que isto comprometa o seu desempenho assintótico no pior caso.

No modelo RAM, o problema AGM pode ser resolvido em tempo linear, como
descrito por Fredman e Willard~\cite{fredman:mst}. Assim, um algoritmo
para o PCM, no modelo RAM, pode utilizar, digamos, um algoritmo para o
problema AGM como pré-processamento, sem comprometer a eficiência
teórica do algoritmo. O algoritmo de Thorup, descrito no
capítulo~\ref{cap:thorup}, resolve o problema AGM em seu pré-processamento.

