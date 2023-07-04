#!/bin/bash
cp /external/*.js .
# cp -r /external/intersystems-iris-native .
npm init -f -y
npm install /external/intersystems-iris-native --save 
npm install websocket --save
npm install 
while true
do
	# echo "Press [CTRL+C] to stop.."
	sleep 60
done
