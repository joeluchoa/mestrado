@* Implementação.

@ Neste apêndice, se encontra a função |main| do código C, junto com as
chamadas para as implementações dos algoritmos. Também são apresentadas 
as funções de teste da condição de otimalidade.
@<Inclusão de arquivos header@>=
#include <stdio.h>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include "gb_graph.h"
#include "gb_save.h"
#include "gb_rand.h"
#include "types_dh.h" /* definições usadas no parser do DIMACS */
#include "parser.c"   /* converte a entrada do formato DIMACS para o \SGB{} */

@ 
@<Definições@>=
#define ERROR_0 0 
#define ERROR_1 1
#define ERROR_2 2
#define ERROR_3 3
#define ERROR_4 4
#define TRUE  1
#define FALSE  0
#define EXAMINADO 1
#define NAO_EXAMINADO 0
#define VISITADO  1 
#define NAO_VISITADO 0
#define VERTICE_DE_G  (-1)

enum{
  REPORT = 1, /* se REPORT igual a 1 gera um pequeno relatório */
  DIJK = 1,  /* se DIJK igual a 1 executa dijkstra */
  THORUP = 1, /* se THORUP igual a 1 executa thorup */
  LINUX = 1, /* se LINUX igual a 1 então o SO é linux , 0 se for UNIX*/ 
  CONEXO = 1,@/
  DIMACS = 0
};

@ @<Variáveis globais@>=
char *err_message[] = 
  { 
/* 0*/    "Não conseguiu abrir arquivo.",
/* 1*/    "Não conseguiu criar grafo.",
/* 2*/    "Não conseguiu alocar memória.",
/* 3*/    "Não exite arborescência.",
/* 4*/    "Partição inválida."
  };@/
 
@ @<Programa principal@>=
int 
main(argc, argv)
     int argc; 
     char *argv[];
{
  unsigned long n = 1000;         /* número de vértices */
  unsigned long m = 50000;        /* número de arestas */
  unsigned long comp_min = 1;     /* comprimento mínimo de um arco */
  unsigned long comp_max = 1000;  /* comprimento máximo de um arco */
  unsigned long semente = 0;      /* semente do número randômico */
  unsigned long r = 1;            /* número de repetições */
  char *grafo_entrada = NULL;
  char grafo_saida[30];
  Graph *g;
  register Vertex *s; /* vértice inicial */
  register Vertex *v;
  register Arc *a;
  register Graph *arb;
  clock_t t;
  float tempo , tmp;
  FILE *tempos, *potencial;
  @/
 /********* variáveis utilizadas no parser do DIMACS ****************/
  arc *arp;
  node *ndp, *source;
  long nmin;
  char name[21];
  long mlen;
  @/
 /******************************************************************/
  if( ((tempos = fopen("tempos.txt","a")) == NULL) || 
      ((potencial = fopen("potencial.txt","a")) == NULL)) {
    printf("%s\n",err_message[ERROR_0]); exit(0);
  }
  if(DIMACS){  
    @<Entrada DIMACS@>@;
    if ( (g == NULL) || (g->n <= 1) ) {
      printf("%s\n", err_message[ERROR_1]); exit(0);
    }
    @<Encontra a árvore de caminhos mínimos@>@;
    gb_recycle(g);
  }
  else{
    @<Leitura da entrada@>@;
    
    while (r--) {
      if (grafo_entrada) 
        g = restore_graph(grafo_entrada);
      else {
        printf("Criando o grafo...\n");
        g = random_graph(n,m,0,0,0,NULL,NULL,comp_min,comp_max,semente);
        sprintf(grafo_saida,"SP_%lu_%lu_%lu.gb",n,m,semente);
        sprintf(g->id,"Grafo g");
        save_graph(g,grafo_saida);
      }
      if ( (g == NULL) || (g->n <= 1) ) {
        printf("%s\n", err_message[ERROR_1]); exit(0);
      }
      n = g->n;
      @<Encontra a árvore de caminhos mínimos@>@;
      gb_recycle(g);
      semente++; /* incrementa o valor da semente */
    }
  }
  fclose(tempos); fclose(potencial);
  return 0;
}

