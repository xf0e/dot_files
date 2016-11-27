#!/bin/sh -eu
find "${1:-.}" -type f ! -empty -print0 | xargs -0 md5 -r | \
    awk '$1 in a{sub("^.{33}","");printf "%s\0",$0}a[$1]+=1{}' | \
    xargs -0 rm -v --
