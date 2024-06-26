# Game-Theoryst

A package for typesetting games in Typst. 

Work in progress. 

## Overview

The main function to make strategic form games is `sgamex` (from Martin J. Osbourne's Latex package of the same name). For a basic 2x2 game, you can do 
```typ
#sgamex(
  names: ("Jack", "Diane"),
  strats1: ($C$, $D$)
  strats2: ($C$, $D$),
  [$10, 10$], [$2, 20$], 
  [$20, 2$], [$5, 5$],
)
```

### Underlining
The default functions for underlining, `hul()` and `vul()`, can be wrapped around math-wrapped (`$..$`) values in the payoff matrix. The underlines are colored by default according to the default colors for names. 
```typ
#sgamex(
  names: ("Jack", "Diane"),
  strats2: ($x$, $y$, $z$),
  strats1: ($a$, $b$),
  [$hul(0),vul(0)$], [$1,1$], [$2,2$],
  [$3,3$], [$4,4$], [$5,5$],
)
```
By default, these commands leave the numbers themselves black, but boldfaces them. The color of the number can be changed via the general `cul()` command, which takes in content, an underline color (`col`), and the color for the value (`tcol()`). For instance, 
```typ
#let new-ul(cont, col: olive, tcol: fuchsia) = { cul(cont, col, tcol) }
```
will define a new command which underlines in olive and sets the text (math) color to fuchsia. 

### Cell Customization
Since the payoffs are implemented as argument sinks (`..args`) which are passed directly to Typst's `#table()`, underlining of non-math can be accomplished via the standard `#underline()` command. Similarly, any of the payoff cells can be customized by using `table.cell()` directly. For instance, `table.cell(fill: yellow.lighten(30%), [$1, 1$])` can be used to highlight a specific cell. 

#### Padding
There are edge cases where the default padding may be off. This can be mended by passing the named `inset` argument to `sgamex`. `inset` either needs to be a single `length` or a `dictionary` with `x`/`y` keys. This should represent how much _additional_ padding you want.  

### Iterated Deletion (Elimination) of Dominated Strategies
You can use the `pinit` package to cross out lines. I typically have to tweak the `dx`/`dy` parameters by hand:

```typ
#sgamex(
    names: ("A", "B"),
    strats1: ([$N$] , [$S$] + pin("30"), [$E$] + pin("40"), [$W$] + pin("00")),
    strats2: ([$W$] + pin("10"), [$E$] + pin("50"), [$F$] + pin("60"), [$A$]),
    [$6, 4$], [$7, 3$], [$5, 5$], [$6, 6$],
    [$7, 3$], [$2, 7$], [$4, 6$], [$5, 5$] + pin("31"),
    [$8, 2$], [$6, 4$], [$3, 7$], [$2, 8$] + pin("41"),
    [$3, 7$] + pin("11"), [$5, 5$] + pin("51"), [$4, 6$] + pin("61"), [$5, 5$] + pin("01"),
  )

#pinit-line(
  stroke: 1.5pt + maroon, 
  start-dy: -3pt,
  end-dy: -3pt,
  start-dx: 2pt,
  end-dx: 7pt,
  "00","01")

  #pinit-line(
  stroke: 1.5pt + maroon, 
  start-dy: 2pt,
  end-dy: 3pt,
  start-dx: -5pt,
  end-dx: -8pt,
  "10","11")

  #pinit-line(
  stroke: 1.5pt + maroon, 
  start-dy: -3pt,
  end-dy: -3pt,
  start-dx: 2pt,
  end-dx: 5pt,
  "20","21")

  #pinit-line(
  stroke: 2pt + maroon, 
  start-dy: -2pt,
  end-dy: -2pt,
  start-dx: 5pt,
  end-dx: 5pt,
  "30","31")

  #pinit-line(
  stroke: 2pt + maroon, 
  start-dy: -2pt,
  end-dy: -2pt,
  start-dx: 5pt,
  end-dx: 5pt,
  "40","41")

  #pinit-line(
  stroke: 2pt + maroon, 
  start-dy: 4pt,
  end-dy: 5pt,
  start-dx: -2pt,
  end-dx: -6pt,
  "50","51")

  #pinit-line(
  stroke: 2pt + maroon, 
  start-dy: 4pt,
  end-dy: 5pt,
  start-dx: -5pt,
  end-dx: -9pt,
  "60","61")
```

### Importing
To be published soon.

~~Simply insert the following into your Typst code:~~ (not yet!)
```typ
#import "@preview/game-theoryst:0.1.0"
```

## License
game-theoryst
Copyright © 2024 Connor T. Wiegand

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http:www.gnu.org/licenses/>.
