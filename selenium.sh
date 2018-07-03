#!/bin/bash

if [ -L $0 ] ; then
    path=$(dirname $(readlink -f $0)) ;
else
    path="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi ;
 

case $1 in
	register )
		sudo ln -fs $path/selenium.sh /usr/local/bin/selenium
		echo "Registered in /usr/local/bin/selenium"
	;;
	update )
		url=`curl https://www.seleniumhq.org/download/ | grep "Download version" | grep -o -E "https?\:\/\/[a-zA-Z0-9\.\/\-\_]*"`

		echo "Downloading selenium ... "
		wget $url -O $path/selenium.jar

		chromeVer=` curl https://sites.google.com/a/chromium.org/chromedriver/downloads | grep "Latest Release:" | grep -o -E "https?\:\/\/[a-zA-Z0-9\.\/\-\_\?\=]*" | grep -oP "(?<=path=).*"`
		chromePath=`curl "https://chromedriver.storage.googleapis.com?delimiter=/&prefix=$chromeVer&marker=" | grep -o -E "[^\>]*linux64[^\<]*"`
		chromeurl="https://chromedriver.storage.googleapis.com/$chromePath"
		
		echo "Downloading chromedriver ..."
		wget $chromeurl -O $path/chromedriver.zip
		unzip -o chromedriver.zip
	;;
	
	* )
		
		java -jar -Dwebdriver.chrome.driver=$path/chromedriver $path/selenium.jar
	;;
esac
