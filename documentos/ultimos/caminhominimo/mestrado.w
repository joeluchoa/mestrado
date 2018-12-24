%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%
%%                  Disserta��o do mestrado de
%%
%%                      Shigueo Isotani
%%
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\P}{} % tira os Ps inc�modos

%\renewcommand{\normalsize}{\fontsize{10}{12}\selectfont}

%\documentclass[11pt,twoside]{book}
%\documentclass[11pt,language=brazil,structure=flat,baseclass=book]{cweb}
\documentclass[language=brazil,structure=hierarchic,baseclass=book,11pt]{cweb}

%% Colocando identa��o no primeiro par�grafo de cada t�pico 
\usepackage{indentfirst} 

%% Escrevendo em portugu�s:
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
%% Dimens�o da p�gina
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
 
% Aqui come�a o documento 
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
%%    DEDICAT�RIA
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage
\thispagestyle{empty}
\vspace*{19cm}
\begin{flushright}
Aos meus pais Sadao e Naoko \\
e meus irm�os Seiji e Mina.
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

%\cleardoublepage % come�a cap�tulo em pags �mpares
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    INTRODU��O
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\input{introd.tex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    CAP�TULOS
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Conceitos e defini��es. 
@i 01-conceitos.w

%%% Defini��o do problema. 
@i 02-problema.w

%% Algoritmo de Dijkstra.
@i 03-dijkstra.w

%% Implementa��es de filas de prioridade.
@i 04-heap.w

%% Algoritmo de Dinitz.
@i 05-dinitz.w
 
%% Algoritmo de Mikkel Thorup.
@i 06-thorup.w 

%% Resultado experimentais.
@i 07-resultados.w

%%% Conclus�es finais.
@i 08-conclusoes.w


%%% Implementa��es.
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
\addcontentsline{toc}{chapter}{Refer�ncias Bibliogr�ficas}
\bibliography{./bib/refs}
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    �NDICE REMISSIVO
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
@
\clearemptydoublepage
\addcontentsline{toc}{chapter}{�ndice Remissivo}
\printindex

@
\clearemptydoublepage
\addcontentsline{toc}{chapter}{�ndice Remissivo para o C�digo}
\cwebIndexIntro{%
    Aqui vai uma lista de identificadores usados na implementa��o e
    onde eles aparecem. Entradas grifadas indicam os lugares de
    defini��es. Mensagens de erros tamb�m s�o mostradas.
}
\end{document}






