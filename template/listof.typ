#import "utils.typ": chapter
#let list_of_contents() = {
    set page(numbering: "i")
    outline(
        title: "Contents",
        fill: repeat[.],
        indent: 1cm
    )
}

#let list_of_tables() = {
    set page(numbering: "i")
    show outline: set heading(outlined: true, supplement: [List of])
    outline(
        title: "List of Tables / Codes",
        fill: repeat[.],
        target: figure.where(kind: table).or(figure.where(kind: "code"))
    )
}

#let list_of_figures() = {
    set page(numbering: "i")
    show outline: set heading(outlined: true, supplement: [List of])
    outline(
        title: "List of Figures",
        fill: repeat[.],
        target: figure.where(kind: image),
    )
}

// #let list_of_illustrations() = {
//     outline(
//         title: "List of Illustrations",
//         fill: repeat[.],
//         indent: 1cm
//     )
// }

// #let list_of_symbols() = {
//     outline(
//         title: "List of Symbols",
//         fill: repeat[.],
//         indent: 1cm
//     )
// }