%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  CAP�TULO. CAMINHO M�NIMO 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\chapter{Problema do caminho m�nimo}
\label{cap:problema}

Est�o descritos neste cap�tulo os ingredientes b�sicos que envolvem o
problema do caminho m�nimo, tais como fun��o comprimento, fun��o
potencial, fun��o predecessor, crit�rio de otimalidade, etc. A refer�ncia
b�sica para este cap�tulo � Feofiloff~\cite{pf:aula}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O: Descri��o
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\section{Descri��o}
\label{sec:problema-descricao}

Uma \defi{fun��o comprimento}\index{funcao@@fun��o!comprimento} %
\index{comprimento!funcao@@fun��o} em
$(V,A)$ � uma fun��o de $A$ em $\NonnegInt$. Se $c$ � uma fun��o
comprimento em $(V,A)$ e $uv$ est� em $A$, ent�o, denotaremos por
$c(u,v)$ o valor de $c$ em $uv$. 
Se $(V,A)$ � um grafo sim�trico e $c$ � 
uma fun��o comprimento em $(V,A)$, ent�o $c$ � 
\defi{sim�trica}\index{funcao@@fun��o!comprimento sim�trica} se
$c(u,v) = c(v,u)$ para todo arco $uv$.
%%%% CZAO
O \defi{maior comprimento}\index{maior
  comprimento} de um arco ser� denotado por $C$\mar{$C$}, ou seja, 
$C = \max\{c(u,v) \tq uv \in A \}$.

