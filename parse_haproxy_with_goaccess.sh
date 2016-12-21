goaccess -f haproxy.log --log-format='%^  %^ %^:%^:%^ %^ %^[%^]: %h:%^ [%d:%t.%^] %^ %^ %^/%^/%^/%^/%L %s %b %^ %^ %^ %^/%^/%^/%^/%^ %^/%^ "%r"' --date-format='%d/%b/%Y' --time-format='%H:%M:%S' -q
