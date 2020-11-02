#!/bin/sh
delete="node_modules"
start_dir=$(ls)
deleted_in=""

function check_for_item() {
  if [ "$1" == "$delete" ];
  then
    rm -rf $delete
    deleted_item=true
    deleted_in+="$PWD/,"
  fi
}

function another_dir {
  cd $1
  echo "$PWD"
  current_dir=$(ls)
  for item in $current_dir
  do
      # If item is a directory, enter and scan for $delete AND other directories to scan through
      # The loop goes deeper and deeper into every directory til it can't dig any deeper
      if [[ -d $item ]]; then

        # If contains node_modules, delete it
        check_for_item "$item"
        if [ "$deleted_item" == true ];
        then
          echo $'\e[31m$ Found & deleted in '$PWD $'\e[0m'
          deleted_item=false
          continue;
        fi

        # If directory was not $delete, go deeper
        another_dir "$item"
      fi
  done

  # If the loop gets here, it means there are no more items in the current directory
  # so it moves out of the current directory and enters the next if there are any
  cd ../
}

for item in $start_dir
do
    # If item is a directory
    if [[ -d $item ]]; then
        check_for_item "$item"
        another_dir "$item"
    fi
done

echo $'"\e[32m'$delete$'\e[0m" Found & deleted in: '
IFS=','
for dir in `echo "$deleted_in"`
  do echo $'\e[33m'$dir $'\e[0m' ""
done
