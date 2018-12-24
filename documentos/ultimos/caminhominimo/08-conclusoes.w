\chapter{Conclus�es}
%\chapter{Considera��es finais}

 Nesta disserta��o descrevemos, implementamos e testamos, algoritmos para o
 problema do caminho m�nimo. O primeiro algoritmo apresentado � o bem
 conhecido algoritmo de Dijkstra. Em seguida, � descrito o algoritmo
 de Dinitz-Thorup, que � um est�gio intermedi�rio entre o algoritmo de
 Dijsktra e o algoritmo de Thorup, que � apresentado ao final. Cada
 descri��o � seguida por uma poss�vel implementa��o. No caso do  
 algoritmo de Dijkstra, seguem cinco poss�veis implementa��es. 
 Finalmente, � feita uma an�lise experimental entre as implementa��es.
 A implementa��o de Dinitz-Thorup n�o entra nas compara��es de tempo, pois seu
 papel � apenas facilitar o entendimento das id�ias propostas no algoritmo de
 Thorup. 
 
 A principal diferen�a entre os algoritmos est� na forma de examinar
 os v�rtices de um grafo. O algoritmo de Dijkstra
 examina os v�rtices em ordem crescente de dist�ncia a partir
 de um dado v�rtice origem. Conforme observado por Fredman e
 Tarjan~\cite{FredTarjan:Fibonacci}, o algoritmo est�, implicitamente, ordenando os
 v�rtices de acordo com esses valores. Assim, qualquer 
implementa��o do algoritmo de Dijkstra para o modelo de compara��o-adi��o realiza,
 no pior caso, $\Omega(m+ n \log n)$ compara��es.
 No algoritmo de
 Dinitz-Thorup, � utilizada a id�ia de bucketing para
 determinar v�rtices que podem ser examinados em qualquer
 ordem. Thorup combinou este bucketing a uma certa decomposi��o do
 grafo. Tamb�m �
 importante lembrar que o algoritmo de Dijkstra 
 utiliza o modelo de compara��o-adi��o, enquanto que os algoritmos de Dinitz-Thorup
 e Thorup foram projetados para o modelo RAM. Os projetos de algoritmos no
 modelo RAM v�m sendo de grande interesse 
de pesquisa, pois oferecem melhorias assint�ticas significativas e fazem sentido
do ponto de vista pr�tico. 

 O algoritmo linear, no modelo RAM, projetado por Thorup resolve,
 eficientemente, os seguintes subproblemas: 
\begin{quote}
\item[{\bf Constru��o da decomposi��o hier�rquica.}]
  O primeiro passo na constru��o da decomposi��o hier�rquica �
encontrar uma �rvore geradora m�nima. Isso � feito em tempo linear,
utilizando-se o algoritmo de Fredman e
Willard~\cite{fredman:mst}. Segundo, ordenar as arestas do grafo em
rela��o ao {\it most significant bit} (msb) do comprimento. Utilizando o algoritmo
 de Andersson, Hagerup, Nilsson e Raman~\cite{andersson:sorting}, essa
tarefa � realizada em tempo linear. E terceiro, utilizar um algoritmo
pr�ximo ao de Kruskal junto com a estrutura {\it union-find}  
desenvolvida por Gabow e Tarjan~\cite{gabow:setunion}, que realiza
cada  opera��o de uni�o de conjuntos distintos em tempo constante.   
\item[{\bf Atualiza��o dos potenciais.}]
 Utiliza a estrutura atomic heap, desenvolvida por Fredman e
Willard~\cite{fredman:mst}.
\item[{\bf Escolha de um elemento maduro.}]
 � feita atrav�s do uso de buckets. O tempo total gasto nessa etapa
� $O(m + n)$.
\end{quote}

 Na implementa��o do algoritmo de Thorup n�o utilizamos atomic
 heaps, pois como o pr�prio Thorup~\cite{thorup:sssp-1999} menciona, os
 atomic heaps s�o definidos somente para $n > 2^{12^{20}}$, e seu
 interesse � principalmente te�rico. N�s utilizamos na 
 implementa��o apenas algoritmos mais conhecidos, facilmente encontrados na
 literatura~\cite{ahuja:netflows, clrs:introalg-2001}.
 Assim, resolvemos os problemas da seguinte maneira:
 \begin{quote}
