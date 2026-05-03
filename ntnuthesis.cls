% File for the ntnuthesis LaTeX class.
% This class produces a subset of book suitable for doctoral
% theses written at NTNU.
%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------
%% Original author:  Federico Zenith                                     ||
%% Customized by:    Bjørn W Solemslie during Oct 2019 - June 2020       ||
%% Customized by:    Chirag Trivedi from July 2020 - cont.               ||
%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------
%
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ntnuthesis}[2007/03/25 Class for theses at NTNU Trondheim]

%% Set default values for the variables used by our implementation of \maketitle
\newcommand{\SubTitle}{}

\newcommand{\DegreeType}{Draft version}                                         % Default degree type in draft version
\newcommand{\NTNU}{Norwegian University of Science and Technology}              % University name
\newcommand{\Faculty}{Faculty of Engineering}                                   % Faculty name
\newcommand{\Department}{Department of Energy and Process Engineering}          % Department name
\newcommand{\CopyrightNotice}{copyright {\copyright} {\Year} {\StudentName}}    % Copyright 
\newcommand{\ISBNPrinted}{N/A}                                                  % This is for PhD thesis
\newcommand{\ISBNElectronic}{N/A}                                               % This is for PhD thesis
\newcommand{\SerialNumber}{N/A}                                                 % This is for PhD thesis
\newcommand{\Month}{\ifcase\month\or
	January\or February\or March\or April\or May\or June\or
	July\or August\or September\or October\or November\or December\fi}
\newcommand{\Year}{\number\year}

%% Set the default values for margin settings
\newcommand{\GeometryOptions}{margin=25mm,top=27mm,bindingoffset=10mm}
\newcommand{\CropOptions}{}
\newcommand{\CropLandscapeFlag}{}

%% Used in some conditional statements
\RequirePackage{ifthen}

