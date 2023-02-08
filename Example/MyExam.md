---
title: "Example Exam sheet"
printPoints: true       # print points in round brakets for each question
pointsTable:
    print: true         # Print the table with points at the end of the exam
    space: 1cm          # vertical space between the last question and the points table
answer: false           # set to true to show answers
special_version: false
spacial_fontSize: 17pt  # special version font size (8pt, 9pt, 10pt, 11pt, 12pt, 14pt, 17pt, and 20pt)
---

@q [10] This is the question with points.

:::parts
@p First part

@p Second part

:::nspecial

@p Third part @hf

@p and fourth part

:::

@p so on...
:::


@q [10] The name of the sea between Europe and Americas:

@hf

:::nspecial

@q [10] The name the seven little Whitesnow friends:

@hf [7]

:::

:::special
@q [10] The name of the large, green-skinned, physically intimidating ogre with a Scottish accent.

@hf [1]
:::

@q [10] Fill in the blanks with the correct word from the list:

*quick*, *fox*, *lazy*

The @tf[quick] brown @tf[fox,5] jumps over the @tf[,1] dog

@q[5] What color is Napoleon's white horse?

*One paragraph checboxes*

:::opcb
@c Yellow
@cc White

:::nspecial

@c Black
@c Brown
:::
:::

@q[5] What color is Napoleon's white horse?

*checkboxes*

:::cb
@c Yellow
@cc White

:::nspecial

@c Black
@c Brown
:::
:::

@q [5] Draw your favorite flower:
@eb[1]

@q [5] Draw your favorite animal:
@eb

