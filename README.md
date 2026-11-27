# 中国地质大学（武汉）研究生学位论文 LaTeX 模板使用指南

> **项目主页与在线预览**：https://zhanlutuzi.github.io/cug-thesis-latex/  
> **样稿 PDF 预览**：[sample.pdf](https://zhanlutuzi.github.io/cug-thesis-latex/sample.pdf)

本模板严格依据 **《中国地质大学（武汉）研究生学位论文写作规范》（2025 年 5 月修改版）**（正文及附件 1–11）编写，开箱即用，支持 **学术型硕士、博士、全日制专业学位硕士、非全日制专业学位硕士及同等学力学位论文**，并兼容 macOS、Windows、Linux 与 Overleaf。

---

## 一、快速上手（5 分钟跑通）

### 1. 环境要求

- **本地编译**：安装 **TeX Live 2022 及以上**（macOS 安装 MacTeX，Windows 安装 TeX Live），**必须使用 `XeLaTeX` 引擎**（不要用 `pdfLaTeX`）。
- **在线编译（Overleaf）**：将本项目打包为 `.zip` 上传至 Overleaf，点击左上角 **Menu → Compiler** 切换为 **`XeLaTeX`**，点击 Recompile 即可。

### 2. 编译方式

#### 方式 A：命令行一键编译（推荐）

本项目已配置好 `latexmkrc`，在论文根目录运行：

```bash
# 一键完成 XeLaTeX + BibTeX 多次编译，生成 main.pdf
latexmk -xelatex main.tex

# 或使用 Makefile
make

# 清理中间临时文件（保留 main.pdf）
make clean

# 彻底清理（含 main.pdf）
make distclean
```

如果手动分步编译，需按顺序执行：

```bash
xelatex main.tex
bibtex main
xelatex main.tex
xelatex main.tex
```

#### 方式 B：VS Code + LaTeX Workshop

1. 安装 VS Code 插件 **LaTeX Workshop**；
2. 打开本文件夹并打开 `main.tex`；
3. 按 `Ctrl+Alt+B`（macOS 为 `Cmd+Option+B`），因根目录自带 `latexmkrc`，插件默认调用 `latexmk` 时会自动使用 `XeLaTeX + BibTeX`；如未生效，在侧边栏 TeX 图标中手动选择 `Recipe: xelatex -> bibtex -> xelatex*2`。

#### 方式 C：TeXstudio

菜单栏选择 **选项 → 设置 TeXstudio → 构建**：
- 默认编译器：`XeLaTeX`
- 默认文献工具：`BibTeX`

---

## 二、目录结构与文件说明

| 文件 / 目录 | 用途 | 写作时是否需要修改 |
| :--- | :--- | :--- |
| `main.tex` | 论文主文件：设置学位类型、个人信息、组织章节顺序 | **必改** |
| `frontmatter/resume.tex` | 作者简介（规范 1.6、附件 6） | **必改** |
| `frontmatter/committee.tex` | 学位论文答辩委员会名单（规范 1.7、附件 7，位于摘要前） | **必改** |
| `frontmatter/abstract_zh.tex` | 中文摘要正文（规范 1.8、3.6） | **必改** |
| `frontmatter/abstract_en.tex` | 英文摘要 Abstract 正文（规范 1.9、3.6） | **必改** |
| `chapters/chap01.tex` 等 | 正文各章内容，可按需增删章节文件 | **必改** |
| `bib/references.bib` | GB/T 7714 参考文献数据库 | **必改** |
| `backmatter/acknowledgements.tex` | 致谢（规范 1.14、3.9） | **必改** |
| `backmatter/appendix.tex` | 附录（规范 1.15、3.9），如无附录可在 `main.tex` 中注释 | 按需修改 |
| `figures/`（自行新建存放图片） | 建议将论文插图统一放在此目录（推荐 `.pdf` / `.eps` / 300 dpi `.png`） | 按需新建 |
| `cugthesis.cls` | 模板核心样式类文件（封装全部格式规范） | **一般无需修改** |
| `latexmkrc` / `Makefile` | 自动编译配置脚本 | **一般无需修改** |

---

## 三、第一步：设置学位类型与模板选项

打开 `main.tex` 顶部，在 `\documentclass[...]{cugthesis}` 中按需组合选项：

| 选项 | 可选值 | 作用说明 |
| :--- | :--- | :--- |
| `degree` | `master`（默认）<br>`doctor`<br>`profmaster`<br>`parttime`<br>`eqmaster`<br>`eqdoctor` | 分别对应：学术型硕士、博士、全日制专业学位硕士、非全日制专业学位硕士、同等学力硕士、同等学力博士。<br>会自动联动切换封面、中英文题名页、原创性声明、导师承诺书以及奇数页页眉文字（例如专硕自动将“学科专业”切换为“专业学位类别”）。 |
| `bibstyle` | `numerical`（默认）<br>`authoryear` | `numerical`：GB/T 7714 顺序编码制（正文上标 `[1]`）；<br>`authoryear`：GB/T 7714 著者-出版年制。 |
| `fontset` | `auto`（默认）<br>`mac` / `windows` / `fandol` | 自动检测系统字体（Windows 用宋体/黑体/仿宋/Times New Roman；macOS 下宋体优先自动调用本机 Microsoft Word 内置 `SimSun`，未装 Word 时回退 `Songti SC`，黑体/仿宋保持 macOS 系统字体；Linux/Overleaf 自动回退 TeX Live 内置 Fandol 字体）。 |
| `cover` | `true`（默认）<br>`false` | 是否输出中文封面。提交学校统一印制固定封面时，设为 `false` 即可直接从中文题名页开始。 |
| `spine` | `false`（默认）<br>`true` | 设为 `true` 时，在 PDF 最后一页生成仿宋竖排书脊（规范 3.3）。 |
| `blind` | `false`（默认）<br>`true` | **盲审模式**：自动将作者姓名、学号、导师姓名替换为 `******`，隐藏签名图片及偶数页页眉中的姓名。 |
| `print` | `false`（默认）<br>`true` | **双面印刷模式**：规范 3.10 规定自中文摘要起双面印刷，之前部分单面印刷；开启后会在中文摘要与第一章前自动补空白页使其落在奇数页。电子提交版保持 `false` 即可。 |
| `frontheader` | `true`（默认）<br>`false` | 中文摘要、Abstract、目录、图/表清单是否显示页眉文字与下划线（开启时 Abstract 页眉严格使用五号 Times New Roman，符合表 3.1）。 |
| `openright` | `false`（默认）<br>`true` | 设为 `true` 时每章强制从奇数页起排；默认 `false`（每章另起页，不插多余空白页）。 |

### 常见场景配置示例

```latex
% 1. 学术型硕士日常写作 / 电子版提交（默认）
\documentclass[degree=master]{cugthesis}

% 2. 全日制专业学位硕士
\documentclass[degree=profmaster]{cugthesis}

% 3. 非全日制专业学位硕士（配合 \cugsetup 中的 corpsupervisor 填写企业导师）
\documentclass[degree=parttime]{cugthesis}

% 4. 博士学位论文 + 著者-出版年制文献
\documentclass[degree=doctor, bibstyle=authoryear]{cugthesis}

% 5. 送审盲审版本
\documentclass[degree=master, blind=true]{cugthesis}

% 6. 最终纸质装订版（关闭自制封面 + 双面印刷对齐 + 附加书脊页）
\documentclass[degree=master, cover=false, print=true, spine=true]{cugthesis}
```

---

## 四、第二步：填写论文元数据（`\cugsetup`）

在 `main.tex` 的 `\cugsetup{...}` 中填入个人与论文信息，**所有封面、中英文题名页、声明、承诺书、摘要关键词和页眉都会自动同步生成**，无需重复修改多处：

```latex
\cugsetup{
  clc               = {P631.4},                   % 中图分类号（第4版）
  udc               = {550.8},                    % UDC 分类号（www.udcc.org）
  secret            = {公开},                     % 密级：公开可填“公开”或留空；涉密如“保密★2年”
  schoolcode        = {10491},                    % 中国地质大学（武汉）学校代码固定为 10491
  studentid         = {1202310001},               % 研究生学号
  title             = {论文中文主标题},            % 一般不宜超过 25 字
  subtitle          = {},                         % 副标题（无则留空）
  header-title      = {},                         % 题目过长导致页眉换行时，可在此填页眉简称
  title-en          = {English Title of Thesis},  % 英文主标题
  subtitle-en       = {},                         % 英文副标题（无则留空）
  author            = {张三},                     % 作者中文姓名
  author-en         = {Zhang San},                % 作者英文/拼音姓名
  major             = {计算机科学与技术},          % 学科专业（专硕填专业学位类别）
  major-en          = {Computer Science and Technology},
  degree-subject-en = {Engineering},              % 英文题名页学位门类（如 Engineering / Science）
  supervisor        = {李四\quad 教授},           % 指导教师（姓名 + 职称）
  supervisor-en     = {Prof. Li Si},              % 英文指导教师
  cosupervisor      = {},                         % 副指导教师（无则留空）
  corpsupervisor    = {},                         % 企业导师（非全日制专硕填写，无则留空）
  corpsupervisor-en = {},                         % 英文企业导师（无则留空）
  department        = {计算机学院},               % 培养单位规范全称
  date              = {二○二六年五月},            % 必须用汉字，不要用阿拉伯数字（规范 3.2/3.4）
  keywords          = {关键词一；关键词二；关键词三}, % 3~5个，中文分号分隔
  keywords-en       = {Keyword 1; Keyword 2; Keyword 3},
  % 如需插入电子手写签名（透明底 PNG），填入路径；纸质版需亲笔签字，留空即可
  author-sig        = {},                         % 例如 figures/sig_author.png
  supervisor-sig    = {},                         % 例如 figures/sig_supervisor.png
  sig-date          = {},                         % 例如 2026年5月20日（留空则显示“  年  月  日”）
}
```

---

## 五、第三步：写作与常用排版语法

### 1. 新增 / 删除正文章节、附录与图/表清单

#### 新增一章（只需两步）

1. **在 `chapters/` 下新建 `.tex` 文件**（例如 `chapters/chap05.tex`，文件名任取，章号按引入顺序自动生成）：

```latex
% !TeX root = ../main.tex
\chapter{你的新章节标题}

\section{第一节标题}

正文内容……

\subsection{第一小节标题}

正文内容……
```

2. **在 `main.tex` 的 `\cugmainmatter` 下添加一行 `\include`**（不带 `.tex` 后缀，放在哪个位置就自动排成第几章）：

```latex
\cugmainmatter
\include{chapters/chap01}
\include{chapters/chap02}
\include{chapters/chap03}
\include{chapters/chap05}   % 插在结论前，自动编为“第四章”
\include{chapters/chap04}   % 原“结论与展望”自动顺延为“第五章”
```

重新编译后，**章号、目录、页眉页码以及图/表/公式编号均会自动更新**，无需手动修改任何编号。删除某一章同理，只需在 `main.tex` 中删掉或注释对应的 `\include{...}` 即可。

#### 新增多篇附录 / 开关可选项

- **新增第二个附录（附录 B）**：在 `backmatter/appendix.tex` 末尾继续写一个 `\chapter{第二个附录标题}`，或在 `backmatter/` 下新建文件后在 `main.tex` 的 `\cugappendix` 下方 `\include` 即可。
- **关闭附录**：如无附录，在 `main.tex` 中注释 `\cugappendix` 和 `\include{backmatter/appendix}`。
- **关闭图/表清单**：规范说明图清单和表清单为非必要项，如不需要，直接在 `main.tex` 中注释 `\cuglistoffigures` 和 `\cuglistoftables`。

### 2. 各级标题写法

模板已自动按照规范表 3.8 设置字体、字号、对齐（章标题与一级节标题居中，二级节标题居左）与空行，写作时直接使用标准命令即可：

```latex
\chapter{研究方法}          % 生成：第二章  研究方法（黑体三号加粗居中）
\section{数学建模}          % 生成：2.1  数学建模（黑体四号加粗居中）
\subsection{目标函数构造}   % 生成：2.1.1  目标函数构造（黑体小四居左）
\subsubsection{正则化项}    % 生成：2.1.1.1  正则化项（不进入目录）
```

### 3. 插入单图与并排子图

图片标题自动排在图下方（五号宋体居中，序号与图题空 1 汉字符），建议在文中先写“如图~\ref{fig:demo} 所示”再放图环境：

```latex
% 单图示例
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.8\textwidth]{figures/demo.pdf}
  \caption{实验区域地质构造示意图}
  \label{fig:demo}
\end{figure}

% 双子图示例
\begin{figure}[htbp]
  \centering
  \begin{subfigure}[b]{0.46\textwidth}
    \centering
    \includegraphics[width=\textwidth]{figures/a.png}
    \caption{原始观测数据}
    \label{fig:compare-a}
  \end{subfigure}
  \hfill
  \begin{subfigure}[b]{0.46\textwidth}
    \centering
    \includegraphics[width=\textwidth]{figures/b.png}
    \caption{反演重建结果}
    \label{fig:compare-b}
  \end{subfigure}
  \caption{观测数据与反演结果对比}
  \label{fig:compare}
\end{figure}
```

### 4. 三线表与跨页续表

表标题自动排在表上方（五号宋体居中，序号与表题空 1 汉字符），表内默认五号宋体：

```latex
\begin{table}[htbp]
  \centering
  \caption{不同算法性能对比}
  \label{tab:perf}
  \begin{tabular}{lccc}
    \toprule
    算法名称 & 准确率 / \% & 召回率 / \% & 耗时 / \si{\second} \\
    \midrule
    基准方法 & 88.5 & 86.2 & 1.24 \\
    本文方法 & \textbf{95.4} & \textbf{94.8} & \textbf{0.35} \\
    \bottomrule
  \end{tabular}
\end{table}
```

> **跨页续表**：若表格超过一页，请直接参考 `chapters/chap02.tex` 中的 `longtable` 示例，已配好续页自动重复表号、“（续）”字样及表头（符合规范 2.5.2）。

### 5. 公式与国际单位（GB 3100–3102）

公式自动分章编号 `(2.1)` 并使用五号 Times New Roman 右对齐；物理单位推荐使用 `siunitx` 提供的 `\si{...}` 与 `\SI{数值}{单位}`（自动保证单位正体并与数值留适当间隙）：

```latex
波速为 \SI{3500}{\meter\per\second}，密度为 \SI{2.65e3}{\kilogram\per\cubic\meter}，如式~\eqref{eq:demo} 所示：
\begin{equation}
  E = mc^2
  \label{eq:demo}
\end{equation}
```

### 6. 脚注与参考文献（GB/T 7714）

- **脚注**：直接使用 `\footnote{注释内容}`，模板会自动在当页底部以带圈数字（① ② ③）小五号宋体排版，且每页重新编号。
- **文献引用**：
  - 将 BibTeX 条目添加到 `bib/references.bib`（可从 Google Scholar、知网、Web of Science、Zotero 直接导出 BibTeX）；
  - 正文中使用 `\cite{key}`（顺序编码制下自动生成上标 `[1]`；连续多篇 `\cite{k1,k2,k3}` 自动压缩为 `[1-3]`）；
  - 如需在正文中非上标引用（如“文献[1]指出”），可使用 `\inlinecite{key}` 或 `\citet{key}`；
  - 文献类型标志（`[J]`/`[M]`/`[C]`/`[D]`/`[S]`/`[P]`/`[EB/OL]`）由 `gbt7714` 自动根据 `@article`、`@book`、`@inproceedings`、`@phdthesis`/`@mastersthesis`、`@standard`、`@patent`、`@online` 生成，示例见 `bib/references.bib`。

---

## 六、提交与印刷前检查清单

- [ ] **盲审提交前**：将 `main.tex` 中 `\documentclass[...]{cugthesis}` 改为 `blind=true`，并检查 `frontmatter/resume.tex`、`frontmatter/committee.tex` 与 `backmatter/acknowledgements.tex`（盲审版一般需按学院要求注释掉致谢、作者简介中的个人姓名/导师姓名）。
- [ ] **答辩后归档版**：恢复 `blind=false`，核对答辩委员会名单、导师职称、完成日期（汉字）、原创性声明与导师承诺书中的论文题目是否与封面完全一致。
- [ ] **纸质印刷装订（规范 3.10）**：自中文摘要起双面印刷，之前部分单面印刷；采用线装或热胶装订（不可用金属钉）；原创性声明、导师承诺书、使用授权书须亲笔签名。
- [ ] **学校统一印制封面**：若直接使用打印店/学校统一封面，将 `cover=false` 重新编译即可去掉自制中文封面。

---

## 七、常见问题（FAQ）

1. **编译报错 `Critical ctex error` 或 `fontspec cannot be run with pdflatex`？**
   - 原因：误用了 `pdfLaTeX` 编译器。
   - 解决：务必切换为 **`XeLaTeX`**（命令行运行 `latexmk -xelatex main.tex`，Overleaf 在 Menu 中选 `XeLaTeX`）。

2. **参考文献全部显示 `[?]` 或末尾没有参考文献表？**
   - 原因：只跑了一次 `xelatex`，没有执行 `bibtex`。
   - 解决：使用 `latexmk -xelatex main.tex`，或手动依次运行 `xelatex → bibtex → xelatex → xelatex`。

3. **论文题目较长，导致偶数页页眉文字换行或与左侧页码重叠？**
   - 解决：在 `main.tex` 的 `\cugsetup` 中填写 `header-title = {简洁的页眉题目}`，仅替换页眉中的标题，不影响封面与题名页的完整标题。

4. **如何在 Windows / Linux / Overleaf 上确保字体正常？**
   - 默认 `fontset=auto` 会自动探测并回退，无需手动修改；如果希望在所有平台得到完全一致的开源字体效果，可显式指定 `fontset=fandol`。

5. **图片跑到了很后面的页面？**
   - 建议使用 `[htbp]` 浮动参数并合理控制图片宽度（如 `width=0.75\textwidth`）；若必须固定在当前位置，可在 `main.tex` 引入 `\usepackage{float}` 并使用 `[H]`。