@
@<Leitura da entrada@>=
while (--argc) {
  if(sscanf(argv[argc],"-n%lu",&n) == 1);
  else if(sscanf(argv[argc],"-m%lu",&m) == 1);
  else if(sscanf(argv[argc],"-cmin%lu",&comp_min) == 1);
  else if(sscanf(argv[argc],"-cmax%lu",&comp_max) == 1);
  else if(sscanf(argv[argc],"-s%lu",&semente) == 1);
  else if(sscanf(argv[argc],"-r%lu",&r) == 1);
  else if(strncmp(argv[argc],"-f",2) == 0) grafo_entrada = argv[argc] + 2; 
  else if(strncmp(argv[argc],"-h",2) == 0){
    printf("Uso: %s [-nN][-mN][-cminN][-cmaxN][-sN][-rN][-farquivo.gb][--hh]\n", argv[0]);
    return 0;
  }
  else if(strncmp(argv[argc],"--hh",4) == 0){
    printf("Uso: %s [-nN][-mN][-cminN][-cmaxN][-sN][-rN][-farquivo.gb][--hh]\n", argv[0]);
    printf(" n    - número de vértices\n");
    printf(" m    - número de arestas (o número de arcos é 2m)\n");
    printf(" cmin - menor comprimento de um arco\n");   
    printf(" cmax - maior comprimento de um arco\n");   
    printf(" s    - semente do número aleatório\n");   
    printf(" r    - número de repetições\n");   
    printf(" f    - lê arquivo.gb\n");   
    return 0;
  }
  else{
    printf("Tente \'%s -h\' para mais informações\n",argv[0]);
    return 0;
  }
}

if (grafo_entrada) r = 1;

@ @<Entrada DIMACS@>=  
parse( &n, &m, &ndp, &arp, &source, &nmin, name, &mlen, &g );
    
printf ( "%s\nn= %ld, m= %ld, nmin= %ld, source = %ld, maxlen= %ld\n",
         name,
         n,m,nmin, (source-ndp)+nmin, mlen );
comp_max = mlen;

@ 
@<Encontra a árvore de ...@>=

@<Escolhe o vértice inicial |s|@>@;

@<Encontra o arco de maior comprimento@>@;

@<Calcule o valor para |infinito|@>@;


if(DIJK){

@<Execute Dijkstra usando a implementação de Heap@>@;

@<Execute Dijkstra usando a implementação de D-Heap@>@;

@<Execute Dijkstra usando a implementação de Fibonacci Heap@>@;

@<Execute Dijkstra usando a implementação de Bucket heap@>@;

@<Execute Dijkstra usando a implementação de Radix Heap@>@;
}

if(THORUP){
  @<Execute o algoritmo de Mikkel Thorup@>@;
}

@ @<Variáveis globais@>=
unsigned long infinito;
unsigned long C;        /* maior comprimento de um arco */
unsigned long num_exam;
unsigned long atualiza_fp;   /* número de atualizações da função potencial */   
double sum;

@ @<Escolhe o vértice inicial |s|@>=
if (DIMACS) s = g->vertices  + (source - ndp) + nmin - 1;
else s = g->vertices;

@ @<Encontra o arco de maior comprimento@>=
if(grafo_entrada) {
  for(v = g->vertices; v < g->vertices + g->n; v++){
    for(a = v->arcs; a; a = a->next){
      if( C < a->len ) C =  a->len;
    }
  }
}
else C = comp_max; /* já estava calculado */

@ @<Calcule o valor para |infinito|@>=
infinito = diametro(g,s)*C + 1;

@ A função |diametro| faz uma busca em largura para encontrar
o maior número de arcos necessário para acessar um vértice, 
a partir do vértice origem $s$.
@<Funções auxiliares@>=
unsigned long
diametro(g,s)
     Graph *g;
     Vertex *s;
{
  register Vertex *u, *v;
  register Arc *a;
  register long i, j;
  register long diam;

  diam = 0;
  for(v = g->vertices; v < g->vertices + g->n; v++){
    v->status = NAO_VISITADO;
  }
  Q = s = g->vertices;
  s->dist = 0;
  Q(0) = s;
  for(i =  j = 0, qsize = 1; qsize > 0; qsize--, i++){
    u = Q(i);
    for(a = u->arcs; a ; a = a->next){
      v = a->tip;
      if(v->status == VISITADO) continue;
      v->dist = u->dist + 1;
      if(diam < v->dist) diam = v->dist;
      v->status = VISITADO;
      Q(++j) = v; qsize++;
    }
  }
  return diam;
}


