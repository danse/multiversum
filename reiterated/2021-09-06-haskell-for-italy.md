----
title: haskell for italy
style: clear
----

## $ git push italia HEAD

### an unique challenge

this gave me the opportunity to explore our limits, and push my profession beyond my comfort zone

. . .

haskell didn't let me down

. . .

- `jgm/pandoc` a rather powerful tool with a global community of users
- `italia/docs-italia-comandi-conversione` an interface for Italy
- `italia/docs-italia-pandoc-filters` details, or a framework for Italy

::: notes

it's rather succinct work. it aims at design transparency by being immediate and sometimes intentionally raw, like in the documentation of the commands which are also notes for the next developer. this style enables easy sharing which could produce more noise than signal and a good way to find out is to ask new users. the documentation corpus has also been flux, and it's now quickly crystallising for a development break

:::

### innovation from working software

the journey started by simply _hammering pandoc here and there to fix this and this_

. . .

as a small half-remote team we where all busy on multiple fronts so i learned to browse a broad scope through my specific expertise

. . .

i found out how starting from a successful piece of software can be more impactful than greenfield projects

### connecting seas

innovation rooted on the existing is like connecting seas, turbulences feel chaotic and dangerous

. . .

keeping an engineering and creative focus while shifting perspectives in the public eye

----

![a rational animal](../images/pandoctopus.svg)

### factoring conversion logic

::: incremental

- format templates
- conversion cases
- syntax errors
- sphinx features
- semantic definitions
- existing issues

:::

### software as an object in an highly dimensional space

code grows towards many goals, expanding on multiple dimensions is avoided in agile, where the priority direction shifts over time

in a context of political uncertainty, the problem has not been to self-organise, but to manage and communicate a value whose definition changes over time

### do you want spanning cells?

- user call close to the beginning of the project
- huge issue involving the hearth of pandoc
- seeding investment in analysis and communication
- rare other occurrences

### how do we engineer software?

- like a plant, perfectly integrated in a rather stable environment
- like a packet, cyclically delivered at the user's devices
- like a ship, whose use depends higly on the pilots and the territory
- like a virus, whose success is defined by replication

## a journey with code

### evolutionary prototyping a ship

i leaned on haskell's quality for refactorings and it enabled me to react swiftly and focus on the domain more than on the structure

prototyping makes little assumptions about what can we do, relying on user testing in order to collect proofs of concept. for many users a process of evolutionary prototyping is a new experience, and in a public context we want to manage expectations carefully

::: notes

one area where the technology fell short has been deployment, where top-down design reacted faster

:::

### integral features

a piece of software can move through different balance points in the space of its integral features

every dimension implies opportunities and tradeoffs

through the dimensions we can express tensions as actionable questions

### reliability and usability

our main `converti` command was

- a bash script
- a turtle script

it's a case where a development direction has been deepened

know your turtle modules

### a doctest packed with its function

```
-- | testable logic core for breakSections
-- >>> breakIntro testDemo "brh h rhb brhb"
-- ("b",["rh ","h ","rhb b","rhb"])
-- >>> breakIntro (const []) "bbrhb bla bla"
-- ("bbrhb bla bla",[])
-- >>> breakIntro testDemo "bh h hb bhb"
-- ("b",["h ","h ","hb b","hb"])
breakIntro :: Eq a => ([a] -> [a]) -> [a] -> ([a], [[a]])
breakIntro c l
  | null (c h) = (h, t)
  | otherwise  = ([], multiBroken)
  where multiBroken = multiPrefixBreak c [] l
        h = head multiBroken
        t = tail multiBroken
```

### a chart for the path

![specification](../images/specification.svg)

## other process dimensions

### opportunistic complexity

::: notes

code complexity that is not easily explained by current user expectations

:::

rise fragmentation

. . .

fall simplification

. . .

seeding and pruning

::: nonincremental

- new ideas and weight adjustments affect software paths like in a neural network
- notes can become comments or documentation
- creativity peak in june, [filter in italian](https://github.com/italia/docs-italia-pandoc-filters/blob/master/filters/filtro-acronimi.hs#L15-L19)
- opportunistic seeding and pruning

:::

::: notes

diversità per la ricerca
conformità per la comunicazione

:::

### expose and codify

. . .

our clarity of action is in a dialogue with the simplicity of our code

## domain dimensions

### working with semantics

- portability and expressivity
- content and presentation layers

which tools can we own to collaborate on content?

which tools can we own to collaborate on style?

### empowering and simplifying

what is devops?

. . .

```
rst2all.sh
 pandoc esempio.rst -o esempio.html
 pandoc esempio.rst -o esempio.md
 pandoc esempio.rst -o esempio.odt
 pandoc esempio.rst -o esempio.docx
```

. . .

a seamless development experience

one starts spotting regularities, factoring resources. in an interpreter, repeting is not an ergonomical problem

the prototypes grown from operating in repos supported both cases through the changes

### online or batch

with haskell i could work offline, for many users work in batches is uncommon, yet technology is not always up to our potential

## options for whole communities

### communities define themselves and communicate also through the source code

an example is defining the level of segregation, do we want to stay global?

- the main entry point's README was not in italian
- the pandoc manual
- quotes filter to merge

### codesign

for many of us it's natural to use the command line and markup languages

my ambition was adoption through sustained enthusiasm

besides our overall throughput, this depends on the way we communicate our work

faster horses

_costruire sensibilità futura_

----

![communities](../images/communities.svg)

### community and software development

software translators

we are not used to truly actionable sharing

in collaborative design the focus of the communication are not the existing artifacts

engage users (attivare gli utenti)

we don't know how the crowd is going to approach a piece of software
and its bottlenecks,
another reason why opening the decision process is worth its cost

the community is also being codesigned

### do you want a sphinx format?

- emerged as an option to consider
- seeding investment in analysis and communication
- [community call at the beginning of April](https://groups.google.com/forum/#!topic/pandoc-discuss/5W-l10MzeG8)
- user call four months later and close to project rollout

### users and communication events
 
some members become voices for whole communities

changing user rings defined by user welcomes have a development value and stake

ownership is fuzzy in the different sensitivities and it gets defined by such roles and by events

- i put it here in front of everyone

### humble accessible codesign

when a system is highly flexible, the context provides it a source of stability. i relied on users to support at the most practical level

low-volume public message channels are less expressive than other technologies but more accessible

they are our public communication infrastructure through which we can build effective collaboration

this is enabled by confidence of expression

## the laboratory

### discontrol

trello, github issues, slack messages, github notifications, twitter

- dive in and dive out guided by motivation
- concentration means keeping equal distance
- bringing back data models to us
- currently working on time tracking

### stress and quality

an amount of hours and a maximum date

## thanks

