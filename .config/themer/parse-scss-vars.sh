#!/bin/bash

echo "" > $2

while IFS= read -r line; do
    # if line starts with @import, parse the file and extract variables
    if [[ $line == @import* ]]; then
        file=$(echo "$line" | sed 's/@import\s*//;s/["'\'']//g; s/;//g')
        if [[ -f $file ]]; then
            # recursively call the script to parse the imported file
            bash ~/.config/themer/parse-scss-vars.sh $file $2
        else 
            echo "File $file not found, skipping."
        fi
    # if line starts with $, extract the variable name and value
    elif [[ $line == \$* ]]; then
        var_name=$(echo $line | cut -d':' -f1 | sed 's/^\$//' | sed 's/-/_/g')
        var_value=$(echo $line | cut -d':' -f2- | sed 's/;//g' | xargs)
        echo "export $var_name=\"$var_value\"" >> $2
    fi
done < "$1"