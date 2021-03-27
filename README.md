# Node Modules Remover Script
Run in the path you want to scan for node_modules archives

```shell
./remover.sh
```

Can easily be modified what to target by editing the delete variable on line 2

<br>

## Update

After some experimenting, this (long) one liner does the exact same job (without output) but way faster than the script...

```shell
T='node_modules';IFS=$'\n';for dir in $(find .|grep "/$T"|grep -v "/$T.");do read -p "$dir - Delete this? Empty for Yes [Y/n]: " c;if [ "$c" != "n" ];then rm -rf $dir;fi;done
```
