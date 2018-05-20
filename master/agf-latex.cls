\def\myClassName{../master/agf-latex}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{\myClassName}

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Document class options %
%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@@ptsize{12pt}
\PassOptionsToPackage{colorlinks=true}{hyperref}

\DeclareOption{onecolumn}{\OptionNotUsed}
\DeclareOption{oneside}{}
\DeclareOption{twoside}{}

\DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption{12pt}{\def\@@ptsize{12pt}}

\DeclareOption{demo}{
	\PassOptionsToPackage{demo}{graphicx}
	}
\DeclareOption{working}{
%	\linenumbers
	\PassOptionsToPackage{backref=true}{biblatex}
%	\PassOptionsToPackage{paperwidth=545pt, inner=100pt, outer=100pt, showframe}{geometry}
	\PassOptionsToPackage{stamp}{draftwatermark}
	}
\DeclareOption{print}{
	\PassOptionsToPackage{hidelinks}{hyperref}
%	\PassOptionsToPackage{nostamp}{draftwatermark}
	}
\DeclareOption{final}{
	\PassOptionsToPackage{disable}{todonotes}
	\PassOptionsToPackage{final}{showkeys}
	\PassOptionsToPackage{backref=false}{biblatex}
	\PassOptionsToPackage{nostamp}{draftwatermark}
	}

\DeclareOption{red}{\renewcommand{\headlinecolor}{\color{slcolor}}}
%=========================
%\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrreprt}}
\ProcessOptions\relax
%%%%%%%%%%%%%%%%%%%%%%%%%%


\LoadClass[\@@ptsize, cleardoublepage=empty]{scrreprt}

%\KOMAoptions{DIV=9}


