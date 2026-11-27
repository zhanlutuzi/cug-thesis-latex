% !TeX encoding = UTF-8
% !TeX program = xelatex
% ============================================================================
% cugthesis.cls
% 中国地质大学（武汉）研究生学位论文 LaTeX 模板
% 依据：《中国地质大学（武汉）研究生学位论文写作规范》（2025年5月修改版）
% ============================================================================

\NeedsTeXFormat{LaTeX2e}[2022/06/01]
\ProvidesClass{cugthesis}[2026/05/01 v2.0 CUG (Wuhan) Graduate Thesis Template (2025 Spec)]

% ----------------------------------------------------------------------------
% 1. 类选项解析 (l3keys)
% ----------------------------------------------------------------------------
\RequirePackage{expl3}
\RequirePackage{xparse}

\ExplSyntaxOn
\tl_new:N \g_cug_degree_tl
\tl_new:N \g_cug_bibstyle_tl
\tl_new:N \g_cug_fontset_tl
\bool_new:N \g_cug_blind_bool
\bool_new:N \g_cug_cover_bool
\bool_new:N \g_cug_spine_bool
\bool_new:N \g_cug_frontheader_bool
\bool_new:N \g_cug_openright_bool
\bool_new:N \g_cug_print_bool

\keys_define:nn { cugthesis }
  {
    % 学位类型:
    %   master     = 学术型硕士学位论文（默认）
    %   doctor     = 博士学位论文
    %   profmaster = 硕士专业学位论文（全日制）
    %   parttime   = 硕士专业学位论文（非全日制）
    %   eqmaster   = 同等学力硕士学位论文
    %   eqdoctor   = 同等学力博士学位论文
    degree .choices:nn =
      { master, doctor, profmaster, parttime, eqmaster, eqdoctor }
      { \tl_gset:Nx \g_cug_degree_tl { \l_keys_choice_tl } },
    degree .initial:n = master,

    % 参考文献格式: numerical(顺序编码制，默认), authoryear(著者-出版年制)
    bibstyle .choices:nn = { numerical, authoryear }
      { \tl_gset:Nx \g_cug_bibstyle_tl { \l_keys_choice_tl } },
    bibstyle .initial:n = numerical,

    % 字体集: auto(跨平台自动检测，默认), mac, windows, fandol
    fontset .choices:nn = { auto, mac, windows, fandol }
      { \tl_gset:Nx \g_cug_fontset_tl { \l_keys_choice_tl } },
    fontset .initial:n = auto,

    % 盲审模式（隐藏作者姓名、学号、导师姓名、签名与页眉姓名）
    blind .bool_gset:N = \g_cug_blind_bool,
    blind .initial:n = false,
    blind .default:n = true,

    % 是否输出中文封面（表3.2；如使用学校统一印制封面可设为 false）
    cover .bool_gset:N = \g_cug_cover_bool,
    cover .initial:n = true,
    cover .default:n = true,

    % 是否在文档末尾附加书脊页（第3.3节）
    spine .bool_gset:N = \g_cug_spine_bool,
    spine .initial:n = false,
    spine .default:n = true,

    % 前置部分（摘要/Abstract/目录/图表清单）是否显示页眉文字
    frontheader .bool_gset:N = \g_cug_frontheader_bool,
    frontheader .initial:n = true,
    frontheader .default:n = true,

    % 章节是否强制从奇数页起排（默认 openany，每章另起页）
    openright .bool_gset:N = \g_cug_openright_bool,
    openright .initial:n = false,
    openright .default:n = true,

    % 双面印刷模式（中文摘要前自动补齐偶数页，使其从奇数页起双面印制）
    print .bool_gset:N = \g_cug_print_bool,
    print .initial:n = false,
    print .default:n = true,

    unknown .code:n = { \PassOptionsToClass { \CurrentOption } { ctexbook } }
  }

\ProcessKeyOptions [ cugthesis ]

\bool_if:NTF \g_cug_openright_bool
  { \PassOptionsToClass { openright } { ctexbook } }
  { \PassOptionsToClass { openany } { ctexbook } }

\cs_new:Npn \cug@degree { \g_cug_degree_tl }
\cs_new:Npn \cug@bibstyle { \g_cug_bibstyle_tl }
\cs_new:Npn \cug@fontset { \g_cug_fontset_tl }
\cs_new:Npn \cug@ifblind { \bool_if:NTF \g_cug_blind_bool }
\cs_new:Npn \cug@ifcover { \bool_if:NTF \g_cug_cover_bool }
\cs_new:Npn \cug@ifspine { \bool_if:NTF \g_cug_spine_bool }
\cs_new:Npn \cug@iffrontheader { \bool_if:NTF \g_cug_frontheader_bool }
\cs_new:Npn \cug@ifprint { \bool_if:NTF \g_cug_print_bool }
\ExplSyntaxOff

% ----------------------------------------------------------------------------
% 2. 加载基类 (ctexbook, A4, 小四号 12bp, 双面版式)
% ----------------------------------------------------------------------------
\PassOptionsToPackage{no-math}{fontspec}
\LoadClass[
  a4paper,
  zihao=-4,
  twoside,
  fontset=none,
  UTF8
]{ctexbook}

% ----------------------------------------------------------------------------
% 3. 基础宏包与数学字体
% ----------------------------------------------------------------------------
\RequirePackage{etoolbox}
\RequirePackage{calc}
\RequirePackage{amsmath}
\RequirePackage{newtxmath} % Times 风格数学字体，与 Times New Roman 协调
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{makecell}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
\RequirePackage{titletoc}
\RequirePackage{siunitx}
\RequirePackage{pifont}
\RequirePackage[perpage]{footmisc}
\RequirePackage{pdfpages}
\RequirePackage[
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  urlcolor=black,
  bookmarksnumbered=true,
  bookmarksopen=true,
  plainpages=false,
  pdfpagelabels=true,
  pdfstartview=FitH
]{hyperref}

\sisetup{
  detect-all,
  mode=match,
  propagate-math-font=true,
  reset-math-version=false,
  reset-text-family=false,
  reset-text-series=false,
  number-unit-product=\,
}

% ----------------------------------------------------------------------------
% 4. 字体配置（跨平台自动适配 Windows / macOS / Linux / Overleaf）
% ----------------------------------------------------------------------------
% 英文主字体：Times New Roman（规范表3.1/3.5/3.6/3.8/3.9），缺失时回退 TeX Gyre Termes
\IfFontExistsTF{Times New Roman}{%
  \setmainfont{Times New Roman}%
}{%
  \setmainfont{TeX Gyre Termes}%
}
\IfFontExistsTF{Arial}{%
  \setsansfont{Arial}%
}{%
  \setsansfont{TeX Gyre Heros}%
}
\IfFontExistsTF{Courier New}{%
  \setmonofont{Courier New}%
}{%
  \setmonofont{TeX Gyre Cursor}%
}

