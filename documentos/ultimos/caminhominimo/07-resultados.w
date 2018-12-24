\chapter{Resultados Experimentais}
\label{cap:experimentos}
\longpage
  
  Atualmente, há um grande interesse em trabalhos relacionados à
  análise experimental de algoritmos. Em particular, no caso do
  algoritmo de Dijkstra, podemos citar os artigos de Cherkassky,
  Goldberg, Radzik e Silverstein 
  ~\cite{boris:experimental, goldberg:buckets, boris:buckets}. 
   Para algoritmos baseados em "decomposição hierárquica",  
  como o de Thorup, podemos citar o artigo de Petti, Ramachandran e
  Sridhar~\cite{pettie:experimental}.

  O interesse em experimentação é devido ao reconhecimento de que os
resultados teóricos, freqüentemente,
  não trazem informações referentes ao desempenho do algoritmo na
  prática. Porém, o campo da análise experimental é repleto de
  armadilhas, como comentado por
  Johnson~\cite{johnson:guide}. Muitas vezes, a implementação do
  algoritmo é a parte mais simples do experimento. A parte difícil é usar, 
  com sucesso, a implementação para produzir resultados de pesquisa significativos.

  Segundo Johnson~\cite{johnson:guide}, pode-se dizer que existem
  quatro motivos básicos que levam a realizar
  um trabalho de implementação de um algoritmo:
  \begin{enumerate}[(1)]
  \item Para usar o código em uma aplicação particular, cujo propósito
  é descrever o impacto do algoritmo em um certo contexto;
  \item Para proporcionar evidências da superioridade de um algoritmo;
  \item Para melhor compreensão dos pontos fortes, fracos e do 
  desempenho das operações algorítmicas na prática; e 
  \item Para produzir conjecturas sobre o comportamento do algoritmo
  no caso-médio sob distribuições específicas de instâncias onde a
  análise probabilística direta é muito difícil.
  \end{enumerate}
  Nesta dissertação estamos mais interessados no motivo (3).
  
\section{Ambiente experimental}
 A plataforma utilizada nos experimentos é um PC rodando Linux
RedHat~7.1 com um processador Pentium III de 733~MHz e 512MB de
memória RAM. Os códigos estão compilados com o \textsf{gcc} versão
\textsf{2.96} e opção de otimização \textsf{03}.

 Na implementação, as instâncias são obtidas utilizando-se os
geradores de grafos aleatórios disponibilizados pelo ``The Fifth DIMACS Challenge''%
\footnote{O tópico era "Priority Queues"~ e~ "Dictionaries".}
 que estão acessíveis no endereço 
