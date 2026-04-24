# NLINK Markdown-to-PDF Pipeline

Standardized tooling for converting Markdown documents to PDF using
**pandoc** + **WeasyPrint**, with full control over font size, orientation,
and table layout from the command line.

## Files

| File | Purpose |
|---|---|
| `Makefile` | Build orchestrator — all variables overridable from env |
| `layout.css` | Default stylesheet — `table-layout: auto` (content-driven widths) |
| `layout-fixed.css` | Alternate stylesheet — `table-layout: fixed` (dash-driven widths) |

## Requirements

```
pip install weasyprint
brew install pandoc        # macOS
pkg install pandoc         # FreeBSD
```

## Installation

```sh
make install
```

This copies `Makefile`, `layout.css`, and `layout-fixed.css` to `~/bin/`.

Then add the alias to your shell rc file:

**zsh / bash** — add to `~/.zshrc` or `~/.bashrc`:
```sh
alias mkpdf='make -f ~/bin/Makefile'
```

**tcsh / csh** — add to `~/.tcshrc` or `~/.cshrc`:
```csh
alias mkpdf 'make -f ~/bin/Makefile'
```

Reload without restarting the shell:
```sh
source ~/.zshrc    # zsh
source ~/.cshrc    # csh
```

## Usage

```sh
mkpdf SRC=mydoc.md                                      # portrait, 8.8pt
mkpdf SRC=mydoc.md PREVIEW=yes                          # build + open PDF
mkpdf SRC=mydoc.md ORIENTATION=landscape                # landscape
mkpdf SRC=mydoc.md FONT_SIZE=7pt                        # smaller font
mkpdf SRC=mydoc.md ORIENTATION=landscape FONT_SIZE=7pt  # wide tables
mkpdf SRC=mydoc.md CSS=~/bin/layout-fixed.css           # fixed column widths
```

Output files are named from the source: `SRC=report.md` → `report.pdf` + `report.html`

## Variables

| Variable | Default | Description |
|---|---|---|
| `SRC` | `src.md` | Source Markdown file |
| `CSS` | `~/bin/layout.css` | Stylesheet path |
| `FONT_SIZE` | `8.8pt` | Base font size — scales all elements proportionally |
| `ORIENTATION` | `portrait` | `portrait` or `landscape` |
| `PREVIEW` | `no` | Set to `yes` to open PDF after build |

## Choosing a stylesheet

**`layout.css`** (default) — WeasyPrint distributes column widths based on
content. Works for any table without tuning. Use this for most documents.

**`layout-fixed.css`** — Column widths follow the separator dash proportions
in the Markdown source. Use when you need explicit column control on
simple tables.

## Table guidelines

**Separator dashes control column widths** (fixed layout only). Make them
proportional to the desired width:

```
| Col A | Col B | Long column C     |
|-------|-------|-------------------|   ← proportional dashes
```

**Always escape `$` as `\$`** in Markdown table cells — pandoc treats
`$...$` as inline LaTeX math and will misalign columns:

```sh
sed -i '' 's/\$/\\$/g' mydoc.md      # macOS / FreeBSD
```

**For wide tables** (6+ columns), use landscape + small font:

```sh
mkpdf SRC=mydoc.md ORIENTATION=landscape FONT_SIZE=7pt
```
