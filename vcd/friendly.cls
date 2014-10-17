\NeedsTeXFormat{LaTeX2e}[1995/12/01]
%\ProvidesClass{cknmc}
\ProvidesClass{/books/sas/friendly/friendly}
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@titlepage
\@titlepagetrue
\setlength\paperheight {11in}
\setlength\paperwidth{8.5in}
\newif\if@openright
\newif\if@mainmatter \@mainmattertrue
\if@compatibility
  \renewcommand\@ptsize{0}
\else
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\fi
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\if@compatibility\else
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\fi
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\if@compatibility\else
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\fi
\DeclareOption{titlepage}{\@titlepagetrue}
\if@compatibility\else
\DeclareOption{notitlepage}{\@titlepagefalse}
\fi
\if@compatibility
\@openrighttrue
\else
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\fi
\if@compatibility\else
\DeclareOption{onecolumn}{\@twocolumnfalse}
\fi
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}%
}
\ExecuteOptions{letterpaper,10pt,twoside,onecolumn,final,openright}
\ProcessOptions
\input{/books/sas/friendly/friendly10.clo}
\input epsf
%\RequirePackage{amsmath}
%% restore ldots
\def\ldots{\mathinner{\ldotp\ldotp\ldotp}}
\def\dots{\relax\ifmmode\ldots\else$\m@th\ldots\,$\fi}

\RequirePackage[dvips]{color}
\definecolor{fiftygray}{cmyk}{0,0,0,.5}
\definecolor{fifteengray}{cmyk}{0,0,0,.15}
\definecolor{gray}{cmyk}{0,0,0,.15}
\usepackage{colortbl}
\arrayrulecolor{black}
\newcommand\tchl[3]{\multicolumn{#1}{#2}{#3}}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{0\p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\renewcommand\topfraction{1}
\setcounter{bottomnumber}{2}
\renewcommand\bottomfraction{1}
\setcounter{totalnumber}{4}
\renewcommand\textfraction{.1}
\renewcommand\floatpagefraction{.9}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\kern-\margwidth\small
	\thepage\kern2em{\itshape\leftmark}\hfill}%
      \def\@oddhead{\kern-\margwidth\small\rm\hfill{\itshape\rightmark}\kern2em
	\thepage}%
      \let\@mkboth\markboth
	\markboth{Visualizing Categorical Data}{Visualizing Categorical Data}
    \def\chaptermark##1{%
      \markright {\ifappendix\else\@chapapp\ \thechapter\kern1em\fi
	##1}}%
    \def\sectionmark##1{\relax}}
\def\ps@blank{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\kern-\margwidth\small
	\thepage\kern2em\hfill}%
      \def\@oddhead{\kern-\margwidth\small\rm\hfill\kern2em
	\thepage}%
      \let\@mkboth\markboth
	}
\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble
    }
\def\ps@plain{%
    \def\@oddfoot{\hfill\small\bfseries\thepage}%
	\def\@evenfoot{\small\kern-\margwidth\thepage\hfil}%
	\def\@evenhead{}\def\@oddhead{}%
	}
  \if@titlepage
  \newcommand\maketitle{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \null\vfil
  \vskip 60\p@
  \begin{center}%
    {\LARGE \@title \par}%
    \vskip 3em%
    {\large
     \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      \vskip 1.5em%
    {\large \@date \par}%       % Set date in \large size.
  \end{center}\par
  \@thanks
  \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\else
\newcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \newpage
  \null
  \vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\LARGE \@title \par}%
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
    \vskip 1em%
    {\large \@date}%
  \end{center}%
  \par
  \vskip 1.5em}
\fi
\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{2}
\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thechapter {\@arabic\c@chapter}
\newcommand\theChapter{\ifcase\thechapter\or ONE\or TWO\or THREE\or FOUR\or
	FIVE\or SIX\or SEVEN\fi}
\renewcommand \thesection {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\newcommand\@chapapp{\chaptername}
\newcommand\frontmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse
  \pagenumbering{roman}}
\newcommand\mainmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmattertrue
  \pagenumbering{arabic}}
\newcommand\backmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse}
\newcommand\part{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \thispagestyle{plain}%
  \if@twocolumn
    \onecolumn
    \@tempswatrue
  \else
    \@tempswafalse
  \fi
  \null\vfil
  \secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >-2\relax
       \huge\bfseries \partname~\thepart
       \par
       \vskip 20\p@
     \fi
     \Huge \bfseries #2\par}%
    \@endpart}
\def\@spart#1{%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \Huge \bfseries #1\par}%
    \@endpart}
\def\@endpart{\vfil\newpage
              \if@twoside
                \null
                \thispagestyle{empty}%
                \newpage
              \fi
              \if@tempswa
                \twocolumn
              \fi}
