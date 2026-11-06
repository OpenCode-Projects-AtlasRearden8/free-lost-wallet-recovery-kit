# STATUS

## What was built

**Free Lost Wallet Recovery Kit** — a calm, printable, local-first markdown + HTML kit for a lost or stolen wallet, published by Asdale Dynamics, LLC (Dylan Asdale). No affiliate links, no sign-ups, no data collection, no secrets.

Files:

- `README.md` — overview, how to use, related kits, Asdale Dynamics credit
- `LICENSE` — MIT, copyright line exactly `Copyright (c) 2026 Asdale Dynamics, LLC`
- `checklist.md` — ordered what-to-do list (first 30 min → first hour → day 1 → days 2–7 → week 2+), with a "panic script"
- `call-list.md` — call-order table for debit/credit/bureaus/DMV/insurance, blank number and confirmation-number slots, phone log
- `replacement-tracker.md` — replacement rows for every card/ID type + autopay/saved-card fix table + running totals
- `police-report-template.md` — one-paragraph report script, fill-in report/incident blanks, contents checklist, privacy guardrails (no SSN/account numbers)
- `fraud-note-template.md` — two dispute letters (card issuer; general-purpose), timing and follow-up tips
- `prevention-sheet.md` — post-recovery 30-minute sheet: slim wallet, home vault, phone-wallet/alerts, inventory table with explicit "never write" list
- `print/wallet-recovery-print.html` — all six parts in one styled, printable HTML page (page-break rules, checkbox glyphs, print button hidden in print media, footers crediting Asdale Dynamics, LLC)
- `STATUS.md` — this file
- `verify.sh` — one-command verification script (see "Verification results")

Deliberately distinct from the other kits: `free-emergency-binder-kit` covers household emergencies broadly; `data-broker-removal-walkthrough-guide` covers data-broker opt-outs. This kit is wallet-specific only and the README points readers to the others.

## How to run it

Nothing to run — it's a static kit.

- Read the markdown files in any viewer; start at `checklist.md`.
- Print: open `print/wallet-recovery-print.html` in any browser, click **Print this kit** (or Ctrl+P / Cmd+P). Works fully offline.

## Verification results

Run `bash verify.sh` in this folder. Checks:

1. All 10 core files present (`LICENSE`, `README.md`, `checklist.md`, `call-list.md`, `replacement-tracker.md`, `police-report-template.md`, `fraud-note-template.md`, `prevention-sheet.md`, `print/wallet-recovery-print.html`, `STATUS.md`) — **pass**
2. Every README file reference exists on disk — **pass**
3. LICENSE copyright line exactly matches `Copyright (c) 2026 Asdale Dynamics, LLC` — **pass**
4. Footer credits present in README and HTML footer — **pass**
5. HTML tag balance: no unbalanced `<table>`/`</table>`, all `<li>` closed (fixed one unclosed `<li>` and replaced a nonsense footer phrase during verification) — **pass**
6. Secret/personal-data pattern scan (private keys, `sk-` keys, AWS keys, email/phone/SSN patterns) — **pass**
7. External/affiliate link scan — **pass** (no URLs or `href` anywhere; company sites are given as plain names)
8. Placeholder scan: no filled-in SSN-looking values — **pass**

HTML was additionally checked with a tag-balance pass for `li`, `table`, `tr`, `th`, `td`, `div`, `header`, `footer`.

## Known gaps

- Adjacent kits (`free-emergency-binder-kit`, `data-broker-removal-walkthrough-guide`) are referenced by name but are separate repos — no cross-links beyond names, so nothing breaks here if they change.
- Phone numbers and bureau URLs are described by name/place (e.g., "Equifax → Credit Report Assistance") rather than hard-coded numbers — intentional, because numbers change and hard-coding risks staleness and wrong-numbers-to-scammers.
- The HTML is a hand-written single file, so edits must be made in both `.md` and `.html` to stay in sync; consider generating one from the other later.
- No automated browser/PDF rendering test (environment has no browser); print styles were verified by inspection of `@media print` / `@page` rules only.

_Copyright (c) 2026 Asdale Dynamics, LLC._
