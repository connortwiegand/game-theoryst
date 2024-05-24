// "Colored Underline": Underline numbers in game table
  //Underlines value in table with colored line (`col`)
  //The number itself remains black by default (`tcol`), but is boldfaced
/*
ToDo: check that `cont` is math, possibly increase functionality to text for convenience sake
  - Normal text could just be underlined with `#underline()`
*/
#let cul(cont, col, tcol: black) = {
  set text(fill: col)
  math.bold(math.underline(text(fill: tcol, cont)))
}

// Utilities for red/blue underlining, corresponding to default player name colors
  // "Horizontal Underline" + "Vertical Underline"
#let hul(cont, col: red) = { cul(cont, col) }
#let vul(cont, col: blue) = { cul(cont, col) }