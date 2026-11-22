---
name: oc-review
description: Open a tuicr review of the current changes beside this opencode session in Rex, so the user can comment on lines and have the review queued back into this session. Use when the user asks to review, look over or comment on your changes, or says "let me review". Also covers acting on a review that arrives as "I reviewed your code and have the following comments".
---

# oc-review

`oc-review` (in `~/bin`) runs tuicr on the repository's changes. When the user exports with `ZZ` or `:wq`, it queues the review into an opencode session as a user message. `:q!` closes without sending.

## Open a review

In Rex (`$REX_SESSION` is set), split to the right of your own terminal and pass your session ID, because the new pane does not inherit your environment:

```sh
rex split -s "$REX_SESSION" -b "$REX_BLOCK" -c "$(git rev-parse --show-toplevel)" -- oc-review -s "$OPENCODE_SESSION_ID"
```

Arguments after the session go to tuicr. The default is `-w` (uncommitted changes). Other scopes: `-r main..@` (jj) or `-r main..HEAD` (git) for a branch, `-r <rev>` for one commit.

Outside Rex, tell the user to run `oc-review -s <your session ID>` in the repository.

Then stop and wait. The review arrives as a new message; do not poll for it.

## Act on a review

The message starts with "I reviewed your code and have the following comments". Each numbered item gives a file and line or range, often the quoted diff, and the comment. Make each requested change, answer each question, or say why one should not be acted on. Reply per item.

Do not add comments into the user's review with `tuicr review add` unless the user asks for that.