\[\mbox{\texttt{ftp://cs.amherst.edu/pub/dimacs}}.\] Essas instâncias são
convertidas para o formato do \SGB{} (seção~\ref{sec:sgb}), que é a
plataforma utilizada nas implementações desta dissertação. Essa
conversão é feita utilizando-se um ``driver'' também disponível pelo
DIMACS, porém com algumas modificações.
Em todos os testes, para cada valor de $n$ e $m$, onde $n$ é o número
de vértices e $m$ o número de arcos, foi obtido a média entre cinco
valores.
Não é utilizado o gerador do \SGB{}, devido ao fato que
o tempo gasto para se gerar um grafo com aproximadamente $2000$ vértices e
$1 \times 10^{6}$ arcos é em torno de 4 horas e o
espaço ocupado por esse grafo em disco é de aproximadamente 50MB. 
Além disso, estamos interessados em grafos de dimensões um pouco maiores que este.

 As implementações comparadas neste experimento são heap (\heap),
\dheap{} (\Dheap), fibonacci heap (\fheap), bucket heap (\bheap), 
radix heap (\rheap) e o algoritmo de thorup (\thorup).

A estimativa do tempo é calculada utilizando-se:
\begin{quote}
\var{\#}\tipo{include} $<${\tt time.h}$>$

\tipo{clock\_t} start, end;\\
\tipo{double} time;

start\ $=$\ clock();\\
/* {\sf implementação} */\\
end\ $=$\ clock();\\
time\ $=$\ ((double) (end\ -\ start)) / {\tt CLOCKS\_PER\_SEC};\\
\end{quote}
O tempo estimado para a construção da decomposição
hierárquica (\agm), realizada pela 
implementação \thorup, é computado separadamente.

A estimativa da memória consumida por uma implementação é calculada
utilizando-se o programa {\it memtime} da seguinte maneira:
$$ \mbox{{\it memtime} {\sf implementação}} $$ Esse programa está
disponível em {\tt http://www.update.uu.se/\~\null johanb/memtime} e
foi escolhido devido a facilidade na sua manipulação.  

Na estimativa de memória, não foi possível computar separadamente a 
quantidade de memória gasta na construção da decomposição
hierárquica, pois o programa {\it memtime} informa qual foi o máximo
de memória utilizada pelo processo que executa a implementação \thorup. 
 
Nas próximas seções, serão apresentados os desempenhos das
implementações  
em grafos produzidos pelos geradores \sprand{}, \spgrid{} e \spbad{}.

\section{\sprand}
 \sprand{} gera grafos aleatórios conexos. Inicialmente é
 criado um ciclo hamiltoniano, e depois são adicionados os demais arcos 
 aleatoriamente.
 Os parâmetros de entrada para o gerador são especificados da seguinte maneira:
\begin{quote}
 \texttt{sprand n m seed [parâmetros opcionais]}, onde
 
 \texttt{n} é o número de vértices,\\
 \texttt{m} é o número de arcos e\\
 \texttt{seed} é a semente do gerador de números aleatórios.
 \end{quote}
 
 Toda vez que o gerador é executado com os mesmos parâmetros, ele gera
 o mesmo grafo.
 Por default, os arcos pertencentes ao ciclo tem comprimento $1$ e os demais têm 
 comprimento em $[0..10000]$.

 Os experimentos realizados com os grafos gerados por \sprand{} se
 dividem em duas classes: grafos esparsos e
 grafos densos.
 
 \paragraph{Grafos esparsos gerados por \sprand}

 Os grafos desta classe possuem o número de arcos $4$ vezes maior que
 o número de vértices, ou seja, $m = 4n$.  A
 figura~\ref{tab:rand-esparso-10000}
 exibe o tempo gasto pelos algoritmos e a
 figura~\ref{tab:mem-rand-esparso-10000} o quanto de
 memória foi consumida. Nestes experimentos, $n$ varia de
 $8192$ a $262144$, e os comprimentos dos arcos estão em $[1..10000]$. 
 
 Pode-se observar que o \bheap{} teve o melhor desempenho. A
 implementação \thorup{} foi melhor do que as implementações \heap, 
 \Dheap{} e \fheap{}, lembrando que o tempo necessário para
 construir a decomposição hierárquica é computado separadamente. Além
 disso, nota-se que a correlação entre o tempo e o número de vértices
 é praticamente linear. A memória consumida por \thorup{} foi maior que a
 das demais implementações, mas apenas por um fator constante. 

 Na figura~\ref{tab:Crand-esparso} é analisada a sensibilidade dos
 algoritmos em relação a $C$, que é o maior comprimento de um arco. 
 Nota-se que \thorup{}
 teve um comportamento bem estável. As implementações \heap{}, \Dheap{} e
 \fheap{} foram a mais sensíveis à variação de $C$.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% SPRAND ESPARSO 
%  C = 10000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\begin{figure}[htbp]
\begin{center}
\psfrag{tempo (seg)}{\small Tempo (seg)}
   \psfrag{numero de vertices}{\small Número de vértices}
   \psfrag{m = 4n C = 10000}{$m = 4n$, $C = 10000$}
  \includegraphics{./graph/rand_esparso_10000.eps}
\end{center}
\centering
%\footnotesize
\begin{tabular}{^^7cl^^7c^^7cc^^7cc^^7cc^^7cc^^7cc^^7cc^^7c^^7cc^^7c}\hline
\multicolumn{8}{^^7cc^^7c}{Tempos (seg)}\\ \hline
\multicolumn{1}{^^7cc^^7c^^7c}{$n$} 
& \heap & \Dheap & \fheap & \bheap & \rheap & \thorup & \agm \\ \hline
8192	&0.030	&0.028	&0.034	&0.036	&0.020	&0.034 &0.040  \\ \hline
16384	&0.064	&0.070	&0.090	&0.056	&0.058	&0.082 &0.074\\ \hline	
32768	&0.172	&0.178	&0.200	&0.110	&0.136	&0.170 &0.152\\ \hline		
65536	&0.418	&0.418	&0.446	&0.208	&0.290	&0.350 &0.322\\ \hline		
131072	&0.976	&0.972	&1.000	&0.414	&0.628	&0.714 &0.662\\ \hline	
262144	&2.242	&2.210	&2.218	&0.838	&1.364	&1.474 &1.336\\ \hline	
 \end{tabular}
 \caption[{\sf Número de vértices em relação ao tempo em grafos esparsos
gerados por \sprand}]{Número de vértices em relação ao tempo em 
grafos esparsos gerados por \sprand.}
 \label{tab:rand-esparso-10000}
\end{figure}

\begin{figure}[htbp]
   \begin{center}
   \psfrag{memoria (megabytes)}{\small Memória (megabytes)}
   \psfrag{numero de vertices}{\small Número de vértices}
   \psfrag{mem}{}
  \includegraphics{./graph/mems_rand_esparso.eps}
  \end{center}
  \scriptsize
 \centering
 \begin{tabular}{^^7cc^^7c^^7cc ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c 
^^7c c ^^7c c ^^7c c ^^7c} \hline
  \multicolumn{7}{^^7cc^^7c}{Memória (megabytes)} \\ \hline
  \multicolumn{1}{^^7cc^^7c^^7c}{$n$} 
& \multicolumn{1}{^^7cc^^7c}{\heap} 
& \multicolumn{1}{^^7cc^^7c}{\Dheap} 
& \multicolumn{1}{^^7cc^^7c}{\fheap} 
& \multicolumn{1}{^^7cc^^7c}{\bheap} 
& \multicolumn{1}{^^7cc^^7c}{\rheap}
& \multicolumn{1}{^^7cc^^7c}{\thorup} \\ \hline
8192 & 0.7    &  0.7  & 0.9  & 0.7  & 0.7 & 3.0 \\ \hline
16384 & 2.6   &  2.6  & 2.6  & 3.0  & 2.6 & 5.3 \\ \hline
32768 & 4.7   &  4.7  & 4.9  & 4.7  & 4.7 & 9.9 \\ \hline
65536 & 8.8   &  10.4 & 9.5  & 10.4 & 9.4 & 20.0 \\ \hline
131072 & 18.9 &  19.3 & 18.9 & 18.7 & 18.7 & 39.7 \\ \hline
262144 & 40.1 &  41.0 & 40.9 & 40.1 & 39.9 & 78.4 \\ \hline
 \end{tabular}
 \caption[{\sf Memória utilizada quando executado em grafos esparsos
 gerados por \sprand}]{Memória utilizada quando executado em grafos
 esparsos gerados por \sprand.}
 \label{tab:mem-rand-esparso-10000}
 \end{figure}
\begin{figure}[htbp]
 \begin{center}
   \psfrag{tempo (seg)}{\small Tempo (seg)}
   \psfrag{numero de vertices}{\small Valor de $C$}
   \psfrag{n = 262144}{$n = 262144$}
  \includegraphics{./graph/Crand_esparso.eps}
  \end{center}
  \scriptsize
 \centering
\begin{tabular}{^^7cl^^7c^^7cc^^7cc^^7cc^^7cc^^7cc^^7cc^^7c^^7cc^^7c}\hline
\multicolumn{8}{^^7cc^^7c}{Tempos (seg)}\\ \hline
\multicolumn{1}{^^7cc^^7c^^7c}{$C$} 
& \heap & \Dheap & \fheap & \bheap & \rheap & \thorup & \agm \\ \hline
8	&1.362	&1.434	&1.444	&0.730	&0.964	&1.426	&1.314\\ \hline
32	&1.678	&1.738	&1.682	&0.742	&1.106	&1.484	&1.326\\ \hline
128	&1.974	&1.992	&1.916	&0.742	&1.198	&1.492	&1.342\\ \hline
512	&2.224	&2.250	&2.136	&0.790	&1.278	&1.496	&1.370\\ \hline
2048	&2.194	&2.166	&2.178	&0.808	&1.292	&1.490	&1.352\\ \hline
8192	&2.210	&2.186	&2.198	&0.832	&1.316	&1.494	&1.338\\ \hline
 \end{tabular}
 \caption[{\sf Valor de $C$ em relação ao tempo em 
   grafos esparsos gerados por \sprand}]{Valor de $C$ em relação ao tempo em 
   grafos esparsos gerados por \sprand.}
 \label{tab:Crand-esparso}
 \end{figure}

\newpage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% SPRAND DENSO
%  C = 10000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 \paragraph{Grafos densos gerados por \sprand}

  Os grafos desta classe possuem $n^2/4$ arcos. A
 figura~\ref{tab:rand-denso-10000} exibe o tempo gasto pelos
 algoritmos, e a figura~\ref{tab:mem-rand-denso-10000} o quanto de
 memória foi consumida.
 Neste experimentos, $n$ varia de
 $512$ a $8192$, e os comprimentos dos arcos são inteiros em 
 $[1..10000]$. 

 Observa-se que o desempenho das implementações foram muito parecidos,
 tanto no tempo, quanto no uso da memória.

 Na figura~\ref{tab:Crand-denso} é analisada a sensibilidade do
 algoritmo em relação a $C$, que é o comprimento do maior
 arco. Nota-se que a construção da decomposição hierárquica (\agm{}) teve
 uma pequena variação.

 \begin{figure}[htbp]
 \begin{center}
     \psfrag{tempo (seg)}{\small Tempo (seg)}
   \psfrag{numero de vertices}{\small Número de vértices}
   \psfrag{m = n2/4 C = 10000}{$m = n^{2}/4$, $C = 10000$}
  \includegraphics{./graph/rand_denso_10000.eps}
 \end{center}
 \centering
%\footnotesize
 \begin{tabular}{^^7cl^^7c^^7cc^^7cc^^7cc^^7cc^^7cc^^7cc^^7c^^7cc^^7c}\hline
\multicolumn{8}{^^7cc^^7c}{Tempos (seg)} \\ \hline
\multicolumn{1}{^^7cc^^7c^^7c}{n} 
& \heap & \Dheap & \fheap & \bheap & \rheap & \thorup & \agm \\ \hline
512	&0.018	&0.012	&0.010	&0.020	&0.010	&0.018 &0.020\\ \hline
1024	&0.054	&0.056	&0.054	&0.062	&0.054	&0.062 &0.080\\ \hline
2048	&0.230	&0.244	&0.238	&0.244	&0.240	&0.260  &0.326	\\ \hline
4096	&1.210	&1.262	&1.220	&1.238	&1.210	&1.326 &1.426	\\ \hline
8192	&5.618	&6.658	&5.728	&5.796	&5.722	&6.262 &6.346\\ \hline	
 \end{tabular}
\caption[{\sf Número de vértices em relação ao tempo em grafos
densos gerados por \sprand}]{Número de vértices em relação ao tempo em grafos
densos gerados por \sprand.}
 \label{tab:rand-denso-10000}
 \end{figure}

\begin{figure}[htbp]
 \begin{center}
   \psfrag{memoria (megabytes)}{\small Memória (megabytes)}
   \psfrag{numero de vertices}{\small Número de vértices}
   \psfrag{mem}{}
  \includegraphics{./graph/mems_rand_denso.eps}
 \end{center}
 \centering
 \scriptsize
 \begin{tabular}{^^7cc^^7c^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c 
^^7c c ^^7c c ^^7c c ^^7c} \hline
  \multicolumn{7}{^^7cc^^7c}{Memória (megabytes)} \\ \hline
  \multicolumn{1}{^^7cc^^7c^^7c}{$n$} 
& \multicolumn{1}{^^7cc^^7c}{\heap} 
& \multicolumn{1}{^^7cc^^7c}{\Dheap} 
& \multicolumn{1}{^^7cc^^7c}{\fheap} 
& \multicolumn{1}{^^7cc^^7c}{\bheap} 
& \multicolumn{1}{^^7cc^^7c}{\rheap}
& \multicolumn{1}{^^7cc^^7c}{\thorup} \\ \hline
512 & 0.8   & 0.8   & 1.0   & 0.8   & 0.8  & 0.8 \\ \hline
1024 & 5.7  & 5.6   & 5.6   & 5.6   & 5.6  & 5.9 \\ \hline
2048 & 22.5 & 20.8  & 20.8  & 22.2  & 21.3 & 21.2 \\ \hline
4096 & 93.8 & 94.9  & 95.4  & 93.4  & 95.9 & 96.0 \\ \hline
8192 & 382.0& 385.5 & 385.3 & 384.0 & 382.1 & 383.9\\ \hline
 \end{tabular}
 \caption[{\sf Memória utilizada quando executado em grafos densos
 gerados por \sprand}]{Memória utilizada quando executado em grafos
 densos gerados por \sprand.}
 \label{tab:mem-rand-denso-10000}
  \end{figure}

\begin{figure}[htbp]
 \begin{center}
   \psfrag{tempo (seg)}{Tempo (seg)}
   \psfrag{numero de vertices}{Valor de $C$}
   \psfrag{n = 8192}{$n = 8192$}
  \includegraphics{./graph/Crand_denso.eps}
 \end{center}
 \scriptsize
 \centering
 \begin{tabular}{^^7cl^^7c^^7cc^^7cc^^7cc^^7cc^^7cc^^7cc^^7c^^7cc^^7c}\hline
\multicolumn{8}{^^7cc^^7c}{Tempos (seg)}\\ \hline
\multicolumn{1}{^^7cc^^7c^^7c}{$C$} 
& \heap & \Dheap & \fheap & \bheap & \rheap & \thorup & \agm \\ \hline
8	&5.618	&6.070	&5.614	&5.620	&5.624	&6.108	&6.938\\ \hline
32	&5.620	&6.262	&5.616	&5.630	&5.640	&6.098	&6.364\\ \hline
128	&5.626	&6.290	&5.626	&5.644	&5.640	&6.146	&6.240\\ \hline
512	&5.632	&6.474	&5.734	&5.758	&5.746	&6.216	&6.294\\ \hline
2048	&5.648	&6.574	&5.732	&5.744	&5.770	&6.236	&6.296\\ \hline
8192	&5.648	&6.644	&5.740	&5.748	&5.712	&6.236	&6.292\\ \hline
 \end{tabular}
 \caption[{\sf Valor de $C$ em relação ao tempo em
   grafos densos gerados por \sprand}]{Valor de $C$ em relação ao tempo em
   grafos densos gerados por \sprand.}
 \label{tab:Crand-denso}
 \end{figure}

\newpage
\section{\spgrid}
 \spgrid{} gera grafos em forma de grade. Em casos simples, todos os arcos
pertencem à grade. Contudo, é possível adicionar mais arcos, tornando a
instância mais complicada. 
Os parâmetros de entrada para o gerador são especificados da seguinte maneira:
 \begin{quote}
 \texttt{spgrid X Y seed [parâmetros opcionais]}, onde
 
 \texttt{X} é o tamanho horizontal da grade; \\
 \texttt{Y} é o tamanho vertical da grade; e\\
 \texttt{seed} é a semente do gerador de números aleatórios.
 \end{quote}
Um exemplo de um grafo gerado por \spgrid{} pode ser visto na figura~\ref{fig:spgrid}.
\begin{figure}[htbp]
\begin{center}
   \psfrag{1}{{$1$}}
   \psfrag{2}{{$2$}}
   \psfrag{3}{{$3$}}
   \psfrag{4}{{$4$}}
   \psfrag{5}{{$5$}}
   \psfrag{6}{{$6$}}
   \psfrag{7}{{$7$}}
  \includegraphics{fig/spgrid.eps}
  \caption[{\sf Exemplo de um grafo gerado por \spgrid}]
{\label{fig:spgrid} Grafo gerado com \texttt{spgrid 2 3 1}. Nesse exemplo,
 os comprimentos dos arcos foram omitidos. O vértice fonte é o 
$\mbox{\texttt{X}}\times \mbox{\texttt{Y}} + 1$.}
\end{center}
\end{figure}

 Toda vez que o gerador é executado com os mesmos parâmetros, ele gera
 o mesmo grafo.
 Por default, os comprimento dos arcos verticais estão em $[0..100]$ e dos
arcos horizontais estão em $[0..10000]$.

Os experimentos realizados com os grafos gerados por \spgrid{} se
dividem em duas classes: (wide) grafos grade onde o comprimento horizontal é fixo 
e o vertical cresce com o tamanho da entrada e (long) grafos grade onde
o comprimento vertical é fixo e o horizotal cresce com o tamanho da
entrada. Observe que o número de arcos com ponta inicial no vértice
origem é sempre determinado pelo valor de $Y$.  

\paragraph{Grafos wide gerados com \spgrid}

 O número fixado de vértices na horizontal é $16$, ou seja, $X = 16$.
 A figura~\ref{tab:grid-wide-10000} exibe o tempo gasto pelos
 algoritmos e a figura~\ref{tab:mem-grid-wide-10000} o quanto de
 memória foi consumida.
 Nestes experimentos, o valor de $Y$ varia de
 $512$ a $16384$, e os comprimentos dos arcos são inteiros  
 em $[1..10000]$. O número de vértices do grafo é $X \times Y + 1$ e o número
 de arcos é $6 (X \times Y)$.

 Observa-se que, para valores grandes de $Y$, o \bheap{} teve o melhor
 desempenho, enquanto o \fheap{} teve o pior. Em relação a memória
 consumida, novamente \thorup{} foi o maior consumidor. 

 Na figura~\ref{tab:Cgrid-wide} é analisada a sensibilidade do
 algoritmo em relação a $C$, que é o comprimento do maior arco. 
 As implementações \heap{} e \Dheap{} foram as mais sensíveis em
 relação à variação de $C$.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% SPGRID WIDE
%  C = 10000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 \begin{figure}[htbp]
 \begin{center}
     \psfrag{tempo (seg)}{Tempo (seg)}
   \psfrag{numero de vertices}{$Y$}
   \psfrag{n = 16 x Y C = 10000}{$n = 16 \times Y + 1$, $C = 10000$}
  \includegraphics{./graph/grid_wide_10000.eps}
 \end{center}
%\footnotesize
 \centering
 \begin{tabular}{^^7cl^^7c^^7cc^^7cc^^7cc^^7cc^^7cc^^7cc^^7c^^7cc^^7c}\hline
\multicolumn{8}{^^7cc^^7c}{Tempos (seg)} \\ \hline
\multicolumn{1}{^^7cc^^7c^^7c}{$Y$} & 
heap & \Dheap & \fheap & \bheap & \rheap & \thorup & \agm\\ \hline
512	&0.02	&0.022	&0.032	&0.032	&0.02	&0.036 &0.044\\ \hline
1024	&0.05	&0.056	&0.078	&0.06	&0.05	&0.08  &0.086\\ \hline
2048	&0.124	&0.13	&0.172	&0.12	&0.118	&0.178 &0.19\\ \hline
4096	&0.312	&0.316	&0.398	&0.24	&0.266	&0.372 &0.388\\ \hline
8192	&0.77	&0.73	&0.9	&0.488	&0.588	&0.776 &0.802\\ \hline
16384	&1.822	&1.69	&2.016	&1.004	&1.284	&1.596 &1.636\\ \hline
 \end{tabular}
\caption[{\sf \small Número de vértices em relação ao tempo em
   grafos grade gerados por \spgrid{} com $X = 16$}]{Número de vértices
em relação ao tempo em grafos grade gerados por \spgrid{} com $X = 16$.}
 \label{tab:grid-wide-10000}
  \end{figure}


 \begin{figure}[htbp]
 \begin{center}
   \psfrag{memoria (megabytes)}{\small Memória (megabytes)}
   \psfrag{numero de vertices}{\small Número de vértices}
   \psfrag{mem}{}
  \includegraphics{./graph/mems_grid_wide.eps}
 \end{center}
 \centering
   \scriptsize
 \begin{tabular}{^^7cc^^7c^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c 
^^7c c ^^7c c ^^7c c ^^7c} \hline
  \multicolumn{7}{^^7cc^^7c}{Memória (megabytes)} \\ \hline
  \multicolumn{1}{^^7cc^^7c^^7c}{$n$} 
& \multicolumn{1}{^^7cc^^7c}{heap} 
& \multicolumn{1}{^^7cc^^7c}{\Dheap} 
& \multicolumn{1}{^^7cc^^7c}{\fheap} 
& \multicolumn{1}{^^7cc^^7c}{\bheap} 
& \multicolumn{1}{^^7cc^^7c}{\rheap}
& \multicolumn{1}{^^7cc^^7c}{\thorup} \\ \hline
512 &   1.9  & 1.9  & 1.7  & 1.8  & 1.7  & 1.9 \\ \hline
1024 &  3.2  & 3.5  & 3.2  & 3.2  & 3.2  & 5.5 \\ \hline
2048 &  6.1  & 6.0  & 5.9  & 6.4  & 5.9  & 11.7 \\ \hline
4096 &  11.4 & 11.4 & 11.4 & 12.3 & 13.4 & 22.8\\ \hline 
8192 &  25.5 & 24.5 & 26.2 & 24.9 & 24.9 & 45.6 \\ \hline
16384 & 49.0 & 51.9 & 49.8 & 51.0 & 50.9 & 90.9\\ \hline
 \end{tabular}
 \caption[{\sf \small Memória utilizada quando executado em grafos grade 
 gerados por \spgrid{} com $X = 16$}]{\footnotesize Memória utilizada
 quando executado em grafos
 grade gerados por \spgrid{} com $X = 16$.} 
 \label{tab:mem-grid-wide-10000}
 \end{figure}

\begin{figure}[htbp]
 \begin{center}
   \psfrag{tempo (seg)}{Tempo (seg)}
   \psfrag{numero de vertices}{Valor de $C$}
   \psfrag{n = 16 x Y}{$n = 16 \times 16384 + 1$}
  \includegraphics{./graph/Cgrid_wide.eps}
 \end{center}
  \scriptsize
 \centering
 \begin{tabular}{^^7cl^^7c^^7cc^^7cc^^7cc^^7cc^^7cc^^7cc^^7c^^7cc^^7c}\hline
\multicolumn{8}{^^7cc^^7c}{Tempos (seg)}\\ \hline
\multicolumn{1}{^^7cc^^7c^^7c}{$C$} 
& \heap & \Dheap & \fheap & \bheap & \rheap & \thorup & \agm \\ \hline
8	&1.202	&1.222	&1.412	&0.812	&0.980	&1.460	&1.492\\ \hline
32	&1.488	&1.450	&1.638	&0.842	&1.094	&1.550	&1.570\\ \hline
128	&1.820	&1.682	&1.850	&0.852	&1.160	&1.564	&1.592\\ \hline
512	&1.834	&1.702	&1.956	&0.894	&1.202	&1.576	&1.586\\ \hline
2048	&1.888	&1.758	&2.018	&0.976	&1.228	&1.576	&1.600\\ \hline
8192	&1.844	&1.706	&2.038	&1.002	&1.262	&1.574	&1.594\\ \hline
 \end{tabular}
\caption[{\sf \small Valor de $C$ em relação ao tempo em 
   grafos grade gerados por \spgrid{} com $X = 16$}]{\footnotesize
Valor de $C$ em relação ao tempo em 
   grafos grade gerados por \spgrid{} com $X = 16$.}
 \label{tab:Cgrid-wide}
 \end{figure}

\newpage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% SPGRID LONG
%  C = 10000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\paragraph{Grafos long gerados com \spgrid}

 O número fixado de vértices na vertical é $16$, ou seja, $Y = 16$. 
Pode-se perceber que os grafos gerados dessa maneira tendem a ter
poucos vértices na fila de prioridade. 
 A figura~\ref{tab:grid-long-10000} exibe o tempo gasto pelos
algoritmos, e a figura~\ref{tab:mem-grid-long-10000} o quanto de
memória foi consumida.
 Nestes experimentos, $X$ varia de
 $512$ a $16384$, e os comprimentos dos arcos são inteiros em 
  $[1..10000]$. O número de vértices do grafo é $X \times Y + 1$ e o número de
  arcos é $6 (X \times Y)$.

 Nestes testes, a implementação \heap{} foi a vencedora, e a
 implementação \bheap{} teve um desempenho bem pior que as demais
 implementações. Mais uma vez, a implementação \thorup{} foi a que
 consumiu mais memória.

 Na figura~\ref{tab:Cgrid-long} é analisada a sensibilidade do
 algoritmo em relação a $C$, que é o maior comprimento de um
 arco. A implementação \bheap{} foi extremamente sensível. 
 Pôde-se notar que a medida que $C$ cresce, o tempo gasto 
 por \bheap{} piora exponencialmente.

 \begin{figure}[htbp]
 \begin{center}
     \psfrag{tempo (seg)}{Tempo (seg)}
   \psfrag{numero de vertices}{$X$}
   \psfrag{n = X x 16 C = 10000}{$n = X \times 16 + 1$, $C = 10000$}
  \includegraphics{./graph/grid_long_10000.eps}
 \end{center}
 %\footnotesize
 \centering
 \begin{tabular}{^^7cl^^7c^^7cc^^7cc^^7cc^^7cc^^7cc^^7cc^^7c^^7cc^^7c}\hline
\multicolumn{8}{^^7cc^^7c}{Tempos (seg)} \\ \hline
\multicolumn{1}{^^7cc^^7c^^7c}{$X$}  
& \heap & \Dheap & \fheap & \bheap & \rheap & \thorup & \agm\\ \hline
512	&0.018	&0.018	&0.022	&0.132	&0.016	&0.026 &0.044\\ \hline
1024	&0.032	&0.036	&0.054	&0.256	&0.038	&0.060  &0.084\\ \hline
2048	&0.074	&0.074	&0.100	&0.520	&0.082	&0.124 &0.172\\ \hline
4096	&0.150	&0.160	&0.214	&1.036	&0.162	&0.248 &0.354\\ \hline
8192	&0.292	&0.312	&0.418	&2.064	&0.322	&0.488 &0.718\\ \hline
16384	&0.578	&0.624	&0.838	&4.152	&0.654	&0.972 &1.454\\ \hline
 \end{tabular}
\caption[{\sf \small Número de vértices em relação ao tempo em 
   grafos grade gerados por \spgrid{} com $Y = 16$}]{Número de vértices
em relação ao tempo em grafos grade gerados por \spgrid{} com $Y = 16$.}
 \label{tab:grid-long-10000}
 \end{figure}


 \begin{figure}[htbp]
 \begin{center}
   \psfrag{memoria (megabytes)}{\small Memória (megabytes)}
   \psfrag{numero de vertices}{\small Número de vértices}
   \psfrag{mem}{}
  \includegraphics{./graph/mems_grid_long.eps}
 \end{center}
 \centering
 \scriptsize
 \begin{tabular}{^^7c c^^7c^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c 
^^7c c ^^7c c ^^7c c ^^7c} \hline
  \multicolumn{7}{^^7cc^^7c}{Memória (megabytes)} \\ \hline
  \multicolumn{1}{^^7cc^^7c^^7c}{$n$} 
& \multicolumn{1}{^^7cc^^7c}{heap} 
& \multicolumn{1}{^^7cc^^7c}{\Dheap} 
& \multicolumn{1}{^^7cc^^7c}{\fheap} 
& \multicolumn{1}{^^7cc^^7c}{\bheap} 
& \multicolumn{1}{^^7cc^^7c}{\rheap}
& \multicolumn{1}{^^7cc^^7c}{\thorup} \\ \hline
512 &  1.7   &  1.9  & 1.7  & 2.4  & 1.7  & 2.0 \\ \hline
1024 & 3.2   &  3.2  & 3.2  & 3.7  & 3.4  & 5.4 \\ \hline
2048 & 5.9   &  6.3  & 5.9  & 6.4  & 6.0  & 9.2 \\ \hline
4096 & 11.4  &  12.8 & 11.4 & 12.3 & 11.6 & 19.8 \\ \hline
8192 & 22.2  &  23.6 & 23.2 & 25.7 & 25.9 & 38.7 \\ \hline
16384 & 51.9 &  52.4 & 51.0 & 49.0 & 50.7 & 76.4 \\ \hline
 \end{tabular}
 \caption[{\sf \small Memória utilizada quando executado em grafos grade 
 gerados por \spgrid{} com $Y = 16$}]{\footnotesize Memória utilizada
 quando executado em grafos
 grade gerados por \spgrid{} com $Y = 16$.}
 \label{tab:mem-grid-long-10000}
 \end{figure}

\begin{figure}[htbp]
 \begin{center}
   \psfrag{tempo (seg)}{Tempo (seg)}
   \psfrag{numero de vertices}{Valor de $C$}
   \psfrag{n = X x 16}{$n = 16384  \times 16 + 1$}
  \includegraphics{./graph/Cgrid_long.eps}
 \end{center}
 \scriptsize
 \centering
 \begin{tabular}{^^7cl^^7c^^7cc^^7cc^^7cc^^7cc^^7cc^^7cc^^7c^^7cc^^7c}\hline
\multicolumn{8}{^^7cc^^7c}{Tempos (seg)}\\ \hline
\multicolumn{1}{^^7cc^^7c^^7c}{$C$} 
& \heap & \Dheap & \fheap & \bheap & \rheap & \thorup & \agm \\ \hline
8	&0.558	&0.598	&0.816	&0.490	&0.538	&0.852	&1.284\\ \hline
32	&0.570	&0.614	&0.836	&0.512	&0.568	&0.930	&1.382\\ \hline
128	&0.572	&0.622	&0.834	&0.538	&0.596	&0.948	&1.416\\ \hline
512	&0.590	&0.636	&0.854	&0.654	&0.630	&0.968	&1.438\\ \hline
2048	&0.576	&0.624	&0.840	&1.086	&0.632	&0.958	&1.434\\ \hline
8192	&0.562	&0.634	&0.844	&3.446	&0.650	&0.982	&1.454\\ \hline
 \end{tabular}
\caption[{\sf \small Valor de $C$ em relação ao tempo em grafos grade gerados
por \spgrid{} com $Y = 16$}]{\footnotesize Valor de $C$ em relação ao tempo em 
grafos grade gerados por \spgrid{} com $Y = 16$.}
 \label{tab:Cgrid-long}
 \end{figure}

\newpage
\section{\spbad}
 Assim como \sprand{}, \spbad{} gera grafos conexos. Porém, o
 comprimento dos arcos no ciclo hamiltoniano é sempre $1$, e o comprimento dos outros
 arcos é calculado de forma a produzir um número maior de operações 
 \textsf{decrease-key} (seção ~\ref{sec:filadeprioridade}).
 A forma de se usar o gerador é a seguinte:
 \begin{center}
 \texttt{spbad n d [parâmetros opcionais]}, 
 \end{center} onde \texttt{n} é o número de vértices 
(deve ser dois ou mais) e \texttt{d} é o grau de saída de cada vértice 
(deve ser um ou mais).
 Um exemplo de um grafo desse tipo pode ser visto na figura~\ref{fig:spbad}.
\begin{figure}[htbp]
\begin{center}
   \psfrag{1}{\footnotesize {$1$}}
   \psfrag{2}{\footnotesize {$2$}}
   \psfrag{3}{\footnotesize {$3$}}
   \psfrag{4}{\footnotesize {$4$}}
   \psfrag{5}{\footnotesize {$5$}}
   \psfrag{6}{\footnotesize {$6$}}
   \psfrag{11}{\footnotesize {$11$}}
   \psfrag{16}{\footnotesize {$16$}}
  \includegraphics{fig/spbad.eps}
  \caption[{\sf Exemplo de um grafo gerado por \spbad{}}]
{\label{fig:spbad} Grafo gerado com \texttt{spbad 5 4}. Nesse exemplo,
 alguns arcos foram omitidos, para simplificar a visualização.}
\end{center}
\end{figure}

 A figura~\ref{tab:bad-denso} exibe o tempo gasto pelos algoritmos e a
 figura~\ref{tab:mem-bad} o quanto de memória foi consumida. Nestes
 experimentos, $n$ varia de $512$ a $8192$ e o número de arcos é $n^2/4$.
 
 Nota-se que a implementação \bheap{} esteve pior em relação ao tempo e
 a memória consumida. As demais implementações tiveram desempenhos
 praticamente idênticos.

 \begin{figure}[htbp]
 \begin{center}
     \psfrag{tempo (seg)}{Tempo (seg)}
   \psfrag{numero de vertices}{Número de vértices}
   \psfrag{tbad_denso}{}
  \includegraphics{./graph/bad_denso.eps}
 \end{center}
 \footnotesize
 \centering
 \begin{tabular}{^^7cl^^7c^^7cc^^7cc^^7cc^^7cc^^7cc^^7cc^^7c^^7cc^^7c}\hline
\multicolumn{8}{^^7cc^^7c}{Tempos (seg)} \\ \hline
\multicolumn{1}{^^7cc^^7c^^7c}{$n$}  & 
heap & \Dheap & \fheap & \bheap & \rheap & \thorup & \agm\\ \hline
512	&0.012	&0.018	&0.016	&0.024	&0.016	&0.014 &0.018 \\ \hline
1024	&0.062	&0.068	&0.064	&0.106	&0.068	&0.064 &0.074 \\ \hline
2048	&0.296	&0.304	&0.296	&0.456	&0.308	&0.300 &0.324\\ \hline
4096	&1.476	&1.550	&1.440	&2.056	&1.504	&1.496 &1.466\\ \hline
8192	&6.694	&7.388	&6.544	&8.826	&6.720	&6.768 &6.572\\ \hline
 \end{tabular}
 \caption[{\sf Número de vértices em relação ao tempo em grafos gerados por
 \spbad}]{Número de vértices em relação ao tempo em 
 grafos gerados por \spbad.}
 \label{tab:bad-denso}
 \end{figure}

 \begin{figure}[htbp]
 \begin{center}
   \psfrag{memoria (megabytes)}{\small Memória (megabytes)}
   \psfrag{numero de vertices}{\small Número de vértices}
   \psfrag{mem}{}
  \includegraphics{./graph/mems_bad.eps}
 \end{center}
 \centering
 \footnotesize
 \begin{tabular}{^^7c c^^7c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c ^^7c c 
^^7c c ^^7c c ^^7c c ^^7c} \hline
\multicolumn{7}{^^7cc^^7c}{Memória (megabytes)} \\ \hline
  \multicolumn{1}{^^7cc^^7c^^7c}{$n$} 
& \multicolumn{1}{^^7cc^^7c}{\heap} 
& \multicolumn{1}{^^7cc^^7c}{\Dheap} 
& \multicolumn{1}{^^7cc^^7c}{\fheap} 
& \multicolumn{1}{^^7cc^^7c}{\bheap} 
& \multicolumn{1}{^^7cc^^7c}{\rheap}
& \multicolumn{1}{^^7cc^^7c}{\thorup} \\ \hline
512 &  0.9   & 0.9   & 1.1   & 1.1   & 1.0   & 0.9 \\ \hline
1024 & 5.6   & 5.6   & 5.6   & 8.9   & 5.6   & 5.8 \\ \hline
2048 & 23.9  & 23.8  & 20.9  & 30.0  & 21.9  & 23.8 \\ \hline
4096 & 94.7  & 94.4  & 94.0  & 107.4 & 95.3  & 95.1 \\ \hline
8192 & 380.6 & 384.7 & 380.6 & 397.0 & 383.3 & 380.5 \\ \hline
 \end{tabular}
 \caption[{\sf Memória utilizada quando executado em grafos  
 gerados por \spbad}]{Memória utilizada quando executado em grafos
 gerados por \spbad.}
 \label{tab:mem-bad}
 \end{figure}
