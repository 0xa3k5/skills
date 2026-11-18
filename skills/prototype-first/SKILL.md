---
name: prototype-first
description: Show design options as prototypes and get a pick before building anything. Use for a new screen, a new flow, a redesign, a website or landing page, any "show me options" or "can you prototype" request, and any UX question with more than one reasonable answer. Also covers how to build from a picked prototype.
---

# Prototype first

I'm a designer. I judge work by looking at it and clicking through it, not by reading a plan. A prototype costs minutes. Building the wrong thing costs a stack of PRs and a day of review.

This skill does one thing: it gets a design pick from me before code gets written. It never opens a PR for a prototype, never ships a prototype as the product, and never builds a direction I haven't picked.

## Hard rules

1. **Never open a PR for a prototype, not even a draft.** PRs are for code meant to land on `main`. A prototype PR adds review and CI noise for something that will be thrown away.
2. **Stop after every round.** Send the variants in the format below, then wait for my reply. Don't start building "the most likely pick" while I look. If I pick something else, that work is waste and I have to review it anyway.
3. **The picked prototype is the spec.** The build has to look like it. Later feedback changes only what I named. I compare the build against the picture I picked, so any drift reads as a mistake, not as an improvement.
4. **Prototype labels stay in prototype files.** "B2", "direction A" and variant nicknames never appear in code, tokens, commits, PRs or issues. They only meant something during the pick. In the codebase they're noise that someone has to decode later.
5. **Look at references as images.** When I name reference sites or apps, look at screenshots of them. A text-only fetch loses every visual quality that made the reference good, and the result reads as generic.

## Should this be a prototype?

```
Does the change have one obvious answer (a spacing value, a label, a color token)?
├── Yes → Build it and say what changed. Skipping the prototype is a good result.
└── No
    ├── New screen, new flow, redesign, or 2+ reasonable answers?
    │   └── Yes → Prototype.
    │       ├── Needs real data, real navigation or native behavior?
    │       │   └── Yes → Throwaway branch `proto/<topic>` off main
    │       └── No → Standalone HTML file, shared in the chat or issue thread
    └── Unsure → Ask in one line: "prototype this or just build it?"
```

Never hide a prototype inside the product behind a `/lab` route or a dev flag.

## Workflow

### Phase 1: References and questions

1. Collect screenshots of every reference I named. Crop long pages into sections.
2. Write down concrete observations for each one: the type, the heading treatment, how the product is shown, how the layout is structured and the one moment that stands out. Say why each works.
3. Question the request. If what I asked for is weak UX, say so and say why. Think from the end user's side, not from the literal fix I described.
4. Ask me a few short, numbered questions about what you can't infer, such as type, density, tone and what to keep from the current version.

**Done when:** every reference has written observations, and I've answered your questions or you had none.

### Phase 2: Build the variants

- **Show 2 to 4 variants**, labeled A, B, C and D. One variant teaches you nothing about my taste. More than four is noise.
- **At least one variant is your own better idea** if you pushed back in Phase 1. Put it next to the one I asked for.
- **Mock in context.** Show the whole window or section, not a component floating on a blank page.
- **Use the real design.** Use the app's current tokens, type and components. Show light and dark if the app has both.
- **Use realistic data.** Real-looking names, numbers and text lengths. Never lorem ipsum, and never real people's or places' data.
- **Make flows clickable.** For anything with steps or states, build one HTML file with a scenario switcher, a light/dark toggle, working interactions and a plain-words note on what each state means.
- **Match the polish to the question.** For a visual direction, it looks like the finished product, because the look is what I'm judging. For a flow, it looks like the app and works, and edge polish can wait, because I'm judging whether I get lost.

**Done when:** every variant is mocked in context with real tokens and realistic data, and every flow is clickable.

### Phase 3: Send the round and stop

Send the round in the format under "Required output format". Then stop.

**Done when:** the round is sent. Nothing else happens until I reply.

### Phase 4: Read my pick

| I say | It means | You do |
| --- | --- | --- |
| "C" | Build C as shown | Go to Phase 5 |
| "D, but 1.5px not 3px" | D with exactly that change | Change only that, then Phase 5 |
| "A's buttons, C's search bar" | A mix | Take each named part from the variant I named it from. The part I say I like most dominates. Don't drift toward whichever variant was easier to build. |
| "I like B but I want to test it" | A provisional pick | Build B, and keep the runner-up until I've tried B in the real app or on the device |
| Feedback on one variant | Iterate | Show the next round of that variant only, back to Phase 3 |
| "I don't get this prototype" | Stop prototyping | Build the real thing in a PR |
| "none of these" | You missed my intent | Go back to the references and my words. Don't make a fourth version of the same idea. |

**Ask why when I don't say.** If I pick without giving a reason, ask one short question: "what made B win?" Record my answer with the decision. A pick without its reason teaches the next agent nothing about my taste.

**Done when:** you know which variant, or which mix of parts, to build, and why.

### Phase 5: Build from the pick

- Brief whoever builds it with the prototype link and the exact values: colors, sizes, spacing and type. Nobody rebuilds it from memory.
- Describe the design by what it is ("dense table, status pills, left rail"), never by its label.
- Apply later general feedback ("too busy", "no hierarchy") only where I pointed. It isn't permission to remove things I liked in the prototype. Before you drop or change a prototype element, name it and ask.
- Before opening the build PR, run the check below.

**Done when:** the build matches the pick, and the check passes.

## The check

Rules 1 and 4 are the ones agents broke most, so they're enforced by a script instead of a sentence:

```sh
scripts/check-prototype-labels.sh main "B2" "Sakin"
```

Pass the base branch and every label or nickname used during the rounds. The script exits non-zero if:

- the current branch is `proto/*`, because prototypes don't get PRs
- any line the branch adds mentions a label you passed
- any added line matches a generic label pattern such as "variant B" or "direction A2"

If it flags something, rename it to describe the design. Don't bypass the check.

## Required output format

Every round looks like this:

```md
**Where to see it:** <link or attachment>, or `git checkout proto/<topic> && <run command>`

| Variant | Betting on | Trade-off |
| --- | --- | --- |
| A | <one line: the idea this variant tests> | <what it gives up> |
| B | ... | ... |

**What I pushed back on:** <one or two lines, or "nothing">

Reply with a letter, a mix (`A's x, C's y`), or `none`.
```

Keep it to this. The prototype does the explaining.

## Invocation variants

| Invocation | Behavior |
| --- | --- |
| `/prototype-first` | Full workflow from Phase 1, stops after Phase 3 |
| `/prototype-first <variant>` | Iterate on one variant from the last round, back to Phase 3 |
| `/prototype-first compare` | One prototype with a NOW / PROPOSED toggle against the current UI |
| `/prototype-first check` | Run the label check on the current branch |
