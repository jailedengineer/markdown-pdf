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
