# Node Modules Remover Script
Run in the path you want to scan for node_modules archives

```shell
./remover.sh
```

Can easily be modified what to target by editing the delete variable on line 2

<br>

## Update

After some experimenting, this (long) one liner does the same job way faster than the script...

```shell
IFS=$'\n';for dir in $(find .|grep /node_modules|grep -v '/node_modules.');do read -p "$dir - Delete this? Empty for Yes [Y/n]: " c;if [ "$c" == "Y" ];then rm -rf $dir;fi;done
```
