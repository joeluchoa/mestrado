\chapter{Conclusões}
%\chapter{Considerações finais}

 Nesta dissertação descrevemos, implementamos e testamos, algoritmos para o
 problema do caminho mínimo. O primeiro algoritmo apresentado é o bem
 conhecido algoritmo de Dijkstra. Em seguida, é descrito o algoritmo
 de Dinitz-Thorup, que é um estágio intermediário entre o algoritmo de
 Dijsktra e o algoritmo de Thorup, que é apresentado ao final. Cada
 descrição é seguida por uma possível implementação. No caso do  
 algoritmo de Dijkstra, seguem cinco possíveis implementações. 
 Finalmente, é feita uma análise experimental entre as implementações.
 A implementação de Dinitz-Thorup não entra nas comparações de tempo, pois seu
 papel é apenas facilitar o entendimento das idéias propostas no algoritmo de
 Thorup. 
 
 A principal diferença entre os algoritmos está na forma de examinar
 os vértices de um grafo. O algoritmo de Dijkstra
 examina os vértices em ordem crescente de distância a partir
 de um dado vértice origem. Conforme observado por Fredman e
 Tarjan~\cite{FredTarjan:Fibonacci}, o algoritmo está, implicitamente, ordenando os
 vértices de acordo com esses valores. Assim, qualquer 
implementação do algoritmo de Dijkstra para o modelo de comparação-adição realiza,
 no pior caso, $\Omega(m+ n \log n)$ comparações.
 No algoritmo de
 Dinitz-Thorup, é utilizada a idéia de bucketing para
 determinar vértices que podem ser examinados em qualquer
 ordem. Thorup combinou este bucketing a uma certa decomposição do
 grafo. Também é
 importante lembrar que o algoritmo de Dijkstra 
 utiliza o modelo de comparação-adição, enquanto que os algoritmos de Dinitz-Thorup
 e Thorup foram projetados para o modelo RAM. Os projetos de algoritmos no
 modelo RAM vêm sendo de grande interesse 
de pesquisa, pois oferecem melhorias assintóticas significativas e fazem sentido
do ponto de vista prático. 

 O algoritmo linear, no modelo RAM, projetado por Thorup resolve,
 eficientemente, os seguintes subproblemas: 
\begin{quote}
\item[{\bf Construção da decomposição hierárquica.}]
  O primeiro passo na construção da decomposição hierárquica é
encontrar uma árvore geradora mínima. Isso é feito em tempo linear,
utilizando-se o algoritmo de Fredman e
Willard~\cite{fredman:mst}. Segundo, ordenar as arestas do grafo em
relação ao {\it most significant bit} (msb) do comprimento. Utilizando o algoritmo
 de Andersson, Hagerup, Nilsson e Raman~\cite{andersson:sorting}, essa
tarefa é realizada em tempo linear. E terceiro, utilizar um algoritmo
próximo ao de Kruskal junto com a estrutura {\it union-find}  
desenvolvida por Gabow e Tarjan~\cite{gabow:setunion}, que realiza
cada  operação de união de conjuntos distintos em tempo constante.   
\item[{\bf Atualização dos potenciais.}]
 Utiliza a estrutura atomic heap, desenvolvida por Fredman e
Willard~\cite{fredman:mst}.
\item[{\bf Escolha de um elemento maduro.}]
 É feita através do uso de buckets. O tempo total gasto nessa etapa
é $O(m + n)$.
\end{quote}

 Na implementação do algoritmo de Thorup não utilizamos atomic
 heaps, pois como o próprio Thorup~\cite{thorup:sssp-1999} menciona, os
 atomic heaps são definidos somente para $n > 2^{12^{20}}$, e seu
 interesse é principalmente teórico. Nós utilizamos na 
 implementação apenas algoritmos mais conhecidos, facilmente encontrados na
 literatura~\cite{ahuja:netflows, clrs:introalg-2001}.
 Assim, resolvemos os problemas da seguinte maneira:
 \begin{quote}
