#!/bin/sh

# fist time use
# echo "locale | grep 'LC_COLLATE' | sed 's|LC_COLLATE|LOCALE|'" >>~/.bashrc

if [ `locale | tail -n1 | tail -c2` = "C" ]; then
        echo 'locale is C'
        sed -i '/export LC_ALL=C/d' ~/.bashrc
        echo 'changing locale to UTF-8'

elif [ `locale | grep -m1 -o 'UTF-8'` ]; then
        echo 'locale is UTF-8'

sed -in "/locale | grep 'LC_COLLATE' | sed 's|LC_COLLATE|LOCALE|'/i export LC_ALL=C \ " ~/.bashrc
        echo "changing locale to C"

fi
echo "in order for the locale to properly work we need to restart terminal"
read -p "press any key to shutdown bash  [y/n]" test
if [ $test='y' ]; then  
	killall -9 bash
fi