%%% Comprimento de um passeio e passei de comprimento minimo.
Se $P$ � um passeio em um grafo $(V,A)$ e $c$ � uma fun��o comprimento, 
denotaremos por $c(P)$ o \defi{comprimento do caminho} $P$%
\index{comprimento!do caminho}, ou seja, $c(P)$ � o somat�rio dos comprimentos
de todos os arcos em $P$.  Um passeio $P$ tem \defi{comprimento m�nimo} se
$c(P) \leq c(P')$ para todo passeio $P'$ que tenha o mesmo in�cio e t�rmino
que $P$.  A \defi{dist�ncia}\index{distancia@@dist�ncia} de um v�rtice $s$ a um
v�rtice $t$ � o menor comprimento de um caminho de $s$ a $t$. 
A dist�ncia de $s$ a $t$ em rela��o a $c$ ser� denotada por 
$\distc{s,t}$\index{$\distc{s,t}$}\mar{$\distc{s,t}$}, ou
simplesmente, quando a fun��o comprimento estiver subentendida, 
 $\dist{s,t}$\index{$\dist{s,t}$}\mar{$\dist{s,t}$} denota a dist�ncia
de $s$ a $t$.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  DEFINI��O
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
%\section{Defini��o do problema}

 Nesta disserta��o, estamos interessados no seguinte
 \defi{problema do caminho m�nimo}:%
 \index{problema!do caminho minimo@@do caminho m�nimo}
\begin{quote}
\textbf{Problema} PCM$(V,A,c,s)$:%
\index{PCM}\mar{PCM}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dado um grafo $(V,A)$, uma fun��o
comprimento $c$ e um v�rtice $s$, encontrar um caminho de 
comprimento m�nimo de $s$ at� $t$, para cada v�rtice $t$ em $V$.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Os caminhos de comprimento m�nimo ser�o devolvidos atrav�s de:
% \begin{enumerate}
% \item[\iten{1}] uma fun��o potencial vi�vel $\fp{}$ e
% \item[\iten{2}] uma fun��o predecessor $\pred$ 
% \end{enumerate}
% \textbf{satisfazendo:}

%  se $\fp(t) - \fp(s) < nC$

%  \x ent�o $c(P) = \fp(t) - \fp(s)$,

%  onde $P$ � um caminho de $s$ a $t$ determinado por $\pred$.
\end{quote}
Na literatura, essa vers�o do problema � conhecida como 
 \textit{single-source shortest path problem.}%
\index{single source@@single-source shortest path}

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O: FUN��ES POTENCIAL
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
\section{Fun��es potencial e crit�rio de otimalidade}
\label{sec:criterio-otimalidade}

Os algoritmos para o problema do caminho m�nimo descritos nesta disserta��o
fornecem certificados de garantia para as suas respostas. Se um v�rtice $t$ n�o
� acess�vel a partir de $s$, um algoritmo pode, para comprovar este fato,
devolver uma parte $S$ de $V$ tal que $s \in S$, $t \not\in S$ e n�o existe
$uv$ com $u$ em $S$ e $v$ em $V\setminus S$, i.e, $A(S)= \emptyset$. Este
seria um certificado combinat�rio da n�o acessibilidade de $t$ por $s$.
Entretanto, os certificados fornecidos pelos algoritmos, baseados em fun��es
potencial, ser�o um atestado compacto para certificar ambos, a minimalidade
dos caminhos fornecidos, e a n�o acessibilidade de alguns v�rtices por $s$.

 Uma \defi{fun��o potencial}\index{funcao@@fun��o!potencial}%
\index{potencial!funcao@@fun��o} � uma fun��o de $V$ em $\NonnegInt$.
Se $\fp$ � uma fun��o potencial e $c$ � uma fun��o comprimento, 
ent�o dizemos que $\fp$ \defi{respeita}\index{funcao@@fun��o!potencial
respeita}
 $c$ em uma parte $A'$ de $A$ se 
 \begin{center}
   $\fp(v) - \fp(u) \leq c(u,v)$ para cada arco $uv$ em $A'$.
 \end{center}
Se $\fp$ respeita $c$ em $A$ ent�o diz-se que $\fp$ � 
\defi{vi�vel}\index{funcao@@fun��o!potencial viavel@@potencial vi�vel}. 

Fun��es potencial vi�veis fornecem limitantes inferiores para comprimentos de
caminhos. Suponha que $c$ � uma fun��o comprimento em $(V,A)$ e que $P$ � um
caminho de um v�rtice $s$ a um v�rtice $t$. Suponha ainda que $\fp$ � uma
fun��o potencial vi�vel. Vale que
\[
c(P) \geq d(t) - d(s).
\]
De fato, suponha que $P$ � o caminho $\seq{s = v_{0}, \alpha_{1}, v_{1}, \ldots,
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
Este fato � resumido atrav�s do lema a seguir, que 
� uma particulariza��o do conhecido lema da dualidade de 
programa��o linear~\cite{pf:proglin}.

\begin{lema}{lema da dualidade}\index{lema!da dualidade}\index{dualidade}
 \label{lema:dualidade}
  Seja $(V,A)$ um grafo e $c$ uma fun��o comprimento sobre~$V$. 
Para todo caminho $P$ em $(V,A)$ e toda fun��o potencial 
vi�vel~$\fp$ sobre~$V$, vale que 
\[
\fp(t) - \fp(s) \leq c(P),
\]
 onde $s$ e $t$ s�o o in�cio e t�rmino de P, respectivamente.
\fimprova
\end{lema}

% Se $\fp$ � uma fun��o potencial al que $\fp(s) = 0$, ent�o para cada
% v�rtice $t$ o valor de $\fp(t)$ pode ser interpretada como uma dist�ncia
% tentativa de $s$ a $t$.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A seguir est�o dois corol�rios imediatos do lema da dualidade.
 
% Um conseq��ncia i
%  \begin{prova}

%  Seja $\fp$ uma fun��o potencial vi�vel sobre $V$ e 

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

 Do lema~\ref{lema:dualidade} tem-se imediatamente os seguintes corol�rios.

\begin{corolario}{condi��o de inacessibilidade}%
\index{condicao de@@condi��o de!inacessibilidade}\index{inacessibilidade}
\label{corolario:inacessibilidade}
Se $(V,A)$ � um grafo, $c$ � uma fun��o comprimento, $\fp$ � uma fun��o
potencial vi�vel e $s$ e $t$ s�o v�rtices tais que 
\[
d(t) - d(s) \geq nC + 1
\]
ent�o $t$ n�o � acess�vel a partir de $s$
\fimprova
\end{corolario}


\begin{corolario}{condi��o de otimalidade}%
\index{condicao de@@condi��o de!otimalidade}\index{otimalidade}
\label{corolario:otimalidade}
Seja $(V,A)$ um grafo e $c$ � uma fun��o comprimento.
Para toda fun��o potencial vi�vel e todo caminho $P$ em $(V,A)$
de $s$ a $t$, se $\fp(t) - \fp(s) = c(P)$, ent�o $P$ � um 
caminho de comprimento m�nimo.
\fimprova
\end{corolario}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O:  FUN��O PREDECESSOR 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
\section{Fun��es predecessor e representa��o de caminhos}
\label{sec:predecessor}

Uma maneira compacta de representar caminhos de um dado v�rtice at� cada um dos
demais v�rtices de um grafo, � atrav�s de fun��es predecessor.
%%% FUN��O PREDECESSOR 
Uma \defi{fun��o predecessor}%
\index{funcao@@fun��o!predecessor}\index{predecessor!funcao@@fun��o} � uma
fun��o de $V$ em $V$.  Se $(V,A)$ � um grafo, $\pred$ uma fun��o
predecessor sobre $V$ e $v_{0}, v_{1}, \ldots,v_{k}$ s�o v�rtices
tais que
\begin{enumerate}
\item[$\iten{1}$] $ v_{0} = \pred(v_{1}), v_{2} = \pred(v_{3}),
  \ldots, v_{k-1} = \pred(v_{k})$; e
          
\item[$\iten{2}$] $\alpha_{i} = v_{i-1}v_{i}$ est� em $A$ para $i =
  1, \ldots, k$,
\end{enumerate}
ent�o dizemos que $\seq{v_{0}, \alpha_{1}, v_{1}, \ldots, \alpha_{k},
v_{k}}$ � um \defi{caminho determinado por
$\pred$}\index{caminho!determinado por $\pred$}. 

Seja $\pred$ uma fun��o predecessor e $\Psi := \{ uv \in A \tq u =
\pred(v)\}$. � dito que $\psi$ \defi{determina uma
arboresc�ncia}\index{arborescencia@@arboresc�ncia!determinada por $\pred$}
quando o grafo $(V,\Psi)$ � uma arboresc�ncia.

Os algoritmos descritos nesta disserta��o utilizam fun��es predecessor
para, compactamente, representar todos os caminhos de comprimento m�nimo a partir
de um dado v�rtice, conforme ilustrado na figura~\ref{fig:pred}.

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
        v�rtice & $\pred$ \\ \hline
        $a$      & $a$  \\
        $b$      & $a$ \\
        $c$      & $a$ \\
        $d$      & $b$ \\
        $e$      & $b$ \\
        $f$      & $e$ \\
        \end{tabular}
     }
  \includegraphics{fig/pred.eps}
  \caption[{\sf Representa��o de caminhos atrav�s da fun��o predecessor}]
  {\label{fig:pred} Representa��o de caminhos atrav�s da
    fun��o predecessor $\pred$ com v�rtice inicial $a$. Os
    n�meros pr�ximos aos arcos representam a fun��o comprimento. Os arcos
    em destaque formam uma arboresc�ncia. A tabela ao lado mostra
    os valores de $\pred$.}
 \end{center}
 \end{figure}

  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O: EXAMINANDO UM V�RTICE
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\section{Examinando arcos e v�rtices}
\label{sec:examinar}

%%%% Bl� inicial
Algoritmos para encontrar caminhos m�nimos mant�m, tipicamente, al�m de uma
fun��o predecessor, uma fun��o potencial. 
O valor desta fun��o potencial para cada v�rtice � um limitante superior para
a dist�ncia a partir do v�rtice $s$. 
Esta fun��o �
intuitivamente interpretada como uma \defi{dist�ncia
  tentativa}\index{distancia@@dist�ncia!tentativa} a  partir de $s$. 

%%% Examinar arco
Seja $\fp$ uma fun��o potencial e $\pred$ uma fun��o predecessor.
Uma opera��o b�sica envolvendo as fun��es $\pred$ e $\fp$ �
\defi{examinar um arco}\index{examinar um/uma!arco}
(\textit{relaxing}~\cite{clrs:introalg-2001},
 \textit{labeling step}~\cite{tarjan:data}). Examinar um arco $uv$ consiste em
 verificar se $\fp$ respeita  $c$ em $uv$ e, caso n�o respeite, ou
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
O passo de examinar $uv$ pode diminuir o valor da dist�ncia
tentativa dos v�rtices $v$  e atualizar o predecessor, tamb�m tentativo,
de $v$ no caminho de comprimento m�nimo de $s$ a $v$. 
O consumo de tempo para examinar um arco � constante.


%%%% Examinar v�rtice
Outra opera��o b�sica � \defi{examinar um v�rtice}%
\index{examinar um/uma!vertice@@v�rtice}. 
Se $u$ � um v�rtice, examinar $u$ consiste em examinar todos os arcos da forma $uv$. Em
linguagem algor�tmica tem-se
\begin{quote}
\textsf{
  Para cada arco $uv$ fa�a \\
 \x se\ $\fp(v) > \fp(u) + c(u,v)$ \\
 \xx ent�o\ $\fp(v) := \fp(u) + c(u,v)$ e $\pred(v) := u$.
%
%Para cada arco $uv$ tal que $d(v) > d(u) + c(u,v)$ fa�a \\
%\x $d(v) := d(u) + c(u,v)$ e $\pred(v) := u$. 
}
\end{quote}
O consumo de tempo para examinar um v�rtice � proporcional ao n�mero de arcos
com ponta inicial no v�rtice.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  SE��O: COMPLEXIDADE 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\section{Complexidade}
\label{sec:complexidade-agm}
O problema do caminho m�nimo (PCM), na sua forma mais geral, ou seja, aceitando 
comprimentos negativos, � NP-dif�cil: o problema do caminho hamiltoniano pode
facilmente ser reduzido a este problema.  

Existem limitantes inferiores bem "fracos"~ para a complexidade do PCM
no modelo compara\-��o-adi��o.
Spira e Pan~\cite{spira:onfinding} mostraram que, independente do n�mero de
adi��es, pelo menos $c n^2$ compara��es s�o necess�rias para resolver o
problema em um grafo sim�trico completo\footnote{Um grafo sim�trico 
$(V,A)$ � \defi{completo}\index{grafo!completo}, se $uv$ e $vu$ est�o
em $A$ para todo par de
v�rtices distintos  $u$ e $v$.} com $n$ v�rtices, onde $c$ � uma constante
positiva. Limitantes para outros problemas relacionados s�o listados em Pettie
e Ramachandran~\cite{petti:computing}.

Alguns algoritmos para o PCM utilizam como subrotina um algoritmo para o 
\defi{problema da �rvore geradora m�nima}, %
\index{problema!da arvore geradora minima@@�rvore geradora m�nima} 
 que consiste em
\begin{quote}
\textbf{Problema} AGM$(V,A,c)$:%
\index{AGM}\mar{AGM}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dado um grafo sim�trico $(V,A)$, uma fun��o
comprimento sim�trica $c$, encontrar uma �rvore geradora de comprimento m�nimo.
\end{quote}
O comprimento de uma �rvore � a soma dos comprimentos das suas
arestas.

Pettie e Ramachandran~\cite{petti:computing} observaram que, no pior caso,
o tempo necess�rio para resolver o problema da �rvore geradora m�nima, no
modelo de compara��o, n�o � 
superior ao tempo necess�rio para resolver o problema do caminho m�nimo no
modelo de compara��o-adi��o. Desta forma, um algoritmo para o problema do
caminho m�nimo, pode utilizar uma subrotina que constr�i
uma �rvore geradora m�nima  
sem que isto comprometa o seu desempenho assint�tico no pior caso.

No modelo RAM, o problema AGM pode ser resolvido em tempo linear, como
descrito por Fredman e Willard~\cite{fredman:mst}. Assim, um algoritmo
para o PCM, no modelo RAM, pode utilizar, digamos, um algoritmo para o
problema AGM como pr�-processamento, sem comprometer a efici�ncia
te�rica do algoritmo. O algoritmo de Thorup, descrito no
cap�tulo~\ref{cap:thorup}, resolve o problema AGM em seu pr�-processamento.