\item[{\bf Constru��o da decomposi��o hier�rquica.}]
  Primeiro, a �rvore geradora m�nima � encontrada utilizando-se o
algoritmo de Kruskal com a estrutura {\it union-find}
~\cite{clrs:introalg-2001}. O tempo gasto � $O(m\alpha(m,n))$,
onde $\alpha(m,n)$ � a inversa da fun��o de Ackermann.
Segundo, ordenar as arestas do grafo em
rela��o ao msb do comprimento � feita utilizando-se um bucket
sort. Esse passo gasta $O(\log C + m)$.
O tempo total gasto na constru��o da decomposi��o hier�rquica na nossa
implementa��o � $O(\log C + m + m \alpha(m,n))$.
\item[{\bf Atualiza��o dos potenciais.}]
 A atualiza��o � feita da maneira mais simples poss�vel, isto �, sempre
 atualizamos 
todos os ancestrais de um elemento folha cujo potencial foi decrescido. No pior caso, o tempo gasto
na atualiza��o dos potenciais 
�, claramente, a altura de $\Lcal$, que � limitado por $\log r$, onde $r$ � a
raz�o entre o maior e o menor comprimento de um arco. Portanto, o
tempo gasto em cada atualiza��o � $O(\log r)$. 
\item[{\bf Escolha de um elemento maduro.}]
 � feita atrav�s do uso de buckets. Portanto, o tempo total gasto nessa etapa
� $O(m + n)$.
\end{quote}
 Logo, a nossa implementa��o do algoritmo de Thorup gasta tempo $O(n + \log C +
 m \alpha(m,n) + m \log r)$.

 Do ponto de vista te�rico, o algoritmo de Thorup apresenta id�ias
 interessantes, como a decomposi��o hier�rquica, e que podem e j� est�o sendo
 exploradas por outros  pesquisadores, como Pettie e
 Ramachandran~\cite{petti:computing, pettie:experimental}. 

  Ainda do ponto de vista te�rico, 
 o pr�-processamento do algoritmo de Thorup, isto �, a constru��o da decomposi��o
 hier�rquica n�o afeta a efici�ncia do algoritmo, como comentado  na 
 se��o~\ref{sec:complexidade-agm}. Contudo, na pr�tica, o mesmo n�o
 ocorre. Basta notar que o algoritmo de
 Prim-Dijkstra~\cite{clrs:introalg-2001}
  para �rvore geradora m�nima �
 praticamente id�ntico ao algoritmo de Dijkstra. Logo, apenas o
 tempo gasto para construir a �rvore geradora m�nima j� ser� pr�ximo
 do tempo de resolver
 o problema do caminho m�nimo. Esse fato pode ser comprovado na an�lise
   experimental do cap�tulo~\ref{cap:experimentos}.

 Embora, do ponto de vista pr�tico, o algoritmo de Thorup n�o tenha se
 mostrado um sucesso, a sua implementa��o fez com que entend�ssemos
 melhor o algoritmo, inclusive seus pontos fortes e fracos. Como o 
 pr�-processamento � muito ``pesado'', n�o faz sentido utilizar esse algoritmo
 para grafos de dimens�es pequenas. Tamb�m n�o vale a pena  utiliz�-lo em uma
 �nica chamada, isto �, encontrar o caminho m�nimo uma �nica vez. 
 Se for desconsiderada a possibilidade
 de ocorrerem modifica��es no grafo dado, esse
 pr�-processamento pode ser calculado uma �nica vez. 
Ent�o, dependendo do n�mero de chamadas, a um mesmo grafo, para encontrar o
 caminho m�nimo de um  v�rtice a todos os outros, o tempo do pr�-processamento 
acaba n�o prejudicando o tempo final. A figura~\ref{tab:chamadas} ilustra o
desempenho dos algoritmos conforme o n�mero de chamadas a um mesmo grafo,
utilizando um v�rtice origem distinto a cada chamada. O
grafo gerado aleatoriamente � esparso, e foi gerado por \sprand{}.
 \begin{figure}[htbp]
 \begin{center}
   \psfrag{tempo (seg)}{\small Tempo (seg)}
   \psfrag{numero de chamadas}{\small N�mero de chamadas}
   \psfrag{n = 262144}{$n = 262144$}
  \includegraphics{./graph/all_pairs.eps}
  \end{center}
  \scriptsize
 \centering
 \begin{tabular}{^^7cc^^7c^^7cc^^7cc^^7cc^^7cc^^7cc^^7cc^^7c}\hline
