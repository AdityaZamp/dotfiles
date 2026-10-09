---
name: linear-ticket
description: Keep a Linear ticket in step with my coding work. Use when starting work on a feature, bug fix or change, when a PR is raised for it, or when asked which ticket the work belongs to.
---

Every piece of code work I do has one Linear ticket in the **Product** team (key `PRO`), assigned to me, in the current cycle, whose status moves as the work moves. Use the Linear MCP tools (`mcp__linear__*`).

Skip this for work that changes no code: answering questions, reviewing someone else's PR, exploring.

## 1. Find the ticket

Look in this order and stop at the first hit:

1. A `PRO-<n>` id in what I said, the current branch name, or the open PR's title or body.
2. `list_issues` with `team: "PRO"`, `assignee: "me"`, `query: <two or three key words from the work>`. A hit counts only when its title describes the same work.

If two or more candidates fit, ask me which one. Done when you hold exactly one ticket id, or know there is none.

## 2. Create it when missing

1. `list_cycles` for the Product team (`ff331647-d720-4197-bab3-130c56e56e65`) with `type: "current"` to get the cycle number. The cycle rolls weekly, so look it up every time.
2. `save_issue` with `team: "PRO"`, `assignee: "me"`, `cycle: <number>`, `state: "Todo"`, a title naming the user-visible change, and a two or three sentence description: the problem and the intended change.

Done when the ticket exists. Tell me its id and URL in one line.

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

Each status change is one `save_issue` call with `id: "PRO-<n>"` and `state`. Mention it in one line ("PRO-123 → In Progress").
