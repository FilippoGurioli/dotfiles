#!/bin/bash
count=$(checkupdates 2>/dev/null | wc -l)
echo "{\"text\": \"  $count\", \"tooltip\": \"$count package(s) can be updated.\"}"
