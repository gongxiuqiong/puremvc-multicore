/**
 * Created by Super on 2014/5/7.
 */
(function(lxqclient,sfsclient){
    var sfs;
    var evenHandlerManagers = evenHandlerManagers||{};
    lxqClient.errorHandler={};
    var config = {};

    config.host = "10.50.200.102";
	
    config.port = 8811;
    // config.zone = "xiaochuServer";

    config.zone = "LhcServer";
    config.debug = true;


    // Create SmartFox client instance
    sfs = new SmartFox(config);
    sfsclient=sfs;
    // Set client details
    var platform = navigator.appName;
    var version = navigator.appVersion;
    sfs.setClientDetails(platform, version);

    // Add event listeners
    sfs.addEventListener(SFS2X.SFSEvent.CONNECTION, onConnection, this);
    sfs.addEventListener(SFS2X.SFSEvent.CONNECTION_LOST, onConnectionLost, this);
    sfs.addEventListener(SFS2X.SFSEvent.LOGIN, onLogin, this);
    sfs.addEventListener(SFS2X.SFSEvent.LOGIN_ERROR, onLoginError, this);
	sfs.addEventListener(SFS2X.SFSEvent.PUBLIC_MESSAGE, onPublicMessage, this);
    sfs.addEventListener(SFS2X.SFSEvent.EXTENSION_RESPONSE, onExtension, this);

    lxqClient.CONNECTION=SFS2X.SFSEvent.CONNECTION;
    lxqClient.CONNECTION_LOST=SFS2X.SFSEvent.CONNECTION_LOST;
    lxqClient.EXTENSION_RESPONSE=SFS2X.SFSEvent.EXTENSION_RESPONSE;
    lxqClient.LOGIN=SFS2X.SFSEvent.LOGIN;
    lxqClient.LOGIN_ERROR=SFS2X.SFSEvent.LOGIN_ERROR;
	lxqClient.PUBLIC_MESSAGE=SFS2X.SFSEvent.PUBLIC_MESSAGE;
	lxqClient.SFSError = SFS2X.ErrorCodes;


    lxqClient.addEvenHandler=function ( type,objHander,handler) {
		objHander[type]=handler;
        evenHandlerManagers[type]=objHander;
    }
    
     lxqClient.removeEvenHandler=function ( type,handler) {
        evenHandlerManagers[type]=null;
    }
    

    lxqClient.connect=function () {
        sfs.connect();
    }
    lxqClient.isConnect=function () {
		console.log("isConnect",sfs.isConnected());
        return sfs.isConnected();
    }
    //lxqClient.login=function (name) {
    //    sfs.send(new SFS2X.Requests.System.LoginRequest(name));
    //}
	lxqClient.instance=lxqClient;
    lxqClient.login = function (name, pwd) {
        sfs.send(new SFS2X.Requests.System.LoginRequest(name, pwd));
    }

	lxqClient.publicSay = function ($message, $param) {
		
        sfs.send(new SFS2X.Requests.System.PublicMessageRequest($message, $param));
    }
    lxqClient.send=function ($cmd,$params) {
        sfs.send(new SFS2X.Requests.System.ExtensionRequest($cmd,$params));
    }
	function onPublicMessage(event) {
        evenHandlerManagers[SFS2X.SFSEvent.PUBLIC_MESSAGE](event.sender.name,event.message);
    }
    function onConnection(event) {
        evenHandlerManagers[SFS2X.SFSEvent.CONNECTION][SFS2X.SFSEvent.CONNECTION](event);
    }
    function onLoginError(event) {
        console.log("onLoginError");
        evenHandlerManagers[SFS2X.SFSEvent.LOGIN_ERROR][SFS2X.SFSEvent.LOGIN_ERROR](event);
    }
    function onLogin(event) {
        console.log("onLogin");
        evenHandlerManagers[SFS2X.SFSEvent.LOGIN][SFS2X.SFSEvent.LOGIN](event);
    }
    function onConnectionLost(event) {
        console.log("onConnectionLost");
        evenHandlerManagers[SFS2X.SFSEvent.CONNECTION_LOST][SFS2X.SFSEvent.CONNECTION_LOST](event);
    }
    function onExtension(event) {
		
        console.log("onExtension",event.params);
        if(event.params["error"]==0||(!event.params["error"]))
        {
            evenHandlerManagers[event.cmd][event.cmd](event.params);
        }
        else
        {
            //lxqClient.errorHandler(event.params[ParamKeys.ERROR]);
        }

    }


})
(lxqClient = lxqClient||{},sfsClient = sfsClient||{});
var lxqClient,sfsClient;
var net={};
net.lxqClient=lxqClient;