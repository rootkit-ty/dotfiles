#!/usr/local/bin/fish

if test -e /tmp/org-clocked-out
	emacsclient -ne '(org-clock-in-last)'
	rm -rf /tmp/org-clocked-out
end
