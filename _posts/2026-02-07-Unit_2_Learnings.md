---
layout: post
title: "Unit 2 Learnings"
subtitle: "Self-Reflective work on the activities covered in Unit 2 "
date: 2026-02-07
categories: [Module 4 Visualising Data]
---

Unit 2 began by deepening my understanding of data abstraction, particularly the concept of items and attributes. Items can be understood as individual objects, such as a person, and each item is described by attributes that define its characteristics, for example gender, height or weight. 
Attributes are broadly classified into qualitative (categorical) and quantitative types. Qualitative data can be nominal, such as gender or paint colour, where categories cannot be logically ordered, or ordinal, such as dress sizes or exam grades, where categories follow a meaningful order. 
Quantitative data is divided into interval and ratio types. Interval data, such as temperature measured in Celsius or Fahrenheit, has equal intervals between values but no true zero point. Ratio data has all the properties of interval data but includes an absolute zero, meaning that a value of 0.0 represents the absence of the variable, such as £0 indicating no money. Beyond items and attributes, datasets may also include link data, which defines relationships or edges between items, and positional data, which specifies where an item is located in space. 
Understanding these distinctions clarified that visualisation design begins with recognising what kind of data structure is being represented.

<img width="616" height="504" alt="image" src="https://github.com/user-attachments/assets/4233c105-f7eb-4309-9427-7542d06a22c0" />

Fig 1 Items and Attributes (University of Essex, no date)

Unit 2 focused on developing a systematic understanding of data visualisation through the framework of Munzner’s “What, Why, and How” model. 
This model provides a structured way of thinking about visualisation design by separating it into three core components: what data is being shown (data abstraction), why the viewer is engaging with it (task abstraction), and how the data is visually encoded (idiom and interaction design). 
Rather than viewing visualisation as simply producing charts, the unit emphasised that effective design requires clarity about the data structure, the user’s goal, and the representational choices that shape interpretation.

<img width="1518" height="916" alt="image" src="https://github.com/user-attachments/assets/45c88527-7e3b-4e42-b013-65319b16b1a9" />

Fig 2 Framework for Visualisation

The “What” component introduced different data and dataset types. 
Data can consist of items, attributes, links and positions, while attributes can be qualitative or quantitative, nominal, ordinal, interval or ratio.
Most real-world datasets are tabular, where rows represent items and columns represent attributes, but the same principles apply to network data and geospatial data. Understanding these distinctions is essential because the structure and type of data constrain which visual representations are appropriate. 
This section reinforced that visualisation design begins with data abstraction rather than graphical design.

The “Why” component explored task abstraction using action–target pairs. 
Users interact with data to compare trends, discover distributions, locate outliers, or browse structures such as networks or topologies. 
This concept shifted my perspective from “what chart should I use?” to “what task does the user need to accomplish?” It became clear that visualisations should be designed around user goals rather than aesthetic preference. 
A chart that is effective for discovering patterns may not be effective for precise comparison, and vice versa. This introduced a more analytical and user-centred mindset in approaching visual design.

The “How” component examined visual encoding through marks and channels. 
Marks are geometric primitives such as points, lines, areas and volumes, while channels control their appearance through position, size, colour, tilt, depth and other properties. 
The concept of channel ranking was particularly significant, as it demonstrates that not all visual encodings are equally effective. Position on a common scale is perceptually strongest, while volume and curvature are far less reliable. 
The discussion of perceptual accuracy showed how human perception responds differently to length, area, depth and colour saturation. For example, length has a linear relationship with perception, while area and brightness plateau, and saturation increases perception disproportionately. 
This highlighted that poor channel selection can distort interpretation even when the data itself is correct.

The unit also explored multidimensional data and layering of encodings. 
By combining spatial positioning, size and colour, complex datasets with several attributes can be communicated effectively. 
The drug screening example demonstrated how five dimensions could be encoded simultaneously through area, colour hue and spatial positioning. 
The exercise illustrated the power of visualisation as a communication tool: even without specialist biological knowledge, meaningful insights could be derived through well-designed encoding. 
This reinforced the idea that visualisation acts as a bridge between complex data and human cognition.

From a critical self-reflection perspective, Unit 2 was conceptually challenging. The distinction between marks and channels was initially difficult to grasp because I had never previously analysed visualisations at such a granular perceptual level. 
In earlier experiences, I focused mainly on producing charts using software tools without critically questioning why certain encodings were more effective than others. 
The idea that perceptual effectiveness can be ranked and that some channels distort magnitude perception required a shift in thinking from practical tool usage to theoretical understanding.

Understanding channel ranking and perceptual judgment was particularly demanding. 
It required not only memorising which channels are stronger but also understanding the cognitive reasons behind their effectiveness. The relationship between perception and visual variables such as saturation or area was not intuitive to me at first. 
However, working through examples helped clarify how design decisions directly influence accuracy and interpretation.

Overall, Unit 2 significantly deepened my conceptual understanding of visualisation design. 
It moved my thinking from creating charts to designing communication systems based on data type, user task and perceptual science. 
Although challenging, especially in understanding channels and perceptual accuracy, the unit strengthened my analytical approach and made me more critical of visualisation choices. 
I now recognise that effective visualisation is not only about technical skill but about understanding human perception, task design and structured reasoning.

References

University of Essex (no date) Representation of Items and Attributes [Online image]. Available at: https://www.my-course.co.uk/mod/scorm/view.php?id=1305716
 (Accessed: 15 February 2026).
