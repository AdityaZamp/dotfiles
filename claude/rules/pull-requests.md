# Pull requests

## Review before raising, always

Before any PR is raised, run the review for its repo and fix what it finds. This is not optional, however small the change looks.

- **application-platform-frontend**: `/pr-review`.
- **pantheon**: `/code-review`, then `/pr-cleanup`.

## Bug bash big frontend changes, your call

For a big or risky frontend change (a new flow, a reworked page, anything touching shared state, lists or streaming), also run `/bug-bash <scope>` before raising the PR, to break it, stress it under worst-case data, and measure it at scale against `release` (`/bug-bash <scope> stress only`). Skip it for small, contained changes. Say in one line whether you ran it and why.

## Greptile after raising

Once the PR is up, watch it with `/checks-watch <PR>` until CI is green and Greptile has no open threads. For each Greptile comment:

- **Genuine**: fix it, push, and reply saying what changed.
- **Not genuine**: don't change the code. Reply with the concrete reason and evidence, then resolve the thread.

After pushing fixes or pushback, re-tag Greptile with exactly `@greptileai re-review`.
