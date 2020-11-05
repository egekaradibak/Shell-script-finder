#!/bin/bash
#check whether only one argument has been fed
if [ "$#" -eq 1 ]; then
    #take the first argument that's been fed
    path="$1"
    #check whether our $path is a directory
    if [[ -d "$path" ]]; then
        #search through the $path directory
        for f in $path/*;
        do  
            #check whether the file $f is a shell script file
            if [ ${f: -3} == ".sh" ]; then
            #counter to count valid lines
              count=0
              #read each line
              while read line
              #check lines to exclude { (is the line commeted) OR (is the line only full of spaces) OR (is the line empty) }
              #negate it, and include the lines that are chosen by the inverted condition
              do [[ "$line" =~ ^[[:space:]]*# && "$line" =~ ^[[:space:]]* && -z "$line" ]] && continue
              #count the validline
              ((count=$count+1))
              done < $f #done for our file $f
              #basename filepath/filename.txt -> trims filepath -> filename.txt 
              #concatenate count after that
              echo "$(basename $f) $count"
            fi
        done
    else
        echo "Error: $path is not a directory"
        exit 0
    fi
else
    #error handling logic: show usage and terminate
    # shows a proper usage once a flawed argument is fed to the program
    echo "Usage : ./srclines.sh dir1"
    exit 0
fi
