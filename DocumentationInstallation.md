# [Remote Webcam Project](https://github.com/WarceuProject/RemoteWebcam)
There are 2 methods to run it.
First: you can install and run it manually, you only need to download the remote webcam source code, take it here [Releases ](https://github.com/WarceuProject/RemoteWebcam/releases). 
after that install some components as follows:
- if running on local server you only need to install php package in your terminal for debian based `apt install php`
- after that extract the source code that you have downloaded, open the Remote Webcam Project folder in the terminal run php server to run on the local server `php -S 127.0.0.1: (port) default is 8080`

- if you have your own physical server or servers on your computer, you can probably use the local server address to be public. like you have installed the Apache server on your computer
reference for how to install apache on your linux computer: https://onnocenter.or.id/wiki/index.php/apache

after that drag the Remote Webcam Project sourcecode folder to (/var/www/html
run as root).
to access it, you simply need to copy the server address on your computer, paste it in a browser or other device (if you want to remote the camera on another device).

Second method: you can simply clone the sourcecode to your computer with the Github Repository
as follows: `git clone https://github.com/WarceuProject/RemoteWebcam.git`

`cd RemoteWebcam`
`chmod 777 setup.sh`
and for run
`bash setup.sh` or `./setup.sh`
