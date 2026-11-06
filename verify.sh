#!/usr/bin/env bash
# Verification for the Free Lost Wallet Recovery Kit (Asdale Dynamics, LLC)
set -u
cd "$(dirname "$0")"

fail=0
pass() { echo "[pass] $1"; }
fail_or_pass() { if [ "$1" -eq 0 ]; then pass "$2"; else echo "[FAIL] $2"; fail=1; fi; }

echo "== 1. Core files present =="
for f in README.md LICENSE checklist.md call-list.md replacement-tracker.md \
         police-report-template.md fraud-note-template.md prevention-sheet.md \
         print/wallet-recovery-print.html STATUS.md; do
  if [ -f "$f" ]; then pass "exists: $f"; else echo "[FAIL] missing: $f"; fail=1; fi
done

echo "== 2. README references nothing missing =="
bad=0
for ref in checklist.md call-list.md replacement-tracker.md police-report-template.md \
           fraud-note-template.md prevention-sheet.md print/wallet-recovery-print.html STATUS.md LICENSE; do
  [ -f "$ref" ] || { bad=1; echo "  README references missing file: $ref"; }
done
fail_or_pass $bad "README file references all resolve"

echo "== 3. LICENSE copyright line exact =="
expected='Copyright (c) 2026 Asdale Dynamics, LLC'
if grep -qxF "$expected" LICENSE; then pass "exact copyright line found"
else echo "[FAIL] LICENSE missing exact line: $expected"; fail=1; fi

echo "== 4. Credits in README and HTML footer =="
grep -q "Asdale Dynamics, LLC" README.md && grep -q "Copyright (c) 2026 Asdale Dynamics, LLC" print/wallet-recovery-print.html \
  && pass "Asdale Dynamics credited in README and HTML footer" \
  || { echo "[FAIL] missing credit"; fail=1; }

echo "== 5. HTML tag balance =="
python3 - <<'EOF'
import sys, re
html = open("print/wallet-recovery-print.html", encoding="utf-8").read()
void_elements = {"meta", "br", "hr", "img", "input", "link"}
ok = True
for tag in ["html","head","body","div","header","footer","table","tr","th","td","li","ul","ol","p","style","button"]:
    if tag in void_elements: continue
    opens = len(re.findall(rf"<{tag}(\s[^>]*?)?/?>", html))
    closes = len(re.findall(rf"</{tag}>", html))
    if opens != closes:
        print(f"[FAIL] <{tag}>: {opens} open vs {closes} close")
        ok = False
for t in ["<html", "<body", "</html>", "</body>", "<!DOCTYPE html>", "<style", "</style>"]:
    if t.strip().startswith("<!DOCTYPE") or t.startswith("</"):
        if t not in html: print(f"[FAIL] missing {t}"); ok = False
    else:
        if t not in html: print(f"[FAIL] missing {t}"); ok = False
sys.exit(0 if ok else 1)
EOF
fail_or_pass $? "HTML tags balanced, structure present"

echo "== 6. No secrets / API keys / personal data patterns =="
bad=0
for pat in 'BEGIN.*PRIVATE KEY' 'sk-[A-Za-z0-9]' 'AKIA[0-9A-Z]{16}' '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.(com|org|net)' '[0-9]{3}-[0-9]{3}-[0-9]{4}' '\b[5-7][0-9]{9}\b'; do
  hits=$(grep -rniE "$pat" --include='*.md' --include='*.html' . | grep -v '^./STATUS.md' || true)
  [ -n "$hits" ] && { echo "  pattern hit: $pat"; echo "$hits"; bad=1; }
done
fail_or_pass $bad "no secret/key/personal-data patterns"

echo "== 7. Affiliate-link scan =="
if grep -rniE '(https?://[^ ]*)|\bhref=|tag=|ref=|&client=' --include='*.md' --include='*.html' . ; then
  echo "[FAIL] possible external/affiliate links found"; fail=1
else pass "no external or affiliate links"; fi

echo "== 8. Placeholder scan (no real-looking filled data) =="
if grep -rniE '\b(SSN|social security number):? [0-9]{3}-?[0-9]{2}-?[0-9]{4}\b' --include='*.md' --include='*.html' . ; then
  echo "[FAIL] SSN-looking value found"; fail=1
else pass "no filled-in SSN values"; fi

echo
if [ "$fail" -eq 0 ]; then echo "ALL CHECKS PASSED"; else echo "CHECKS FAILED"; exit 1; fi
