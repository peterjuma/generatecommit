### Create Files
The script `createmultifiles.sh` creates multiple according to the count passed on the commandline and appends a sequential number on the filename based on the count.

It creates 5 files by default, if no count is passed on the command line with stub name "File000<seq number>.txt".

```
./createmultifiles.sh
File0001.txt created
File0002.txt created
File0003.txt created
File0004.txt created
File0005.txt created
```

You may also define your own filename with first argument as the count and second argument as the filename. 

Example:

```
./createmultifiles.sh 5 noname
noname1.txt created
noname2.txt created
noname3.txt created
noname4.txt created
noname5.txt created
```

Existing Files will be skipped

```
./createmultifiles.sh 6
File0001.txt exists, moving on
File0002.txt exists, moving on
File0003.txt exists, moving on
File0004.txt exists, moving on
File0005.txt exists, moving on
File0006.txt created

/createmultifiles.sh 6 noname
noname1.txt exists, moving on
noname2.txt exists, moving on
noname3.txt exists, moving on
noname4.txt exists, moving on
noname5.txt exists, moving on
noname6.txt created

```

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


