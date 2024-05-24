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
