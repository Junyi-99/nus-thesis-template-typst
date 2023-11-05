#import "utils.typ": page_title

#let declaration_page(
    author: none,
    date: none,
    signature: "pics/signature.png",
) = {
    set par(first-line-indent: 0em, justify: false) // 不对齐
    page_title("Declaration")

    align(center, [
        I hereby declare that this thesis is my original work and it has been written by me in its entirety. I have duly acknowledged all the sources of information which have been used in the thesis.
        
        #v(2em)
        This thesis has also not been submitted for any degree in any university previously.
        
        #v(1.2in)
        #image("../" + signature, width: 15em)
        #line(length: 15em, stroke: 0.5pt)
        
        #author
        #v(0.5em)
        #date.display("[day] [month repr:long] [year]")
    ])
}