%%%%%%%%%%%%%%%%%
% Draft options %
%%%%%%%%%%%%%%%%%
\RequirePackage[nostamp]{draftwatermark}
\SetWatermarkText{\MakeUppercase{Draft}}
\SetWatermarkScale{1.2}
\SetWatermarkColor[gray]{0.9}
\SetWatermarkColor[rgb]{1,.9,.9}
\SetWatermarkAngle{45}	
%================
\RequirePackage[switch, modulo]{lineno}
\modulolinenumbers[2]
\renewcommand\thelinenumber{\color{red}\arabic{linenumber}}
\makeatletter
\newif\iflineno
\@ifclasswith{\myClassName}{working}{
%	\linenumbers
	\linenotrue
}{}
\makeatother
%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bibliography & Citation %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[
	backend=biber,
%	backref=true,					% set this to false for final 
	citestyle=authoryear,
	dashed=false,
	defernumbers=true,
	doi=true,
	giveninits=true,
%	heading=subbibnumbered,
	isbn=false,
	maxcitenames=2,
	maxbibnames=40,
	refsegment=chapter,
	style=authoryear,
	%style=numeric,
	uniquename=false,
	uniquelist=false,
	useprefix=true,
	url=true,
	urldate=short
]{biblatex}
%https://tex.stackexchange.com/questions/130228/two-styles-in-biblatex-with-textcite-author-year-and-author-year/130257#130257
%==============================================
% adjust parencite
\DeclareCiteCommand{\myparencite}[\mkbibparens]
{\usebibmacro{prenote}}
{%
	\def\nameyeardelim{\addcomma\addspace}%
	\usebibmacro{citeindex}%
	\usebibmacro{cite}%
	\def\nameyeardelim{\addspace}%
}
{\multicitedelim}
{\usebibmacro{postnote}}
\renewcommand{\parencite}{\myparencite}
%==============================================
% adjust footcite
\DeclareCiteCommand{\myfootcite}[\mkbibfootnote] 
{\usebibmacro{prenote}}                                 
{%
	\usebibmacro{citeindex}%
	\setunit{\addnbspace}
	\printnames{labelname}%
	\addcomma%
	\printfield{year}%
	\setunit{\labelnamepunct}%
	\printfield[citetitle]{title}%
%	\newunit
}
{\addsemicolon\space}
{\usebibmacro{postnote}}
\renewcommand{\footcite}{\myfootcite}
%==============================================
% Bib properties
\renewcommand{\UrlFont}{\footnotesize}
\renewcommand*{\bibfont}{\small}
\renewbibmacro{in:}{}
\renewcommand{\labelnamepunct}{\addcolon\space}
\setlength\bibitemsep{1\itemsep}
\setlength\bibhang{25pt}
%\defbibheading{bibliography}{\section*{Bibliography}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%
% Floating environments %
%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{floatrow}
\floatsetup[figure]{style=plain}
\floatsetup[table]{style=plaintop}

\RequirePackage{sansmath}
\DeclareCaptionFont{sansmath}{\sansmath}

\RequirePackage{caption}
\captionsetup{
	format=plain, 				% hang, plain
	labelformat=simple,			% default, empty, simple, brace, parens
	labelfont={bf,up}, 
	labelsep=colon,				% none, colon, period, space, quad, newline, endash
	textformat=simple, 			% empty, simple, period
	justification=justified,	% text alignment: justified, centering, centerlast, centerfirst, raggedright, raggedleft
	margin=5mm,
	font={footnotesize, sf, sansmath}, 					% bf, it, up
	labelfont={bf},
	textfont={sf,sansmath},
%	textfont=up,
	skip=5mm, 					% spacing between captions and content of the environment
%	singlelinecheck=false 		% set automatic text centering on/off
}

\RequirePackage{subcaption}		% enables depiction of several images amongst each other (\subcaptionbox)
\RequirePackage{placeins}		% contains \FloatBarrier
%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%
% Pagestyles %
%%%%%%%%%%%%%%
\RequirePackage[automark, headsepline]{scrlayer-scrpage}
\clearpairofpagestyles
\lehead{\footnotesize\headmark}
\rohead{\footnotesize\headmark}
\cfoot[\pagemark]{\pagemark}
\pagestyle{scrheadings}
%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%
% Title formatting %
%%%%%%%%%%%%%%%%%%%%
% =================================
%\makeatletter
%\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
%	{-3.25ex\@plus -1ex \@minus -.2ex}%
%	{1.5ex \@plus .2ex}%
%	{\normalfont\normalsize\bfseries}}
%\makeatother
% =================================
\setlength{\parindent}{0pt}
\setlength{\parskip}{3ex}

\linespread{1.075}
%===================
% Set spaces before/after
\RedeclareSectionCommand[
	beforeskip=0pt, 
	afterskip=3\baselineskip
	]{chapter}
\RedeclareSectionCommand[
	beforeskip=1.5\baselineskip, 
	afterskip=1\baselineskip
	]{section}
\RedeclareSectionCommand[
	beforeskip=1\baselineskip, 
	afterskip=0.5\baselineskip
	]{subsection}
\RedeclareSectionCommand[
	beforeskip=0.5\baselineskip,
	afterskip=1pt,
	]{paragraph}
%===================
% Change appearance of the chapter
\KOMAoption{chapterprefix}{true}
\setkomafont{chapterprefix}{\normalsize\mdseries}
\setkomafont{chapter}{\huge\normalfont\bfseries}
\renewcommand*{\chapterformat}{%
	\MakeUppercase{\chapappifchapterprefix{\nobreakspace}\thechapter}%
	\IfUsePrefixLine{%
		\par\nobreak\vspace{-\parskip}\vspace{-.6\baselineskip}%
		\rule{0.9\textwidth}{.5pt}%
	}{\enskip}%
}
%===================
% Change numbering
%\renewcommand\thechapter{\Roman{chapter}} 			% Roman numerals for chapters
%\renewcommand*\thesubsubsection{\thesubsection\,\alph{subsubsection}}
%%%%%%%%%%%%%%%%%%%%


\usepackage[all]{nowidow}
%\clubpenalties 	3 10000 150 0 	% unterbindet Schusterjungen
%\widowpenalties 3 10000 150 0 	% unterbindet Hurenkinder
\displaywidowpenalty = 10000