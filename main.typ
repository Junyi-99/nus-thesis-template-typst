#import "template/template.typ":*
#let abstract = [
  This is your abstract
  #lorem(100)
  This is your abstract
]

#show: nus.with(
    title: "Singapore Chilli Crab: A Comprehensive Study",
    author: "Eugene H. Krabs",
    qualification: "BSc, NUS",
    degree: "Master of Cooking",
    department: "SCHOOL OF COOKING",
    date: datetime.today(),
    supervisors: (
        "Professor Squidward Tentacles",
        "Associate Professor Patrick Star"
    ),
    examiners: (
        "SpongeBob SquarePants",
    ),
    signature: "pics/signature.png",
    bibliography-file: "bibliography.bib",
    acknowledgement: none,
    abstract: abstract
)

#show "XXX" : text(red, weight: "black")[WHAT]

= Introduction <introduction>
#include "chapters/introduction.typ"
#pagebreak()

= Literature Review <literature_review>
#include "chapters/literature_review.typ"
#pagebreak()

= Objective <objective>
#include "chapters/objective.typ"
#pagebreak()

= Methodology <methodology>
#include "chapters/methodology.typ"
#pagebreak()

= Conclusion and Future work <conclusion_and_future_work>
#include "chapters/conclusions.typ"
#pagebreak()

= Appendix
#include "chapters/appendix.typ"
#pagebreak()
