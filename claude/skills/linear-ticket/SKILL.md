---
name: linear-ticket
description: Keep a Linear ticket in step with my coding work. Use when starting work on a feature, bug fix or change, when a PR is raised for it, or when asked which ticket the work belongs to.
---

Every piece of code work I do has one Linear ticket in the **Product** team (key `PRO`), assigned to me, in the current cycle, whose status moves as the work moves. Use the Linear MCP tools (`mcp__linear__*`).

Skip this for work that changes no code: answering questions, reviewing someone else's PR, exploring.

## 1. Find the ticket

A duplicate ticket is worse than asking me, so a new ticket is the last resort. Run these in order and stop at the first hit. A ticket id from any team counts (`PRO-`, `FRO-`, `MAC-`, ...): use the ticket the work already has rather than adding a Product one beside it.

1. **This session.** If the skill already ran in this conversation, reuse that ticket id.
2. **This branch.** `git config --get branch.$(git branch --show-current).linearTicket`. Step 2 writes it, so a branch I came back to in a new session still knows its ticket.
3. **Ids in plain sight.** A ticket id in what I said, the branch name, the commit messages since the base branch, or the open PR's title or body (`gh pr view --json title,body`).
4. **My open tickets.** `list_issues` with `assignee: "me"`, once with `state: "started"` and once with `state: "unstarted"`, `limit: 100`. Read every title. The list is short, and reading it is more reliable than search.
5. **Recent creations.** `list_issues` with `creator: "me"`, `createdAt: "-P14D"`. This catches a ticket an earlier session created under different wording.
6. **Search.** Run `list_issues` with no team filter, once with `assignee: "me"` and once with `team: "PRO"` and no assignee, each with `query:` set to two or three key words from the work. Then repeat with a second phrasing (a synonym, or the component or route name). The search is fuzzy: "accessible" missed a ticket titled "...screen reader accessible" that "screen reader" found first. Include every state except `Canceled` and `Duplicate`.

Judge each result by whether its title or description describes the same change, not by shared words alone. Then:

- **Exactly one match** that is open: use it.
- **A match that is `Done`**: ask me whether this is a follow-up (new ticket, `relatedTo` the old one) or a reopen.
- **Several plausible matches, or one you are unsure of**: list them with id, title and status, and ask me which. Create nothing until I answer.
- **Nothing plausible after all six checks**: go to step 2.

Done when you hold one ticket id, or have run all six checks and found nothing.

## 2. Create it when missing

1. `list_cycles` for the Product team (`ff331647-d720-4197-bab3-130c56e56e65`) with `type: "current"` to get the cycle number. The cycle rolls weekly, so look it up every time.
2. `save_issue` with `team: "PRO"`, `assignee: "me"`, `cycle: <number>`, `state: "Todo"`, a title naming the user-visible change, and a two or three sentence description: the problem and the intended change.
3. Record it on the branch: `git config branch.$(git branch --show-current).linearTicket PRO-<n>`. This is local git config, so it never reaches the remote.

Done when the ticket exists and the branch records it. Tell me its id and URL in one line.

When step 1 found an existing ticket, record it on the branch the same way (step 2.3), so the next session hits check 2.

## 3. Move the status with the work

| Moment                                            | Status        |
| ------------------------------------------------- | ------------- |
| Ticket just created, nothing written yet          | `Todo`        |
| First code edit for this work                     | `In Progress` |
| PR raised (`gh pr create` succeeded)              | `In Review`   |

Statuses only move forward along that table. A ticket already `In Review` stays there while I address review comments. `Done` comes from the PR merging through Linear's GitHub integration, so leave it to that.

When the PR is raised:

- Put the ticket id in the PR template's "Closes Issue" field (`Closes PRO-<n>`), so the PR and ticket link.
- `save_issue` with `links: [{url: <PR url>, title: "PR #<n>"}]` alongside the status change.

Each status change is one `save_issue` call with the ticket `id` and `state`. A ticket in another team uses that team's matching status name, so check it with `list_issue_statuses` first. Mention each change in one line ("PRO-123 → In Progress").