%% Commodity command to give two different versions of code, the first for printout mode
%% and the second for screen mode. Useful for large pictures and layouts in absolute units.
\newcommand{\printandscreen}[2]{\ifthenelse{\isundefined{\ScreenMode}}{#1}{#2}}
\newcommand{\frontPage}{}
\newcommand{\backPage}{}

%% Process options passed to the class
\DeclareOption{a4crop}{\renewcommand{\CropOptions}{cam,a4,center}}
\DeclareOption{phd}{\renewcommand{\DegreeType}{Philosophiae Doctor}}
\DeclareOption{msc}{
    \renewcommand{\DegreeType}{Master of Science}
    \renewcommand{\frontPage}{\include{ntnu-style/cover-page}}
    \renewcommand{\backPage}{\include{ntnu-style/last-page}}
    }
\DeclareOption{project}{
    \renewcommand{\DegreeType}{Project report}
    \renewcommand{\frontPage}{\include{ntnu-style/cover-page}}
    \renewcommand{\backPage}{\include{ntnu-style/last-page}}
    }
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{book}}
\DeclareOption{final}{\PassOptionsToClass{\CurrentOption}{book}}
\DeclareOption{screen}{
	\renewcommand{\CropLandscapeFlag}{landscape}
	\renewcommand{\GeometryOptions}{margin=10mm,screen}
	\newcommand{\ScreenMode}{true}
}
\DeclareOption*{\PackageWarning{ntnuthesis}{Unknown option `\CurrentOption´.}}
\ProcessOptions\relax

\LoadClass[a4paper,11pt,twoside,openright,onecolumn,titlepage]{book}
%\LoadClass[b5paper,10pt,twoside,openright,onecolumn,titlepage]{book}

%% Set appropriate margins
\RequirePackage[\GeometryOptions,includeheadfoot,headheight=14.5pt]{geometry}

%% Set cropping marks, if a4crop has been specified.
\RequirePackage[\CropOptions,\CropLandscapeFlag]{crop}

%% Define the commands to set the variables used by \maketitle
\newcommand{\printFrontPage}{\include{\frontPage}}
\newcommand{\subtitle}[1]{\renewcommand{\SubTitle}{#1}}
\newcommand{\degreetype}[1]{\renewcommand{\DegreeType}{#1}}
\newcommand{\university}[1]{\renewcommand{\ntnu}{#1}}
\newcommand{\faculty}[1]{\renewcommand{\Faculty}{#1}}
\newcommand{\department}[1]{\renewcommand{\Department}{#1}}
\newcommand{\copyrightnotice}[1]{\renewcommand{\CopyrightNotice}{#1}}
\newcommand{\isbnprinted}[1]{\renewcommand{\ISBNPrinted}{#1}}
\newcommand{\isbnelectronic}[1]{\renewcommand{\ISBNElectronic}{#1}}
\newcommand{\serialnumber}[1]{\renewcommand{\SerialNumber}{#1}}
\newcommand{\setyear}[1]{\renewcommand{\Year}{#1}}
\newcommand{\setmonth}[1]{\renewcommand{\Month}{#1}}

%% Override the \maketitle command------------------------
\renewcommand{\maketitle}{
	\begin{titlepage}
	   	\parindent=0cm
    	{\Huge \@author}
    	
    	\printandscreen{\vspace{2cm}}
    
    	{\Huge \textbf{\@title}}
    
    	{\LARGE \SubTitle}
    	\vfill
    	
    	{\large
    	    \DegreeType
    	    
    	    \vspace{1cm}
    	    \Department
    	    
            \Faculty
            
            \NTNU
            
            \vspace{2cm}
            Trondheim, \Month\ \Year
        }

    	\printandscreen{\vspace{1cm}}{\vspace{0.5cm}}
    	\includegraphics[width=0.4\textwidth]{logo/ntnu_hoeyde_eng.pdf}
    	
    	\newpage                            % Copyright page back side of title page
    	\pagestyle{empty}                   % No header and no footer on this paper
    	\topskip0pt
    	\vspace*{\fill}
    	\begin{center}
    	    \CopyrightNotice
    	\end{center}
    	\vspace*{\fill}
	\end{titlepage}
}
%%---------------------------------------------------------

%% Necessary to set the headers; notice that right and left headers are swapped.
\RequirePackage{fancyhdr}

%% Header settings
\AtBeginDocument{
	\pagestyle{fancy}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\sectionmark}[1]{\markright{{\thesection.\ #1}}}
	\renewcommand{\chaptermark}[1]{\markboth{{\thechapter.\ #1}}{}}
	\lhead{\nouppercase{\leftmark}}
	\rhead{\nouppercase{\rightmark}}
	\printandscreen{
		\fancyhead[LE,RO]{\thepage}
	}{	
		\fancyfoot[C]{\thepage}
	}
	\fancyfoot[C]{}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Other useful userpackages

\usepackage{enumitem}
\setlist[itemize]{topsep=2pt, itemsep=0pt, parsep=0pt}


\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[english]{babel}                 % UK-english hyphenation patterns.
\RequirePackage{ae,aecompl}
\RequirePackage{placeins}					    % Control float placement \FloatBarrier
\RequirePackage{wrapfig}					    % WrapFigure pakke
\RequirePackage{colortbl}
\RequirePackage{xcolor}				            % Definerer fargesystem
\RequirePackage{color}
\RequirePackage{colortbl}                       % For colour shades in tables
\RequirePackage{sidecap}
\RequirePackage{type1cm}                        % Use scalable, PostScript Type 1 versions of the Computer Modern fonts.
\RequirePackage[compact]{titlesec}              % Control the title format and spaces around the titles
\RequirePackage[normalem]{ulem}  	            % Enables lines in chapter headers
\RequirePackage{nomencl}                        % Nomenclature
\RequirePackage{amsmath}                        % Equations and symbols
\RequirePackage{mathtools}
\RequirePackage{appendix}                       % Appendix
\RequirePackage[breaklinks = true]{hyperref}    % Hyperlink
\RequirePackage{enumitem}                       % Numbering and bullet point
\RequirePackage{tabularx}
\RequirePackage{tabulary}
\RequirePackage{longtable}                      % Table on several pages
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{multicol}
\RequirePackage{dcolumn}
\RequirePackage{array}
\RequirePackage{fncychap}
\RequirePackage{graphicx}                       % Include figure
\RequirePackage[small,bf]{caption}              % Caption styles
\RequirePackage[labelformat=simple]{subcaption} % Enable sub figure
\RequirePackage{epstopdf} 						% Support for eps.
\RequirePackage{float} 							% figure placing [H]
\RequirePackage{lscape} 						% Landscape Option Left down
\RequirePackage[draft,colorinlistoftodos,textwidth=2cm,obeyFinal]{todonotes}	% To-dos note package
\RequirePackage[super]{nth}
\RequirePackage{units}
\RequirePackage{pdfpages} 						% Include full pdf pages, such as cover page and oppgave
\RequirePackage{hyphenat}                       % Prevent hyphenation of a sentence
\RequirePackage{lipsum}                         % Dummy text
\RequirePackage{doi}                            % Doi hyperlink
\RequirePackage{fancyvrb}                       % Inline verbatim
\RequirePackage{cite}                           % Make compact version of citations [1-5]
\RequirePackage{setspace}                       % Change linespacing locally
\RequirePackage{tikz}                           % Package for drawing
\RequirePackage{rotating}                       % Rotate the text
\RequirePackage{changepage}                     % Change paragraph margin locally
\RequirePackage{afterpage}                          % Used to change margin locally and restore
\RequirePackage{scalefnt}                       % Scaling font in tikz
\RequirePackage{rotating}                       % Rotate text
\usepackage{svg}
\svgsetup{
  inkscapelatex=true % gjør at all tekst i SVG settes av LaTeX
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Extra customized setting comes here, paragraph, hyperlink, table, figure, caption, header-forter, nomenclatures, etc.

\usetikzlibrary {arrows.meta}

\captionsetup{justification=centering}              % Figure caption setting
\DeclareGraphicsExtensions{.eps,.ps,.pdf,.png,.jpg}

%% Paragraph setting for section, subsection and subsubsection.
\titlespacing{\section}{0pt}{18pt}{6pt}
\titlespacing{\subsection}{0pt}{12pt}{3pt}
\titlespacing{\subsubsection}{0pt}{6pt}{0pt}
\setlength{\parindent}{0.5cm}
\setlength{\parskip}{6pt}
\renewcommand{\baselinestretch}{1.25}

\titleformat*{\section}{\large\bfseries}
\titleformat*{\subsection}{\normalsize\bfseries}
\titleformat*{\subsubsection}{\small\itshape}

%% Fixes appendix referencing name
\newcommand*{\Appendixautorefname}{Appendix}

% https://i.ntnu.no/wiki/-/wiki/Norsk/Farger+i+grafisk+profil
\definecolor{mscBox}{HTML}{6096d0} % Color for the box for cover page
\definecolor{mscCirc}{HTML}{9db7e1} % Color for the circle for cover page

\definecolor{projBox}{HTML}{ef8114} % Color for the box for cover page
\definecolor{projCirc}{HTML}{f4ac67} % Color for the circle for cover page

%% Hyperlink color setting
\hypersetup{
	colorlinks=true,
	urlcolor=blue,
	linkcolor=black,
	citecolor=blue,
	pdfborder= 0 0 0
	}

%% Section Numbering and toc depth
% This will fix the digit limit in toc. Current setting allows from \subsection x.1 to x.99.
\setcounter{secnumdepth}{2}
% This setting is limited to \subsection. You may use \setcounter{tocdepth}{2} to include level 3 toc, however it is not recommended.
\setcounter{tocdepth}{1}

%% Fix for SubFigure reference apperal
\renewcommand\thesubfigure{(\alph{subfigure})}

%% Define a new 'leo' style for the package that will use a smaller font.
\makeatletter
\def\url@leostyle{
  	\@ifundefined{selectfont}
  		{\def\UrlFont{\sf}}
  		{\def\UrlFont{\small\ttfamily}}
  	}
\makeatother
\urlstyle{leo}                                      % Now actually use the newly defined style.

%-----Header / Footer configuration-----------------%
\def\thickhrulefill{\sout \hfill}	                % Defines lines in chapter headers

\fancypagestyle{plain}{                             % Style for no header and no footer
	\fancyhead{}                                %
	\fancyfoot{}                                %
	\renewcommand{\headrulewidth}{0pt}          %
	\renewcommand{\footrulewidth}{0pt}          %
}                                                   %

\fancypagestyle{hfstyle-front}{                     % Style for front matters
	\fancyhead[LO,CO,RO,LE,CE,RE]{}             %
	\fancyfoot[LO,RO,LE,RE]{}                   %
	\fancyfoot[CO,CE]{\thepage}                 %
	\renewcommand{\headrulewidth}{0pt}          %
	\renewcommand{\footrulewidth}{0pt}          %
}                                                   %

\fancypagestyle{hfstyle-chapter}{                   % Style for chapters
	\fancyhead[LO,RO,LE,RE]{}                   %
	\fancyhead[CO]{\footnotesize{\rightmark}}   %
	\fancyhead[CE]{\footnotesize{\leftmark}}    %
	\fancyfoot[LO,RO,LE,RE]{}                   %
	\fancyfoot[CO,CE]{\thepage}                 %
	\renewcommand{\headrulewidth}{0.2pt}        %
	\renewcommand{\footrulewidth}{0pt}          %
}                                                   %

\fancypagestyle{hfstyle-appendix}{                  % Style for references and appendices
	\fancyhead[LO,CO,RO,LE,CE,RE]{}             %
    \fancyfoot[LO,RO,LE,RE]{}                       %
	\fancyfoot[CO,CE]{\thepage}                 %
	\renewcommand{\headrulewidth}{0pt}          %
	\renewcommand{\footrulewidth}{0pt}          %
}                                                   %

%% Defines header for numbered chapter              %
\titleformat 										%
	{name=\chapter} 						    % command
	[display] 								    % shape
	{\Large} 						            % format
	{\renewcommand\thechapter{\arabic{chapter}}
		\thickhrulefill\,Chapter \thechapter
		\thickhrulefill \renewcommand
		\thechapter{\arabic{chapter}}}          % label
	{1pt} 									    % Separation between label and name
	{\Large\bfseries\center} 		            % Name preamble
	{}										    % Name postamble

%% Defines header for unnumbered chapter            %
\titleformat                                        %
			{name=\chapter,numberless} 			% command
			[display] 							% shape
			{\Large} 				            % format
			{\thickhrulefill} 					% label
			{1pt} 								% Separation between label and name
			{\Large\bfseries\center} 			% Name preamble
			{}									% Name postamble
%---------------------------------------------------%

%-------------Setting for the table-----------------%
\newcolumntype{d}                                   %
	{D{.}{.}{-2}}                               %
			                                    %
\newcommand{\tabincell}                             %
	[1]                                         %
	{\begin{tabular}{c}#1\end{tabular}}         %
                                                    %
\newcommand{\tabincellt}                            %
	[1]                                         %
	{\begin{tabular}{l}#1\end{tabular}}         %
                                                    %
\newcommand{\merge}                                 %
	[1]                                         %
	{\multicolumn{1}{c}{#1}}                    %
                                                    %
\newcommand{\PreserveBackslash}                     %
	[1]                                         %
	{\let\temp=\\#1\let\\=\temp}                %
                                                    %
\newcolumntype{C}                                   %
	[1]                                         %
	{>{\PreserveBackslash\centering}p{#1}}      %
                                                    %
\newcolumntype{R}                                   %
	[1]                                         %
	{>{\PreserveBackslash\raggedleft}p{#1}}     %
                                                    %
\newcolumntype{L}                                   %
	[1]                                         %
	{>{\PreserveBackslash\raggedright}p{#1}}    %
%---------------------------------------------------%

\setlength{\marginparwidth}{0.8in}  %fix for issue with two-sided document and todonotes
%------- Figure fixing -> blue todo notes ----------%
\newcommand{\figfix} 								%
	[1]											%
	{\todo[color=blue!40]{#1}} 					%
												%
%------- Ok-ish -> yellow todo notes ---------------%
\newcommand{\okish} 								%
	[1]											%
	{\todo[color=yellow!40]{#1}} 				%
												%
%-------  OK -> green todo notes -------------------%
\newcommand{\ok} 									%
	[1]											%
	{\todo[color=green!40]{#1}} 				%
                                                    %
%------- Text Check -> red todo notes --------------%
\newcommand{\textfix} 								%
	[1] 										%
	{\todo[size=\small,color=red!40]{#1}} 		%
												%
%%--------------------------------------------------%

%-----------------------Nomenclature setting-----------------------------------%
\makenomenclature                                                               %
\newcommand{\nomunit}[1]{\renewcommand{\nomentryend}{\hspace*{\fill}#1$}$}      %
\renewcommand{\nomgroup}[1]                                                     %
{ 														                        %
\ifthenelse{\equal{#1}{A}}{\item[\textbf{\\ Abbreviation}]}{ 					% "A" start -> Abbreviations
    \ifthenelse{\equal{#1}{B}}{\item[\textbf{\\ Latin symbols}]}{ 				% "B" start -> Latin symbols
	    \ifthenelse{\equal{#1}{C}}{\item[\textbf{\\ Dimensionless numbers}]}{ 	% "C" start -> Dimensionless
			\ifthenelse{\equal{#1}{D}}{\item[\textbf{\\ Greek symbols}]}{ 		% "" start -> Greek symbols
				\ifthenelse{\equal{#1}{E}}{\item[\textbf{\\ Superscripts and subscripts}]}{} % "E" start -> Indices
			    }                                                           %
		    }                                                               %
	    }                                                                   %
    }                                                                           %
}                                                                               %
%-------------------------------------------------------------------------------%

%--------------Settings to create archival document, pdf/A----------------------%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%