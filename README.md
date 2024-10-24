#### Docker Support added   

This is now the version compatible to IRIS using _IRIS Native API for Node.js_   
which is significantly different from the interface availaible for Caché.   

Node / JavaScript have wide reputation to work as WebSocket client.    
By using the IRIS adapter it becomes easy to control and to consume the results as a   
Client for WebSocket Servers and to collect the replies in IRIS.   

I used node-v10.15.1-x64.msi and intersystems-iris-native package     

## How it works   
You provide a Global for input in namespace USER (default)   

set ^ZSocketIn(0)=6  
set ^ZSocketIn(1)="Hello"  
set ^ZSocketIn(2)="World !" 
set ^ZSocketIn(3)="Robert"  
set ^ZSocketIn(4)="is waiting"  
set ^ZSocketIn(5)="for replies" 
set ^ZSocketIn(6)="exit"  
   
The server is controlled by ^ZSocketRun from IRIS   
   
set ^ZSocketRun(0)="wss://ws.postman-echo.com/raw"  ;echo server   
set ^ZSocketRun=1   ; => send to echo server   
;    -1 => stop server and exit  
;     0 => wait for action   
    
and from echo server you get back a Global as output    
written by Node.js using the Native API for Node.js   
```
zwrite ^ZSocketOut   
^ZSocketOut="wss://ws.postman-echo.com/"    
^ZSocketOut(0)=6   
^ZSocketOut(1)="Hello"   
^ZSocketOut(2)="World !"    
^ZSocketOut(3)="Robert"     
^ZSocketOut(4)="is waiting"     
^ZSocketOut(5)="for replies"     
^ZSocketOut(6)="exit"    
```
Or run 
```
USER>do ^ZSocket
``` 
### Local installation and operation
The WebSocket Service is started from OS command line.   
You can follow the progress in console output    
```    
C:\Program Files\nodejs\cache>node WebSocketIRIS.js <server-ip>:<superserver-port>     
``` 
![image](https://github.com/rcemper/WebSocketIRIS.js/assets/31236645/7791b075-4474-4649-bb3b-de7db1f7fff0)

[Comment in DC](https://community.intersystems.com/post/client-websockets-based-nodejs#comment-128726)

## Docker support  
### Prerequisites  
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.  
### Installation
Clone/git pull the repo into any local directory   
```
  git clone https://github.com/rcemper/WebSocketIRIS.js.git   
``` 
Open the terminal in this directory, build and run the container:     
```
 docker-compose up -d   
```   
Next open a IRIS session in namespace USER and prepare the Globals for testing   
a test program **ZSocket.MAC** is in subdirectory **src** of download directory    

Now activate your Node.js client  
Have the external IP address and the SuperServerPort ready  !   
default: localhost:1972 is just a placeholder    
```
docker-compose exec wsock nodejs WebSocketIRIS.js <ip-adr>:<port>  
```
From IRIS terminal run
```
USER>do ^ZSocket
 
*** Welcome to WebSocket Micoservice demo ***
Known Hosts (*=Exit) [1]:
1  wss://ws.postman-echo.com/raw
2  --- server 2 ----
3  --- server 3 ----
select (1): 1 ==> wss://ws.postman-echo.com/raw
#
Enter text to get echoed from WebSocketClient Service
Terminate with * at first position
or get generated text by %
or append new text with @
```
    
