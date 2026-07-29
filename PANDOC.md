Pandoc supports two kinds of values in `{...}`:

**1. Known language → syntax highlighting**

Pandoc has a built-in list of languages it highlights automatically:

```
```{.bash}
```{.python}
```{.c}
```{.cpp}
```{.javascript}
```{.haskell}
```{.yaml}
```{.json}
```{.sql}
```{.diff}
```{.makefile}
```{.perl}
```{.ruby}
```{.java}
```{.html}
```{.css}
```{.dockerfile}
```{.ini}
```{.nix}
```{.r}
```

Full list: `pandoc --list-highlight-languages`

---

**2. Unknown class → custom CSS hook**

Anything pandoc doesn't recognize as a language becomes a CSS class on the `<pre>` element — you define the styling yourself:

```
```{.diagram}     → pre.diagram   (what we just built)
```{.terminal}    → pre.terminal
```{.config}      → pre.config
```{.warning}     → pre.warning
```

---

**3. Multiple attributes**

You can combine class, id, and arbitrary attributes:

```
```{.python #my-id}
```{.bash .warning}          ← two classes
```{.python style="..."}     ← inline style override
```

---

**Practical additions to your CSS worth having:**

```css
/* terminal — dark background, green text */
pre.terminal, pre.terminal code {
  background: #1A202C;
  color: #68D391;
  padding: 2mm;
  border-radius: 2pt;
  border: none;
}

/* warning — yellow tint */
pre.warning, pre.warning code {
  background: #FFFFF0;
  border-left: 2pt solid #D69E2E;
  color: #1A202C;
  padding: 2mm;
}

/* config — subtle grey, no color syntax */
pre.config, pre.config code {
  background: #F7FAFC;
  color: #2D3748;
  border: 0.5pt solid #CBD5E0;
  padding: 2mm;
}
```

These are useful additions to your `layout.css` for technical documents like `roteiro.md`.

## ASCII diagrams (box-drawing art)

Fenced blocks tagged with the `diagram` class render with zero leading, so
box-drawing glyphs (`─ │ ┌ ┐ └ ┘ ┬ ▼ ►`) connect vertically instead of
appearing dashed:

```{.diagram}
    ┌──────┐    ┌───────┐
    │ left │───►│ right │
    └──┬───┘    └───────┘
       ▼
```

The tag is inert on GitHub (plain code block) and in plaintext, so one
source works for repo, PDF, and mailing-list use. Regular fenced blocks
keep `line-height: 1.4` for readable config listings. All code blocks
avoid page splits (`page-break-inside: avoid`); a block taller than one
page will still split — break it in the source instead.

Font note: box-drawing alignment depends on a mono font with full
coverage — the stack is Menlo (macOS) → DejaVu Sans Mono (Linux) →
Courier New. Verify with `fc-match Menlo` if columns shear.
