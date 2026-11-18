---
name: prototype-first
description: Show design options as prototypes and get a pick before building anything. Use for a new screen, a new flow, a redesign, a website or landing page, any "show me options" or "can you prototype" request, and any UX question with more than one reasonable answer. Also covers how to build from a picked prototype.
---

# Prototype first

I'm a designer. I judge work by looking at it and clicking through it, not by reading a plan. A prototype costs minutes. Building the wrong thing costs a stack of PRs and a day of review. So I pick from prototypes first, and the build follows the pick.

## When to prototype

Prototype first for:

- a new screen, panel, sheet or page
- a new flow with more than one step or state
- a redesign or a new visual direction
- any change where you see two or more reasonable answers

Skip it when the change is a tweak to existing UI with one obvious answer, like a spacing value, a label or a color token. Build it and tell me what changed.

If you're unsure, ask in one line: "prototype this or just build it?"

## Before you sketch

1. **Look at the references visually.** When I name reference sites or apps, look at screenshots of them. Crop long pages into sections. A text-only fetch loses every visual quality that made the reference good, and the result reads as generic.
2. **Write down concrete observations.** Cover the type, the heading treatment, how the product is shown, how the layout is structured and the one moment that stands out. Say why each works.
3. **Interview me on the specifics** you can't infer, such as type, density, tone and what to keep from the current version. Ask a few short numbered questions, not a questionnaire.
4. **Question the request.** If what I asked for is weak UX, say so and say why. Then show a better idea next to the one I asked for. Think from the end user's side, not from the literal fix I described.

## Making the prototype

- **Show 2 to 4 variants** and label them A, B, C, D. One variant is never enough to learn my taste from, and more than four is noise.
- **Mock in context.** Show the whole window or section, not a component floating on a blank page. I need to see it next to what surrounds it.
- **Use the real design.** Use the app's current tokens, type and components so the prototype looks like the product, not a wireframe. Show light and dark if the app has both.
- **Use realistic data.** Use real-looking names, repos, numbers and lengths. Never use lorem ipsum, and never use real people's or places' data.
- **Make flows clickable.** For anything with steps or states, build one HTML file with a scenario switcher, a light/dark toggle, working interactions and a plain-words note on what each state means.
- **Match the polish to the question.**
  - For a visual direction, make it look like the finished product, because the look is what I'm judging.
  - For a flow, it has to look like the app and work, and edge polish can wait. I'm judging whether I get lost.

## Where prototypes live

- **Standalone HTML, shared in the chat or issue thread, is the default.** It's fast to change and nothing touches the codebase.
- **Use a throwaway branch** when the prototype needs the real app (real data, real navigation, native behavior). Name it `proto/<topic>`, branch it off `main` and tell me the branch name and the command to run it.
- **Never open a PR for a prototype**, not even a draft. PRs are for code meant to land on `main`. A prototype PR adds review and CI noise for something that will be thrown away.
- **Never hide a prototype in the product** behind a `/lab` route or a dev flag.

## Reading my pick

I pick fast and in shorthand. Each kind of reply means something different:

- **"C"** means build C as shown.
- **"D, but 1.5px not 3px"** means D with exactly that change, nothing else.
- **"A's buttons, C's search bar"** means a mix. Take each named part from the variant I named it from. If I say which part I like most, that part dominates. Don't drift toward whichever variant was easier to build.
- **"I like B but I want to test it"** means the pick is provisional. Keep the runner-up around until I've tried B in the real app or on the device.
- **"I don't get this prototype"** means stop prototyping and build the real thing in a PR.
- **"none of these"** means go back to the references and to my words. Don't make a fourth variation of the same idea.

When I give feedback on a variant, iterate on that variant and show the next round. After a direction is chosen, don't start prototyping again unless I ask.

## Building from the pick

- **The picked prototype is the spec.** The shipped UI has to look like it, including badge styles, table cells, header layout, spacing and type. I compare the build against the prototype I picked.
- **Apply later feedback only where I pointed.** General feedback like "too busy" or "no hierarchy" is not permission to remove things I liked in the prototype. Before you drop or change a prototype element, name it and ask.
- **Brief builders with the prototype.** Link it and give the exact values (colors, sizes, spacing, type) so nobody rebuilds it from memory.
- **Keep prototype labels out of the work.** "B2", "direction A" and variant nicknames stay inside prototype files. Code, token names, commits, PR titles and bodies, and issues describe the design by what it is ("dense table, status pills, left rail"), never by its label. Rename any label you find when you touch the file.

## Checklist before you send a round

- [ ] I looked at the references as images, not text.
- [ ] There are 2 to 4 labeled variants, mocked in context.
- [ ] They use the real tokens and realistic data, in light and dark.
- [ ] Any flow is clickable, with a scenario switcher.
- [ ] It's shared in chat or on a `proto/` branch, with no PR.
- [ ] Each variant has one or two lines saying what it's betting on.
