---
name: format-for-slack
description: Convert markdown-formatted text to Slack-compatible mrkdwn (bold, italics, code fences, blockquotes, links, lists, tables)
---

# Format for Slack

Slack does not render standard Markdown. It uses "mrkdwn", a different syntax. This skill converts a markdown-formatted message into Slack mrkdwn.

Trigger: user says something like "format this for Slack" or "output this for Slack" about a message already composed or edited in the conversation.

## Conversion rules

Apply every rule that matches content in the source.

### Emphasis

| Markdown                                 | Slack mrkdwn       |
| ---------------------------------------- | ------------------ |
| `**bold**`                               | `*bold*`           |
| `__italic__`                             | `_italic_`         |
| `*italic*` / `_italic_` (already single) | `_italic_`         |
| `~~strikethrough~~`                      | `~strikethrough~`  |

Never leave `**` or `__` in the output. Bold is always single asterisks; italics is always single underscores.

### Headings

Slack has no heading syntax. Strip leading `#` characters, then render the heading text in bold (`*text*`) on its own line, followed by a blank line.

### Links

Slack renders standard markdown link syntax `[text](url)` directly; leave it unchanged. Do not convert to the legacy mrkdwn `<url|text>` form. Bare URLs need no change either.

### Code

- Inline code stays as single backticks: `` `code` ``.
- Fenced code blocks: Slack does not support language identifiers after the opening triple backticks. Strip them, e.g. converting ` ```python ` to ` ``` `.

### Blockquotes

Slack renders a blockquote line by line. Every line of the quote, including blank lines, must start with `> `. A blank line inside a blockquote must be rendered as `> ` (the marker with a trailing space, no other content); never leave a bare empty line inside a quoted block, or the quote breaks.

### Lists

Keep bullet and number characters as literal text; Slack does not auto-render or renumber ordered lists, so preserve existing numbers as-is. Convert `+` bullet markers to `-`, since Slack does not treat `+` as a list marker.

### Horizontal rules

Remove `---`, `***`, or `___` rule lines entirely; Slack has no equivalent.

### Tables

Slack has no table syntax. Convert each row to a bullet line with `label: value` pairs per cell. For simple tables, an aligned plain-text table inside a code fence (no language identifier) is an acceptable alternative; use judgment based on table complexity.

## Process

1. Identify the message text the user wants formatted (most recently composed or edited message unless the user points to something else).
2. Apply every rule above that matches content present in the source.
3. Return the converted text wrapped in a fenced code block (triple backticks, no language tag) so it renders as a single copyable block in the terminal viewport. This fence is a display convenience only, not part of the Slack message; the user copies only the content between the fences and pastes that into Slack. If the message itself contains a triple-backtick code fence, wrap the whole output in four backticks instead so the nested fence does not terminate the outer one early.
4. For any construct not covered above, prefer the simplest plain-text rendering over inventing new syntax; Slack displays unrecognized markup as literal characters.

## Checklist before returning output

- No `#` headings remain.
- No `**` or `__` remain.
- No language identifiers on code fences that were already present in the source content.
- Every line inside a blockquote, including blank lines, is prefixed with `> `.
- Markdown link syntax `[text](url)` is left unchanged.
- The final output to the user is wrapped in its own triple-backtick fence for easy copying.
