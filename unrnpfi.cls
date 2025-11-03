%% template author: lara.a.torletti@gmail.com
%% This is file `unrnpfi.cls' 
%%
%% The style has the following options
%% papel o screen.     papel se usa para imprimir - screen agrega links
%% preprint.           Cambia los m\'{a}rgenes para incluir m\'{a}s texto en cada p\'{a}gina
%% singlespacing-doublespacing Modifica el espacio entre l\'{\i}neas
%%
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{unrnpfi}[2024/08/23 v0.1 (a4 paper) UNRN - Sede ANDINA]%

\LoadClassWithOptions{book}

\RequirePackage{ifpdf}
\RequirePackage[english,spanish]{babel}
\RequirePackage{makeidx}
\RequirePackage{caption}
\RequirePackage{fnpos}
\RequirePackage{tabu} %para tablas copadas
% Paquetes para simbolos y fonts usados en ecuaciones
\RequirePackage{amsmath}
\RequirePackage{bm}
\RequirePackage{minted} %para código
\RequirePackage{circuitikz} %para circuitos
\RequirePackage{graphicx}
\RequirePackage{color}
\RequirePackage{fancyhdr}
\RequirePackage{changepage}

% La opci\'{o}n `preprint' produce un texto con m\'{a}rgenes m\'{a}s chicos (m\'{a}s texto por p\'{a}gina)
\newif\ifDraft \Draftfalse
\DeclareOption{preprint}{\Drafttrue}

% La opcion predeterminada es interlineado de un espacio y medio
% El interlineado se puede cambiar con cualquiera de estas opciones
\DeclareOption{onehalfspace}{\gdef\@spacing{onehalfspacing}\gdef\@space{onehalfspace}}
\DeclareOption{singlespace} {\gdef\@spacing{singlespacing}\gdef\@space{singlespace}}
\DeclareOption{doublespace} {\gdef\@spacing{doublespacing}\gdef\@space{doublespace}}


% Las opciones paper/screen dan versiones muy similares. La versi\'{o}n screen incorpora informaci\'{o}n adicional en el documento y enlaces que no son necesarios o vistos en la versi\'{o}n impresa.
\newif\ifpapel \papelfalse
\DeclareOption{papel}{\papeltrue} 
\DeclareOption{screen}{\papelfalse} % En principio no se usa

\ExecuteOptions{papel,onehalfspace}
\ProcessOptions
\RequirePackage{calc}
\RequirePackage[a4paper]{geometry}
\RequirePackage[\@spacing]{setspace}


\newif\iftitlepage \titlepagetrue % initially true by default
% For preprint we do not create a title page (?)
\ifDraft\titlepagefalse\fi

% The Page layout depends on the mode final/preprint
\ifpapel%
\ifDraft\geometry{total={178mm,262mm},top=25mm, includefoot}%
\else\geometry{total={155mm,256mm},top=30mm, left=30mm, includefoot}\fi%
\else%
\ifDraft\geometry{total={178mm,262mm},top=25mm,ratio=1:1, includefoot}%
\else\geometry{total={155mm,256mm},top=30mm, hmarginratio=1:1, includefoot}\fi%
\fi

\RequirePackage{hyperref}
\ifpdf\ifpapel\hypersetup{pdfborder={0 0 0},
  pdfpagemode={UseOutlines},%
  pdfhighlight  =/N,%
  pdfstartview={FitH},  %% determines starting view ("percentage")
  colorlinks=false,
}\else%
\hypersetup{pdfborder={0 0 0},
  pdfpagemode={UseOutlines},%
  pdfhighlight  =/P,%
  pdfstartview={FitH},  %% determines starting view ("percentage")
  colorlinks=true,
  linkcolor=blue,
  anchorcolor=red,
  citecolor=green
}%
\fi
\fi

% Modificamos "\today" en espa\~{n}ol para que \date solo muestre el mes y el a\~{n}o.
\def\es@today#1{%
 \ifcase\es@datefmt
  \es@month#1%
 \else
  \es@month#1~\the\day
 \fi
 \ de\ifnum\year>1999\es@yearl\fi~\the\year}

% Modificado para que nos d\'{e} las p\'{a}ginas en romanos min\'{u}sculas (no s\'{e} que estoy haciendo ac\'{a})
\DeclareRobustCommand\es@scroman{\@firstofone}

% Usado internamente para chequear si se definieron algunos comandos
\def\@ifdefined#1#2{\@ifundefined{#1}{}{#2}}

% Algunas definiCIONES
\def\palabrasclave#1{\gdef\@keywordsEspanol{#1}}
\def\keywords#1{\gdef\@keywordsIngles{#1}}

\newcommand\SetPdfInfo{\ifpdf\hypersetup{pdfauthor={\@author},
  pdftitle={\@carrera},
  pdfsubject={\@title},
  pdfkeywords={\@keywordsEspanol},
}\fi}


\palabrasclave{palabras, clave, espa\~{n}ol}
\keywords{key, words, English}

