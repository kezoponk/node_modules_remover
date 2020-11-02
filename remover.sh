#!/bin/sh
delete='node_modules'
start_dir=$(ls)
deleted_in=''
scanned_items=0

function scan_for_item() {
  if [ "$1" == "$delete" ];
  then
    #rm -rf $delete
    deleted_in+="$PWD,"
    echo $'\e[93mFound in '$PWD $'\e[0m'
    continue;
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
    scan_for_item "$item"
    scanned_items=$(($scanned_items + 1))

    if [ -d $item ]; then
      # If directory was not $delete, go deeper
      another_dir "$item"
    fi
  done
  # If the loop gets here, it means there are no more items in the current directory
  # so it moves out of the current directory and enters the next if there are any
  cd ../
}

# Main
for item in $start_dir
do
  scan_for_item "$item"
  scanned_items=$(($scanned_items + 1))

  # If item is a directory, enter it
  if [ -d $item ]; then
    another_dir "$item"
  fi
done

# Purge finished
echo
echo $'\e[32m"'$delete$'"\e[0m found: Yes is default'
IFS=','
for dir in `echo "$deleted_in"`
do
  read -p "$dir/$delete, delete? [Y/n] " choice
  if [ "$choice" != "n" ] && [ "$choice" != "N" ]; then
    echo "Deleting"
    rm -rf $dir/$delete
  fi
done

printf "\nTotal scanned items: $scanned_items\n"
