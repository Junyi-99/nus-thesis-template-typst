#import "declaration.typ": declaration_page
#import "title.typ" : title_page
#import "listof.typ" : list_of_tables, list_of_figures, list_of_contents
#import "acknowledgments.typ" : acknowledgments_page
#import "abstract.typ" : abstract_page
#import "utils.typ": num_to_rome, to-string, dots


#let nus(
    title: "NUS",
    author:"Junyi",
    qualification: "B.S., NUS",
    degree: "Master of Computing",
    department : "Cooking Rice",
    date: none,
    bibliography-file: none, // path of the bib file
    supervisors: (),
    examiners: (),
    signature: "path of *.png",
    acknowledgement : none,
    abstract: none,
    body
) = {
    set document(
        title: title,
        author: author
    )

    set page(
        paper: "a4", // NUS required page size
        margin: (
            left: 1.5in,
            right: 1.5in,
            top: 1.5in, // The top and bottom margins should not be less than 1 inch each
            bottom: 1.5in
        ),
    )

    show figure : it => [
        #set par(leading: 0.5em) // single spaced
        #align(center, [
            #it.body
            #it.caption
        ]) 
    ]

    show footnote.entry : set par(leading: 0.5em) // single spaced for footnote
       

    set text(font: "Times New Roman", size: 12pt) // The font size for the main text should be 11 to 12 points. The same font type and size should be used for the entire thesis.
    // The following fonts are acceptable: Times New Roman and Helvetica.
    // The text should be double-spaced
    // The page numbers must appear at the bottom center of the page.
    

    set page(numbering: none)

    // 1 级作为 Chapter
    set heading(
        level: 1,
        numbering: "1.1",
        supplement: [Chapter],
        
    )
    
    show heading.where(level: 1) : it => block(
        width: 100%, 
        stroke: none,
        [
            #v(1in)
            #set text(28pt, weight: "bold")
            #set align(left)
            #if it.numbering != none [
                #block(stroke: none, spacing: 0em, [Chapter #counter(heading).display()])
            ]
            #v(1em)
            #block(stroke: none, spacing: 0em, it.body)
            #v(0.5in)
        ]
    )

    set par(leading: 1.0em, justify: true, first-line-indent: 1em) // 1.65em: double-spaced line spacing
    title_page(
        title: title,
        qualification: qualification,
        author: author,
        degree: degree,
        department:department,
        date: date,
        supervisors: supervisors,
        examiners: examiners
    )
    pagebreak()

    declaration_page(
        author: author,
        date: date,
        signature: signature
    )
    pagebreak()
    // title 和 declaration 不要有页码

   
    if acknowledgement != none {
      set page(numbering: "i")
      counter(page).update(1)
      acknowledgments_page(acknowledgement)
      pagebreak()
    }

    // set page(header: locate(loc => {
    //     let elems = query(
    //         heading.where(level:1, supplement: [Chapter], outlined:true).before(loc),
    //         // selector(heading).before(loc),
    //         loc,
    //     )

    //     if elems == () {
    //         [EMPTY!!]
    //     } else {
    //         h(1fr) + "[" + elems.last().body + "]"
    //         [#loc.]
    //         // let body = elems.last().body
    //         // h(1fr) + upper(body)
    //     }
    // }))
    let ht-first = state("page-first-section", [])
    let ht-last = state("page-last-section", [])


    // Page Header
    set page(
        header: locate(
            loc => [
                // find first heading of level 1 on current page
                #let first-heading = query(
                    heading.where(level: 1, supplement: [Chapter], outlined:true), loc).find(h => h.location().page() == loc.page())
                // find last heading of level 1 on current page
                #let last-heading = query(
                    heading.where(level: 1, supplement: [Chapter], outlined:true), loc).rev().find(h => h.location().page() == loc.page())
                // test if the find function returned none (i.e. no headings on this page)
                #{
                    if not first-heading == none {
                        ht-first.update([
                            // change style here if update needed section per section
                            #h(1fr) #upper(first-heading.body)
                        ])
                        ht-last.update([
                           #h(1fr) #upper(last-heading.body)
                        ])
                    // if one or more headings on the page, use first heading
                    // change style here if update needed page per page
                    [#ht-first.display()]
                } else {
                    // no headings on the page, use last heading from variable
                    // change style here if update needed page per page
                    [#ht-last.display()]
                }}
            ]
        )
    )
    
    // TOC 里面 一些关于 Section 的设置
    show outline.entry.where(level: 1): it => {
        let heading_page = counter(page).at(it.element.location()).first()
        let page_numbering = it.element.location().page-numbering()
        let body = to-string(it.body)
        let list_of = lower(body).contains(":")
        
        if list_of {
          let ab = body.split(":")
          let a = strong(ab.at(0)) + ":"
          let b = ab.at(1)
          [
            #a #b #dots(1fr)
            #strong([
               #if page_numbering == "i" { num_to_rome(heading_page) 
               } else { heading_page }
            ])
          ]
        } else {
          strong([
            #it.body #dots(1fr)
            #if page_numbering == "i" { num_to_rome(heading_page) 
            } else { heading_page }
          ])
        }
        
    }
    // show outline.entry.where(body: "Abstract"): it=>{
    //     strong(it.body) // 不知道为什么不生效
    // }
    
    
    list_of_contents()
    pagebreak()

    set page(numbering: "i")
    abstract_page(abstract)
    pagebreak()
    
    list_of_tables()
    pagebreak()
    list_of_figures()
    pagebreak()
    // list_of_illustrations()
    // pagebreak()
    // list_of_symbols()
    // pagebreak()

    set page(numbering: "1")
    counter(page).update(1)

    
    body

    // Display bibliography.
    if bibliography-file != none {
        show bibliography: set text(8pt)
        bibliography("../" + bibliography-file, title: "Bibliography", style: "ieee")
    }
}

// TODO: Captions for Figures/Tables: should be single-spaced

// • List of Figures/Tables: should be single-spaced and double-spaced between entries

// • Footnotes: should be single-spaced