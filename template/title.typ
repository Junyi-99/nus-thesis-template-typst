#let title_page(
    title: "Thesis Title",
    author: none,
    qualification: none,
    degree: none,
    department: none,
    date: none,
    supervisors: (),
    examiners: ()
) = {
    set par(first-line-indent: 0em, justify: false, leading: 1.65em) // 不对齐，double-spaced line spacing
    
    align(center, [
        #upper(text(weight: "bold", title)) \
        #v(1.5in)
        #upper(text(weight: "bold", author)) \
        (#text(style: "italic", qualification)) \
    ])
    
    v(1.5in)
    
    align(center, text(weight: "bold", [
        A THESIS SUBMITTED \
        FOR THE DEGREE OF #upper(degree) \
        #upper(department) \
        NATIONAL UNIVERSITY OF SINGAPORE \
        #v(0.5in)
        #date.display("[year]")
    ]))
    
    v(0.5in)

    set par(leading: 0.5em) // single-spaced line spacing
    align(center, text(weight: "regular", [

        #if supervisors.len() <= 1 [
            Supervisor: \
        ] else [
            Supervisors: \
        ]
        #for sup in supervisors [
            #sup \
        ]
        
        #v(0.5em)

        #if examiners.len() <= 1 [
            Examiner: \
        ] else [
            Examiners: \
        ]
        #for exa in examiners [
            #exa \
        ]
    ]))

}