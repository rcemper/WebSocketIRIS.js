#### Docker Support added

This is now the version compatible to IRIS using _IRIS Native API for Node.js_   
which is significantly different from the interface availaible for Caché.  

Node / JavaScript have wide reputation to work as WebSocket client.  
By using the IRIS adapter it becomes easy to control and to consume the results as a   
Client for WebSocket Servers and to collect the replies in IRIS.   

I used node-v10.15.1-x64.msi and intersystems-iris-native package

### How it works
You provide a Global for input in namespace USER (default)
~~~
set ^WsockIn="wss://echo.websocket.org/"
set ^WsockIn(0)=6set ^WsockIn(1)="Hello"
set ^WsockIn(2)="World !"
set ^WsockIn(3)="Robert"
set ^WsockIn(4)="is waiting"
set ^WsockIn(5)="for replies"
set ^WsockIn(6)="exit"
~~~
the server is controlled by ^ZSocketRun from IRIS   
~~~ 
set ^ZSocketRun(0)="wss://echo.websocket.org/"  ;echo server
set ^ZSocketRun=1   ; => send to echo server  
;    -1 => stop server and exit  
;     0 => wait for action  
~~~
and from echo server you get back a Global as output  
written by Node.js using the Native API for Node.js
~~~
zwrite ^WsockOut
      ^ZSocketOut="wss://echo.websocket.org/"
     ^WsockOut(0)=6
     ^WsockOut(1)="Hello"
     ^WsockOut(2)="World !"
     ^WsockOut(3)="Robert"
     ^WsockOut(4)="is waiting"
     ^WsockOut(5)="for replies"
     ^WsockOut(6)="exit"
~~~
### local installation and operation
The WebSocket Service is started from OS command line.  
You can follow the progress in console output
~~~
      C:\Program Files\nodejs\cache>node WebSocketIRIS.js

        *****************************
        *** no IRIS host defined ****
        Connect to IRIS on: localhost
    Successfully connected to InterSystems IRIS.
        echoserver:  wss://echo.websocket.org/
        ** Lines to process: 6 **
        ********* next turn *********
        ******* Startup done ********

        * WebSocket Client connected *
        ****** Client is ready ******
    Line: 1 text> 'Hello'
    Received: 1 > 'Hello'
    Line: 2 text> 'World !'
    Received: 2 > 'World !'
    Line: 3 text> 'Robert'
    Received: 3 > 'Robert'
    Line: 4 text> 'is waiting'
    Received: 4 > 'is waiting'
    Line: 5 text> 'for replies'
    Received: 5 > 'for replies'
        *** wait 3sec for request ***
    Line: 6 text> 'exit'
    Received: 6 > 'exit'

        ******* lines sent: 6 ******
        *** replies received: 6 ****

        *** wait 3sec for request ***
        *** wait 3sec for request ***
        *** wait 3sec for request ***
        *** wait 3sec for request ***
        *** wait 3sec for request ***
        *** wait 3sec for request ***
        *** Client Service closed ***
~~~
[Comment in DC](https://community.intersystems.com/post/client-websockets-based-nodejs#comment-128726)

## Docker support
### Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.
### Installation
Clone/git pull the repo into any local directory   
~~~
  git clone https://github.com/rcemper/WebSocketIRIS.js.git    
~~~    
Open the terminal in this directory, build and run the container:    
~~~
 docker-compose up -d
~~~
Next open a IRIS session in namespace USER and prepare the Globals for testing  
~~~
set ^WsockIn="wss://echo.websocket.org/"
set ^WsockIn(0)=6set ^WsockIn(1)="Hello"
set ^WsockIn(2)="World !"
set ^WsockIn(3)="Robert"
set ^WsockIn(4)="is waiting"
set ^WsockIn(5)="for replies"
set ^WsockIn(6)="exit"
set ^ZSocketRun(0)="wss://echo.websocket.org/"  ;echo server
set ^ZSocketRun=1   ; => send to echo server 
~~~
Now activate your Node.js client  
Have the external IP address and the SuperServerPort ready  !   
default: localhost:1972
~~~
docker-compose exec wsock node WebSocketIRIS.js <ip-adr>:<port>

platform = linux: ubuntu: x64

        *****************************
        Connect to IRIS on: 192.168.0.9:57771
Successfully connected to InterSystems IRIS.
        echoserver:  wss://echo.websocket.org/
        ** Lines to process: 6 **
        ********* next turn *********
        ******* Startup done ********
~~~

