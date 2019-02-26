%\pdfoutput=1

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{maps}[2004/02/23]
\RequirePackage{ifpdf}

\@twocolumntrue
\newif\ifrealfonts  \realfontsfalse
\newif\ifmapstables \mapstablestrue
\newif\ifasym \asymfalse
\newif\ifsubsub \subsubtrue

\DeclareOption{twocolumn}{\@twocolumntrue\asymfalse}
\DeclareOption{onecolumn}{\@twocolumnfalse\asymfalse}
\DeclareOption{asym}{\@twocolumnfalse\asymtrue}
\DeclareOption{realfonts}{\realfontstrue}
\DeclareOption{nosubsub}{\subsubfalse}
\DeclareOption{deftables}{\mapstablesfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\if@twocolumn
\LoadClass[twoside,twocolumn,a4paper]{article}
\else
\LoadClass[twoside,a4paper]{article}
\fi

% page and paper
\paperwidth=595.3bp % 21cm, 597.5pt
\paperheight=756bp % 759pt

\ifpdf
  \pdfhorigin=1in
  \pdfvorigin=1in
  \pdfpagewidth=\paperwidth
  \pdfpageheight=\paperheight
  \edef\pdfdate{%
    \the\year
    \ifnum \month < 10 0\the\month \else \the\month \fi
    \ifnum \day < 10 0\the\day \else \the\day \fi}
  \pdfoptionpdfminorversion=3
  \pdfinfo{%
    /CreationDate (D:\pdfdate)
    /ModDate (D:\pdfdate)
    /Trapped (False)
    /GTS_PDFXVersion (PDF/X-3)
    /Title (\jobname)
  }
  \pdfpageattr{/TrimBox [ 0 0 595.3 756] }
\fi

\RequirePackage{ifthen,graphicx,verbatim}

\ifrealfonts
  \RequirePackage{mapsfont}
\fi

%% FONT SIZES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newdimen{\le@ding}\setlength{\le@ding}{11pt} % non-elastic
\renewcommand\normalsize{%
   \@setfontsize\normalsize{10}{11}%
   \if@twocolumn
     \abovedisplayskip 5.5\p@
   \else
     \abovedisplayskip 9\p@
   \fi
   \abovedisplayshortskip \z@
   \belowdisplayshortskip \z@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalsize

\renewcommand\small{%
   \@setfontsize\small{9}{10}%
   \if@twocolumn
     \abovedisplayskip 4.5\p@
   \else
     \abovedisplayskip 7\p@
   \fi
   \abovedisplayshortskip \z@
   \belowdisplayshortskip 3.5\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 3\p@
               \parsep 2\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip }
\renewcommand\footnotesize{%
   \@setfontsize\footnotesize{8}{9}%
   \if@twocolumn
     \abovedisplayskip 4\p@
   \else
     \abovedisplayskip 6\p@
   \fi
   \abovedisplayshortskip \z@
   \belowdisplayshortskip 3\p@
   \def\@listi{\leftmargin\leftmargini
     \topsep 3\p@
     \parsep 2\p@
     \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\renewcommand\scriptsize{\@setfontsize\scriptsize{7}{8}}
\renewcommand\tiny{\@setfontsize\tiny{6}{7}}
\renewcommand\large{\@setfontsize\large{11}{11}}
\renewcommand\Large{\@setfontsize\Large{14}{14}}
\renewcommand\LARGE{\@setfontsize\LARGE{24}{24}}
\let\huge\LARGE
\let\Huge\LARGE

%% BASIC TYPOGRAPHY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setlength{\parindent} {11pt}
\newlength\parsave
\setlength{\parsave}{11pt}
\setlength{\parskip}{0pt}

% \textstrut: phantom ascender+descender
% not used in classfile, but may come in handy anyway
\newbox\strutbox
\newlength\m@xh\newlength\m@xd
\newcommand{\textstrut}{\setbox\strutbox=\hbox{Aljgp)|}%
  \m@xh=\ht\strutbox\m@xd=\dp\strutbox\advance\m@xh \m@xd
  \rule[-\m@xd]{0pt}{\m@xh}}

%% VERTICAL PAGE LAYOUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% vertical dimensions in picas and points

%\voffset=2mm
\topskip11pt
\setlength{\textheight}{605pt} % text height: 55*11pt
\setlength{\topmargin}{36pt}   % set topmargin
\addtolength{\topmargin}{-1in} % standard voffset
\setlength{\headheight}{\le@ding}
\setlength{\footskip}{33pt}

\def\raggedbottom{%
  \def\@textbottom{\vskip \z@ \@plus.01fil}\let\@texttop\relax}
\raggedbottom

%%% HORIZONTAL TYPOGRAPHY AND LAYOUT %%%%%%%%%%%%%%%%%%%%

% when assembling the volume, shift all pages about 10pt toward the
% spine. In Context I don't know how to do it directly with the
% asymmetric layout.

% underlying horizontal grid:
% 70.3 106 11 106 11 106 11 106 70.3 | 70.3 106 11 106 11 106 11 106 70.3
% two-column:
% 70.3 223 11 223 70.3 | 70.3 223 11 223 70.3
% one column:
% 198 340 70.3 | 70.3 340 198
% asym:
% 198 340 70.3 | 177 340 70.3
%
% inside 70.3 pt, 4 106pt columns, separated by 11pt gutters,
% outside 70.3pt

\setlength{\oddsidemargin}{70.3pt}
\setlength{\evensidemargin}{70.3pt}
\addtolength{\oddsidemargin}{-1in} % default hoffset
\addtolength{\evensidemargin}{-1in}
\if@twocolumn
  \setlength{\textwidth}{457pt}        % set text width
  \setlength{\columnsep}{11pt}
  % dummy definitions for fullwidth and verboutdent
  \newenvironment{fullwidth}{\par}{\par}
  \newenvironment{verboutdent}{\verbatim}{\endverbatim}
\else
  \newlength{\twocoltextwidth}          % text width 2-col layout
  \setlength{\twocoltextwidth}{457pt}
  \newlength{\marginpartot}
  \setlength{\marginpartot}{\z@}
  % calculate 1-col widths: assume underlying 4-col grid
  % with inner 3 cols together main col,
  % and outer col reserved for e.g. verbatims
  \setlength\marginparsep{\columnsep}
  \setlength\marginparwidth{\twocoltextwidth}
  \addtolength\marginparwidth{-3\columnsep}
  \addtolength\marginparwidth{-0.75\marginparwidth}
  \setlength\textwidth{\twocoltextwidth}
  \addtolength\textwidth{-\marginparsep}
  \addtolength\textwidth{-\marginparwidth}
  \setlength\marginpartot{\marginparwidth}
  \addtolength\marginpartot{\marginparsep}

  \addtolength{\evensidemargin}{\marginpartot}
  \ifasym \addtolength{\oddsidemargin}{\marginpartot} \fi

  \ifasym
    \newenvironment{fullwidth}{%
      \bgroup
      \vspace{6pt}
      \leftskip-\marginpartot
      \par\parindent0pt}%
      {\par\vspace{6pt}\egroup}
    \def\verbout{\def\verbatim@processline{%
        \hspace*{-\marginpartot}\the\verbatim@line\par}}
    \newenvironment{verboutdent}{%
      \verbatim\verbout}{\endverbatim}
  \else
    % Simply testing on c@page unsafe because
    % final pagebreaking not yet known
    \newcount\@evenodd\@evenodd=0
    \newenvironment{fullwidth}{%
      \global\advance\@evenodd1
      \par
      \bgroup
      \vspace{6pt}
      \ifthenelse{\isodd{\pageref{@eo\the\@evenodd}}}%
        {\rightskip-\marginpartot}%
        {\leftskip-\marginpartot}%
        \parindent0pt\label{@eo\the\@evenodd}}%
      {\par\vspace{6pt}\egroup}
    \def\verbout{%
      \global\advance\@evenodd1
      \label{@eo\the\@evenodd}
      \ifthenelse{\isodd{\pageref{@eo\the\@evenodd}}}{}{%
        \def\verbatim@processline{%
        \hspace*{-\marginpartot}\the\verbatim@line\par}}}
    \newenvironment{verboutdent}{%
      \verbatim\verbout}{\endverbatim}
  \fi % end not asym
\fi % end not twocolumn

\widowpenalty=1000
\clubpenalty=1000

%%% VERBATIMS %%%%%%%%%%%%%%%%%%%%%%%

% We like a smaller verbatim, but not in running text.
% \every@verbatim doesn't apply to the inline verb environment.

\def\sm@ller{%
  \@tempdima=\f@size pt
  \advance\@tempdima-0.1\@tempdima
  %\@tempdimb=\f@baselineskip
  %\advance\@tempdimb-0.1\@tempdimb
  \fontsize{\@tempdima}{\f@baselineskip}\selectfont}
\addto@hook\every@verbatim{\sm@ller}%

%%% BOXES AND BULLETS

% makeshift square bullet;
% in mapsfont.sty a wasysym character is used instead.

\newcommand\rectangle[2]{{%
  \setlength\fboxsep{0pt}%
  \fbox{\rule{#1}{0pt}\rule{0pt}{#2}}
}}
\ifx\mapsbullet\undefined
  \newsavebox{\squarebullet}
  \sbox{\squarebullet}{\raisebox{.2ex}{\rectangle{.75ex}{.75ex}}}
  \def\mapsbullet{\usebox{\squarebullet}}
\fi


%%%%%%%%%%% LISTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\@itempenalty-1000

% define label formatting indirectly, for easy overruling
\def\@mklab#1{#1 \hfil} % left-align labels in lists

\def\mapslistargs#1{%
  \setlength{\partopsep}{0.0pt}
  \if@twocolumn
     \setlength{\topsep}{#1}
     \setlength{\itemsep}{0.0pt}
     \setlength{\listparindent}{0.0pt}
     \setlength{\leftmargin}{1.25\parsave}
     \setlength{\labelwidth}{\leftmargin}
  \else
     \setlength{\topsep}{.5\le@ding}
     \setlength{\itemsep}{.5\le@ding}
     \setlength{\listparindent}{\parsave}
     \setlength{\leftmargin}{2\parsave}
     \setlength{\labelwidth}{\parsave}
  \fi
  \setlength{\parsep}{0.0pt}
  \setlength{\itemindent}{0.0pt}
  \setlength{\labelsep}{0pt}
  \setlength{\@rightskip}{0pt plus 2em} % lists raggedright
  \let\makelabel\@mklab % left-align labels in lists
}

\def\noindentlistparams#1{%
  \topsep .5\le@ding
  \itemsep .5\le@ding
  \listparindent 0pt
  \leftmargin 0pt
  \labelwidth 0pt
  \parsep 0pt
  \itemindent 0pt
  \labelsep 0pt
  \setlength{\@rightskip}{0pt} % these lists fully justified
  \def\makelabel##1{\kern0pt \rlap{##1}\kern #1}%
  \advance\@itempenalty-1000
}

\newif\ifinitemize % \initemize automatically initialized false
\renewenvironment{itemize}%
  {\ifinitemize
     \begin{list}{--}{\mapslistargs{0pt}}%
   \else
     \initemizetrue
     \begin{list}{\mapsbullet}{\mapslistargs{\le@ding}}%
   \fi}{\end{list}}

\newenvironment{itemouter}%
    {\ifinitemize\@toodeep
     \else
      \initemizetrue
      \begin{list}{\mapsbullet}{\noindentlistparams{1em}}%
     \fi}%
    {\end{list}}

\def\theenumii{\alph{enumii}}
\def\theenumi{\arabic{enumi}}
\newif\ifinenum
\renewenvironment{enumerate}%
    {\ifinenum
        \setcounter{enumii}{1}\begin{list}
        {\theenumii.\hfil}{\usecounter{enumii}\mapslistargs{0pt}}%
     \else
      \inenumtrue
      \begin{list}{\theenumi.\hfil}{%
         \usecounter{enumi}\mapslistargs{\le@ding}}%
     \fi}%
    {\end{list}}

\newenvironment{enumouter}%
    {\ifinenum\@toodeep
     \else
      \inenumtrue
      \begin{list}{{\small\bfseries \theenumi.\hfil}}{%
        \usecounter{enumi}\noindentlistparams{1.25em}}%
     \fi}%
    {\end{list}}

\renewcommand\descriptionlabel[1]{\normalfont\bfseries #1\kern 9.5pt}
\newenvironment{descript}%
 {\list{}{\noindentlistparams{3pt}%
    \labelwidth\z@ \@rightskip 0pt
    \let\makelabel\descriptionlabel}}%
 {\endlist}

\renewenvironment{description}%
  {\list{}{\mapslistargs{11pt}\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}%
  {\endlist}

% list environment especially for named-references bibliographies
% no labels; hanging indents
\newenvironment{biblist}%
  {\list{}{\mapslistargs{\le@ding}\labelwidth\z@ \itemindent-\leftmargin
                       \def\makelabel##1{\noindent}}}%
  {\endlist}
\renewenvironment{quote}%
  {\begin{list}{}{\mapslistargs{\le@ding}}\item[]}{\end{list}}
%       \setlength{\rightmargin}{9.5pt} right-indent removed 3/2000

%%% FOOTNOTES ARE ENDNOTES %%%%%%%%%%%%%%%%
% code adapted from endnotes.sty

%\AtBeginDocument{%
%  \let\footnote\endnote
%  \let\footnotemark\endnotemark
%  \let\footnotetext\endnotetext
%}

\@definecounter{endnote}
\def\theendnote{\@arabic\c@endnote}

\def\@makeenmark{\hbox{\@textsuperscript{\normalfont\footnotesize\@theenmark}}}
\def\makeenmark{\@makeenmark}

\def\theenmark{\@theenmark}

\newdimen\endnotesep

\def\endnote{%
  \@ifnextchar[%
    {\@xendnote}%
    {\stepcounter{endnote}%
     \protected@xdef\@theenmark{\theendnote}%
     \@endnotemark\@endnotetext}}

\def\@xendnote[#1]{%
   \begingroup
     \c@endnote=#1\relax
     \unrestored@protected@xdef\@theenmark{\theendnote}%
   \endgroup
   \@endnotemark\@endnotetext}

%  Here begins a section of endnote code that's really different from
% the footnote code of LaTeX.

\let\@doanenote=0
\let\@endanenote=0

\newwrite\@enotes
\newif\if@enotesopen \global\@enotesopenfalse

\def\@openenotes{\immediate\openout\@enotes=\jobname.ent\relax
      \global\@enotesopentrue}

%  The stuff with \next and \meaning is a trick from the TeXbook, 382,
% there intended for setting verbatim text, but here used to avoid
% macro expansion when the footnote text is written.  \next will have
% the entire text of the footnote as one long line, which might well
% overflow limits on output line length; the business with \newlinechar
% makes every space become a newline in the \@enotes file, so that all
% of the lines wind up being quite short.

\long\def\@endnotetext#1{%
     \if@enotesopen \else \@openenotes \fi
     \immediate\write\@enotes{\@doanenote{\@theenmark}}%
     \begingroup
        \def\next{#1}%
        \newlinechar='40
        \immediate\write\@enotes{\meaning\next}%
     \endgroup
     \immediate\write\@enotes{\@endanenote}}

% \addtoendnotes works the way the other endnote macros probably should
% have, requiring the use of \protect for fragile commands.

\long\def\addtoendnotes#1{%
     \if@enotesopen \else \@openenotes \fi
     \begingroup
        \newlinechar='40
        \let\protect\string
        \immediate\write\@enotes{#1}%
     \endgroup}

%  End of unique endnote code

\def\endnotemark{%
   \@ifnextchar[%
     {\@xendnotemark}%
     {\stepcounter{endnote}%
      \protected@xdef\@theenmark{\theendnote}%
      \@endnotemark}}

\def\@xendnotemark[#1]{%
   \begingroup
      \c@endnote #1\relax
      \unrestored@protected@xdef\@theenmark{\theendnote}%
   \endgroup
   \@endnotemark}

\def\@endnotemark{%
  \leavevmode
  \ifhmode\edef\@x@sf{\the\spacefactor}\nobreak\fi
  \makeenmark
  \ifhmode\spacefactor\@x@sf\fi
  \relax}

\def\endnotetext{%
     \@ifnextchar
       {\@xendnotenext}%
       {\protected@xdef\@theenmark{\theendnote}%
    \@endnotetext}}

\def\@xendnotenext[#1]{%
  \begingroup
     \c@endnote=#1\relax
     \unrestored@protected@xdef\@theenmark{\theendnote}%
  \endgroup
  \@endnotetext}

%  \theendnotes actually prints out the endnotes.

\def\notesname{Notes}

\def\enoteformat{\rightskip\z@ \leftskip\z@ \parindent=1em
  \noindent \@theenmark.\kern.4em
}

\def\enotesize{\small}

\def\theendnotes{%
  \immediate\closeout\@enotes \global\@enotesopenfalse
  \section*{\notesname}
  %\rule{0pt}{\l@ading}\rule{9.25pc}{0.4pt}\par\vspace{4pt}
  \begingroup
    \makeatletter
    %
    % The machinery with \@ResetGT and > here ensures that
    % \@doanenote works properly even if > is an active character
    % at the point where \theendnotes is invoked. > needs to have
    % catcode 12 when the arguments of \@doanenote are scanned, so
    % that the > in the string "macro:->" is matched.  The actual
    % footnote text is not an argument to \@doanenote, but just
    % follows it in the .ent file; so \@ResetGT can reset the
    % category code for > that should be used when processing
    % that text.  That resetting takes place within a
    % \begingroup-\endgroup block set up by \@doanenote and
    % \@endanenote, so the catcode for > is back to 12 for the
    % next note.
    %
    \edef\@tempa{`\string >}%
    \ifnum\catcode\@tempa=12%
      \let\@ResetGT\relax
    \else
      \edef\@ResetGT{\noexpand\catcode\@tempa=\the\catcode\@tempa}%
      \@makeother\>%
    \fi
    \def\@doanenote##1##2>{\def\@theenmark{##1}\par\begingroup
        \@ResetGT
        \edef\@currentlabel{\csname p@endnote\endcsname\@theenmark}%
        \enoteformat}
    \def\@endanenote{\par\endgroup}%
    %\enoteheading
    \enotesize
    \input{\jobname.ent}%
  \endgroup}

%% BIBLIOGRAPHY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\let\@openbib@code\relax
\renewenvironment{thebibliography}[1]
  {\section*{\refname}%
   \def\@biblabel##1{[\,##1\,]\hfil}%
      \list{\@biblabel{\@arabic\c@enumiv}}{%
         \mapslistargs{\le@ding}%
         \settowidth\labelwidth{{\@biblabel[#1]}}%
         \setlength{\leftmargin}{\labelwidth}%
         \setlength{\itemindent}{0pt}%
         \setlength{\labelsep}{3pt}%
         \addtolength{\leftmargin}{\labelsep}%
         \@openbib@code
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
%         \sfcode`\.\@m
     }{\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
%\renewcommand{\@cite}[2]{{[#1\ifthenelse{\boolean{@tempswa}}{,#2}{}]}}

%% TABULARS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\arraycolsep 6pt
\tabcolsep 6pt
\arrayrulewidth .4pt
\doublerulesep 2pt

\AtBeginDocument{%
  \ifmapstables
    \let\savehline\hline
    \def\hline{\noalign{\vskip2pt}\savehline\noalign{\vskip2pt}}
  \fi
}

%% SECTIONING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setcounter{secnumdepth}{0}

\@secpenalty-\@highpenalty

\def\@runin#1{{\normalsize\bfseries\itshape #1.}}

\ifsubsub
  \def\section{\@startsection{section}{1}{\z@}%
    {-1.5\le@ding}{.5\le@ding}{\large\sffamily\bfseries\raggedright}}
  \def\subsection{\@startsection{subsection}{2}{\z@}%
    {-\le@ding}{1sp}{\normalsize\sffamily\bfseries\raggedright}}
  \def\subsubsection{\@startsection{subsubsection}{3}{\z@}%
    {0.5\le@ding}{-0.5em}{\@runin}}
\else
  \def\section{\@startsection{subsection}{2}{\z@}%
    {-\le@ding}{1sp}{\normalsize\sffamily\bfseries\raggedright}}
  \def\subsection{\@startsection{subsubsection}{3}{\z@}%
    {0.5\le@ding}{-0.5em}{\@runin}}
  \let\subsubsection\subsection
\fi

\let\paragraph\subsubsection
\let\subparagraph\subsubsection

%%% PAGE STYLES (TWO-SIDED) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% header items: (short) author and (short) title

\let\sectionmark\@gobble
\let\subsectionmark\@gobble

\def\mapsnummer{{\footnotesize MAPS 30}}
\def\mapsdate{{\footnotesize VOORJAAR 2004}}

\if@twocolumn
  \def\ps@headings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@oddhead{%
      \normalfont\sffamily
      \ifnum \c@page= \c@firstpage \leftmark \else \rightmark \fi
      \hfill
      \mapsdate
      \quad\textbf{\thepage}%
      \hskip-30pt\null}%
    \def\@evenhead{%
      \normalfont\sffamily
      \null\hskip-30pt
      \textbf{\thepage}\quad
      \mapsnummer
      \hfill
      \mdseries\leftmark}}
  \def\ps@plain{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@oddhead{%
      \normalfont\sffamily
      \null\hfill
      \mapsdate
      \quad\normalsize\textbf{\thepage}%
      \hskip-30pt\null}%
    \def\@evenhead{%
      \normalfont\sffamily
      \null\hskip-30pt
      \normalsize\textbf{\thepage}\quad
      \mapsnummer
      \hfill\null}}
\else \ifasym
  \def\ps@headings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@oddhead{%
      \normalfont\sffamily
      \null\hskip-\marginpartot
      \ifnum \c@page= \c@firstpage \leftmark \else \rightmark \fi
      \hfill
      \mapsdate
      \quad\textbf{\thepage}%
      \hskip-30pt\null}%
    \def\@evenhead{%
      \normalfont\sffamily
      \null\hskip-\marginpartot
      \null\hskip-30pt
      \textbf{\thepage}\quad
      \mapsnummer
      \hfill
      \mdseries\leftmark}}
  \def\ps@plain{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@oddhead{%
      \normalfont\sffamily
      \null\hskip-\marginpartot
      \null\hfill
      \mapsdate
      \quad\normalsize\textbf{\thepage}%
      \hskip-30pt\null}%
    \def\@evenhead{%
      \normalfont\sffamily
      \null\hskip-\marginpartot
      \null\hskip-30pt
      \normalsize\textbf{\thepage}\quad
      \mapsnummer
      \hfill\null}}
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@oddhead{%
      \normalfont\sffamily
      \ifnum \c@page= \c@firstpage \leftmark \else \rightmark \fi
      \hfill
      \mapsdate
      \quad\textbf{\thepage}%
      \hskip-\marginpartot\null
      \hskip-30pt\null}%
    \def\@evenhead{%
      \normalfont\sffamily
      \null\hskip-\marginpartot
      \null\hskip-30pt
      \textbf{\thepage}\quad
      \mapsnummer
      \hfill
      \mdseries\leftmark}}
  \def\ps@plain{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@oddhead{%
      \normalfont\sffamily
      \null\hfill
      \mapsdate
      \quad\normalsize\textbf{\thepage}%
      \hskip-\marginpartot\null
      \hskip-30pt\null}%
    \def\@evenhead{%
      \normalfont\sffamily
      \null\hskip-\marginpartot
      \null\hskip-30pt
      \normalsize\textbf{\thepage}\quad
      \mapsnummer
      \hfill\null}}
\fi\fi
\def\ps@empty{%
  \let\@oddfoot\@empty\let\@evenfoot\@empty
  \let\@oddhead\@empty\let\@evenhead\@empty}

%% CAPTIONS & FIGURES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\long\def\@makecaption#1#2{%
  \vskip.5\abovecaptionskip
  \raggedright %\sffamily
  \small\textbf{#1.} #2\par
  \vskip\belowcaptionskip}

\setlength{\textfloatsep}{11pt}
\setlength{\dbltextfloatsep}{11pt}
\setlength{\intextsep}{11pt}

\setcounter{topnumber}{7}
\setcounter{bottomnumber}{7}
\setcounter{totalnumber}{11}
\setcounter{dbltopnumber}{2}
\renewcommand{\topfraction}{.9}
\renewcommand{\textfraction}{.1}
\renewcommand{\bottomfraction}{.75}
\renewcommand{\floatpagefraction}{.9}
\renewcommand{\dblfloatpagefraction}{.9}
\renewcommand{\dbltopfraction}{.9}

\def\@floatboxreset{%
  \reset@font\sffamily\normalsize\@setminipage}

%% MAKETITLE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{firstpage}
\renewcommand\maketitle{%
  \setcounter{firstpage}{\value{page}}%
  \par
  \begingroup
    \def\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\@textsuperscript{\normalfont\@thefnmark}}%
    \long\def\@makefntext##1{%
      \noindent\rule{1em}{0pt}%
        \@textsuperscript{\normalfont\@thefnmark}##1}%
    \if@twocolumn
      \twocolumn[\@maketitle]%
    \else
      \@maketitle
    \fi
    \@thanks
    %\thispagestyle{plain}%
  \endgroup
  \markboth{\@authorshort}{\@titleshort}%
  \gdef\thanks##1{\message{%
    thanks command only allowed in title, not in author or elsewhere}}%
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  %\global\let\@author\@empty % \@author saved for the end
  \global\let\@title\@empty
  \global\let\@subtitle\@empty
  \global\let\author\relax
  \global\let\title\relax
  \global\let\subtitle\relax
  \pagestyle{headings}%
  % thanks is to be a real footnote,
  % but from now on we do only endnotes.
  \let\footnote\endnote
  %\let\footnotemark\endnotemark
  %\let\footnotetext\endnotetext
  \setcounter{endnote}{0}
}

\def\@maketitle{%
  \newpage
  \vspace*{36pt}
  \bgroup
    \parskip=0pt
    \parindent=0pt
    \raggedright
    {\LARGE\upshape
     \noindent{\bfseries
     \@title}\vadjust{\vskip6pt}%
     \par
     \ifx\@subtitle\@empty\else
       {\sffamily\itshape
        \@subtitle} \par
     \fi
    }
  \egroup
  \vspace*{24pt}%
  \ifx\@author\@empty\else
    \AtEndDocument{%
      \par \vskip \le@ding
      \noindent\small\sffamily\@author\par} \fi
}

\newcommand{\opener}[1]{%
  \bgroup
  \raggedright
  \rightskip=1em plus 1fil\parindent=0pt
  \sffamily\small\textbf{#1}\par\ignorespaces}
\def\endopener{%
  \par\egroup\vspace{\le@ding}}

\def\abstract{\opener{Abstract}}
\def\endabstract{\endopener}

\def\keywords{\opener{Keywords}}
\def\endkeywords{\endopener}

\renewcommand{\title}[2][\@empty]{%
  \ifthenelse{\equal{\@empty}{#1}}{%
    \gdef\@titleshort{#2}}{%
    \gdef\@titleshort{#1}}%
    \gdef\@title{#2}%
}
\global\let\titel\title

\long\def\@subtitle{\@empty}
\newcommand{\subtitle}[1]{\long\def\@subtitle{#1}}
\global\let\subtitel\subtitle

\def\@titleshort{}
\def\@authorshort{}
\renewcommand{\author}[2][\@empty]{%
  \ifthenelse{\equal{\@empty}{#1}}%
    {\gdef\@authorshort{#2}}%
    {\gdef\@authorshort{#1}}%
  \gdef\@author{#2}}

%% SOME LOGOS %%%%%%%%%%%%%%%%%%%%%

% \TeX seems to get a new definition somewhere,
% which doesn't play nice with our font setup

\AtBeginDocument{%
  \gdef\TeX{T\kern-.15em\lower.5ex\hbox{E}\kern-.1emX\@}%
  \gdef\LaTeX{La\kern-.07em\TeX}%
  \global\let\Latex\LaTeX
  \gdef\Context{Con\kern-.07em\TeX{}t}%
  \global\let\ConTeXt\Context}

%% A FEW SPECIAL CHARS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% discretionary linebreak
\newcommand{\dbr}{\discretionary{}{}{}}

%% backslash in tt font
\newcommand{\bsl}{\char92}

%% underline in tt font
\newcommand{\ul}{\char95}

%% tilde in tt font
\newcommand{\tild}{\char126}

\endinput