\multicolumn{7}{^^7cc^^7c}{Tempos (seg)}\\ \hline
\multicolumn{1}{^^7cc^^7c^^7c}{N�mero de chamandas} 
& \heap & \Dheap & \fheap & \bheap & \rheap & \thorup \\ \hline
1       &2.100  &2.124  &2.162  &0.814  &1.296  &2.744\\ \hline
2       &4.198  &4.252  &4.334  &1.626  &2.596  &4.160\\ \hline
4       &8.448  &8.532  &8.670  &3.242  &5.190  &7.030\\ \hline
8       &16.794 &17.004 &17.344 &6.492  &10.384 &12.740\\ \hline
16      &33.618 &34.010 &34.694 &12.976 &20.754 &24.180\\ \hline\hline
\multicolumn{7}{^^7cc^^7c}{Tempo m�dio para construir a decomposi��o
hier�rquica: 1.3 segundos}% 
\\\hline
 \end{tabular}
 \caption[{\sf N�mero de chamadas em rela��o ao tempo}]
{N�mero de chamadas em rela��o ao tempo em grafos esparsos gerados por \sprand{}.}
 \label{tab:chamadas}
 \end{figure}

 Em rela��o aos testes, observamos que a implementa��o \bheap{},
 apesar de ser a melhor em alguns casos, em outros � a pior. A
 implementa��o \rheap{}, apesar de n�o ganhar em nenhum dos testes,
 sempre teve um bom desempenho e � bem est�vel em rela��o � varia��o
 de $C$. J� com \bheap{}, isso n�o aconteceu. As implementa��es
 \heap{}, \bheap{} e \fheap{} tiveram os melhores desempenhos quando o 
 n�mero de v�rtice mantidos por eles � pequeno. Tamb�m foi poss�vel
 observar que a implementa��o \thorup{} consome mais mem�ria que as
 demais e que o seu desempenho � mediano.

 N�o consideramos que compreendemos inteiramente o algoritmo de
 Thorup. A descri��o apresentada nesta disserta��o difere da descri��o~``mais
 baixo n�vel''~de Thorup. Tentamos, na medida que nos foi poss�vel, extrair a
 ess�ncia do algoritmo, mas ainda sentimos que mais trabalho precisa ser feito
 para compreend�-lo melhor e simplific�-lo.

 Entre as partes que deixamos por fazer e seriam um pr�ximo passo no sentido
 de desvendar alguns, por n�s, mist�rios, destacamos o estudo dos
 artigos de  Andersson
 {\it  et} al~\cite{andersson:sorting}, Fredman e  
 Tarjan~\cite{fredman:mst}, Gabow e Tarjan~\cite{gabow:setunion} e
 Gabow~\cite{gabow:split}.  
 Apesar destes representarem avan�os te�ricos, n�o 
 acreditamos que do ponto de vista pr�tico colaborem com uma melhora no
 desempenho da implementa��o do algoritmo de Thorup.

 Em termos te�ricos, � interessante estender as t�cnicas de Thorup para
 encontrar caminhos m�nimos em grafos n�o
 necessariamente sim�tricos.
 Os primeiros passos nessa dire��o j� foram dados por
 Hagerup~\cite{hagerup:sssp} que projetou um algoritmo para o PCM que consome
 tempo $O(n + m\log \word)$.

 Ainda um outro poss�vel trabalho futuro seria fazer uma implementa��o h�brida do
 algoritmo de Thorup, como � feito com o quicksort, e avaliar seu desempenho. 
Quando o elemento $X$ de
 $\Lcal$ a ser visitado � "suficientemente"~pequeno poder�amos aplicar ent�o o
 algoritmo de Dijkstra para examinar todos os v�rtices em $Q \cap X$ cujos
 potenciais estivessem em um certo "intervalo de seguran�a".
 