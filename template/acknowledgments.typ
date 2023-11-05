#import "utils.typ": page_title

#let acknowledgments_page(
    content
) = {
    align(center, heading(outlined: true, level: 2, numbering: none)[Acknowledgments])
    v(2em)
    content
}