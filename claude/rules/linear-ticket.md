# Linear ticket

When I start work that changes code, invoke the `linear-ticket` skill before the first edit, and again once the PR is raised. It finds or creates the Product team ticket and moves its status (Todo → In Progress → In Review).

## Issue tracker for `to-spec` and `to-tickets`

These skills ask for a tracker that `/setup-matt-pocock-skills` would configure. Skip that setup, since it writes into the repo. The tracker is Linear, Product team (`PRO`): new tickets go in the current cycle as `Todo`, use Linear's native blocking relations, and get no triage labels unless I ask for them.