% Definimos la car\'{a}tula
\if@titlepage%
\renewcommand\maketitle{\pagenumbering{roman}%
\begin{titlepage}
    \begin{center}
    	% \vspace*{-1in}
    	\begin{figure}[htb]
    		\begin{center}
    			\includegraphics[width=0.2\linewidth]{figs/Logo_oficial_UNRN.jpg}
    		\end{center}
    	\end{figure}
    
    	\begin{Large}
    		\textsc{UNIVERSIDAD NACIONAL DE RÍO NEGRO}\\
    	\end{Large}
    	
    	\vspace*{0.15in}
    	
    	\begin{large}
    		\textsc{Escuela de Producción, Tecnología y Medio Ambiente} \\
    	\end{large}
    	
    	\vspace*{0.3in}
    	
    	\rule{\textwidth}{0.1em}\\
    	
    	\vspace*{0.15in}
    	
    	\begin{large}
    		\textsc{Proyecto Final Integrador de Ingeniería Electrónica}\\
    	\end{large}
    	
    	\vspace*{0.2in}
    	
    	\begin{huge}
    		\textbf{HR-RT-Reporter} \\
    	\end{huge}
    	
    	\vspace*{0.15in}
    	
    	\rule{\textwidth}{0.1em}\\
    	
    	\vspace*{0.15in}
    	
    	\begin{large}
    		Estudiante\\
    		Sotomayor P. B. Gabriel\\
    		UNRN \textnumero{}20242\\
    		%aca va el número de UNRN que aparece en el PADRÓN
                \url{grabixz.29@gmail.com}\\
    	\end{large}
    	
    	\vspace*{0.5in}
     
    % COMENTAR/DESCOMENTAR EN CADA CASO SEGÚN CORRESPONDA
    
    % CASO 1 DIRECTOR Y CODIRECTOR DE PFI
    	\begin{large}
    		\begin{tabu} to 0.8\linewidth {X[c]X[c]}
    			Director & Co-Director \\
    			Dr. Ing. Nombre Apellido del Director & Ing. Nombre Apellido del Co-director \\
    			\url{mail@mail.com} & \url{mail@mail.com} \\
    		\end{tabu}
    	\end{large}
    
    % CASO 2 SOLO DIRECTOR DE PFI
     %	\begin{large}
    %			Director\\
    %			Dr. Ing. Nombre Apellido del Director\\
    %	\end{large}
    
    	\vfill{}
    	
    	\begin{large}
    		\textsc{Noviebre, 2025}
                %\textsc{Abril, 2024}
    	\end{large}
    \end{center}

\end{titlepage}%
\setcounter{footnote}{0}%

}%
\fi


