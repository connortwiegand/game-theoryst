#import table: cell

// Utility to insert blank cells
#let blank_cells = {
  cell(colspan: 2, [])
}

// Helper function to format player 1's name
  // Default color is red
  // Default rspn (`row-span`) is for a 3x3 game
#let p1(name, col: red, rspn: 3) = {
  cell(
    rowspan: rspn, 
    text(
      fill: col, 
      weight: "semibold",
      name
    )
  )
}

// Helper function to format player 1's name
  // Default color is blue
  // Default cspn (`column-span`) is for a 3x3 game
#let p2(name, col: blue, cspn: 3) = {
  table.header(
    blank_cells, 
    cell(
      colspan: cspn, 
      text(
        fill: col, 
        weight: "semibold", 
        name
      )
    )
  )
}

// "Stroke-if": utility to stroke only the payoff matrix, not the player or strategy cells
#let strf(x,y) = {
  if x < 2 or y < 2 {
      none
  } else {
      1pt + black
  }
}

// "Align-if": Utility to set alignment for players and strategies
#let alif(x,y) = {
  if x == 0 and y >= 2 { //p1
      horizon + left
  } else if y == 0 and x >= 2 { //p2
      center + top
  } else if x == 1 and y >= 2 { //S1
      right + horizon
  } else if y == 1 and x >= 2 { // S2
      bottom + center
  } else { //payoffs, blank cells
      center + horizon
  }
}

// Main function to make strategic-form games
  //..args is meant to be for payoffs only, with one exception (see below) (this may change)
    
/*
"inset" can be optionally supplied, either as a dictionary or as a length. 
  - Pads cells with additional space, helpful for underlines

Note: This function requires context in order to equalize cell lengths. It's possible that the scope of the context could be reduced through refactoring
*/

#let sgamex(
  names: ("A", "B"),
  strats1: ($x$, $y$),
  strats2: ($a$, $b$),
  ..args
) = context {
    let nrow = strats1.len()
    let ncol = strats2.len()
    let cpad = {
      if ("inset" in args.named().keys()) {
        args.named().at("inset")
      } else {
        none
      }
    }
    
    // Equalize Cell Widths
    let intLengths = (0,)
    let ptLenths = (0pt,)
    for i in range(0, args.pos().len()) {
      let wpt = measure(args.pos().at(i)).width
      let wint = wpt.pt()
      intLengths.push(calc.round(wint, digits: 2))
      ptLenths.push(wpt)
    }
    let which = intLengths.position(x => {
      x == calc.max(..intLengths)
    })
    let cw = ptLenths.at(which) + 10pt
    
    let cw = cw + {
      if type(cpad) == "dictionary" and "x" in cpad.keys() {
        cpad.at("x")
      } else if type(cpad) == "length" {
        cpad
      } else {0pt}
    }
      
    set table(inset: 5pt + cpad) if type(cpad) == "length"  
    set table(inset: if "y" in cpad.keys() {cpad.at("y") + 5pt} else {cpad}) if type(cpad) == "dictionary"
    
  
    table(
      stroke: (x,y) => {strf(x,y)},
      align: (x,y) => {alif(x,y)},
      rows: ((2.5% + 0.25em, auto), ((auto,) * nrow)).join(),
      columns: ((2.5% + (0.66em * names.at(0).len()), auto), ((cw,) * ncol)).join(),
      p2(names.at(1), cspn: ncol),
      blank_cells, ..range(0, strats2.len()).map(x => strats2.at(x)),
      p1(names.at(0), rspn: nrow),
      ..for i in range(0, nrow) {
        (strats1.at(i), ..range(0, ncol).map(j => args.pos().at(i * ncol + j)))
      }
    )
}
