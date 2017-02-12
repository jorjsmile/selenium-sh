#!/bin/bash
path=`pwd`

case $1 in
	register )
		sudo ln -fs $path/selenium.sh /usr/local/bin/selenium
		echo "Registered in /usr/local/bin/selenium"
	;;
	update )
		url=`curl http://www.seleniumhq.org/download/ | grep "Download version" | grep -o -E "https?\:\/\/[a-zA-Z0-9\.\/\-\_]*"`
		chromeurl=`curl https://sites.google.com/a/chromium.org/chromedriver/downloads | grep "Latest Release:" | grep -o -E "https?\:\/\/[a-zA-Z0-9\.\/\-\_]*" | grep -o ".*chromedriver.*"`

		wget $url -O $path/selenium.jar
		wget $chromeurl -O $path/chromedriver
	;;
	
	* )
		
		java -jar -Dwebdriver.chrome.driver=$path/chromedriver $path/selenium.jar
	;;
esac
