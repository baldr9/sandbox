# Useful grep commands

## Search code

* `find . -name "*" -print0 | xargs -0 grep -ni "TXT_TO_SEARCH" 2> /dev/null`