\newcommand{\cug@setup@fonts@fandol}{%
  \setCJKmainfont{FandolSong-Regular.otf}[
    BoldFont = FandolSong-Bold.otf,
    ItalicFont = FandolKai-Regular.otf
  ]%
  \setCJKsansfont{FandolHei-Regular.otf}[BoldFont = FandolHei-Bold.otf]%
  \setCJKmonofont{FandolFang-Regular.otf}%
  \setCJKfamilyfont{zhsong}{FandolSong-Regular.otf}[BoldFont = FandolSong-Bold.otf]%
  \setCJKfamilyfont{zhhei}{FandolHei-Regular.otf}[BoldFont = FandolHei-Bold.otf]%
  \setCJKfamilyfont{zhfs}{FandolFang-Regular.otf}[AutoFakeBold = 1.8]%
  \setCJKfamilyfont{zhkai}{FandolKai-Regular.otf}[AutoFakeBold = 1.8]%
}

\newcommand{\cug@setup@fonts@windows}{%
  \setCJKmainfont{SimSun}[AutoFakeBold = 2.0, ItalicFont = KaiTi]%
  \setCJKsansfont{SimHei}[AutoFakeBold = 1.8]%
  \setCJKmonofont{FangSong}[AutoFakeBold = 1.8]%
  \setCJKfamilyfont{zhsong}{SimSun}[AutoFakeBold = 2.0]%
  \setCJKfamilyfont{zhhei}{SimHei}[AutoFakeBold = 1.8]%
  \setCJKfamilyfont{zhfs}{FangSong}[AutoFakeBold = 1.8]%
  \setCJKfamilyfont{zhkai}{KaiTi}[AutoFakeBold = 1.8]%
}

\newcommand{\cug@macword@fontpath}{/Applications/Microsoft Word.app/Contents/Resources/DFonts/}

\newcommand{\cug@setup@fonts@mac}{%
  \IfFileExists{/Applications/Microsoft Word.app/Contents/Resources/DFonts/Simsun.ttc}{%
    \setCJKmainfont{Simsun.ttc}[Path = \cug@macword@fontpath, FontIndex = 0, AutoFakeBold = 2.0]%
    \setCJKfamilyfont{zhsong}{Simsun.ttc}[Path = \cug@macword@fontpath, FontIndex = 0, AutoFakeBold = 2.0]%
  }{%
    \IfFontExistsTF{Songti SC}{%
      \setCJKmainfont{Songti SC}[UprightFont = * Regular, BoldFont = * Bold]%
      \setCJKfamilyfont{zhsong}{Songti SC}[UprightFont = * Regular, BoldFont = * Bold]%
    }{%
      \setCJKmainfont{FandolSong-Regular.otf}[BoldFont = FandolSong-Bold.otf]%
      \setCJKfamilyfont{zhsong}{FandolSong-Regular.otf}[BoldFont = FandolSong-Bold.otf]%
    }%
  }%
  \IfFontExistsTF{Heiti SC}{%
    \setCJKsansfont{Heiti SC}[UprightFont = * Medium, AutoFakeBold = 1.8]%
    \setCJKfamilyfont{zhhei}{Heiti SC}[UprightFont = * Medium, AutoFakeBold = 1.8]%
  }{%
    \setCJKsansfont{FandolHei-Regular.otf}[BoldFont = FandolHei-Bold.otf]%
    \setCJKfamilyfont{zhhei}{FandolHei-Regular.otf}[BoldFont = FandolHei-Bold.otf]%
  }%
  \IfFontExistsTF{FangSong_GB2312}{%
    \setCJKmonofont{FangSong_GB2312}[AutoFakeBold = 1.8]%
    \setCJKfamilyfont{zhfs}{FangSong_GB2312}[AutoFakeBold = 1.8]%
  }{%
    \IfFontExistsTF{STFangsong}{%
      \setCJKmonofont{STFangsong}[AutoFakeBold = 1.8]%
      \setCJKfamilyfont{zhfs}{STFangsong}[AutoFakeBold = 1.8]%
    }{%
      \setCJKmonofont{FandolFang-Regular.otf}[AutoFakeBold = 1.8]%
      \setCJKfamilyfont{zhfs}{FandolFang-Regular.otf}[AutoFakeBold = 1.8]%
    }%
  }%
  \IfFontExistsTF{Kaiti SC}{%
    \setCJKfamilyfont{zhkai}{Kaiti SC}[UprightFont = * Regular, BoldFont = * Bold]%
  }{%
    \setCJKfamilyfont{zhkai}{FandolKai-Regular.otf}[AutoFakeBold = 1.8]%
  }%
}

\newcommand{\cug@setup@fonts@auto}{%
  \IfFontExistsTF{SimSun}{%
    \cug@setup@fonts@windows
  }{%
    \IfFontExistsTF{Songti SC}{%
      \cug@setup@fonts@mac
    }{%
      \cug@setup@fonts@fandol
    }%
  }%
}

\ExplSyntaxOn
\str_case:Vn \g_cug_fontset_tl
  {
    { auto }    { \cug@setup@fonts@auto }
    { mac }     { \cug@setup@fonts@mac }
    { windows } { \cug@setup@fonts@windows }
    { fandol }  { \cug@setup@fonts@fandol }
  }
\ExplSyntaxOff

\providecommand{\songti}{\CJKfamily{zhsong}}
\providecommand{\heiti}{\CJKfamily{zhhei}}
\providecommand{\fangsong}{\CJKfamily{zhfs}}
\providecommand{\kaishu}{\CJKfamily{zhkai}}

% ----------------------------------------------------------------------------
% 5. 页面设置与正文行距（第3.1节 表3.1、第3.8节 表3.8）
%    A4(210x297mm)，上下3cm，左右3cm，页眉2.5cm，页脚2.0cm，装订线0cm
% ----------------------------------------------------------------------------
\RequirePackage[
  a4paper,
  top=3cm,
  bottom=3cm,
  left=3cm,
  right=3cm,
  headheight=14pt,
  headsep=0.22cm,
  footskip=1.0cm,
  bindingoffset=0cm
]{geometry}

% 固定值行距 20 磅（小四号 12bp），段前段后 0 磅，首行缩进 2 个汉字符
\linespread{1.0}\selectfont
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{20bp}%
  \abovedisplayskip 8bp \@plus 2bp \@minus 2bp
  \abovedisplayshortskip \z@ \@plus 2bp
  \belowdisplayshortskip 4bp \@plus 2bp \@minus 2bp
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI
}
\normalsize
\setlength{\parskip}{0pt}
\setlength{\parindent}{2\ccwd}

