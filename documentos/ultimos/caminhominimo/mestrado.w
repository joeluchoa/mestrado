%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%
%%                  Dissertação do mestrado de
%%
%%                      Shigueo Isotani
%%
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\P}{} % tira os Ps incômodos

%\renewcommand{\normalsize}{\fontsize{10}{12}\selectfont}

%\documentclass[11pt,twoside]{book}
%\documentclass[11pt,language=brazil,structure=flat,baseclass=book]{cweb}
\documentclass[language=brazil,structure=hierarchic,baseclass=book,11pt]{cweb}

%% Colocando identação no primeiro parágrafo de cada tópico 
\usepackage{indentfirst} 

%% Escrevendo em português:
\usepackage[brazil]{babel}
\usepackage[T1]{fontenc}
\usepackage[latin1]{inputenc}
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% packages
\usepackage[dvips]{graphicx,psfrag}
\usepackage{multicol}
\usepackage{lscape} 
\usepackage{latexsym}
\usepackage{amscd}
\usepackage{amsfonts}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{epsf}
\usepackage{ifthen}
\usepackage{makeidx}
\usepackage{enumerate}
\usepackage{fancyheadings}
 
%% definicao personalizada
\usepackage{./sty/mythesis}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Dimensão da página
\setlength{\parskip}{.5pc}
\setlength{\paperwidth}{216mm}
\setlength{\paperheight}{279mm}
\setlength{\textwidth}{38pc}
\setlength{\textheight}{52pc}
\setlength{\topmargin}{0cm}
 
% margens impar e par da pagina
%\setlength\oddsidemargin{.2cm}  
%\setlength\evensidemargin{.2cm}  
\setlength\oddsidemargin{.6cm}  
\setlength\evensidemargin{-.5cm}  

\linespread{1.2}

\makeatletter 
\makeatother
\setcounter{tocdepth}{2}

\makeindex
 
% Aqui começa o documento 
\begin{document}  
%\normalsize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    CAPA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\thispagestyle{empty} 
\input{capa.tex}
\newpage

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    BANCA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\thispagestyle{empty}
\input{banca.tex}
\newpage

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    DEDICATÓRIA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage
\thispagestyle{empty}
\vspace*{19cm}
\begin{flushright}
Aos meus pais Sadao e Naoko \\
e meus irmãos Seiji e Mina.
\end{flushright}

\newpage
\pagestyle{plain}
\pagenumbering{roman}
\setcounter{page}{1} 
%%%%%%%%%%%%%%gv m%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    AGRADECIMENTOS
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\newpage
\input{agradecimentos.tex}
\newpage

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    RESUMO E ABSTRACT
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\pagenumbering{arabic}
%\setcounter{page}{1}
\input{resumo.tex}
\newpage

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    Lista de figuras
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{\baselineskip=.9\baselineskip 
% acho melhor o espacamento entre linhas dos
% tables  diminuido.
\tableofcontents
\clearemptydoublepage

% Este e' para comecar a pagina de um capitulo
% em pagina impar. Tambem deixa a pagina
% anterior sem estilo, se for vazia.
\addcontentsline{toc}{chapter}{\listfigurename}
\listoffigures
%\clearemptydoublepage
%\addcontentsline{toc}{chapter}{\listtablename}
%\listoftables
}

\newpage
\clearemptydoublepage
\pagestyle{fancyplain}
\renewcommand{\chaptermark}[1]%
    {\markboth{#1}{}}
\renewcommand{\sectionmark}[1]%
    {\markright{\thesection\ #1}}
\rhead[\fancyplain{}{\bfseries\rightmark}]%
    {\fancyplain{}{\bfseries\thepage}}
\lhead[\fancyplain{}{\bfseries\thepage}]%
    {\fancyplain{}{\bfseries\leftmark}}
\cfoot{}

\pagestyle{fancy}
\pagenumbering{arabic}
\setcounter{page}{1}

%\cleardoublepage % começa capítulo em pags ímpares
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    INTRODUÇÃO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\input{introd.tex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    CAPÍTULOS
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Conceitos e definições. 
@i 01-conceitos.w

%%% Definição do problema. 
@i 02-problema.w

%% Algoritmo de Dijkstra.
@i 03-dijkstra.w

%% Implementações de filas de prioridade.
@i 04-heap.w

%% Algoritmo de Dinitz.
@i 05-dinitz.w
 
%% Algoritmo de Mikkel Thorup.
@i 06-thorup.w 

%% Resultado experimentais.
@i 07-resultados.w

%%% Conclusões finais.
@i 08-conclusoes.w


%%% Implementações.
\appendix
@i ap-implementacoes.w

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    BIBLIOGRAFIA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage
@
\clearemptydoublepage
\bibliographystyle{./bib/joseplain}
\addcontentsline{toc}{chapter}{Referências Bibliográficas}
\bibliography{./bib/refs}
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    ÍNDICE REMISSIVO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
@
\clearemptydoublepage
\addcontentsline{toc}{chapter}{Índice Remissivo}
\printindex

@
\clearemptydoublepage
\addcontentsline{toc}{chapter}{Índice Remissivo para o Código}
\cwebIndexIntro{%
    Aqui vai uma lista de identificadores usados na implementação e
    onde eles aparecem. Entradas grifadas indicam os lugares de
    definições. Mensagens de erros também são mostradas.
}
\end{document}






