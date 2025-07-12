#!/bin/bash

output_dir="$HOME/.config/themer/libs/autogen"

# initialize only if this is the top-level call
if [[ -z $output_sh ]]; then
    mkdir -p "$output_dir"
    input_file="$1"
    file_name=$(basename "$input_file")
    output_sh=$output_dir/${file_name%.scss}.sh
    output_conf=$output_dir/${file_name%.scss}.conf
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
            source ~/.config/themer/libs/parse-scss-vars.sh $abs_path
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