% ----------------------------------------------------------------------------
% 6. 论文元数据配置接口 (\cugsetup)
% ----------------------------------------------------------------------------
\ExplSyntaxOn
\tl_new:N \g_cug_clc_tl                 % 分类号
\tl_new:N \g_cug_udc_tl                 % UDC
\tl_new:N \g_cug_secret_tl              % 密级（公开可不填，涉密如“保密★2年”）
\tl_new:N \g_cug_schoolcode_tl          % 学校代码（10491）
\tl_new:N \g_cug_studentid_tl           % 研究生学号
\tl_new:N \g_cug_title_tl               % 中文论文题目
\tl_new:N \g_cug_subtitle_tl            % 中文副标题（可选）
\tl_new:N \g_cug_title_en_tl            % 英文论文题目
\tl_new:N \g_cug_subtitle_en_tl         % 英文副标题（可选）
\tl_new:N \g_cug_headertitle_tl         % 页眉简称（可选，长题目时覆盖）
\tl_new:N \g_cug_author_tl              % 姓名
\tl_new:N \g_cug_author_en_tl           % 英文姓名
\tl_new:N \g_cug_major_tl               % 学科专业 / 专业学位类别
\tl_new:N \g_cug_major_en_tl            % 英文学科专业 / 专业学位类别
\tl_new:N \g_cug_degree_subject_en_tl   % 英文学位门类（如 Engineering / Science）
\tl_new:N \g_cug_supervisor_tl          % 指导教师（姓名 职称）
\tl_new:N \g_cug_supervisor_en_tl       % 英文指导教师
\tl_new:N \g_cug_cosupervisor_tl        % 副指导教师（可选，姓名 职称）
\tl_new:N \g_cug_corpsupervisor_tl      % 企业导师（非全日制专硕等，姓名 职称）
\tl_new:N \g_cug_corpsupervisor_en_tl   % 英文企业导师（可选）
\tl_new:N \g_cug_department_tl          % 培养单位（规范全称）
\tl_new:N \g_cug_date_tl                % 论文完成时间（汉字，如 二○二六年五月）
\tl_new:N \g_cug_keywords_tl            % 中文关键词（分号分隔）
\tl_new:N \g_cug_keywords_en_tl         % 英文关键词（分号分隔）
\tl_new:N \g_cug_author_sig_tl          % 作者电子签名图片路径（可选）
\tl_new:N \g_cug_supervisor_sig_tl      % 导师电子签名图片路径（可选）
\tl_new:N \g_cug_sig_date_tl            % 声明签字日期（可选）

\tl_gset:Nn \g_cug_schoolcode_tl { 10491 }

\keys_define:nn { cugsetup }
  {
    clc               .tl_gset:N = \g_cug_clc_tl,
    udc               .tl_gset:N = \g_cug_udc_tl,
    secret            .tl_gset:N = \g_cug_secret_tl,
    schoolcode        .tl_gset:N = \g_cug_schoolcode_tl,
    studentid         .tl_gset:N = \g_cug_studentid_tl,
    title             .tl_gset:N = \g_cug_title_tl,
    subtitle          .tl_gset:N = \g_cug_subtitle_tl,
    title-en          .tl_gset:N = \g_cug_title_en_tl,
    subtitle-en       .tl_gset:N = \g_cug_subtitle_en_tl,
    header-title      .tl_gset:N = \g_cug_headertitle_tl,
    author            .tl_gset:N = \g_cug_author_tl,
    author-en         .tl_gset:N = \g_cug_author_en_tl,
    major             .tl_gset:N = \g_cug_major_tl,
    major-en          .tl_gset:N = \g_cug_major_en_tl,
    degree-subject-en .tl_gset:N = \g_cug_degree_subject_en_tl,
    supervisor        .tl_gset:N = \g_cug_supervisor_tl,
    supervisor-en     .tl_gset:N = \g_cug_supervisor_en_tl,
    cosupervisor      .tl_gset:N = \g_cug_cosupervisor_tl,
    corpsupervisor    .tl_gset:N = \g_cug_corpsupervisor_tl,
    corpsupervisor-en .tl_gset:N = \g_cug_corpsupervisor_en_tl,
    department        .tl_gset:N = \g_cug_department_tl,
    date              .tl_gset:N = \g_cug_date_tl,
    keywords          .tl_gset:N = \g_cug_keywords_tl,
    keywords-en       .tl_gset:N = \g_cug_keywords_en_tl,
    author-sig        .tl_gset:N = \g_cug_author_sig_tl,
    supervisor-sig    .tl_gset:N = \g_cug_supervisor_sig_tl,
    sig-date          .tl_gset:N = \g_cug_sig_date_tl,
  }

