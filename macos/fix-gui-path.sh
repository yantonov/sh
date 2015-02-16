#!/bin/bash

# patch PATH for gui (and spotlight in particular)
OLD_GUI_PATH=`launchctl getenv PATH`

# if initial path is empty fill it using /etc/paths, otherwise
# you cant use apps in system directories
if [[ -z "$OLD_GUI_PATH" ]]
then
    OLD_GUI_PATH=`cat /etc/paths | tr "\n" ":" | sed 's/:$//'`
fi

# load .profile (i save terminal PATH modification here)
# so i want to reuse this settings for gui applications
source ~/.profile

# patch gui PATH varible
if [[ $OLD_GUI_PATH != *$ADDITIONAL_PATH* ]]
then
    NEW_GUI_PATH=$ADDITIONAL_PATH:$OLD_GUI_PATH
    launchctl setenv PATH $NEW_GUI_PATH
fi

launchctl setenv M2_HOME $M2_HOME
launchctl setenv JAVA_HOME $JAVA_HOME