\pagestyle{fancy}%
\renewcommand{\chaptermark}[1]{\markboth{{#1}}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}

\fancypagestyle{plain}{% First page of chapter
\fancyhf{}%
\fancyfoot[C]{\bfseries\thepage}
\renewcommand{\headrulewidth}{0pt}\renewcommand{\footrulewidth}{0pt}
}

\fancypagestyle{myheadings}{% Custom pages
\fancyhf{}%
\fancyhead{}%
\fancyfoot[C]{\bfseries\thepage}
\renewcommand{\headrulewidth}{0pt}\renewcommand{\footrulewidth}{0pt}
}
% All other pages
\fancyhead[LO]{}
\fancyfoot[L,R,C]{}
\fancyhead[LE,RO]{\bfseries\thepage}
\fancyhead[RE]{\sffamily\bfseries\nouppercase{\leftmark}}
\fancyhead[LO]{\sffamily\nouppercase{\rightmark}}
\renewcommand{\headrulewidth}{1pt}

% Redefino el comando \cleardoublepage  para que no ponga ni header ni footer 
% en las paginas vacias que quedan entre capitulos. Copiado de fancyhdr.tex
% Solo funciona para el draft
\def\cleardoublepage{\clearpage\ifDraft\else\if@twoside \ifodd\c@page\else
  \hbox{}
  \vspace*{\fill}
  \vspace{\fill}
  \thispagestyle{empty}
  \newpage
  \if@twocolumn\hbox{}\newpage\fi\fi\fi\fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%   From gatech-thesis.cls   %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%    New formatting environments and commands.
% \newcommand{\setfrontpagestyle}[1]{%
%   \gdef\front@pagestyle{#1}
% }
% \newcommand{\setbodypagestyle}[1]{%
%   \gdef\body@pagestyle{#1}
% }
% \newcommand{\setbackpagestyle}[1]{%
%   \gdef\back@pagestyle{#1}
% }

%
%% \begin{preliminary} sets the pagestyle and pagenumbering 
%% (roman numeral format ) for the preliminary sections; 
%% \end{preliminary} resets the pagenumbering. To start page 
%% numbering in arabic format, use \pagestyle{plain} and 
%% \pagenumbering{arabic} after the preliminary environment block
%% The spacing within preliminary is not affected by options
\newenvironment{preliminary}%
{  
  \frontmatter
  \begin{singlespace}
  \pagenumbering{roman}%
  \pagestyle{plain}%
  \iftitlepage\maketitle\fi%
  \end{singlespace}
  \begin{\@space}
}%
{%
  \end{\@space}
  \ifDraft%
  \else%
  \if@twoside%
  \if@openright%
  \cleardoublepage%
  \fi%
  \fi%
  \fi%
  \newpage%
  \pagenumbering{arabic}%
  \pagestyle{fancy}%
  \mainmatter %
}%

%% \begin{postliminary} sets the pagestyle for the
%% postliminary sections.  
%%
%% \end{postliminary} resets the pagestyle and
%% performs any other cleanup.
\newenvironment{postliminary}%
  {  \cleardoublepage%
    \pagestyle{empty}}%
  {%
% \settocdepth{\chapter@tocdepth}%
   \pagestyle{fancy}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Arreglamos las listas del principio %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\tableofcontents{%
   \if@twocolumn
      \@restonecoltrue\onecolumn
   \else
      \@restonecolfalse
   \fi
   \cleardoublepage
   \phantomsection
   \addcontentsline{toc}{chapter}{\contentsname}%
   \chapter*{\contentsname
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
   \@starttoc{toc}%
   \if@restonecol\twocolumn\fi}

\renewcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \cleardoublepage
    \phantomsection
    \addcontentsline{toc}{chapter}{\listfigurename}%
    \chapter*{\listfigurename}%
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }

\renewcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \cleardoublepage
    \phantomsection
    \addcontentsline{toc}{chapter}{\listtablename}%
    \chapter*{\listtablename}%
      \@mkboth{%
          \MakeUppercase\listtablename}%
         {\MakeUppercase\listtablename}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Definimos el estilo de los captions
\captionsetup{width=0.95\textwidth,textfont=footnotesize,labelfont={bf,small}} 

\newcommand\dedicatoria[1]{%
\cleardoublepage
\thispagestyle{empty}
\vspace*{10em}%
\begin{flushright} \large
\begin{tabular}[t]{l}  #1 \end{tabular}
\end{flushright}
\cleardoublepage
}

\newcommand\agradecimientos[1]{%
\cleardoublepage
\section*{Agradecimientos}%
 #1
\vfill
\cleardoublepage
}

\newenvironment{resumen}{\cleardoublepage%
\phantomsection%
\markboth{\abstractname}{}
\addcontentsline {toc}{chapter}{\abstractname}%
\chapter*{\abstractname}%
\noindent}%
{\vfill%
{\noindent {\bfseries Palabras clave:} \MakeUppercase \@keywordsEspanol}% \vfill%
\cleardoublepage}

\newenvironment{abstract}{\cleardoublepage%
\phantomsection%
\markboth{\abstractnameeng}{}
\addcontentsline {toc}{chapter}{\abstractnameeng}%
\selectlanguage{english}%
\chapter*{\abstractnameeng}%
\noindent}%
{\vfill%
{\noindent {\bfseries Keywords:} \MakeUppercase \@keywordsIngles}% \vfill%
\selectlanguage{spanish}%
\cleardoublepage}

\newenvironment{abreviaturas}{\cleardoublepage%
\phantomsection%
\markboth{\nomname}{}%
\addcontentsline {toc}{chapter}{\nomname}%
\chapter*{\nomname}}%
{\cleardoublepage}

\newenvironment{seccion}[1]{\cleardoublepage%
\phantomsection%
\markboth{#1}{}%
\addcontentsline {toc}{chapter}{#1}%
\chapter*{#1}}%
{\cleardoublepage}

\newenvironment{biblio}{\cleardoublepage%
\phantomsection%
\addcontentsline {toc}{chapter}{\bibname}}%
{\cleardoublepage}

\date{\Today}

\DeclareRobustCommand{\chapterquote}[2]{%
  \begin{adjustwidth}{0.3\textwidth}{}%
    \noindent{\em ``#1''} \newline%
  \indent --- #2%
  \end{adjustwidth}%
  \vspace{.5cm}%
}

\setlength{\headheight}{15.6pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Declaraciones \'{u}tiles %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newlength{\imsizeL}\setlength{\imsizeL}{0.9\textwidth}
\newlength{\imsize}\setlength{\imsize}{0.7\textwidth}
\newlength{\imsizeS}\setlength{\imsizeS}{0.5\textwidth}

\addto\captionsspanish{
\def\nomname{\'{I}ndice de s{\'{\i}}mbolos}
\def\contentsname{\'{I}ndice de contenidos}
\def\listfigurename{\'{I}ndice de figuras}
\def\listtablename{\'{I}ndice de tablas}
\def\figurename{Figura}
\def\tablename{Tabla}
\def\abstractname{Resumen}
\def\abstractnameeng{Abstract}
\def\bibname{Bibliograf{\'{\i}}a}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\endinput