@ @<Execute Dijkstra usando a implementação de Heap@>=
create_pq = create_heap;
insert = insert_heap; 
delete_min = delete_min_heap;
decrease_key = decrease_key_heap;

printf("\n++++++++++++++++++++ DIJKSTRA ++++++++++++++++++\n");
t = clock();
dijkstra(g,s);
tempo = clock() - t;
printf("\nImplementação de Heap\n");
printf("| V | = %ld\t| A | = %ld\n",g->n,g->m);
@<Imprime os dados de saida@>@;
@<Testa a corretude da solução@>@;

@ @<Execute Dijkstra usando a implementação de D-Heap@>=
create_pq = create_dheap;
insert = insert_dheap; 
delete_min = delete_min_dheap;
decrease_key = decrease_key_dheap;

printf("\n++++++++++++++++++++ DIJKSTRA ++++++++++++++++++\n");
t = clock();
dijkstra(g,s);
tempo = clock() - t;
printf("\nImplementação de D-Heap\n");
printf("| V | = %ld\t| A | = %ld\tD = %ld\n",g->n,g->m,D); 
@<Imprime os dados de saida@>@;
@<Testa a corretude da solução@>@;

@ @<Execute Dijkstra usando a implementação de Fibonacci Heap@>=
create_pq = create_fheap;
insert = insert_fheap; 
delete_min = delete_min_fheap;
decrease_key = decrease_key_fheap;

printf("\n++++++++++++++++++++ DIJKSTRA ++++++++++++++++++\n");
t = clock();
dijkstra(g,s);
tempo = clock() - t;
printf("\nImplementação de Fibonacci Heap\n");
printf("| V | = %ld\t| A | = %ld\t\n",g->n,g->m);
@<Imprime os dados de saida@>@;
@<Testa a corretude da solução@>@;

@ @<Execute Dijkstra usando a implementação de Bucket heap@>=
create_pq = create_bkheap;
insert = insert_bkheap; 
delete_min = delete_min_bkheap;
decrease_key = decrease_key_bkheap;

printf("\n++++++++++++++++++++ DIJKSTRA ++++++++++++++++++\n");
t = clock();
dijkstra(g,s);
free(Q);
tempo = clock() - t;
printf("\nImplementação de Bucket heap\n");
printf("| V | = %ld\t| A | = %ld\t%ld Buckets\n",g->n,g->m,C+1); 
@<Imprime os dados de saida@>@;
@<Testa a corretude da solução@>@;

@ @<Execute Dijkstra usando a implementação de Radix Heap@>=
create_pq = create_rxheap;
insert = insert_rxheap; 
delete_min = delete_min_rxheap;
decrease_key = decrease_key_rxheap;

printf("\n++++++++++++++++++++ DIJKSTRA ++++++++++++++++++\n");
t = clock();
dijkstra(g,s);
free(Q);
tempo = clock() - t;
printf("\nImplementação de Radix Heap\n");
printf("| V | = %ld\t| A | = %ld\t%d Buckets\n",g->n,g->m,log2(g->n*C) + 2); 
@<Imprime os dados de saida@>@;
@<Testa a corretude da solução@>@;

@ @<Imprime os dados de saida@>=
printf("\nDurante a execução do programa:\n");
printf(" Foram examinados %lu vértices\n",num_exam);
for(v = g->vertices, sum = 0; v < g->vertices + g->n; v++, sum += v->dist);
printf(" Soma das distâncias: %.0f\n",sum);
printf(" A função pontencial precisou ser atualizada %ld vezes\n",atualiza_fp);
printf("Tempo: %.4f segundos\n",tempo/CLOCKS_PER_SEC);
if(g->m != 0) fprintf(potencial,"%.4f\t",(float)atualiza_fp/g->m);
fprintf(tempos,"%.4f\t", tempo/CLOCKS_PER_SEC);


@ @<Execute o algoritmo de Mikkel Thorup@>=
printf("\n++++++++++++++++++ THORUP +++++++++++++++++++\n");
t = clock();
arb = krusk(g);
tmp = clock() - t;
printf("Tempo para construir a arborescencia: %.4f segundos\n",tmp/CLOCKS_PER_SEC);

