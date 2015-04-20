%%
%% This is file `diss.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% diss.dtx  (with options: `diss')
%%   LS Info III Dissertation class.
\def\filename{diss.dtx}
\def\fileversion{2.8}
\def\filedate{28 Dec 98}
\def\docdate{01 Dec 98}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{diss}[1996/25/09 UniWue LS f. Informatik III Diss class.]
\DeclareOption{german}{\AtEndOfClass{\selectlanguage{german}}}
\DeclareOption{draft}{
 \AtEndOfClass{
   \RequirePackage{showidx}
   \global\overfullrule=1mm
   \tolerance=200               % these are the LaTeX2e defaults
   \hbadness=1000
   \vbadness=1000
   \def\@evenfoot{\vbox{\hsize=\textwidth
    \if@fsl \hrule \vskip 3pt \fi
    \hbox to \textwidth{{\pnumfont\thepage\hfil\texttt{\today}}}}}
   \def\@oddfoot{\vbox{\hsize=\textwidth
    \if@fsl \hrule \vskip 3pt \fi
    \hbox to \textwidth{{\pnumfont\texttt{\today}\hfil\thepage}}}}
 }
}
\newif\ifd@pdf \d@pdffalse
\DeclareOption{pdf}{
 \d@pdftrue
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ProcessOptions
% \LoadClass[10pt,twoside,fleqn,headsepline,headinclude]{scrbook}
\LoadClass[10pt,twoside,fleqn,headsepline]{scrbook}
\RequirePackage{makeidx}
\RequirePackage[german,english]{babel}
%%\RequirePackage{i3logo}
\usepackage{color} % funzt sonst nicht
\RequirePackage{graphicx}
\ifd@pdf
  \RequirePackage{hyperref}
\else
  \RequirePackage{url}
  \newcommand{\hypersetup}[1]{}
  \newcommand{\autoref}[1]{\ref{#1}}
\fi
\typeout{Class `diss' \fileversion\space<\filedate>}
\typeout{English documentation\space\space\space<\docdate>}
 \newcount\d@saveeqn
 \newcount\d@eqnplus \d@eqnplus=-1

 \newdimen\d@depth
 \newdimen\d@tmp
 \newif\ifd@draft
  \d@draftfalse

\setlength\paperwidth{148mm}
\setlength\paperheight{210mm}
\typearea[8mm]{11}
\renewcommand{\normalsize}{%
   \@setfontsize\normalsize\@ixpt\@xpt
   \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalsize
\renewcommand{\small}{%
   \@setfontsize\small\@viipt{9.5}%
   \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus2\p@
   \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 4\p@ \@plus2\p@ \@minus2\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\renewcommand{\footnotesize}{%
   \@setfontsize\footnotesize\@viipt\@viiipt%
   \abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus\p@
   \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 3\p@ \@plus\p@ \@minus\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\renewcommand{\scriptsize}{\@setfontsize\scriptsize\@viipt\@viiipt}
\renewcommand{\tiny}{\@setfontsize\tiny\@vpt\@vipt}
\renewcommand{\large}{\@setfontsize\large\@xipt\@xiipt}
\renewcommand{\Large}{\@setfontsize\Large\@xiipt{14}}
\renewcommand{\LARGE}{\@setfontsize\LARGE\@xivpt{18}}
\renewcommand{\huge}{\@setfontsize\huge\@xviipt{22}}
\renewcommand{\Huge}{\@setfontsize\Huge\@xxpt{25}}

% \settodepth{\d@depth}{\headfont gypqjz} % Machte Probleme mit hyperref
\def\ps@headings{\let\@mkboth\markboth
 \def\@evenhead{%
  \settodepth{\d@tmp}{\leftmark}%
  \vbox{\hsize=\textwidth%
  \hb@xt@ \textwidth{{\headfont%
  \ifdim\d@tmp >0\p@%
   \leftmark%
  \else
   \raisebox{\d@depth}{\leftmark}%
  \fi%
  \hfil}}%
  \if@hsl \vskip 1.5\p@ \hrule \fi}}
 \def\@oddhead{%
   \settodepth{\d@tmp}{\rightmark}%
   \vbox{\hsize=\textwidth%
  \hb@xt@ \textwidth{{\headfont\hfil%
  \ifdim\d@tmp >0\p@%
   \rightmark%
  \else
   \raisebox{\d@depth}{\rightmark}%
  \fi}}
  \if@hsl \vskip 1.5\p@ \hrule \fi}}
 \def\@evenfoot{\vbox{\hsize=\textwidth
  \if@fsl \hrule \vskip 3\p@ \fi
  \hb@xt@ \textwidth{{\pnumfont\thepage\hfil}}}}%
 \def\@oddfoot{\vbox{\hsize=\textwidth
  \if@fsl \hrule \vskip 3\p@ \fi
  \hb@xt@ \textwidth{{\pnumfont\hfil\thepage}}}}%
 \def\chaptermark##1{%
  \markboth {\ifnum \c@secnumdepth >\m@ne
     \if@mainmatter
       \chaptermarkformat\fi
     \fi
       ##1}{}}%
 \def\sectionmark##1{%
   \markright {\ifnum \c@secnumdepth >\z@
       \sectionmarkformat\fi
       ##1}}}
\let\emph=\textsl

 \def\eqnref#1{(\ref{#1})}

 \expandafter\long\expandafter\def\csname eqnarray+\endcsname{
  \@ifnextchar [{\@eqnarrayplus}{\@eqnarrayplus[]}}
 \expandafter\long\expandafter\def\csname endeqnarray+\endcsname{
  \endeqnarray\global\d@eqnplus\c@equation\global\advance\d@eqnplus by -1
  \global\c@equation\d@saveeqn
 }
 \long\def\@eqnarrayplus[#1]{
   \d@saveeqn\c@equation
   \if #1c\c@equation=\d@eqnplus
     \else\advance\d@saveeqn by 1
         \c@equation=-1
   \fi
   \refstepcounter{equation}
   \def\theequation{\thechapter.\@arabic\d@saveeqn\rm\alph{equation}}
   \def\eqnlabel##1{\let\savelabel=\@currentlabel
     \edef\@currentlabel{\p@equation\thechapter.\@arabic\d@saveeqn}\label{##1}
     \let\@currentlabel=\savelabel}
   \eqnarray
 }

 \let\d@author\@empty
 \def\author#1#2{\def\d@author{#1}\def\@author{#2}}
 \let\d@disp\@empty
 \def\disputation#1{\def\d@disp{#1}}
 %\def\d@issn{1432-8801}
 \def\issn#1{\def\d@issn{#1}}
 \let\d@issn\@empty
 \let\d@place\@empty
 \def\place#1{\def\d@place{#1}}
 \let\d@vorwort\@empty
 \long\def\vorwort#1#2{\def\d@vorwortname{#1}\long\def\d@vorwort{#2}}
 \let\d@preface\@empty
 \long\def\preface#1#2{\def\d@prefacename{#1}\long\def\d@preface{#2}}
 \let\d@reviewer\@empty
 \def\reviewer#1{\def\d@reviewer{#1}}
 \let\d@reviewerint\@empty
 \def\reviewerint#1{\def\d@reviewerint{#1}}
 \def\@date{\number\day.\number\month.\number\year}
 \let\d@repnr\@empty
 \def\serialnumber#1{\def\d@repnr{#1}}
 \let\d@titlei\@empty
 \let\d@titleii\@empty
 \def\title#1{\@ifnextchar[{\d@title#1}{\d@title#1[]}}
 \renewcommand{\title}[2][\@empty]{\def\d@titleii{#2}%
   \ifx#1\@empty\let\d@titlei\d@titleii\else\def\d@titlei{#1}\fi}
 \let\d@addfrontmatter\@empty
 \long\def\addtofrontmatter#1{\long\def\d@addfrontmatter{#1}}
 \def\maketitle{%
    \clearpage
    \pagenumbering{alph} % Michael Duelli, 2011-05-15, as of http://en.wikibooks.org/wiki/LaTeX/Hyperlinks#Problems_with_Links_and_Pages
    \thispagestyle{empty}
    \null
    \vskip 10mm%
    \parbox{17mm}{\includegraphics[width=1.5cm]{figures/i3logo}}
    \parbox{75mm}{
      \begin{center}\vfill\vskip 1mm%
       {\bfseries Julius-Maximilians-Universit\"at %\vskip 1mm%
            W\"urzburg}\vskip 1mm
       {\sffamily Institut f\"ur Informatik\\
            Lehrstuhl f\"ur Kommunikationsnetze\\
            Prof.~Dr.-Ing.~P.~Tran-Gia}
      \end{center}
    }
    \vskip 20mm%
    \vfill
    \begin{center}\sffamily%
       {\LARGE\sffamily\bfseries \d@titlei \par}%
       \vskip 10mm%
       {\Large\sffamily\bfseries \d@author\ \@author}
       \vskip 20mm%
       \vfill%
       {\Large W\"urzburger Beitr\"age zur\vskip1mm%
               Leistungsbewertung Verteilter Systeme}\vskip3mm%
              {\large Bericht \d@repnr}%
      \vskip 5mm%
    \end{center}
    \clearpage
    \thispagestyle{empty}
    \null
    \vfill
    \noindent
    {\large\sffamily\bfseries W\"urzburger Beitr\"age zur\\[2mm]
               Leistungsbewertung Verteilter Systeme}\\[4mm]
    {\sffamily\bfseries Herausgeber}\\[2mm]
    Prof.~Dr.~Ing.~P.~Tran-Gia\\
    Universit\"at W\"urzburg\\
    Institut f\"ur Informatik\\
    Lehrstuhl f\"ur Kommunikationsnetze\\
    Am Hubland\\
    D-97074 W\"urzburg\\[1mm]
    Tel.:\hspace{1.8mm}+49-931-31-86630\\
    Fax.: +49-931-31-86632\\
    email: trangia@informatik.uni-wuerzburg.de\\[4mm]
    {\sffamily\bfseries Satz}\\[2mm]
    Reproduktionsf\"ahige Vorlage vom Autor.\\
    Gesetzt in \LaTeX\ Computer Modern 9pt.\\[4mm]
    {\sffamily\bfseries ISSN \d@issn}
    \clearpage
    \clearpage
    \thispagestyle{empty}
    \null
    \vskip 20mm%
    \begin{center}%
      {\LARGE\sffamily\bfseries \d@titleii \par}%
      \vskip 10mm%
      {\normalsize
       Dissertation zur Erlangung des\\
       naturwissenschaftlichen Doktorgrades\\
       der Julius--Maximilians--Universit\"at W\"urzburg\par
       \vskip 10mm%
       vorgelegt von
      }
      \vskip 10mm%
      {\Large\sffamily\bfseries \d@author\ \@author}
      \vskip 5mm%
      {\normalsize
       aus\\[3mm]
       \d@place
      }
      \vfill
      {\large W\"urzburg \number\year }
    \end{center}
    \clearpage
    \thispagestyle{empty}
    \null
    \vfill
    \noindent
    Eingereicht am: \@date\\
    bei der Fakult\"at f\"ur Mathematik und Informatik\\
    1. Gutachter: Prof.~Dr.-Ing~P.~Tran-Gia\\
    2. Gutachter: \d@reviewer\\
    %3. Gutachter: \d@reviewerint\\
    Tag der m\"undlichen Pr\"ufung: \d@disp
 }

\AtBeginDocument{
 \let\@thepart\relax
 \global\@altsecnumformatfalse
}
\renewcommand\part{\cleardoublepage
                 \thispagestyle{empty}%
                 \if@twocolumn
                     \onecolumn
                     \@tempswatrue
                   \else
                     \@tempswafalse
                 \fi
                 \hbox{}\vfil
                 \secdef\@part\@spart}

 \let\d@bibliography\bibliography
 \let\d@bib\@empty
 \def\bibliography#1{\def\d@bib{#1}}


\pagestyle{headings}
\frenchspacing
\tolerance=10000
\hbadness=10000
\vbadness=10000
\AtBeginDocument{
 \maketitle
 %% Added by K. Leibnitz
 \renewcommand{\baselinestretch}{1.3}\normalsize
 \clearpage\pagenumbering{roman}\setcounter{page}{1}
 \ifx\d@vorwort\@empty \else%
   \InputIfFileExists{\d@vorwort}%
     {\chapter*{\d@vorwortname}\markboth{\d@vorwortname}{\d@vorwortname}}
     {}
 \fi
 \ifx\d@preface\@empty \else%
   \InputIfFileExists{\d@preface}%
     {\chapter*{\d@prefacename}\markboth{\d@prefacename}{\d@prefacename}}
     {}
 \fi
 \tableofcontents
 \ifx\d@addfrontmatter\@empty \else%
   \d@addfrontmatter%
 \fi
 \cleardoublepage\pagenumbering{arabic}\setcounter{page}{1}
 \makeindex
}
\AtEndDocument{
  \cleardoublepage
  \ifd@pdf
    \phantomsection
  \fi
  \printglossaries
  \chapter*{Bibliography and References}
  \addcontentsline{toc}{chapter}{Bibliography and References}
  \markboth{\bibname}{}
  \section*{Bibliography of the Author}
  \printbibliography[heading=book_chapter,type=incollection]
  \printbibliography[heading=journal,type=article]
  \printbibliography[heading=conference,type=inproceedings]
  \printbibliography[heading=demo,filter=demo]
  \printbibliography[heading=references,notkeyword=publication]
  \cleardoublepage
%  \IfFileExists{\jobname.ind}{%
%   \addcontentsline{toc}{chapter}{\indexname}
%   {\def\uppercase##1{##1}\printindex}}%
%   {}
%  \newpage
  \thispagestyle{empty}\hbox{}
  \vfill
  \begin{center}
     {\large ISSN \d@issn}
  \end{center}
}
 \InputIfFileExists{diss.cfg}%
 {\typeout{***************************^^J%
           *  Customization diss.cfg *^^J%
           ***************************}}%
  {\ClassInfo{diss}{No customization found}}
\endinput
%%
%% End of file `diss.cls'.
