#!/bin/sh

if [ $# -eq 0 ]; then 
    read -p 'enter 1 for moving to parent | enter 2 for moving to sub folder:  >' nos
    if [ $nos -gt 2  ]; then 
        echo invalid option
        exit 1;
    fi
    read -p 'enter the foldername: ' folder 
    if [ ! -d $folder ]; then 
        echo 'invalid folder '
        exit 1;
    fi
    read -p 'enter the extension: .' ext 
elif [ $# -eq 3 ]; then 
    nos=$1
    folder=$2 
    ext=$3
    
fi

cd $folder ;

pwd 

if [ $nos -eq 1 ]; then 
    for f in `ls *.$ext` ;do 
    mv $f ../$f
    done 
elif [ $nos -eq 2 ]; then 
    mkdir newFolder 
    for f in `ls *.$ext` ;do 
    mv $f ./newFolder
    done 
    
fi 