\item[{\bf Construção da decomposição hierárquica.}]
  Primeiro, a árvore geradora mínima é encontrada utilizando-se o
algoritmo de Kruskal com a estrutura {\it union-find}
~\cite{clrs:introalg-2001}. O tempo gasto é $O(m\alpha(m,n))$,
onde $\alpha(m,n)$ é a inversa da função de Ackermann.
Segundo, ordenar as arestas do grafo em
relação ao msb do comprimento é feita utilizando-se um bucket
sort. Esse passo gasta $O(\log C + m)$.
O tempo total gasto na construção da decomposição hierárquica na nossa
implementação é $O(\log C + m + m \alpha(m,n))$.
\item[{\bf Atualização dos potenciais.}]
 A atualização é feita da maneira mais simples possível, isto é, sempre
 atualizamos 
todos os ancestrais de um elemento folha cujo potencial foi decrescido. No pior caso, o tempo gasto
na atualização dos potenciais 
é, claramente, a altura de $\Lcal$, que é limitado por $\log r$, onde $r$ é a
razão entre o maior e o menor comprimento de um arco. Portanto, o
tempo gasto em cada atualização é $O(\log r)$. 
\item[{\bf Escolha de um elemento maduro.}]
 É feita através do uso de buckets. Portanto, o tempo total gasto nessa etapa
é $O(m + n)$.
\end{quote}
 Logo, a nossa implementação do algoritmo de Thorup gasta tempo $O(n + \log C +
 m \alpha(m,n) + m \log r)$.

 Do ponto de vista teórico, o algoritmo de Thorup apresenta idéias
 interessantes, como a decomposição hierárquica, e que podem e já estão sendo
 exploradas por outros  pesquisadores, como Pettie e
 Ramachandran~\cite{petti:computing, pettie:experimental}. 

  Ainda do ponto de vista teórico, 
 o pré-processamento do algoritmo de Thorup, isto é, a construção da decomposição
 hierárquica não afeta a eficiência do algoritmo, como comentado  na 
 seção~\ref{sec:complexidade-agm}. Contudo, na prática, o mesmo não
 ocorre. Basta notar que o algoritmo de
 Prim-Dijkstra~\cite{clrs:introalg-2001}
  para árvore geradora mínima é
 praticamente idêntico ao algoritmo de Dijkstra. Logo, apenas o
 tempo gasto para construir a árvore geradora mínima já será próximo
 do tempo de resolver
 o problema do caminho mínimo. Esse fato pode ser comprovado na análise
   experimental do capítulo~\ref{cap:experimentos}.

 Embora, do ponto de vista prático, o algoritmo de Thorup não tenha se
 mostrado um sucesso, a sua implementação fez com que entendêssemos
 melhor o algoritmo, inclusive seus pontos fortes e fracos. Como o 
 pré-processamento é muito ``pesado'', não faz sentido utilizar esse algoritmo
 para grafos de dimensões pequenas. Também não vale a pena  utilizá-lo em uma
 única chamada, isto é, encontrar o caminho mínimo uma única vez. 
 Se for desconsiderada a possibilidade
 de ocorrerem modificações no grafo dado, esse
 pré-processamento pode ser calculado uma única vez. 
Então, dependendo do número de chamadas, a um mesmo grafo, para encontrar o
 caminho mínimo de um  vértice a todos os outros, o tempo do pré-processamento 
acaba não prejudicando o tempo final. A figura~\ref{tab:chamadas} ilustra o
desempenho dos algoritmos conforme o número de chamadas a um mesmo grafo,
utilizando um vértice origem distinto a cada chamada. O
grafo gerado aleatoriamente é esparso, e foi gerado por \sprand{}.
 \begin{figure}[htbp]
 \begin{center}
   \psfrag{tempo (seg)}{\small Tempo (seg)}
   \psfrag{numero de chamadas}{\small Número de chamadas}
   \psfrag{n = 262144}{$n = 262144$}
  \includegraphics{./graph/all_pairs.eps}
  \end{center}
  \scriptsize
 \centering
 \begin{tabular}{^^7cc^^7c^^7cc^^7cc^^7cc^^7cc^^7cc^^7cc^^7c}\hline