\NewDocumentCommand{\cugsetup}{m}
  {
    \keys_set:nn { cugsetup } { #1 }
    % 写入 PDF 元数据
    \hypersetup{
      pdftitle   = {\tl_use:N \g_cug_title_tl},
      pdfauthor  = {\bool_if:NTF \g_cug_blind_bool { 匿名 } { \tl_use:N \g_cug_author_tl }},
      pdfsubject = {中国地质大学（武汉）研究生学位论文},
      pdfkeywords= {\tl_use:N \g_cug_keywords_tl}
    }
  }

% 盲审遮罩辅助函数
\cs_new:Npn \cug@mask:n #1
  {
    \bool_if:NTF \g_cug_blind_bool { ****** } { #1 }
  }

% 根据 degree 选项自动推导各类学位名称
\cs_new:Npn \cug@degreetitle
  {
    \str_case:Vn \g_cug_degree_tl
      {
        { master }     { 硕士学位论文 }
        { doctor }     { 博士学位论文 }
        { profmaster } { 硕士专业学位论文（全日制） }
        { parttime }   { 硕士专业学位论文（非全日制） }
        { eqmaster }   { 同等学力硕士学位论文 }
        { eqdoctor }   { 同等学力博士学位论文 }
      }
  }

\cs_new:Npn \cug@degreeshort
  {
    \str_case:Vn \g_cug_degree_tl
      {
        { master }     { 硕士 }
        { doctor }     { 博士 }
        { profmaster } { 硕士 }
        { parttime }   { 硕士 }
        { eqmaster }   { 硕士 }
        { eqdoctor }   { 博士 }
      }
  }

\cs_new:Npn \cug@major@label
  {
    \str_case:VnF \g_cug_degree_tl
      {
        { profmaster } { 专业学位类别 }
        { parttime }   { 专业学位类别 }
      }
      { 学科专业 }
  }

\cs_new:Npn \cug@label@width
  {
    \str_case:VnF \g_cug_degree_tl
      {
        { profmaster } { 6.2\ccwd }
        { parttime }   { 6.2\ccwd }
      }
      { 4.5\ccwd }
  }

\cs_new:Npn \cug@ifprof #1#2
  {
    \str_if_eq:VnTF \g_cug_degree_tl { profmaster }
      { #1 }
      {
        \str_if_eq:VnTF \g_cug_degree_tl { parttime }
          { #1 }
          { #2 }
      }
  }

\cs_new:Npn \cug@ifparttime #1#2
  {
    \str_if_eq:VnTF \g_cug_degree_tl { parttime } { #1 } { #2 }
  }

\cs_new:Npn \cug@ifdoctor #1#2
  {
    \str_if_eq:VnTF \g_cug_degree_tl { doctor }
      { #1 }
      {
        \str_if_eq:VnTF \g_cug_degree_tl { eqdoctor }
          { #1 }
          { #2 }
      }
  }

% 内部 getter 供经典 TeX 环境调用
\cs_new:Npn \cug@get@clc { \tl_use:N \g_cug_clc_tl }
\cs_new:Npn \cug@get@udc { \tl_use:N \g_cug_udc_tl }
\cs_new:Npn \cug@get@secret { \tl_use:N \g_cug_secret_tl }
\cs_new:Npn \cug@get@schoolcode { \tl_use:N \g_cug_schoolcode_tl }
\cs_new:Npn \cug@get@studentid { \cug@mask:n { \tl_use:N \g_cug_studentid_tl } }
\cs_new:Npn \cug@get@title { \tl_use:N \g_cug_title_tl }
\cs_new:Npn \cug@get@subtitle { \tl_use:N \g_cug_subtitle_tl }
\cs_new:Npn \cug@get@title@en { \tl_use:N \g_cug_title_en_tl }
\cs_new:Npn \cug@get@subtitle@en { \tl_use:N \g_cug_subtitle_en_tl }
\cs_new:Npn \cug@get@author { \cug@mask:n { \tl_use:N \g_cug_author_tl } }
\cs_new:Npn \cug@get@author@en { \cug@mask:n { \tl_use:N \g_cug_author_en_tl } }
\cs_new:Npn \cug@get@major { \tl_use:N \g_cug_major_tl }
\cs_new:Npn \cug@get@major@en { \tl_use:N \g_cug_major_en_tl }
\cs_new:Npn \cug@get@degreesubject@en
  {
    \tl_if_empty:NTF \g_cug_degree_subject_en_tl
      { \tl_use:N \g_cug_major_en_tl }
      { \tl_use:N \g_cug_degree_subject_en_tl }
  }
\cs_new:Npn \cug@get@supervisor { \cug@mask:n { \tl_use:N \g_cug_supervisor_tl } }
\cs_new:Npn \cug@get@supervisor@en { \cug@mask:n { \tl_use:N \g_cug_supervisor_en_tl } }
\cs_new:Npn \cug@get@cosupervisor { \cug@mask:n { \tl_use:N \g_cug_cosupervisor_tl } }
\cs_new:Npn \cug@get@corpsupervisor { \cug@mask:n { \tl_use:N \g_cug_corpsupervisor_tl } }
\cs_new:Npn \cug@get@corpsupervisor@en { \cug@mask:n { \tl_use:N \g_cug_corpsupervisor_en_tl } }
\cs_new:Npn \cug@get@department { \tl_use:N \g_cug_department_tl }
\cs_new:Npn \cug@get@date { \tl_use:N \g_cug_date_tl }
\cs_new:Npn \cug@get@keywords { \tl_use:N \g_cug_keywords_tl }
\cs_new:Npn \cug@get@keywords@en { \tl_use:N \g_cug_keywords_en_tl }
\cs_new:Npn \cug@get@author@sig { \tl_use:N \g_cug_author_sig_tl }
\cs_new:Npn \cug@get@supervisor@sig { \tl_use:N \g_cug_supervisor_sig_tl }
\cs_new:Npn \cug@get@sig@date { \tl_use:N \g_cug_sig_date_tl }

\cs_new:Npn \cug@ifempty #1#2#3 { \tl_if_blank:eTF { #1 } { #2 } { #3 } }

\cs_new:Npn \cug@header@even
  {
    \tl_set:Nx \l_tmpa_tl
      {
        \tl_if_empty:NTF \g_cug_headertitle_tl
          { \tl_use:N \g_cug_title_tl }
          { \tl_use:N \g_cug_headertitle_tl }
      }
    \bool_if:NTF \g_cug_blind_bool
      { \tl_use:N \l_tmpa_tl }
      { \tl_use:N \g_cug_author_tl ：\tl_use:N \l_tmpa_tl }
  }
\ExplSyntaxOff

% ----------------------------------------------------------------------------
% 7. 页眉与页码设计（第2.4节、第3.1节表3.1、附件10）
%    - 正文起每页设置页眉，字号 5 号宋体 (10.5bp)，下方有横线
%    - 奇数页居中：“中国地质大学□”，页码在右侧（外侧）
%    - 偶数页居中：“作者姓名：论文题目”，页码在左侧（外侧）
%    - 页脚空白，无页码
% ----------------------------------------------------------------------------
\newcommand{\cug@front@headmark}{}

\fancypagestyle{cugempty}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}

\fancypagestyle{cugfront}{%
  \fancyhf{}%
  \cug@iffrontheader{%
    \fancyhead[C]{\zihao{5}\cug@front@headmark}%
    \fancyhead[RO,LE]{\zihao{5}\thepage}%
    \renewcommand{\headrulewidth}{0.5pt}%
  }{%
    \fancyhead[RO,LE]{\zihao{5}\thepage}%
    \renewcommand{\headrulewidth}{0pt}%
  }%
  \renewcommand{\footrulewidth}{0pt}%
}

\fancypagestyle{cugmain}{%
  \fancyhf{}%
  \fancyhead[CO]{\zihao{5}\songti 中国地质大学\cug@degreetitle}%
  \fancyhead[CE]{\zihao{5}\songti \cug@header@even}%
  \fancyhead[RO,LE]{\zihao{5}\thepage}%
  \renewcommand{\headrulewidth}{0.5pt}%
  \renewcommand{\footrulewidth}{0pt}%
}

% 动态将 plain 样式绑定到当前所处区域，确保每章首页/目录首页也有页眉与外侧页码
\newcommand{\cug@set@plain@to}[1]{%
  \fancypagestyle{plain}{%
    \expandafter\csname ps@#1\endcsname
  }%
}

\AtBeginDocument{\pagenumbering{Alph}\pagestyle{cugempty}\cug@set@plain@to{cugempty}}

% 前置双面部分（摘要、Abstract、目录、图表清单）起始命令
\newcommand{\cugfrontmatter}{%
  \clearpage
  \cug@ifprint{%
    % 规范3.10：论文自中文摘要起双面印刷，之前部分单面印刷
    \ifodd\c@page\else\hbox{}\thispagestyle{cugempty}\clearpage\fi
  }{}%
  \pagenumbering{Roman}%
  \pagestyle{cugfront}%
  \cug@set@plain@to{cugfront}%
}

% 正文起始命令（从第一章起阿拉伯数字 1, 2, 3... 连续编排，启用规范页眉）
\newcommand{\cugmainmatter}{%
  \clearpage
  \cug@ifprint{%
    \ifodd\c@page\else\hbox{}\thispagestyle{cugempty}\clearpage\fi
  }{}%
  \pagenumbering{arabic}%
  \setcounter{page}{1}%
  \pagestyle{cugmain}%
  \cug@set@plain@to{cugmain}%
}

% 后置部分起始命令（保持页眉与页码连续）
\newcommand{\cugbackmatter}{%
  \clearpage
  \pagestyle{cugmain}%
  \cug@set@plain@to{cugmain}%
}

% ----------------------------------------------------------------------------
% 8. 章节标题格式（第2.3节、第3.8节表3.8）
%    - 各章标题：第一章 ×××，黑体16磅(三号)加粗居中，单倍行距，上下空2行，空1汉字符
%    - 一级节标题：1.1 ×××，黑体14磅(四号)加粗居中，单倍行距，上下空1行，空1汉字符
%    - 二级节标题：1.1.1 ×××，黑体12磅(小四)居左，单倍行距，上下空1行，空1汉字符
% ----------------------------------------------------------------------------
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}

\ctexset{
  chapter = {
    name       = {第,章},
    number     = \chinese{chapter},
    aftername  = \hspace{1\ccwd},
    format     = \heiti\bfseries\fontsize{16bp}{19.2bp}\selectfont\centering,
    beforeskip = 20bp,
    afterskip  = 24bp,
    fixskip    = true,
    pagestyle  = cugmain,
    break      = \clearpage,
  },
  section = {
    aftername  = \hspace{1\ccwd},
    format     = \heiti\bfseries\fontsize{14bp}{16.8bp}\selectfont\centering,
    beforeskip = 14bp,
    afterskip  = 14bp,
    fixskip    = true,
  },
  subsection = {
    aftername  = \hspace{1\ccwd},
    format     = \heiti\fontsize{12bp}{14.4bp}\selectfont\raggedright,
    beforeskip = 12bp,
    afterskip  = 12bp,
    fixskip    = true,
  },
  subsubsection = {
    aftername  = \hspace{1\ccwd},
    format     = \songti\bfseries\fontsize{12bp}{14.4bp}\selectfont\raggedright,
    beforeskip = 8bp,
    afterskip  = 6bp,
    fixskip    = true,
  },
}

% ----------------------------------------------------------------------------
% 9. 目录、图清单、表清单格式（第3.7节表3.7、附件8、附件9）
% ----------------------------------------------------------------------------
\titlecontents{chapter}[0pt]
  {\songti\fontsize{14bp}{20bp}\selectfont}
  {\thecontentslabel\hspace{0.8\ccwd}}
  {}
  {\titlerule*[4pt]{.}\contentspage}

\titlecontents{section}[1\ccwd]
  {\songti\fontsize{12bp}{20bp}\selectfont}
  {\thecontentslabel\hspace{0.8\ccwd}}
  {}
  {\titlerule*[4pt]{.}\contentspage}

\titlecontents{subsection}[2\ccwd]
  {\songti\fontsize{12bp}{20bp}\selectfont}
  {\thecontentslabel\hspace{0.8\ccwd}}
  {}
  {\titlerule*[4pt]{.}\contentspage}

\titlecontents{figure}[0pt]
  {\songti\fontsize{12bp}{20bp}\selectfont}
  {图\thecontentslabel\hspace{1\ccwd}}
  {}
  {\titlerule*[4pt]{.}\contentspage}

\titlecontents{table}[0pt]
  {\songti\fontsize{12bp}{20bp}\selectfont}
  {表\thecontentslabel\hspace{1\ccwd}}
  {}
  {\titlerule*[4pt]{.}\contentspage}

% 清除图/表清单中章间额外垂直空隙，保持统一 20bp 固定行距
\newcommand{\cug@patch@addtocontents}{%
  \gdef\@chapter[##1]##2{%
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \refstepcounter{chapter}%
        \typeout{\@chapapp\space\thechapter.}%
        \addcontentsline{toc}{chapter}{\protect\numberline{\CTEXthechapter}##1}%
      \else
        \addcontentsline{toc}{chapter}{##1}%
      \fi
    \else
      \addcontentsline{toc}{chapter}{##1}%
    \fi
    \chaptermark{##1}%
    \if@twocolumn
      \@topnewpage[\@makechapterhead{##2}]%
    \else
      \@makechapterhead{##2}%
      \@afterheading
    \fi
  }%
}
% 保持 ctexbook 原生章处理，仅禁止默认 lof/lot 插入 10pt 章间距
\patchcmd{\@chapter}{\addtocontents{lof}{\protect\addvspace{10\p@}}}{}{}{}
\patchcmd{\@chapter}{\addtocontents{lot}{\protect\addvspace{10\p@}}}{}{}{}

% 统一页首居中标题（扣除 \topskip 且避免 \begin{center} 的 trivlist 额外下沉，与 \chapter 顶距精确一致）
% #1 = 段前间距, #2 = 段后间距, #3 = 字体与字号命令, #4 = 标题文本
\newcommand{\cug@pagetitle}[4]{%
  \begingroup
    \par\vspace*{\dimexpr#1-\topskip\relax}\nointerlineskip
    {\setlength{\parindent}{0pt}\centering #3#4\par}%
    \vspace{#2}%
  \endgroup
}

\newcommand{\cugtableofcontents}{%
  \clearpage
  \renewcommand{\cug@front@headmark}{\songti 目\quad 录}%
  \pagestyle{cugfront}%
  \phantomsection
  \pdfbookmark[0]{目录}{toc}%
  \cug@pagetitle{20bp}{20bp}{\heiti\bfseries\fontsize{16bp}{19.2bp}\selectfont}{目\quad 录}%
  \@starttoc{toc}%
  \clearpage
}

\newcommand{\cuglistoffigures}{%
  \clearpage
  \renewcommand{\cug@front@headmark}{\songti 图清单}%
  \pagestyle{cugfront}%
  \phantomsection
  \addcontentsline{toc}{chapter}{图清单}%
  \cug@pagetitle{20bp}{20bp}{\heiti\bfseries\fontsize{18bp}{21.6bp}\selectfont}{图清单}%
  \@starttoc{lof}%
  \clearpage
}

\newcommand{\cuglistoftables}{%
  \clearpage
  \renewcommand{\cug@front@headmark}{\songti 表清单}%
  \pagestyle{cugfront}%
  \phantomsection
  \addcontentsline{toc}{chapter}{表清单}%
  \cug@pagetitle{20bp}{20bp}{\heiti\bfseries\fontsize{18bp}{21.6bp}\selectfont}{表清单}%
  \@starttoc{lot}%
  \clearpage
}

% ----------------------------------------------------------------------------
% 10. 图、表、公式与脚注格式（第2.5节、第3.8节表3.8）
% ----------------------------------------------------------------------------
\renewcommand{\thefigure}{\thechapter.\arabic{figure}}
\renewcommand{\thetable}{\thechapter.\arabic{table}}
\renewcommand{\theequation}{\thechapter.\arabic{equation}}
\renewcommand{\figurename}{图}
\renewcommand{\tablename}{表}

% 图名、表名：宋体 10.5bp (五号)，居中，单倍行距，序号与题名空 1 汉字符
\DeclareCaptionFont{cugcaption}{\songti\fontsize{10.5bp}{12.6bp}\selectfont}
\DeclareCaptionLabelSeparator{cugspace}{\hspace{1\ccwd}}
\captionsetup{
  font=cugcaption,
  labelfont=cugcaption,
  labelsep=cugspace,
  justification=centering,
  singlelinecheck=true
}
\captionsetup[figure]{position=bottom, skip=6bp}
\captionsetup[table]{position=top, skip=6bp}
\captionsetup[sub]{font=cugcaption, labelfont=cugcaption, skip=4bp}

% 三线表线宽微调
\setlength{\heavyrulewidth}{1.2pt}
\setlength{\lightrulewidth}{0.5pt}
\setlength{\cmidrulewidth}{0.5pt}

% 表格正文默认五号宋体，仅作用于论文数据表环境（不影响封面/题名页排版表格）
\AtBeginEnvironment{table}{\zihao{5}\linespread{1.15}\selectfont}
\AtBeginEnvironment{table*}{\zihao{5}\linespread{1.15}\selectfont}
\AtBeginEnvironment{longtable}{\zihao{5}\linespread{1.15}\selectfont}

% 表达式编号：圆括号，Times New Roman 10.5bp (五号)，右对齐（表3.8）
\def\maketag@@@#1{\hbox{\m@th\normalfont\rmfamily\fontsize{10.5bp}{12.6bp}\selectfont#1}}

% 脚注：每页重新编号，带圈数字 ① ② ③，小五号宋体（使用 pifont 矢量字形，避免缺字）
\newcommand{\cug@circled}[1]{%
  \ifnum#1<11
    \ding{\numexpr171+#1\relax}%
  \else
    \textsuperscript{[#1]}%
  \fi
}
\renewcommand{\thefootnote}{\cug@circled{\value{footnote}}}
\renewcommand{\footnotesize}{\fontsize{9bp}{12bp}\selectfont}

% 列表环境紧凑且对齐正文行距
\setlist{nosep, leftmargin=2\ccwd}

% ----------------------------------------------------------------------------
% 11. 参考文献配置（第1.13节、第2.6节、第3.9节表3.9、附件11）
%     遵照 GB/T 7714，支持顺序编码制(默认)与著者-出版年制
% ----------------------------------------------------------------------------
\ExplSyntaxOn
\str_if_eq:VnTF \g_cug_bibstyle_tl { authoryear }
  {
    \RequirePackage[authoryear]{gbt7714}
  }
  {
    \RequirePackage[sort&compress]{gbt7714}
  }
\ExplSyntaxOff

\newcommand{\cugbibliography}[1]{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{参考文献}%
  \renewcommand{\bibname}{参考文献}%
  \begingroup
    \renewcommand{\bibsection}{%
      \cug@pagetitle{20bp}{24bp}{\heiti\bfseries\fontsize{16bp}{19.2bp}\selectfont}{参考文献}%
    }%
    \setlength{\bibsep}{0pt}%
    \songti\fontsize{12bp}{20bp}\selectfont
    \bibliography{#1}%
  \endgroup
}

% 分散对齐中文标签辅助宏（避免 \makebox[...][s] 报 Underfull \hbox）
\newcommand{\cug@spread}[2]{%
  \hbox to #1{\xeCJKsetup{CJKglue=\hfil}#2}%
}

% ----------------------------------------------------------------------------
% 12. 中文封面（第1.1节、第3.2节表3.2）
% ----------------------------------------------------------------------------
\newcommand{\cug@cover@field}[2]{%
  \cug@spread{\cug@label@width}{#1}：\underline{\makebox[8.2cm][c]{#2}}%
}

\newcommand{\makecover}{%
  \clearpage
  \thispagestyle{cugempty}%
  \begingroup
    \songti
    % 顶部：分类号、UDC、密级
    \noindent
    \begin{tabular}{@{}p{7.2cm}@{}p{7.8cm}@{}}
      {\zihao{5}\bfseries 分类号：}{\zihao{5}\cug@get@clc} &
      \hfill {\zihao{5}\bfseries 密级：}{\zihao{5}\cug@get@secret} \\
      {\zihao{5}\bfseries UDC：}{\zihao{5}\cug@get@udc} & \\
    \end{tabular}

    \vspace{1.8cm}

    % 校名与学位论文类型：宋体26磅(一号)加粗
    \begin{center}
      {\songti\bfseries\fontsize{26bp}{38bp}\selectfont
        中国地质大学\\[0.3em]
        \cug@degreetitle\par
      }
    \end{center}

    \vspace{1.6cm}

    % 论文题目：黑体22磅(二号)加粗居中，单倍行距（匹配 Word 二号中文单倍行距）
    \begin{center}
      {\heiti\bfseries\fontsize{22bp}{33bp}\selectfont
        \cug@get@title\par
        \cug@ifempty{\cug@get@subtitle}{}{%
          \vspace{0.3em}{\fontsize{18bp}{26bp}\selectfont ——\cug@get@subtitle\par}%
        }%
      }
    \end{center}

    \vfill

    % 作者信息栏：学号 TNR 16bp加粗，其余宋体16bp(三号)加粗（表3.2）
    \begin{center}
      \renewcommand{\arraystretch}{1.55}%
      {\songti\bfseries\fontsize{16bp}{22bp}\selectfont
      \begin{tabular}{@{}l@{}}
        \cug@cover@field{学号}{\rmfamily\bfseries\cug@get@studentid} \\
        \cug@cover@field{论文作者}{\cug@get@author} \\
        \cug@cover@field{\cug@major@label}{\cug@get@major} \\
        \cug@cover@field{指导教师}{\cug@get@supervisor} \\
        \cug@ifempty{\cug@get@cosupervisor}{}{%
          \cug@cover@field{副指导教师}{\cug@get@cosupervisor} \\
        }%
        \cug@ifempty{\cug@get@corpsupervisor}{}{%
          \cug@cover@field{企业导师}{\cug@get@corpsupervisor} \\
        }%
        \cug@cover@field{培养单位}{\cug@get@department} \\
      \end{tabular}}
    \end{center}

    \vspace{1.8cm}

    % 日期：宋体16磅(三号)汉字居中，不用阿拉伯数字
    \begin{center}
      {\songti\fontsize{16bp}{22bp}\selectfont \cug@get@date}
    \end{center}
    \vspace{0.6cm}
  \endgroup
  \clearpage
}

% ----------------------------------------------------------------------------
% 13. 中文题名页（第1.2节、第3.4节表3.4、附件1）
% ----------------------------------------------------------------------------
\newcommand{\cug@titlezh@row}[2]{%
  \cug@spread{\cug@label@width}{#1}：& #2 \\
}

\newcommand{\maketitlepagezh}{%
  \clearpage
  \thispagestyle{cugempty}%
  \begingroup
    % 顶部：学校代码、研究生学号（宋体16磅/三号，学号 TNR 16磅）
    \noindent
    {\songti\fontsize{16bp}{22bp}\selectfont
      学校代码：{\rmfamily\cug@get@schoolcode}\hfill
      研究生学号：{\rmfamily\cug@get@studentid}%
    }

    \vspace{2.0cm}

    % 中国地质大学 + 学位论文类型：宋体26磅(一号)加粗
    \begin{center}
      {\songti\bfseries\fontsize{26bp}{38bp}\selectfont
        中国地质大学\\[0.3em]
        \cug@degreetitle\par
      }
    \end{center}

    \vspace{1.6cm}

    % 论文题目：黑体22磅(二号)加粗居中，单倍行距（匹配 Word 二号中文单倍行距）
    \begin{center}
      {\heiti\bfseries\fontsize{22bp}{33bp}\selectfont
        \cug@get@title\par
        \cug@ifempty{\cug@get@subtitle}{}{%
          \vspace{0.3em}{\fontsize{18bp}{26bp}\selectfont ——\cug@get@subtitle\par}%
        }%
      }
    \end{center}

    \vfill

    % 信息栏：宋体16磅(三号)，不加粗（表3.4与附件1）
    \begin{center}
      \renewcommand{\arraystretch}{1.65}%
      {\songti\fontsize{16bp}{22bp}\selectfont
      \begin{tabular}{@{}r@{\hspace{0.6em}}l@{}}
        \cug@titlezh@row{姓名}{\cug@get@author}
        \cug@titlezh@row{\cug@major@label}{\cug@get@major}
        \cug@titlezh@row{指导教师}{\cug@get@supervisor}
        \cug@ifempty{\cug@get@cosupervisor}{}{%
          & \cug@get@cosupervisor \\
        }%
        \cug@ifempty{\cug@get@corpsupervisor}{}{%
          \cug@titlezh@row{企业导师}{\cug@get@corpsupervisor}
        }%
        \cug@titlezh@row{培养单位}{\cug@get@department}
      \end{tabular}}
    \end{center}

    \vspace{2.0cm}

    % 日期：宋体16磅(三号)汉字居中，不用阿拉伯数字
    \begin{center}
      {\songti\fontsize{16bp}{22bp}\selectfont \cug@get@date}
    \end{center}
    \vspace{0.6cm}
  \endgroup
  \clearpage
}

% ----------------------------------------------------------------------------
% 14. 英文题名页（第1.2节、第3.5节表3.5、附件2）
%     全部 Times New Roman：常规项16bp(三号)，题目22bp(二号)加粗居中单倍行距
% ----------------------------------------------------------------------------
\newcommand{\maketitlepageen}{%
  \clearpage
  \thispagestyle{cugempty}%
  \begingroup
    \rmfamily
    % 顶部声明（自动适配博士、学硕、全日制专硕、非全日制专硕 4 种附件2样式）
    \par\vspace*{\dimexpr0.4cm-\topskip\relax}\nointerlineskip
    {\setlength{\parindent}{0pt}\centering
      \fontsize{16bp}{24bp}\selectfont
      A Dissertation Submitted to China University of Geosciences\\[0.25em]
      \cug@ifprof{%
        \cug@ifparttime{%
          For the Part-Time Master of Professional Degree of\\[0.25em]
          \cug@get@degreesubject@en
        }{%
          For the Full-Time Master of Professional Degree of\\[0.25em]
          \cug@get@degreesubject@en
        }%
      }{%
        \cug@ifdoctor{%
          For the Doctor Degree of \cug@get@degreesubject@en
        }{%
          For the Master Degree of \cug@get@degreesubject@en
        }%
      }\par
    }

    \vspace{2.0cm}

    % 英文题目：Times New Roman 22磅(二号)加粗居中，单倍行距
    \begin{center}
      {\bfseries\fontsize{22bp}{29bp}\selectfont
        \cug@get@title@en\par
        \cug@ifempty{\cug@get@subtitle@en}{}{%
          \vspace{0.25em}{\fontsize{18bp}{24bp}\selectfont \cug@get@subtitle@en\par}%
        }%
      }
    \end{center}

    \vfill

    % 责任者栏：Times New Roman 16磅(三号)
    \begin{center}
      \renewcommand{\arraystretch}{1.65}%
      {\fontsize{16bp}{22bp}\selectfont
      \begin{tabular}{@{}r@{\hspace{0.6em}}l@{}}
        \cug@ifdoctor{Ph.D. Candidate:}{Master Candidate:} & \cug@get@author@en \\
        \cug@ifprof{Professional Degree Category:}{Major:} & \cug@get@major@en \\
        Supervisor: & \cug@get@supervisor@en \\
        \cug@ifempty{\cug@get@corpsupervisor@en}{}{%
          Co-Supervisor: & \cug@get@corpsupervisor@en \\
        }%
      \end{tabular}}
    \end{center}

    \vspace{2.2cm}

    % 底部学校英文名称与邮编
    \begin{center}
      {\fontsize{16bp}{24bp}\selectfont
        China University of Geosciences\\[0.25em]
        Wuhan 430074 P.R. China\par
      }
    \end{center}
    \vspace{0.6cm}
  \endgroup
  \clearpage
}

% ----------------------------------------------------------------------------
% 15. 原创性声明、导师承诺书、使用授权书（第1.3-1.5节、附件3-5）
% ----------------------------------------------------------------------------
\newcommand{\cug@render@sig}[1]{%
  \cug@ifblind{\hspace{4.5cm}}{%
    \cug@ifempty{#1}{\hspace{4.5cm}}{%
      \raisebox{-0.35\height}{\includegraphics[height=1.1cm]{#1}}%
    }%
  }%
}

\newcommand{\cug@render@sigdate}{%
  \cug@ifempty{\cug@get@sig@date}{%
    \hspace{2.2em}年\hspace{1.8em}月\hspace{1.8em}日%
  }{%
    \cug@get@sig@date
  }%
}

% 附件3：学位论文原创性声明
\newcommand{\makeoriginality}{%
  \clearpage
  \thispagestyle{cugempty}%
  \begingroup
    \cug@pagetitle{24bp}{28bp}{\heiti\bfseries\fontsize{16bp}{22bp}\selectfont}{中国地质大学（武汉）研究生学位论文原创性声明}%

    {\songti\fontsize{14bp}{26bp}\selectfont
      \par\indent 本人郑重声明：本人所呈交的\cug@degreeshort 学位论文《\cug@get@title》，是本人在导师的指导下，在中国地质大学（武汉）攻读\cug@degreeshort 学位期间独立进行研究工作所取得的成果。论文中除已注明部分外不包含他人已发表或撰写过的研究成果，对论文的完成提供过帮助的有关人员已在文中说明并致以谢意。

      \par\indent 本人所呈交的\cug@degreeshort 学位论文没有违反学术道德和学术规范，没有侵权行为，并愿意承担由此而产生的法律责任和法律后果。

      \vspace{2.6cm}
      \begin{flushright}
        \begin{minipage}{9.5cm}
          \songti\fontsize{14bp}{28bp}\selectfont
          学位论文作者签名：\cug@render@sig{\cug@get@author@sig}\\[0.6em]
          \cug@spread{4\ccwd}{日期}：\cug@render@sigdate
        \end{minipage}
      \end{flushright}
    }
  \endgroup
  \clearpage
}

% 附件4：研究生学位论文导师承诺书
\newcommand{\makesupervisorpromise}{%
  \clearpage
  \thispagestyle{cugempty}%
  \begingroup
    \cug@pagetitle{24bp}{28bp}{\heiti\bfseries\fontsize{16bp}{22bp}\selectfont}{中国地质大学（武汉）研究生学位论文导师承诺书}%

    {\songti\fontsize{14bp}{26bp}\selectfont
      \par\indent 本人郑重承诺：本人所指导的\cug@degreeshort 学位论文《\cug@get@title》，是在本人的指导下，研究生在中国地质大学（武汉）攻读\cug@degreeshort 学位期间独立进行研究工作所取得的成果，论文由研究生独立完成。

      \par\indent 研究生所呈交的\cug@degreeshort 学位论文没有违反学术道德和学术规范，没有侵权行为，并愿意承担由此而产生的与导师相关的责任和后果。

      \vspace{2.6cm}
      \begin{flushright}
        \begin{minipage}{9.5cm}
          \songti\fontsize{14bp}{28bp}\selectfont
          指导教师（签字）：\cug@render@sig{\cug@get@supervisor@sig}\\[0.6em]
          \cug@spread{4\ccwd}{日期}：\cug@render@sigdate
        \end{minipage}
      \end{flushright}
    }
  \endgroup
  \clearpage
}

% 附件5：学位论文使用授权书
\newcommand{\makeauthorization}{%
  \clearpage
  \thispagestyle{cugempty}%
  \begingroup
    \cug@pagetitle{24bp}{28bp}{\heiti\bfseries\fontsize{16bp}{22bp}\selectfont}{中国地质大学（武汉）学位论文使用授权书}%

    {\songti\fontsize{14bp}{26bp}\selectfont
      \par\indent 本人授权中国地质大学（武汉）可采用影印、缩印、数字化或其它复制手段保存本学位论文；学校可向国家有关部门或机构送交本学位论文的电子版全文，编入有关数据库进行检索、下载及文献传递服务；同意在校园网内提供全文浏览和下载服务。

      \par\indent 涉密论文解密后适用于本授权书。

      \vspace{2.8cm}
      \begin{flushright}
        \begin{minipage}{9.5cm}
          \songti\fontsize{14bp}{28bp}\selectfont
          学位论文作者签名：\cug@render@sig{\cug@get@author@sig}\\[0.6em]
          \cug@spread{4\ccwd}{日期}：\cug@render@sigdate
        \end{minipage}
      \end{flushright}
    }
  \endgroup
  \clearpage
}

% 一键生成前五项前置页（封面 + 中英文题名页 + 三项声明授权书）
\newcommand{\makefrontpages}{%
  \cug@ifcover{\makecover}{}%
  \maketitlepagezh
  \maketitlepageen
  \makeoriginality
  \makesupervisorpromise
  \makeauthorization
}

% ----------------------------------------------------------------------------
% 16. 作者简介（第1.6节、第3.9节表3.9、附件6）
% ----------------------------------------------------------------------------
\NewDocumentEnvironment{resume}{O{作者简介}}{%
  \clearpage
  \thispagestyle{cugempty}%
  \pagestyle{cugempty}%
  \cug@pagetitle{20bp}{24bp}{\heiti\bfseries\fontsize{16bp}{19.2bp}\selectfont}{#1}%
  \songti\fontsize{12bp}{20bp}\selectfont
}{%
  \clearpage
}

% ----------------------------------------------------------------------------
% 17. 学位论文答辩委员会名单（第1.7节、附件7）
% ----------------------------------------------------------------------------
\NewDocumentEnvironment{committee}{}{%
  \clearpage
  \thispagestyle{cugempty}%
  \pagestyle{cugempty}%
  \cug@pagetitle{24bp}{36bp}{\heiti\bfseries\fontsize{22bp}{28bp}\selectfont}{学位论文答辩委员会名单}%
  \begin{center}
    \renewcommand{\arraystretch}{1.8}%
    \songti\fontsize{16bp}{22bp}\selectfont
    \begin{tabular}{@{}p{2.2cm}p{2.8cm}p{2.8cm}l@{}}
}{%
    \end{tabular}
  \end{center}
  \clearpage
}

\newcommand{\committeemember}[4]{%
  #1 & #2 & #3 & #4 \\
}

% ----------------------------------------------------------------------------
% 18. 中文摘要与英文摘要（第1.8-1.9节、第3.6节表3.6）
%     中文摘要标题：黑体18磅(小二)加粗居中，单倍行距
%     英文摘要标题：Times New Roman 18磅(小二)加粗居中，单倍行距
%     正文：宋体 / Times New Roman 12磅(小四)，固定行距20磅，段前段后0磅
%     关键词：“关键词” / “Key Words”加粗，分号分隔
% ----------------------------------------------------------------------------
\NewDocumentEnvironment{abstractzh}{}{%
  \cugfrontmatter
  \renewcommand{\cug@front@headmark}{\songti 摘\quad 要}%
  \pagestyle{cugfront}%
  \phantomsection
  \pdfbookmark[0]{摘要}{abstractzh}%
  \cug@pagetitle{20bp}{20bp}{\heiti\bfseries\fontsize{18bp}{21.6bp}\selectfont}{摘\quad 要}%
  \songti\fontsize{12bp}{20bp}\selectfont
}{%
  \par\vspace{10bp}%
  \noindent{\songti\bfseries\fontsize{12bp}{20bp}\selectfont 关键词：}%
  {\songti\fontsize{12bp}{20bp}\selectfont \cug@get@keywords}%
  \clearpage
}

\NewDocumentEnvironment{abstracten}{}{%
  \clearpage
  % 规范表3.1：Abstract部分页眉用Times New Roman字体10.5磅(五号)
  \renewcommand{\cug@front@headmark}{\rmfamily Abstract}%
  \pagestyle{cugfront}%
  \phantomsection
  \pdfbookmark[0]{Abstract}{abstracten}%
  \cug@pagetitle{20bp}{20bp}{\rmfamily\bfseries\fontsize{18bp}{21.6bp}\selectfont}{Abstract}%
  \rmfamily\fontsize{12bp}{20bp}\selectfont
}{%
  \par\vspace{10bp}%
  \noindent{\rmfamily\bfseries\fontsize{12bp}{20bp}\selectfont Key Words:\ }%
  {\rmfamily\fontsize{12bp}{20bp}\selectfont \cug@get@keywords@en}%
  \clearpage
}

% ----------------------------------------------------------------------------
% 19. 致谢与附录（第1.14-1.15节、第3.9节表3.9）
% ----------------------------------------------------------------------------
\NewDocumentEnvironment{acknowledgements}{}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{致谢}%
  \cug@pagetitle{20bp}{24bp}{\heiti\bfseries\fontsize{16bp}{19.2bp}\selectfont}{致\quad 谢}%
  \songti\fontsize{12bp}{20bp}\selectfont
}{%
  \clearpage
}

% 附录环境：支持多篇附录（附录A、附录B）及单篇附录
\newcommand{\cugappendix}{%
  \clearpage
  \appendix
  \ctexset{
    chapter = {
      name      = {附录,},
      number    = \Alph{chapter},
      aftername = \hspace{1\ccwd},
    }
  }%
  \renewcommand{\thefigure}{\Alph{chapter}.\arabic{figure}}%
  \renewcommand{\thetable}{\Alph{chapter}.\arabic{table}}%
  \renewcommand{\theequation}{\Alph{chapter}.\arabic{equation}}%
}

% ----------------------------------------------------------------------------
% 20. 书脊排版（第3.3节：仿宋，上方题目，中间作者姓名，下方“中国地质大学（武汉）”）
% ----------------------------------------------------------------------------
\newcommand{\makespine}{%
  \clearpage
  \thispagestyle{cugempty}%
  \begingroup
    \centering
    \fangsong\fontsize{14bp}{16bp}\selectfont
    \vspace*{1.5cm}
    \fbox{%
      \begin{minipage}[c][24cm][t]{1.6cm}
        \centering
        \vspace{1cm}
        \parbox[t]{1.1em}{\centering \cug@get@title}
        \vfill
        \parbox[c]{1.1em}{\centering \cug@get@author}
        \vfill
        \parbox[b]{1.1em}{\centering 中国地质大学（武汉）}
        \vspace{1cm}
      \end{minipage}%
    }
  \endgroup
  \clearpage
}

\AtEndDocument{%
  \cug@ifspine{\makespine}{}%
}

\endinput
