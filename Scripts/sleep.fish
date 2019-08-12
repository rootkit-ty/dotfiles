#!/usr/local/bin/fish


set -l clocked (emacsclient -ne '(org-clock-out)' ^ /dev/null)
[ $clocked = 'nil' ]; and touch /tmp/org-clocked-out
