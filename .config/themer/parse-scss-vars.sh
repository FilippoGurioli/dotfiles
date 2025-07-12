#!/bin/bash

input_file="$1"
output_sh="${2:-$1.sh}"
output_conf="${3:-$1.conf}"

# initialize only if this is the top-level call
if [[ -z $2 ]]; then
    echo "" > "$output_sh"
    echo "" > "$output_conf"
fi

declare -A scss_vars

while IFS= read -r line || [[ -n $line ]]; do
    # if line starts with @import, parse the file and extract variables
    if [[ $line == @import* ]]; then
        file=$(echo "$line" | sed 's/@import\s*//;s/["'\'']//g; s/;//g')
        abs_path="$(dirname "$1")/$file"
        if [[ -f $abs_path ]]; then
            # recursively call the script to parse the imported file
            source ~/.config/themer/parse-scss-vars.sh $abs_path "$output_sh" "$output_conf"
        else 
            echo "File $abs_path not found, skipping."
        fi
    # if line starts with $, extract the variable name and value
    elif [[ $line == \$* ]]; then
        var_name=$(echo $line | cut -d':' -f1 | sed 's/^\$//' | sed 's/-/_/g')
        var_value=$(echo $line | cut -d':' -f2- | sed 's/;//g' | xargs)
        if [[ -v scss_vars["${var_value:1}"] ]]; then
            var_value="${scss_vars["${var_value:1}"]}"
        fi
        scss_vars["$var_name"]="$var_value"
        echo "export $var_name=\"$var_value\"" >> $output_sh
        echo "\$$var_name = ${var_value:1}" >> $output_conf
    fi
done < "$1"