t = clock();
thorup(g, arb, s);
gb_recycle(arb);
free(BK);
tempo = clock() - t;

printf("\nImplementação de Mikkel Thorup\n");
printf("| V | = %ld\t| A | = %ld\n",g->n,g->m);
printf("\nDurante a execução do programa:\n");
printf(" Foram examinados %lu vértices\n",num_exam);
for(v = g->vertices, sum = 0; v < g->vertices + g->n; v++,sum += v->dist);
printf(" Soma das distâncias: %.0f\n",sum);
printf(" A função pontencial precisou ser atualizada %ld vezes\n",atualiza_fp);
printf("Tempo: %.4f segundos\n",tempo/CLOCKS_PER_SEC);
if(g->m != 0) fprintf(potencial,"%.4f\n",(float)atualiza_fp/g->m);
fprintf(tempos,"%.4f\t", tempo/CLOCKS_PER_SEC); /* thorup */
fprintf(tempos,"%.4f\n", tmp/CLOCKS_PER_SEC);   /* AGM */
if(REPORT){
  printf(" A arborescência tem %d nós(fora os vértices de g)\n",nelementos); 
  printf(" Precisou desempilhar %d vezes\n",desempilha);
  printf(" Precisou atualizar para cima %d vezes\n",atualiza_acima);
  printf(" Os elementos mudaram de maduros para não maduros %d vezes\n", nao_maduro);
}
@<Testa a corretude da solução@>@;

@*1 Testa condição de otimalidade.
 A função |funcao_potencial_OK| verifica se todos os vértices estão com 
um potencial válido.
Se todos os potenciais forem válidos, a função devolve TRUE. 
Caso contrário, devolve FALSE e imprime um arco que não respeita a função potencial.

@ @<Teste da condição de otimalidade@>=
int 
funcao_potencial_OK(g)
Graph *g;
{
  register Vertex* v;
  register Vertex *u;
  register Arc *a;

  for(u = g->vertices; u < g->vertices + g->n; u++){
    for(a = u->arcs; a; a = a->next){
      v = a->tip;
      if ( v->dist - u->dist > a->len){ /* a função não respeita c */
        printf("\n********  A função potencial não é válida  *********\n");
        printf("****** Arco que não respeita a função potencial ******\n");
        printf("*******  %s -> %s  ----  %ld - %ld > %ld  ************\n",
               u->name,v->name,v->dist,u->dist,a->len);
        return FALSE;
      }
    }
  }
  return TRUE;
}

@ A subrotina |calcula_caminho| calcula o comprimento do caminho, e |verifica_caminhos_OK| 
verifica se o comprimento do caminho respeita a condição de 
otimalidade~\ref{sec:criterio-otimalidade}.
@<Teste da condição de otimalidade@>=
unsigned long 
comprimento_caminho(v)
     Vertex *v;
{  
  register Vertex *u;
  register Arc *a;
  register unsigned long minarc = infinito;

  if(v->pred == v) return 0; 
  
  for(a = (v->pred)->arcs; a; a = a->next){
     /* encontra o arco de menor comprimento com ponta final em |v| */ 
     u = a->tip;
     if(u == v) {
       if(a->len < minarc) minarc = a->len;
     }
  } 
  return (comprimento_caminho(v->pred) + minarc);
}

int 
verifica_caminhos_OK(g)
Graph *g;
{
  register Vertex *v;
  register unsigned long comp;
  
  for(v = g->vertices; v < g->vertices + g->n; v++)
    if( (v->dist != infinito) && ((comp = comprimento_caminho(v)) != v->dist )){
      printf("\n** Comprimento do caminho de s a %s está errado **\n", v->name);
      printf("*** Caminho: %ld\tPotencial: %ld  ***\n", comp, v->dist);
      return FALSE;
    }
  return TRUE;
}

@ Se não houve nenhum problema, imprime as seguintes mensagens. 
@<Testa a corretude da solução@>=
if( REPORT && funcao_potencial_OK(g) && verifica_caminhos_OK(g) ){
  printf(">>>>>>>>>>  Função potencial Ok  <<<<<<<<<<\n");
  printf(">>>>>>>>>>  Caminhos de custo mínimo Ok  <<<<<<<<<<\n");
}
@