\multicolumn{7}{^^7cc^^7c}{Tempos (seg)}\\ \hline
\multicolumn{1}{^^7cc^^7c^^7c}{Número de chamandas} 
& \heap & \Dheap & \fheap & \bheap & \rheap & \thorup \\ \hline
1       &2.100  &2.124  &2.162  &0.814  &1.296  &2.744\\ \hline
2       &4.198  &4.252  &4.334  &1.626  &2.596  &4.160\\ \hline
4       &8.448  &8.532  &8.670  &3.242  &5.190  &7.030\\ \hline
8       &16.794 &17.004 &17.344 &6.492  &10.384 &12.740\\ \hline
16      &33.618 &34.010 &34.694 &12.976 &20.754 &24.180\\ \hline\hline
\multicolumn{7}{^^7cc^^7c}{Tempo médio para construir a decomposição
hierárquica: 1.3 segundos}% 
\\\hline
 \end{tabular}
 \caption[{\sf Número de chamadas em relação ao tempo}]
{Número de chamadas em relação ao tempo em grafos esparsos gerados por \sprand{}.}
 \label{tab:chamadas}
 \end{figure}

 Em relação aos testes, observamos que a implementação \bheap{},
 apesar de ser a melhor em alguns casos, em outros é a pior. A
 implementação \rheap{}, apesar de não ganhar em nenhum dos testes,
 sempre teve um bom desempenho e é bem estável em relação à variação
 de $C$. Já com \bheap{}, isso não aconteceu. As implementações
 \heap{}, \bheap{} e \fheap{} tiveram os melhores desempenhos quando o 
 número de vértice mantidos por eles é pequeno. Também foi possível
 observar que a implementação \thorup{} consome mais memória que as
 demais e que o seu desempenho é mediano.

 Não consideramos que compreendemos inteiramente o algoritmo de
 Thorup. A descrição apresentada nesta dissertação difere da descrição~``mais
 baixo nível''~de Thorup. Tentamos, na medida que nos foi possível, extrair a
 essência do algoritmo, mas ainda sentimos que mais trabalho precisa ser feito
 para compreendê-lo melhor e simplificá-lo.

 Entre as partes que deixamos por fazer e seriam um próximo passo no sentido
 de desvendar alguns, por nós, mistérios, destacamos o estudo dos
 artigos de  Andersson
 {\it  et} al~\cite{andersson:sorting}, Fredman e  
 Tarjan~\cite{fredman:mst}, Gabow e Tarjan~\cite{gabow:setunion} e
 Gabow~\cite{gabow:split}.  
 Apesar destes representarem avanços teóricos, não 
 acreditamos que do ponto de vista prático colaborem com uma melhora no
 desempenho da implementação do algoritmo de Thorup.

 Em termos teóricos, é interessante estender as técnicas de Thorup para
 encontrar caminhos mínimos em grafos não
 necessariamente simétricos.
 Os primeiros passos nessa direção já foram dados por
 Hagerup~\cite{hagerup:sssp} que projetou um algoritmo para o PCM que consome
 tempo $O(n + m\log \word)$.

 Ainda um outro possível trabalho futuro seria fazer uma implementação híbrida do
 algoritmo de Thorup, como é feito com o quicksort, e avaliar seu desempenho. 
Quando o elemento $X$ de
 $\Lcal$ a ser visitado é "suficientemente"~pequeno poderíamos aplicar então o
 algoritmo de Dijkstra para examinar todos os vértices em $Q \cap X$ cujos
 potenciais estivessem em um certo "intervalo de segurança".
 