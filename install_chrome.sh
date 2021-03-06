#!/bin/bash

CHROMEDRIVER_VERSION=""

curl https://intoli.com/install-google-chrome.sh | bash
if [ $? -ne 0 ]; then
    echo "install of google-chrome is failed."
    exit 1
fi

CHROME_VERSION=$(google-chrome-stable -version | grep -oP "(?<=Google Chrome )\d+\.\d+\.\d+")
echo ${CHROME_VERSION}

version_list=$(curl -s https://sites.google.com/a/chromium.org/chromedriver/ | grep 'Latest stable' | grep -oP '(?<=ChromeDriver )\d+\.\d+\.\d+\.\d+'| grep '94')
for item in ${version_list[@]}; do
    if [[ ${item} =~ ${CHROME_VERSION} ]] ;
    then
        CHROMEDRIVER_VERSION=${item}
    fi
done

# https://chromedriver.storage.googleapis.com/96.0.4664.45/chromedriver_linux64.zip
CHROMEDRIVER_VERSION="96.0.4664.45"
#curl -O https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip
curl -O https://chromedriver.storage.googleapis.com/96.0.4664.45/chromedriver_linux64.zip
if [ $? -ne 0 ]; then
    echo "download of chromedriver is failed."
    exit 1
fi

unzip chromedriver_linux64.zip
if [ $? -ne 0 ]; then
    echo "unzip of chromedriver is failed."
    exit 1
fi

mv chromedriver /usr/local/bin/.
if [ $? -ne 0 ]; then
    echo "move of chromedriver is failed."
    exit 1
fi
