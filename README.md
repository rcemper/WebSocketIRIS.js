#### Docker Support added   

This is now the version compatible to IRIS using _IRIS Native API for Node.js_   
which is significantly different from the interface availaible for Caché.   

Node / JavaScript have wide reputation to work as WebSocket client.    
By using the IRIS adapter it becomes easy to control and to consume the results as a   
Client for WebSocket Servers and to collect the replies in IRIS.   

I used node-v10.15.1-x64.msi and intersystems-iris-native package     

### How it works   
You provide a Global for input in namespace USER (default)   

set ^ZSockIn(0)=6  
set ^ZSockIn(1)="Hello"  
set ^ZSockIn(2)="World !" 
set ^ZSockIn(3)="Robert"  
set ^ZSockIn(4)="is waiting"  
set ^ZSockIn(5)="for replies" 
set ^ZSockIn(6)="exit"  
   
The server is controlled by ^ZSocketRun from IRIS   
   
set ^ZSocketRun(0)="wss://ws.postman-echo.com/raw"  ;echo server   
set ^ZSocketRun=1   ; => send to echo server   
;    -1 => stop server and exit  
;     0 => wait for action   
    
and from echo server you get back a Global as output    
written by Node.js using the Native API for Node.js   

zwrite ^ZSockOut   
^ZSocketOut="wss://ws.postman-echo.com/"    
^ZZSockOut(0)=6   
^ZSockOut(1)="Hello"   
^ZSockOut(2)="World !"    
^ZSockOut(3)="Robert"     
^ZSockOut(4)="is waiting"     
^ZSockOut(5)="for replies"     
^ZSockOut(6)="exit"    

### Local installation and operation
The WebSocket Service is started from OS command line.   
You can follow the progress in console output    
    
*C:\Program Files\nodejs\cache>node WebSocketIRIS.js*     
 
![image](https://github.com/rcemper/WebSocketIRIS.js/assets/31236645/7791b075-4474-4649-bb3b-de7db1f7fff0)

[Comment in DC](https://community.intersystems.com/post/client-websockets-based-nodejs#comment-128726)

## Docker support  
### Prerequisites  
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.  

### Installation
Clone/git pull the repo into any local directory   
````
  git clone https://github.com/rcemper/WebSocketIRIS.js.git   
````
  
Open the terminal in this directory, build and run the container:     

````
 docker-compose up -d   
````    
Next open a IRIS session in namespace USER and prepare the Globals for testing   
a test program **ZSocket.MAC** is in subdirectory **src** of download directory    

![image](https://github.com/rcemper/WebSocketIRIS.js/assets/31236645/87032767-8b47-442b-8a19-84ed8b0e0fa2)   

Now activate your Node.js client  
Have the external IP address and the SuperServerPort ready  !   
default: localhost:1972 is just a placeholder    

*docker-compose exec wsock nodejs WebSocketIRIS.js <ip-adr>:<port>*    

![image](https://github.com/rcemper/WebSocketIRIS.js/assets/31236645/964674f2-65bb-4dd3-89dc-427e875829b5)
