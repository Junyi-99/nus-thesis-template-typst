#let chapter(content, caption: "", level: 1) = {
        block(stroke: red, spacing: 0em)[
        #caption
    ]
}

#let subfigure(body, caption: "", numbering: "(a)") = {
  let figurecount = counter(figure) // Main figure counter
  let subfigurecount = counter("subfigure") // Counter linked to main counter with additional sublevel
  let subfigurecounterdisply = counter("subfigurecounter") // Counter with only the last level of the previous counter, to allow for nice formatting

  let number = locate(loc => {
    let fc = figurecount.at(loc)
    let sc = subfigurecount.at(loc)

    if fc == sc.slice(0,-1) {
      subfigurecount.update(
        fc + (sc.last()+1,)
      ) // if the first levels match the main figure count, update by 1
      subfigurecounterdisply.update((sc.last()+1,)) // Set the display counter correctly
    } else {
      subfigurecount.update( fc + (1,)) // if the first levels _don't_ match the main figure count, set to this and start at 1
      subfigurecounterdisply.update((1,)) // Set the display counter correctly
    }
    subfigurecounterdisply.display(numbering) // display the counter with the first figure level chopped off
  })
  
  body // put in the body
  v(-.65em) // remove some whitespace that appears (inelegant I think)
  if not caption == none {
    align(center)[#number #caption] // place the caption in below the content
  }
}

#let page_title(
    title
) = align(center)[
    #block(stroke: none, spacing: 0em)[
        #text(
            size: 16pt,
            weight: "bold",
            upper(title)
        )
    ] // 后面再跟一个block的话，就是紧挨着的
    #v(1in)
]

#let dots(w) = {
  box(width: w, h(3pt) + box(width: 1fr, repeat[.]) + h(3pt))
}

#let num_to_rome(number) = {
    let ones = ("","I","II","III","IV","V","VI","VII","VIII","IX")
    let tens = ("","X","XX","XXX","XL","L","LX","LXX","LXXX","XC")
    let hrns = ("","C","CC","CCC","CD","D","DC","DCC","DCCC","CM")
    let ths=("","M","MM","MMM")
    return ths.at(calc.floor(number/1000)) + hrns.at(calc.floor(calc.rem(number, 1000)/100)) + tens.at(calc.floor(calc.rem(number, 100)/10)) + ones.at(calc.floor(calc.rem(number, 10)))
}

#let to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join("")
  } else if content.has("body") {
    to-string(content.body)
  } else if content == [ ] {
    " "
  }
}