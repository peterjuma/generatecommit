## Edit Existing Files
The shell script `editfiles.sh` adds a new line to every file passed to it on the command line.
The script can edit single or multiple files.

### Edit Single file
`./editfiles.sh filename`

Example:

`./editfiles.sh File0001.txt`

### Edit Multiple Files
Use wildcards to match multiple files (similar to what you would use with `ls`)

Example:

```
./editfiles.sh File000{1..10}.txt
./editfiles.sh `ls File000{1..20}.txt` 
./editfiles.sh *.txt*
```