\newcommand\chapter{\if@openright\clearpage\else\clearpage\fi
                    \thispagestyle{empty}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                       \else
                         \addcontentsline{toc}{chapter}{#1}%
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
\newbox\temptbox
\newdimen\titledepth
\newif\ifappendix	\global\appendixfalse

\def\minitoc{\bgroup
	\def\contentsline##1{\csname chap@##1\endcsname}
	\vskip12pt plus6pt minus4pt
	\noindent\kern-\margwidth\vrule height1pt width\fullwidth
	\vskip15pt plus6pt minus4pt
	\@starttoc{toc}
	\egroup
	\vskip24pt plus6pt minus4pt}

\def\minitocsub{\bgroup
	\def\contentsline##1{\csname chapsub@##1\endcsname}
	\vskip12pt plus6pt minus4pt
	\noindent\kern-\margwidth\vrule height1pt width\fullwidth
	\vskip15pt plus6pt minus4pt
	\@starttoc{toc}
	\egroup
	\vskip24pt plus6pt minus4pt}


\def\@makechapterhead#1{%
	\vspace*{34pt}
%	\strut\hfill{\chapwordsize\sffamily\bfseries
%		\ifappendix\vphantom{\@chapapp A}\else\@chapapp\ \thechapter\fi}
%	\vskip13pt
	\noindent\smash{\llap{\hbox to\margwidth{\hss
		\begin{tabular}[b]{@{}c@{}}
			%\chapwordsize\sffamily\bfseries
			\cwfont\@chapapp\\
		\noalign{\vskip10pt}
		%\chapnumsize\sffamily\bfseries
		\cnfont\thechapter\end{tabular}\hss}}}%
		\vbox to0pt{\vss
		\parindent0pt
		%\chaptitlesize\sffamily\bfseries
		\ctfont\baselineskip32pt\raggedright
		#1\par}
	\vskip64pt plus12pt minus6pt
%	\bgroup
%	\def\contentsline##1{\csname chap@##1\endcsname}
%	\@starttoc{toc}
%	\egroup
%	\vskip36pt plus12pt minus6pt
	}

\def\@makeappendixhead#1{%
	\vspace*{-13pt}
	\strut\hfill{%\chapwordsize\sffamily\bfseries
		\cwfont\@chapapp\ \thechapter}
	\vskip13pt
	\noindent\kern-\margwidth\vtop{\hsize30pc
		\parindent0pt
		%\chaptitlesize\sffamily\bfseries
		\ctfont\baselineskip32pt\raggedright
		#1}
	\vskip40pt plus12pt minus6pt
%	\bgroup
%	\def\contentsline##1{\csname chap@##1\endcsname}
%	\@starttoc{toc}
%	\egroup
%	\vskip36pt plus12pt minus6pt
	}

\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}
\def\@makeschapterhead#1{%
	\vspace*{59pt}
	\noindent\kern-\margwidth\rlap{\hbox to\fullwidth{\hss}}%
		\vbox to0pt{\hsize28pc
		\parindent0pt
		\vss%\chaptitlesize\sffamily\bfseries
		\ctfont\baselineskip32pt\raggedright
		#1}
	\vskip40pt plus12pt minus6pt
	\bgroup
	\def\contentsline##1{\csname chap@##1\endcsname}
	\@starttoc{toc}
	\egroup
	\vskip36pt plus12pt minus6pt
	}
\def\@makeschapterhead#1{%
	\vspace*{-7pt}
	\strut\hfill{%\chapwordsize\sffamily\bfseries
		\cwfont\vphantom{Chapter 0}}
	\vskip13pt
	\noindent\kern-\margwidth\vtop{\hsize30pc
		\parindent0pt
		%\chaptitlesize\sffamily\bfseries
		\ctfont\baselineskip32pt\raggedright
		#1}
	\vskip40pt plus12pt minus6pt
	\bgroup
	\def\contentsline##1{\csname chap@##1\endcsname}
	\@starttoc{toc}
	\egroup
	\vskip36pt plus12pt minus6pt
	}
\def\@seccntformat#1{\csname the#1\endcsname\kern1pc}
\newif\iflevelone	\global\levelonefalse

\def\@sect#1#2#3#4#5#6[#7]#8{\global\levelonefalse%
     \ifnum #2>\c@secnumdepth
       \let\@svsec\@empty\else
       \refstepcounter{#1}%
       \protected@edef\@svsec{\@seccntformat{#1}}%
     \fi
     \@tempskipa #5\relax
      \ifdim \@tempskipa>\z@
	\ifnum #2=1\iflevelone\global\levelonefalse\fi
        \begingroup #6\relax
		\leftskip-\margwidth
          \@hangfrom{\relax\@svsec}%
                    {\interlinepenalty \@M 
				\iflevelone#8\par}%
	\nobreak\vskip-4.5pt\nobreak
	\noindent\kern-\margwidth
	\rlap{\vrule height1pt width\fullwidth depth0pt}\fi
        \endgroup
\else
        \begingroup #6\relax
          \@hangfrom{\hskip #3\relax\@svsec}%
                    {\interlinepenalty \@M #8\par}%
        \endgroup
\fi
       \csname #1mark\endcsname{#7}\addcontentsline
         {toc}{#1}{\ifnum #2>\c@secnumdepth \else
                      \protect\numberline{\csname the#1\endcsname}\fi
                    #7}\else
        \def\@svsechd{#6\hskip #3\relax  %% \relax added 2 May 90
                   \@svsec #8\csname #1mark\endcsname
                      {#7}\addcontentsline
                           {toc}{#1}{\ifnum #2>\c@secnumdepth \else
                           \protect\numberline{\csname the#1\endcsname}%
                                     \fi
                       #7}}\fi
     \@xsect{#5}}

\def\@ssect#1#2#3#4#5{\@tempskipa #3\relax
   \ifdim \@tempskipa>\z@
     \begingroup #4\@hangfrom{\hskip #1}{\interlinepenalty \@M 
	#5\iflevelone\vrule width0pt depth6pt\fi\par}%
	\iflevelone\global\levelonefalse
	\nobreak\vskip-4.5pt\nobreak
	\noindent\kern-\margwidth
	\rlap{\vrule height1pt width\fullwidth depth0pt}\fi
     \endgroup
   \else \def\@svsechd{#4\hskip #1\relax #5}\fi
    \@xsect{#3}}

\newcommand\section{\@startsection {section}{1}{-\margwidth}%
                                   {-30pt plus -6pt minus-6pt}%
                                   {12pt}%
                                   {\normalfont\ahfam\sffamily\bfseries
			\global\levelonetrue\raggedright
			\mathversion{sansbold}%
  \renewcommand\boldmath{\@nomath\boldmath\mathversion{sansbold}}}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-24pt plus -4pt minus-2pt}%
                                     {12pt}%
                                     {\normalfont\bhfam\sffamily\bfseries
			\global\levelonefalse
			\mathversion{sansbold}%
  \renewcommand\boldmath{\@nomath\boldmath\mathversion{sansbold}}
\raggedright}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-12pt \@plus -4pt \@minus -2pt}%
                                     {6pt}%
                                     {\normalfont\normalsize\sffamily\bfseries
			\global\levelonefalse
						\mathversion{sansbold}}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {-12pt \@plus -4pt \@minus -2pt}%
                                    {-1em}%
                                    {\normalfont\normalsize\bfseries
			\global\levelonefalse
		\mathversion{bold}}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\bfseries
			\global\levelonefalse
}}
\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
\fi
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\raise.13em\hbox{\textbullet}}
\newcommand\labelitemii{\hbox{--}}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}

\def\@verbatim{\list{}{\topsep12pt\leftmargin0pt\labelwidth0pt\labelsep0pt
	\parsep0pt}\small \item\relax
  \if@minipage\else\vskip\parskip\fi
  \leftskip\@totalleftmargin\rightskip\z@skip
  \parindent\z@\parfillskip\@flushglue\parskip\z@skip
  \@@par
  \@tempswafalse
  \def\par{%
    \if@tempswa
      \leavevmode \null \@@par\penalty\interlinepenalty
    \else
      \@tempswatrue
      \ifhmode\@@par\penalty\interlinepenalty\fi
    \fi}%
  \obeylines \verbatim@font \@noligs
  \let\do\@makeother \dospecials
  \everypar \expandafter{\the\everypar \unpenalty}%
}
\def\endverbatim{\if@newlist \leavevmode\fi\endlist}

\begingroup \catcode `|=0 \catcode `[= 1
\catcode`]=2 \catcode `\{=12 \catcode `\}=12
\catcode`\\=12 |gdef|@xwideverbatim#1\end{wideverbatim}[#1|end[wideverbatim]]
|gdef|@sxwideverbatim#1\end{wideverbatim*}[#1|end[wideverbatim*]]
|endgroup
\def\@wideverbatim{\trivlist\small \item\relax
  \if@minipage\else\vskip\parskip\fi
  \leftskip-\margwidth\rightskip\z@skip
  \parindent\z@\parfillskip\@flushglue\parskip\z@skip
  \@@par
  \@tempswafalse
  \def\par{%
    \if@tempswa
      \leavevmode \null \@@par\penalty\interlinepenalty
    \else
      \@tempswatrue
      \ifhmode\@@par\penalty\interlinepenalty\fi
    \fi}%
  \obeylines \verbatim@font \@noligs
  \let\do\@makeother \dospecials
  \everypar \expandafter{\the\everypar \unpenalty}%
}
\def\wideverbatim{\@wideverbatim \frenchspacing\@vobeyspaces \@xwideverbatim}
\def\endwideverbatim{\if@newlist \leavevmode\fi\endtrivlist}

\begingroup \catcode `|=0 \catcode `[= 1
\catcode`]=2 \catcode `\{=12 \catcode `\}=12
\catcode`\\=12 |gdef|@xsmallverbatim#1\end{smallverbatim}[#1|end[smallverbatim]]
|gdef|@sxsmallverbatim#1\end{smallverbatim*}[#1|end[smallverbatim*]]
|endgroup
\def\@smallverbatim{\trivlist\small \item\relax
  \if@minipage\else\vskip\parskip\fi
  \leftskip0pt\rightskip\z@skip
  \parindent\z@\parfillskip\@flushglue\parskip\z@skip
  \@@par
  \@tempswafalse
  \def\par{%
    \if@tempswa
      \leavevmode \null \@@par\penalty\interlinepenalty
    \else
      \@tempswatrue
      \ifhmode\@@par\penalty\interlinepenalty\fi
    \fi}%
  \obeylines \verbatim@font \@noligs
  \let\do\@makeother \dospecials
  \everypar \expandafter{\the\everypar \unpenalty}%
}
\def\smallverbatim{\@smallverbatim \frenchspacing\@vobeyspaces \@xsmallverbatim}
\def\endsmallverbatim{\if@newlist \leavevmode\fi\endtrivlist}

\begingroup \catcode `|=0 \catcode `[= 1
\catcode`]=2 \catcode `\{=12 \catcode `\}=12
\catcode`\\=12 |gdef|@xsmallerverbatim#1\end{smallerverbatim}[#1|end[smallerverbatim]]
|gdef|@sxsmallerverbatim#1\end{smallerverbatim*}[#1|end[smallerverbatim*]]
|endgroup
\def\@smallerverbatim{\trivlist\smallerminus \item\relax
  \if@minipage\else\vskip\parskip\fi
  \leftskip0pt\rightskip\z@skip
  \parindent\z@\parfillskip\@flushglue\parskip\z@skip
  \@@par
  \@tempswafalse
  \def\par{%
    \if@tempswa
      \leavevmode \null \@@par\penalty\interlinepenalty
    \else
      \@tempswatrue
      \ifhmode\@@par\penalty\interlinepenalty\fi
    \fi}%
  \obeylines \verbatim@font \@noligs
  \let\do\@makeother \dospecials
  \everypar \expandafter{\the\everypar \unpenalty}%
}
\def\smallerverbatim{\@smallerverbatim \frenchspacing\@vobeyspaces \@xsmallerverbatim}
\def\endsmallerverbatim{\if@newlist \leavevmode\fi\endtrivlist}

\begingroup \catcode `|=0 \catcode `[= 1
\catcode`]=2 \catcode `\{=12 \catcode `\}=12
\catcode`\\=12 |gdef|@xnoskipverbatim#1\end{noskipverbatim}[#1|end[noskipverbatim]]
|gdef|@sxnoskipverbatim#1\end{noskipverbatim*}[#1|end[noskipverbatim*]]
|endgroup
\def\@noskipverbatim{\list{}{\topsep12pt
	\leftmargin0pt\labelwidth0pt\labelsep0pt
	\listparindent0pt\parsep0pt}
	\small \item\relax
  \if@minipage\else\vskip\parskip\fi
  \leftskip\@totalleftmargin\rightskip\z@skip
  \parindent\z@\parfillskip\@flushglue\parskip\z@skip
  \@@par
  \@tempswafalse
  \def\par{%
    \if@tempswa
      \leavevmode \null \@@par\penalty\interlinepenalty
    \else
      \@tempswatrue
      \ifhmode\@@par\penalty\interlinepenalty\fi
    \fi}%
  \obeylines \verbatim@font \@noligs
  \let\do\@makeother \dospecials
  \everypar \expandafter{\the\everypar \unpenalty}%
}
\def\noskipverbatim{\@noskipverbatim \frenchspacing\@vobeyspaces \@xnoskipverbatim}
\def\endnoskipverbatim{\if@newlist \leavevmode\fi\endlist}

\def\myverbatim{\begin{small}\ttfamily\obeylines\obeyspaces}
\def\endmyverbatim{\end{small}}

%%
%% EQUATIONS
%%

\jot=\medskipamount
\def\@xeqncr[#1]{%
   \ifnum0=`{\fi}%
   \@@eqncr
   \noalign{\penalty\@eqpen\vskip\jot\vskip #1\relax}%
}

\def\eqnarray{%
   \stepcounter{equation}%
   \def\@currentlabel{\p@equation\theequation}%
   \global\@eqnswtrue
   \m@th
   \global\@eqcnt\z@
   \tabskip\@centering
   \let\\\@eqncr
   $$\everycr{}\halign to\displaywidth\bgroup
       \hskip\@centering$\displaystyle\tabskip\z@skip{##}$\@eqnsel
      &\global\@eqcnt\@ne \hfil${{}##{}}$\hfil
      &\global\@eqcnt\tw@ 
         $\displaystyle{##}$\hfil\tabskip\@centering
      &\global\@eqcnt\thr@@ \hbox to\z@\bgroup\hss##\egroup
         \tabskip\z@skip
      \cr
}


\newenvironment{description}
               {\list{}{\topsep12pt plus2pt minus2pt
	\itemsep3pt plus2pt minus.5pt
			\labelwidth\z@
				\leftmargin\parindent
				\itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\topsep12pt plus2pt minus2pt
						\leftmargin0pt
						\itemsep      \z@
                        \itemindent0pt%
                        \listparindent\itemindent
                        }%
                \item\relax}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}
\newenvironment{quote}
               {\list{}{\topsep12pt plus2pt minus2pt
			\leftmargin\parindent\rightmargin\leftmargin}%
               \small\item\relax}
               {\endlist}
\newenvironment{iquote}
               {\list{}{\topsep12pt plus2pt minus2pt
			\leftmargin\parindent\rightmargin0pt}%
               \small\item\relax}
               {\endlist}
\if@compatibility
\newenvironment{titlepage}
    {%
      \cleardoublepage
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\z@
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
    }
\else
\newenvironment{titlepage}
    {%
      \cleardoublepage
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\@ne
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
     \if@twoside\else
        \setcounter{page}\@ne
     \fi
    }
\fi
\newcommand\appendix{\global\appendixtrue\par
%\let\@makechapterhead\@makeappendixhead
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand\@chapapp{\appendixname}%
  \renewcommand\thechapter{\@Alph\c@chapter}}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{12\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{.4\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset {equation}{chapter}
\renewcommand\theequation
  {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
\newcounter{figure}[chapter]
\renewcommand \thefigure
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}
               {\let\@caption\@figcaption\@float{figure}}
               {\end@float}
\renewenvironment{figure}
               {\vtop\bgroup\centering\let\@caption\@figcaption\def\@captype{figure}}
               {\egroup}

\long\def\@Outputcaption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \normalsize
    \@makeOutputcaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\ignorespaces
  \endgroup\ignorespaces}

\long\def\@makeOutputcaption#1#2{%
%\vskip\abovecaptionskip
\small\sffamily\mathversion{sans}%
  %\renewcommand\boldmath{\@nomath\boldmath\mathversion{sansbold}}%
%{\bfseries#1}\quad\ignorespaces #2\strut
\@hangfrom{\bfseries#1\quad}\ignorespaces #2\strut
\vskip6pt
%\noindent\rlap{\vrule height18pt width\textwidth depth-17pt}%
%		\rlap{\vrule height18pt width1pt depth-12pt}%
%		\vskip-28pt
}

\newcounter{Output}[chapter]
\renewcommand \theOutput
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@Output}
\def\fps@Output{tbp}
\def\ftype@Output{1}
\def\ext@Output{loo}
\newcommand\Outputname{Output}
\def\fnum@Output{\Outputname~\theOutput}
%\newenvironment{Output}
%               {\let\@caption\@figcaption\@float{Output}}
%               {\end@float}

\def\graybox#1{\hbox to\hsize{\color{fifteengray}\vrule width\textwidth\kern-\textwidth
	\color{black}%
	\hss\begin{minipage}{29.5pc}\vspace*{12pt}#1\vspace*{0pt}\end{minipage}}}

\newenvironment{Output}
               {\vbox\bgroup\let\@caption\@Outputcaption\def\@captype{Output}%
			}
               {%\vskip-12pt
		%\noindent\rlap{\vrule height1pt width\textwidth depth0pt}%
		%\rlap{\hbox to\textwidth{\hss\vrule height6pt width1pt}}
		\egroup}


\def\figskip{\vspace{\textfloatsep}}
\newenvironment{figure*}
               {\let\@caption\@figcaption\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}[chapter]
\renewcommand \thetable
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
               {\let\@caption\@tablecaption\footnotesize\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\let\@caption\@tablecaption\footnotesize\@dblfloat{table}}
               {\end@dblfloat}
\renewenvironment{table}
               {\vtop\bgroup\parindent0pt\centering
					\let\@caption\@tablecaption\def\@captype{table}}
               {\egroup}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}

\long\def\@figcaption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \normalsize
    \@makefigcaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\ignorespaces
  \endgroup\ignorespaces}

\long\def\@tablecaption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \normalsize
    \@maketablecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}

\long\def\@makefigcaption#1#2{%
%\sbox\@tempboxa{\small\sffamily{\bfseries#1}\quad\ignorespaces #2}
%\ifdim \wd\@tempboxa > \hsize
%\vskip\abovecaptionskip
%
\small\sffamily\mathversion{sans}%
%\renewcommand\boldmath{\@nomath\boldmath\mathversion{sansbold}}%
\@hangfrom{\bfseries#1\quad}\ignorespaces #2
%\else
%\hb@xt@\hsize{\hfil\box\@tempboxa\hfil}\fi
 \vskip\abovecaptionskip
}

\long\def\@widefigcaption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \normalsize
    \@makewidefigcaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\ignorespaces
  \endgroup\ignorespaces}

\long\def\@makewidefigcaption#1#2{%
\vspace*{6pt}
\raggedright\small\sffamily%
  %\renewcommand\boldmath{\@nomath\boldmath\mathversion{sansbold}}%
\noindent{\bfseries#1}\vskip0pt #2
}

\newenvironment{widefigure}
               {\noindent\kern-\margwidth
		\vbox\bgroup\hsize\fullwidth
		\let\@caption\@figcaption\parindent0pt\def\@captype{figure}}
               {\egroup}

\newif\ifnarrowcaption	\global\narrowcaptionfalse
\def\narrowcaption{\global\narrowcaptiontrue}

\long\def\@maketablecaption#1#2{%
\small\sffamily\mathversion{sans}\raggedright%
 % \renewcommand\boldmath{\@nomath\boldmath\mathversion{sansbold}}%
\ifnarrowcaption{\bfseries#1\quad}%
\else
\@hangfrom{\bfseries#1\quad}\fi\ignorespaces #2\brule\par
  \global\narrowcaptionfalse\vskip\belowcaptionskip}

\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }
\renewcommand\tableofcontents{\begingroup
  \makeatletter  
  \if@filesw \expandafter\newwrite\csname tf@toc\endcsname
             \expandafter\openout \csname tf@toc\endcsname \jobname.toc\relax
  \fi \global\@nobreakfalse \endgroup}

%% auto-generate chapter TOC's, always need \tableofcontents
\tableofcontents

\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}

\def\numberline#1{\llap{\hbox{\catcode`\~=13\def~{\hphantom{0}}%
	\tocnumfont#1}\hskip\@tempdima}}

%\font\twfrbf  = phvb at 24pt		% roman

\newdimen\fmtoc	\settowidth\fmtoc{\large\sffamily\bfseries 10\quad}
\newdimen\fmtocsec	\settowidth\fmtocsec{\large\sffamily 1.1\quad}
%\newcommand\setfmtoc[1]{\settowidth\fmtoctoc{\large\sffamily#1\quad}}
\newdimen\fmtocsub	\settowidth\fmtocsub{\large\sffamily 1.1.1\quad}

\newcommand*\l@chapter[2]{\let\\=\tempbreak\addpenalty{-\@highpenalty}
	\vskip12pt plus.5pt minus.5pt
	\@tempdima 0pt \begingroup
	\def\appnumberline##1{\llap{Appendix\ ##1\quad}\ignorespaces}%
	\def\numberline##1{\llap{Chapter\ ##1\quad}\ignorespaces}%
%\def\tocnumfont{\sffamily\bfseries}%
 \parindent \z@\raggedright %\hangindent=12pt \hangafter=1	% turnovers indenting 12pt
										% removed 10-10-92, -dwd
	\leftskip0pt
 \tocsecsize\bfseries\sffamily\mathversion{sansbold}\leavevmode #1\nobreak\hfill\nobreak#2\par
 \penalty\@highpenalty \endgroup}

\newcommand*\l@appendix[2]{\let\\=\tempbreak\addpenalty{-\@highpenalty} 
 \vskip 27pt plus 6pt minus6pt
\@tempdima 12pt \begingroup
\def\tocnumfont{\large\sffamily\bfseries}%
\def\numberline##1{\llap{\tocnumfont APPENDIX ##1\hskip\@tempdima}}
 \parindent \z@
 \large\sffamily\bfseries\mathversion{sansbold}\leavevmode \MakeUppercase{#1}\nobreak\hfill
 \nobreak\hbox to\@pnumwidth{\hss #2}
 \par\nobreak\vskip2pt
 \penalty\@highpenalty \endgroup}

\newcommand\l@section[2]{\let\\=\tempbreak\addpenalty{-\@highpenalty}
	\vskip2pt plus.5pt minus.5pt
	\@tempdima 0pt \begingroup
	\def\numberline##1{\llap{##1\quad}\ignorespaces}%
%\def\tocnumfont{\sffamily\bfseries}%
 \parindent \z@ %\hangindent=12pt \hangafter=1	% turnovers indenting 12pt
		% removed 10-10-92, -dwd
	\raggedright\leftskip\fmtocsec %\advance\leftskip\fmtocsec
 \large\sffamily\mathversion{sans}\leavevmode #1\nobreak\hskip12pt\nobreak#2\par
 \penalty\@highpenalty \endgroup}

%\def\l@subsection#1#2{\let\\=\tempbreak\addpenalty{-\@highpenalty} 
% \@tempdima 12pt \begingroup
% \parindent \z@ 
% \def\numberline##1{\catcode`\~=13\def~{\hphantom{0}}%
%	\setbox\@tempboxb=\hbox{\tocnumfont##1\quad\ignorespaces}%
%	\@tempdimb=\wd\@tempboxb \hangindent=\@tempdimb \hangafter=0
%	\llap{\tocnumfont##1\quad\ignorespaces}}
% \normalsize \leavevmode #1\nobreak\hskip12pt\nobreak#2\par\vskip0pt
% \penalty\@highpenalty \endgroup}
%\def\l@subsection#1#2{\relax}

\newcommand\l@subsection[2]{\let\\=\tempbreak\addpenalty{-\@highpenalty}
	\vskip2pt plus.5pt minus.5pt
	\@tempdima 0pt \begingroup
	\def\numberline##1{\llap{##1\quad}\ignorespaces}%
 \parindent \z@ %\hangindent=12pt \hangafter=1	% turnovers indenting 12pt
		% removed 10-10-92, -dwd
	\raggedright\leftskip\fmtocsec\advance\leftskip\fmtocsub
 \large\sffamily\mathversion{sans}\leavevmode #1\nobreak\hskip12pt\nobreak#2\par
 \penalty\@highpenalty \endgroup}


\newcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{12em}{6em}}

\newdimen\chaptoc	\settowidth\chaptoc{\large\sffamily 1.1\quad}
\newcommand\settoc[1]{\settowidth\chaptoc{\large\sffamily#1\quad}}
\newdimen\chapsubtoc	\settowidth\chapsubtoc{\large\sffamily A.31.1\quad}
\newcommand\setsubtoc[1]{\settowidth\chapsubtoc{\large\sffamily#1\quad}}


\newcommand\chap@chapter[2]{\relax}
\newcommand\chap@section[2]{\let\\=\tempbreak\addpenalty{-\@highpenalty}
	\vskip2pt plus.5pt minus.5pt
	\@tempdima 0pt \begingroup
	\def\numberline##1{\llap{##1\quad}\ignorespaces}%
%\def\tocnumfont{\sffamily\bfseries}%
 \parindent \z@ %\hangindent=12pt \hangafter=1	% turnovers indenting 12pt
						% removed 10-10-92, -dwd
	\raggedright\leftskip\chaptoc
 \large\sffamily\mathversion{sans}\leavevmode #1%\nobreak\hskip12pt\nobreak
	\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep
       mu$}\hfill#2\par
 \penalty\@highpenalty \endgroup}
\newcommand\chap@subsection[2]{\relax}
\newcommand\chap@subsubsection[2]{\relax}
\newcommand\chap@paragraph[2]{\relax}
\newcommand\chap@subparagraph[2]{\relax}

\let\chapsub@chapter\chap@chapter
\let\chapsub@section\chap@section
\let\chapsub@subsubsection\chap@subsubsection
\let\chapsub@paragraph\chap@paragraph
\let\chapsub@subparagraph\chap@subparagraph
\newcommand\chapsub@subsection[2]{\let\\=\tempbreak\addpenalty{-\@highpenalty}
	\vskip2pt plus.5pt minus.5pt
	\@tempdima 0pt \begingroup
	\def\numberline##1{\llap{##1\quad}\ignorespaces}%
%\def\tocnumfont{\sffamily\bfseries}%
 \parindent \z@ %\hangindent=12pt \hangafter=1	% turnovers indenting 12pt
						% removed 10-10-92, -dwd
	\raggedright\leftskip\chaptoc\advance\leftskip\chapsubtoc
 \large\sffamily\mathversion{sans}\leavevmode #1%\nobreak\hskip12pt\nobreak
	\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep
       mu$}\hfill#2\par
 \penalty\@highpenalty \endgroup}

\newcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename
      \@mkboth{%
          \MakeUppercase\listtablename}{\MakeUppercase\listtablename}}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\def\bibitem[#1]#2{\item[]\ignorespaces}
\newenvironment{thebibliography}[1]
     {\chapter*{\bibname}%
	\markright{\bibname}
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {%\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin12pt\labelwidth0pt
			\itemindent-12pt
           \labelsep0pt
			\itemsep2pt plus.5pt minus.5pt
            %\@openbib@code
            %\usecounter{enumiv}%
            %\let\p@enumiv\@empty
            %\renewcommand\theenumiv{\@arabic\c@enumiv}
			}%
      \small\sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\RequirePackage{multicol}
\renewenvironment{theindex}
               {\columnseprule \z@
                \columnsep 18\p@
                \parindent\z@
                \parskip\z@\relax
				\small\raggedright
				\list{}{\leftmargin-\margwidth\topsep0pt
						\labelwidth0pt\labelsep0pt
						\parsep0pt}\item[]%
                \begin{multicols}{3}
				\let\item\@idxitem}
               {\end{multicols}\endlist}
\newcommand\@idxitem{\par\hangindent 3em}
\newcommand\subitem{\@idxitem \hspace*{1em}}
\newcommand\subsubitem{\@idxitem \hspace*{2em}}
\newcommand\indexspace{\par \vskip\baselineskip\relax}
\renewcommand\footnoterule{%
  \kern6\p@
  \hrule\@width6pc
  \kern2.6\p@}
\@addtoreset{footnote}{chapter}
\newcommand\@makefntext[1]{%
    \parindent 24pt
    \noindent
    \strut\@makefnmark#1}
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{References}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{headings}
\pagenumbering{arabic}
\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi

\def\intro{\list{}{\topsep0pt\leftmargin-\margwidth\listparindent\parindent}
	\large\item[]%\begin{large}\leftskip-\margwidth\relax%\sffamily\mathversion{sans}%
%\renewcommand\boldmath{\@nomath\boldmath\mathversion{sansbold}}%
%\color{fiftygray}
}
\def\endintro{\endlist}


\newcounter{program}
\def\theprogram{\thechapter.\arabic{program}}

\def\program{\@ifnextchar [{\opargprogram}{\regprogram}}

\def\opargprogram[#1]{\refstepcounter{program}
	\list{}{\topsep12pt plus2pt minus2pt
	\leftmargin0pt\labelwidth0pt\labelsep0pt
	\parsep0pt
	\def\makelabel##1{##1}}
	\item[\strut\llap{\sffamily\bfseries PROGRAM \theprogram\kern1pc}]%
		{\sffamily\bfseries\mathversion{sansbold}#1}
		\quad\ignorespaces}
\def\regprogram{\refstepcounter{program}
	\list{}{\topsep12pt plus2pt minus2pt
	\leftmargin0pt\labelwidth0pt\labelsep1em
	\parsep0pt
	\def\makelabel##1{##1}}
	\item[\hskip\labelsep\llap{\sffamily\bfseries PROGRAM \theprogram\kern1pc}]
	\strut\ignorespaces}
\def\endprogram{\endlist}

%\newtheorem{theorem}{Theorem}[section]

\newcounter{example}[chapter]
\def\theexample{\thechapter.\arabic{example}}

\def\example{\@ifnextchar [{\opargexample}{\regexample}}

\def\regexample#1{\refstepcounter{example}%
	\def\theexamplename{#1}%
	\list{}{\topsep12pt plus4pt minus2pt
	\leftmargin0pt
	\labelwidth0pt\labelsep0pt
	\listparindent\parindent
	\itemsep6pt plus1pt minus1pt
	\def\makelabel##1{\hss\llap{\hbox to\margwidth{\hss\sffamily\bfseries##1\quad}}}}
	%\renewcommand\proofbox{\hbox{$\triangle$}}%
	\item[EXAMPLE \theexample]\ixe{#1|(}{\mathversion{sansbold}\sffamily\bfseries#1}\label{ex:#1}
		%\quad
	\item[]
		\ignorespaces}

\def\opargexample[#1]#2{\refstepcounter{example}%
	\def\theexamplename{#2}%
	\list{}{\topsep12pt plus4pt minus2pt
	\leftmargin0pt
	\labelwidth0pt\labelsep0pt
	\listparindent\parindent
	\itemsep6pt plus1pt minus1pt
	\def\makelabel##1{\hss\llap{\hbox to\margwidth{\hss\sffamily\bfseries##1\quad}}}}
	%\renewcommand\proofbox{\hbox{$\triangle$}}%
	\item[EXAMPLE \theexample]\ixe{#2|(}%
	{\mathversion{sansbold}\sffamily\bfseries#2}\label{ex:#1}%\quad
	\item[]
		\ignorespaces}

\def\endexample{\expandafter\ixe\expandafter{\theexamplename|)}\endlist}

\newenvironment{solution}{\list{}{\leftmargin0pt
	\labelwidth0pt\labelsep0pt
	\listparindent\parindent
	\def\makelabel##1{\hss\llap{\sffamily##1\kern1pc}}}
	\item[Solution]}{\endlist}

\newenvironment{proof}{\list{}{\leftmargin0pt
	\labelwidth0pt\labelsep0pt
	\listparindent\parindent
	\def\makelabel##1{\hss\llap{\sffamily##1\kern1pc}}}
	\item[Proof]}{\endlist}

%\def\proofbox{\vbox{\hrule height.3pt
%	\hbox{\vrule width.3pt height6pt\kern5.4pt\vrule width.3pt}
%	\hrule height.3pt}}

\def\algorithm{\@ifnextchar [{\opargalgorithm}{\regalgorithm}}

\def\opargalgorithm[#1]{%
	\list{}{\leftmargin0pt
	\labelwidth0pt\labelsep0pt
	\listparindent\parindent
	\def\makelabel##1{\color{fiftygray}\hss\llap{\sffamily\bfseries##1\kern1pc}}}
	\properties
	\item[ALGORITHM]{\bfseries\itshape#1}\quad\ignorespaces}

\def\regalgorithm{%
	\list{}{\leftmargin0pt
	\labelwidth0pt\labelsep0pt
	\listparindent\parindent
	\def\makelabel##1{\color{fiftygray}\hss\llap{\sffamily\bfseries##1\kern1pc}}}
	\properties
	\item[ALGORITHM]}

\let\endalgorithm\endlist

\def\properties{\let\enumerate=\propertiesenumerate
	\let\endenumerate=\endpropertiesenumerate}


\def\property{\@ifnextchar [{\opargproperty}{\regproperty}}

\def\opargproperty[#1]{%
	\list{}{\leftmargin0pt
	\labelwidth0pt\labelsep0pt
	\listparindent\parindent
	\def\makelabel##1{\color{fiftygray}\hss\llap{\sffamily\bfseries##1\kern1pc}}}
	\properties
	\item[PROPERTIES]{\bfseries\itshape#1}\quad\ignorespaces}

\def\regproperty{%
	\list{}{\leftmargin0pt
	\labelwidth0pt\labelsep0pt
	\listparindent\parindent
	\def\makelabel##1{\color{fiftygray}\hss\llap{\sffamily\bfseries##1\kern1pc}}}
	\properties
	\item[PROPERTIES]}

\let\endproperty\endlist


%
%	\list{}{\leftmargin0pt
%	\labelwidth0pt\labelsep0pt
%	\listparindent\parindent
%	\def\makelabel##1{\color{fiftygray}\hss\llap{\sffamily\bfseries##1\kern1pc}}}
%	\item[PROPERTIES]}

\let\endproperties\relax

\usepackage{qedequation}

%% for tables
\def\arule{\vrule height11pt width0pt depth0pt}
\def\brule{\vrule height0pt width0pt depth5.5pt}
\def\abrule{\vrule height11pt width0pt depth5.5pt}
%\def\D{\hphantom{1}}
%\def\M{\hphantom{\hbox{$-$}}}
\def\settildes{\catcode`\~=\active
	\def~{\hphantom{1}}}


%\def\@eqnnum{{\reset@font\rmfamily \normalcolor (\theequation)}}

\def\itemize{%
  \ifnum \@itemdepth >3 \@toodeep\else \advance\@itemdepth \@ne
  \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
  \list{\csname\@itemitem\endcsname}%
       {\ifnum\@itemdepth=1
		\topsep12pt plus2pt minus1pt
	\else
		\topsep6pt plus1pt minus1pt
	\fi
	\settowidth\labelwidth{\textbullet}%
	\labelsep.5em
	\leftmargin\labelwidth\advance\leftmargin by\labelsep
	\listparindent\parindent
	\itemsep3pt plus.5pt minus.5pt
\def\makelabel##1{\hss\llap{##1}}}\fi}

\let\enditemize =\endlist

\def\unlist{%
  \ifnum \@itemdepth >3 \@toodeep\else \advance\@itemdepth \@ne
  \list{}%
       {\topsep12pt plus2pt minus1pt
	\labelsep0pt
	\leftmargin\parindent
	\itemsep3pt plus.5pt minus.5pt
}\fi}

\let\endunlist =\endlist

\def\enumerate{\@ifnextchar [{\opargenum}{\regenum}}

\def\opargenum[#1]{\ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
      {\csname label\@enumctr\endcsname}{\usecounter
        {\@enumctr}%
	\ifcase\@enumdepth\or
		\topsep12pt plus2pt minus1pt\or
		\topsep3pt plus.5pt minus.5pt\or
		\topsep3pt plus.5pt minus.5pt\fi	
	\settowidth\labelwidth{#1}
	\listparindent\parindent
	\labelsep.5em
	\leftmargin\labelwidth\advance\leftmargin by\labelsep
	\itemsep3pt plus.5pt minus.5pt
	\def\makelabel##1{\hss\llap{##1}}}
	%\def\labelenumii{\alph{enumii}.}
	\fi}

\def\regenum{\ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
      {\csname label\@enumctr\endcsname}{\usecounter
        {\@enumctr}%
	\ifcase\@enumdepth\or
		\topsep12pt plus2pt minus1pt
		\settowidth\labelwidth{1.}\or
		\topsep3pt plus.5pt minus.5pt
		\settowidth\labelwidth{(b)}\or
		\topsep3pt plus.5pt minus.5pt
		\settowidth\labelwidth{(iii)}\fi	
	\labelsep.5em
	\leftmargin\labelwidth\advance\leftmargin by\labelsep
	\itemsep3pt plus.5pt minus.5pt
	\def\makelabel##1{\hss\llap{##1}}}
	%\def\labelenumii{\alph{enumii}.}
	\fi}

\let\endenumerate =\endlist

\def\flenumerate[#1]{\ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
      {\csname label\@enumctr\endcsname}{\usecounter
        {\@enumctr}%
	\ifcase\@enumdepth\or
		\topsep12pt plus2pt minus1pt\or
		\topsep3pt plus.5pt minus.5pt\or
		\topsep3pt plus.5pt minus.5pt\fi	
	\settowidth\labelwidth{#1}
	\labelsep.5em
	\leftmargin\labelwidth\advance\leftmargin by\labelsep
	\itemsep3pt plus.5pt minus.5pt
	\def\makelabel##1{\rlap{##1}\hss}}
	%\def\labelenumii{\alph{enumii}.}
	\fi}

\def\endflenumerate{\endlist}

\def\subenumerate[#1]{\ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
      {\csname label\@enumctr\endcsname}{\usecounter
        {\@enumctr}%
	\ifcase\@enumdepth\or
		\topsep3pt plus.5pt minus.5pt\or
		\topsep3pt plus.5pt minus.5pt\or
		\topsep3pt plus.5pt minus.5pt\fi	
	\settowidth\labelwidth{#1}
	\labelsep.5em
	\leftmargin\labelwidth\advance\leftmargin by\labelsep
	\itemsep3pt plus.5pt minus.5pt
	\def\makelabel##1{\hss\llap{##1}}}
	%\def\labelenumii{\alph{enumii}.}
	\fi}

\let\endsubenumerate =\endlist


\def\propertiesenumerate{\@ifnextchar [{\opargpropenum}{\regpropenum}}

\def\opargpropenum[#1]{\ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
      {\csname label\@enumctr\endcsname}{\usecounter
        {\@enumctr}%
	\ifcase\@enumdepth\or
		\topsep6pt plus2pt minus1pt\or
		\topsep3pt plus.5pt minus.5pt\or
		\topsep3pt plus.5pt minus.5pt\fi	
	\settowidth\labelwidth{\bf#1}
	\labelsep.5em
	\leftmargin\labelwidth\advance\leftmargin by\labelsep
	\itemsep3pt plus.5pt minus.5pt
	\def\makelabel##1{\hss\llap{\bf##1}}}
	%\def\labelenumii{\alph{enumii}.}
	\fi}

\def\regpropenum{\ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
      {\csname label\@enumctr\endcsname}{\usecounter
        {\@enumctr}%
	\ifcase\@enumdepth\or
		\topsep6pt plus2pt minus1pt
		\settowidth\labelwidth{\bf1.}\or
		\topsep3pt plus.5pt minus.5pt
		\settowidth\labelwidth{\bf(b)}\or
		\topsep3pt plus.5pt minus.5pt
		\settowidth\labelwidth{\bf(iii)}\fi	
	\labelsep.5em
	\leftmargin\labelwidth\advance\leftmargin by\labelsep
	\itemsep3pt plus.5pt minus.5pt
	\def\makelabel##1{\hss\llap{\bf##1}}}
	%\def\labelenumii{\alph{enumii}.}
	\fi}

\let\endpropertiesenumerate =\endlist

\def\problemsenum{\@ifnextchar [{\opargpenum}{\regpenum}}

\def\opargpenum[#1]{\ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
      {\csname label\@enumctr\endcsname}{\usecounter
        {\@enumctr}%
	\ifcase\@enumdepth\or
		\topsep6pt plus2pt minus1pt\or
		\topsep3pt plus.5pt minus.5pt\or
		\topsep3pt plus.5pt minus.5pt\fi	
	\settowidth\labelwidth{\bf#1}
	\labelsep.5em
	\leftmargin\labelwidth\advance\leftmargin by\labelsep
	\itemsep3pt plus.5pt minus.5pt
	\def\makelabel##1{\hss\llap{\bf##1}}}
	\def\labelenumii{\alph{enumii}.}\fi}

\def\regpenum{\ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
      {\csname label\@enumctr\endcsname}{\usecounter
        {\@enumctr}%
	\ifcase\@enumdepth\or
		\topsep6pt plus2pt minus1pt
		\settowidth\labelwidth{\bf 1.}\or
		\topsep3pt plus.5pt minus.5pt
		\settowidth\labelwidth{\bf b.}\or
		\topsep3pt plus.5pt minus.5pt
		\settowidth\labelwidth{\bf(iii)}\fi	
	\labelsep.5em
	\leftmargin\labelwidth\advance\leftmargin by\labelsep
	\itemsep3pt plus.5pt minus.5pt
	\def\makelabel##1{\hss\llap{\bf##1}}}
	\def\labelenumii{\alph{enumii}.}\fi}

\let\endproblemsenum =\endlist

\def\answers{\@ifnextchar [{\oparganswers}{\reganswers}}

\def\oparganswers[#1]{\ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
      {\csname label\@enumctr\endcsname}{\usecounter
        {\@enumctr}%
	\ifcase\@enumdepth\or
		\topsep6pt plus2pt minus1pt
		\topsep3pt plus.5pt minus.5pt
		\topsep3pt plus.5pt minus.5pt\fi
	\labelwidth0pt
	\labelsep.5em
	\leftmargin0pt
	\itemsep3pt plus.5pt minus.5pt
	\def\makelabel##1{\hskip\labelsep{\bf##1}}}
	\def\labelenumii{\alph{enumii}.}\fi}

\def\reganswers{\ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
      {\csname label\@enumctr\endcsname}{\usecounter
        {\@enumctr}%
	\ifcase\@enumdepth\or
		\topsep6pt plus2pt minus1pt
		\topsep3pt plus.5pt minus.5pt
		\topsep3pt plus.5pt minus.5pt\fi
	\labelwidth0pt
	\labelsep.5em
	\leftmargin0pt
	\itemsep3pt plus.5pt minus.5pt
	\def\makelabel##1{\hskip\labelsep{\bf##1}}}
	\def\labelenumii{\alph{enumii}.}\fi}

\let\endanswers =\endlist

%\def\qitem[#1]{\hskip-\lastskip\qquad\textbf{#1}\enspace\ignorespaces}

\def\problems{\list{}{\topsep20pt plus4pt minus4pt
	\leftmargin0pt
	\labelwidth8.5pc
	\labelsep1pc
	\def\makelabel##1{\vrule height20pt width0pt
		$\smash{\rlap{\color{fiftygray}\large\sffamily\bfseries
			\begin{tabular}[t]{@{}l@{}}##1\end{tabular}}}$\hss}}
	\let\enumerate\problemsenum
	\let\endenumerate\endproblemsenum
	\item[\rlap{\vrule height20.5pt width\fullwidth depth-20pt}%
		\rlap{\vrule height18.5pt width\fullwidth depth-18pt}%
		PROBLEMS\\ \thesection]}
\def\endproblems{\endlist}

\def\cproblems{\list{}{\topsep20pt plus4pt minus4pt
	\leftmargin0pt
	\labelwidth8.5pc
	\labelsep1pc
	\def\makelabel##1{\vrule height20pt width0pt
		$\smash{\rlap{\color{fiftygray}\large\sffamily\bfseries
			\begin{tabular}[t]{@{}l@{}}##1\end{tabular}}}$\hss}}
	\let\enumerate\problemsenum
	\let\endenumerate\endproblemsenum
	\item[\rlap{\vrule height20.5pt width\fullwidth depth-20pt}%
		\rlap{\vrule height18.5pt width\fullwidth depth-18pt}%
		COMPUTER\\ PROBLEMS\\ \thesection]}
\def\endcproblems{\endlist}

\input colordvi

\def\boxedminipage{\@ifnextchar [{\@iboxedminipage}{\@iboxedminipage[c]}}

\def\@iboxedminipage[#1]#2{\leavevmode \@pboxswfalse
  \if #1b\vbox 
    \else \if #1t\vtop 
	     \else \ifmmode \vcenter 
		       \else \@pboxswtrue $\vcenter
		    \fi
	  \fi
  \fi\bgroup % start of outermost vbox/vtop/vcenter
    \hsize #2
    \hrule\@height\fboxrule
    \hbox\bgroup % inner hbox
      \vrule\@width\fboxrule \hskip\fboxsep \vbox\bgroup % innermost vbox
	\vskip8pt %\fboxsep
	\advance\hsize -2\fboxrule \advance\hsize-2\fboxsep
	\textwidth\hsize \columnwidth\hsize
	\@parboxrestore 
	\def\@mpfn{mpfootnote}\def\thempfn{\thempfootnote}\c@mpfootnote\z@
	\let\@footnotetext\@mpfootnotetext
	\let\@listdepth\@mplistdepth \@mplistdepth\z@
	\@minipagerestore\@minipagetrue 
	\everypar{\global\@minipagefalse\everypar{}}}

\def\endboxedminipage{%
	\par\vskip-\lastskip
	\ifvoid\@mpfootins\else
	  \vskip\skip\@mpfootins\footnoterule\unvbox\@mpfootins\fi
	\vskip9pt %\fboxsep
      \egroup % ends the innermost \vbox
      \hskip\fboxsep \vrule\@width\fboxrule
    \egroup % ends the \hbox
    \hrule\@height\fboxrule
  \egroup% ends the vbox/vtop/vcenter
  \if@pboxsw $\fi}

\def\theorem[#1]{\list{}{\topsep15pt plus2pt minus2pt
	\leftmargin0pt\labelwidth0pt\labelsep0pt
	}\fboxsep12pt\fboxrule = .5pt
	\properties
	\item[] \strut\vtop\bgroup\parindent0pt\strut\vskip-12pt
		\color{fiftygray}\noindent\vrule width\textwidth\kern-\textwidth
			\kern12pt\begin{minipage}{25.5pc}
			\parindent0pt\raggedright
			{\color{white}\sffamily\bfseries\mathversion{sansbold}%
				\vrule height16pt width0pt
				\ignorespaces
			\MakeUppercase{#1}\vrule width0pt depth8pt}\end{minipage}
			\vskip-1.5pt
			\noindent\begin{boxedminipage}{\textwidth}
			\color{black}\parindent=24pt\noindent\ignorespaces}
\def\endtheorem{\end{boxedminipage}\egroup\endlist}
			
\def\definition[#1]{%\refstepcounter{example}%
	\list{}{\leftmargin0pt
	\labelwidth0pt\labelsep0pt
	\listparindent\parindent
	\itemsep6pt plus 1pt minus1pt
	\def\makelabel##1{\hss\llap{\hbox to\margwidth{\hss
		\sffamily\bfseries##1\quad}}}}
	\renewcommand\proofbox{\hbox{$\triangle$}}%
	\item[DEFINITION:]{\sffamily\mathversion{sansbold}\bfseries#1}\quad
	\item[]
		\ignorespaces}

\def\enddefinition{\endlist}

			
%%
%% Modify output for trim marks, tagline
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TRIM MARKS
%% Trim marks added here.  The default is to have the trim
%% marks on, to turn them off call \trimmarksfalse somewhere
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newdimen\fudgetrimdown		\fudgetrimdown=-6pt
\newdimen\fudgetrimright	\fudgetrimright=0pt
\newif\iftrimmarks  \trimmarkstrue \trimmarksfalse

\def\tlmark{\hbox{\vrule height .5pt depth 0pt width 18pt%
		\hskip 5.5pt%
		\vrule height 24pt depth -6pt width .5pt}}

\def\trmark{\hbox{\vrule height 24pt depth -6pt width .5pt
		\hskip 5.5pt%
		\vrule height .5pt depth 0pt width 18pt}}%

\def\brmark{\hbox{\vrule height -6pt depth 24pt width .5pt
		\hskip 5.5pt%
		\vrule height .5pt depth 0pt width 18pt}}%

\def\blmark{\hbox{\vrule height .5pt depth 0pt width 18pt%
		\hskip 5.5pt%
		\vrule height -6pt depth 24pt width .5pt}}

\def\imagemarks{\vbox to 0pt{%
	\advance\paperwidth by 48pt\advance\paperheight by 48pt%
	%% I'm not sure why the below fudges are needed
	\advance\paperwidth by -1pt%
	\advance\paperheight by -26pt%
	\hbox{\hskip-24pt\hskip\fudgetrimright%
	\vbox to 0pt{\vskip -24pt\vskip\fudgetrimdown%
		\vbox to \paperheight{%
		\hbox to \paperwidth{\tlmark\hss\trmark}%
		\vss%
		\hbox to \paperwidth{\blmark\hss\brmark}%
		}%
	\vss}}}}

\def\timestring{\begingroup
	\count0 = \time \divide\count0 by 60
	\count2 = \count 0 %The hour.
	\count4 = \time \multiply\count0 by 60
	\advance\count4 by -\count0 %The minute.
	\ifnum\count4<10 \toks1 = {0}% Get a leading zero.
	\else            \toks1 = {}%
	\fi
	\ifnum\count2<12 \toks0 = {a.m.}%
	\else            \toks0 = {p.m.}%
		\advance\count2 by -12
	\fi
	\ifnum\count2=0 \global\count2=12\relax\fi % Make noon and midnight `12'.
	\number\count2:\the\toks1 \number\count4
	\thinspace \the\toks0
\endgroup}
\def\timestamp{\number\day\space\monthname\space\number\year\quad\timestring}

\def\@outputpage{%
  \let \protect \noexpand
  \shipout \vbox{%
    \set@typeset@protect
    \aftergroup\set@typeset@protect
    \@shipoutsetup
    \@begindvi
\iftrimmarks\vbox to0pt{\vskip700pt\hbox to\hsize{\footnotesize
		Integre Technical Publishing Co., Inc.\qquad
			Friendly\qquad Visualizing Categ. Data\qquad\today\quad\timestring
			\qquad\jobname\qquad page \thepage\hss}\vss}
	   %\imagemarks
	   		\global\voffset=0in
			\global\hoffset=0in
			\else
			\global\voffset=0in
			\global\hoffset=0in
			\vbox to 0pt{}\fi%
    \vskip \topmargin
    \moveright\@themargin \vbox {%
      \setbox\@tempboxa \vbox to\headheight{%
        \vfil
        \color@hbox
          \normalcolor
          \hbox to\textwidth {%
            \let \label \@gobble
            \let \index \@gobble
            \let \glossary \@gobble %% 21 Jun 91
            \@thehead
            }%
        \color@endbox
        }%                        %% 22 Feb 87
      \dp\@tempboxa \z@
      \box\@tempboxa
      \vskip \headsep
      \box\@outputbox
      \baselineskip \footskip
		\vskip-7pt %for footer position
      \color@hbox
        \normalcolor
        \hbox to\textwidth{%
          \let \label \@gobble
          \let \index \@gobble      %% 22 Feb 87
          \let \glossary \@gobble   %% 21 Jun 91
          \@thefoot
          }%
      \color@endbox
      }%
    }%
  \global \@colht \textheight
  \stepcounter{page}%
  \let\firstmark\botmark
}
\def \@shipoutsetup {%
     \@resetactivechars
     \let\-\@dischyph
     \let\'\@acci\let\`\@accii\let\=\@acciii
     \if@specialpage
       \global\@specialpagefalse\@nameuse{ps@\@specialstyle}%
     \fi
     \if@twoside
       \ifodd\count\z@ \let\@thehead\@oddhead \let\@thefoot\@oddfoot
            \let\@themargin\oddsidemargin
       \else \let\@thehead\@evenhead
          \let\@thefoot\@evenfoot \let\@themargin\evensidemargin
       \fi
     \fi
     \reset@font
     \normalsize
     \baselineskip\z@skip \lineskip\z@skip \lineskiplimit\z@
     \let\par\@@par          %% 15 Sep 87
}
\def \@begindvi{%
  \unvbox \@begindvibox
  \global\let \@begindvi \@empty
}

%%added by bw to page balance:
\def\newpage{\par\relax\vskip-\lastskip\penalty -\@M}

\let\textsl=\textit
\let\sl=\it
\hyphenation{Table Tables ex-ample ex-amples}
\emergencystretch10pt


%% AUTHOR MACROS

\def\a{\alpha}
\def\e{\epsilon}
\def\s{\sigma}
\def\text#1{\mathrm{#1}}
\def\pv{$p$-value}
\def\ap{\tilde p}
\def\b{\beta}

\newcommand\makeboldchar[1]{\mathchoice{\mbox{\boldmath$#1$}}
	{\mbox{\boldmath$#1$}}
	{\mbox{\scriptsize\boldmath$#1$}}
	{\mbox{\scriptsize\boldmath$#1$}}}

\newcommand{\bmu}{\makeboldchar{\mu}}
\newcommand{\blambda}{\makeboldchar{\lambda}}
\newcommand{\bSigma}{\makeboldchar{\Sigma}}
\newcommand{\be}{\makeboldchar{\epsilon}}
\newcommand{\bG}{\makeboldchar{\Gamma}}
\newcommand{\btheta}{\makeboldchar{\theta}}
\newcommand{\bsigma}{\makeboldchar{\sigma}}
\newcommand{\bd}{\makeboldchar{\delta}}
\newcommand{\bl}{\makeboldchar{\ell}}
\newcommand{\bb}{\makeboldchar{\beta}}
\newcommand{\bbeta}{\makeboldchar{\beta}}
\newcommand{\Rho}{\makeboldchar{\rho}}
\newcommand{\bgamma}{\makeboldchar{\gamma}}
\newcommand{\bzero}{\ensuremath{\mathbf{0}}}
\newcommand{\bz}{\ensuremath{\mathbf{z}}}
\newcommand{\bx}{\ensuremath{\mathbf{x}}}
\newcommand{\bZ}{\ensuremath{\mathbf{Z}}}
\newcommand{\bT}{\ensuremath{\mathbf{T}}}
\newcommand{\bP}{\ensuremath{\mathbf{P}}}
\newcommand{\bt}{\ensuremath{\mathbf{t}}}
\newcommand{\bu}{\ensuremath{\mathbf{u}}}
\newcommand{\bv}{\ensuremath{\mathbf{v}}}
\newcommand{\bY}{\ensuremath{\mathbf{Y}}}
\newcommand{\by}{\ensuremath{\mathbf{y}}}
\newcommand{\bD}{\ensuremath{\mathbf{D}}}
\newcommand{\bdd}{\ensuremath{\mathbf{d}}}
\newcommand{\bX}{\ensuremath{\mathbf{X}}}
\newcommand{\bC}{\ensuremath{\mathbf{C}}}
\newcommand{\bV}{\ensuremath{\mathbf{V}}}
\newcommand{\bI}{\ensuremath{\mathbf{I}}}
\newcommand{\bc}{\ensuremath{\mathbf{c}}}
\newcommand{\bM}{\ensuremath{\mathbf{M}}}
\newcommand{\bR}{\ensuremath{\mathbf{R}}}
\def\d{\delta}
\def\g{\gamma}
\def\Hc{H\colon } %{H\!\! :}
\def\c{\colon } %{\!\! :}
\def\emdash{\,---\,}

\def \AEnamefontfirst #1{{\rm #1}}%
\def \AEnamefontrest  #1{{\rm #1}}%
\def \AEpagefontfirst #1{{\bf #1}}%
\def \AEpagefontrest  #1{{\rm #1}}%


\def\dotfill{\leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep
       mu$}\hfill}
\endinput
%%
%% End of file `book.cls'.
