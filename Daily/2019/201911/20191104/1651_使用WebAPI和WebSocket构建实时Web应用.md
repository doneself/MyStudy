# 使用WebAPI和WebSocket构建实时Web应用

WebSocket is a recent technology that provides two\-way communication over a TCP connection. This allows us to create real\-time web apps where servers can push data to clients. In this blog post, I’ll demonstrate how this can be done by building a simple chat app using ASP.NET WebAPI and ASP.NET’s new support for WebSockets in .NET 4.5.

Before we get started, there are a few requirements for using WebSockets. It must be supported by both the browser and the web server. The WebSocket protocol is currently supported in Chrome, Firefox, and Safari and will be supported in the upcoming Internet Explorer 10 release. On the server side of things, you will need Windows 8 (or Windows Server 2012) to support WebSockets. Now you may not always be able to guarantee that your client browser and your web server support WebSockets. If that’s your case, I highly recommend you take a look at [SignalR](http://signalr.net/). SignalR provides you with the abstraction of a real\-time, persistent connection without having to worry about how the data is being sent back and forth between the browser and the server.

Now once you’ve met the requirements, you’ll need to enable support for WebSockets on IIS. You can do so by going through Control Panel > Programs > Turn Windows features on or off. You’ll then need to make sure the following boxes are checked:

*   Internet Information Services > World Wide Web Services > Application Development Features > ASP.NET 4.5
*   Internet Information Services > World Wide Web Services > Application Development Features > WebSocket Protocol
*   .NET Framework 4.5 Advanced Services > ASP.NET 4.5

Next, it’s time to write our app. Start by creating a new Empty ASP.NET MVC 4 App in Visual Studio 2012. Create a new HTML page called “chat.htm” with this in the body:

``` html
<form id="chatform" action="">
    <input id="inputbox" />
</form>
<div id="messages" />
```

The HTML here is just a simple chat field to enter messages and a <div> to display our broadcast messages at. Next, let’s implement our client\-side WebSocket functionality:

``` javascript
$(document).ready(function () {
 
    var username = prompt('Please enter a username:');
 
    var uri = 'ws://' + window.location.hostname + window.location.pathname.replace('chat.htm', 'api/Chat') + '?username=' + username;
    websocket = new WebSocket(uri);
 
    websocket.onopen = function () {
        $('#messages').prepend('<div>Connected.</div>');
 
        $('#chatform').submit(function (event) {
            websocket.send($('#inputbox').val());
            $('#inputbox').val('');
            event.preventDefault();
        });
    };
 
    websocket.onerror = function (event) {
        $('#messages').prepend('<div>ERROR</div>');
    };
 
    websocket.onmessage = function (event) {
        $('#messages').prepend('<div>' + event.data + '</div>');
    };
});
```

This JavaScript depends on the JQuery library. Note how we’re sending a username in the query string for our initial web socket, and note how we’re sending messages over the websocket whenever a message is submitted, and that we display messages received over the websocket as well. Now it’s time to implement our server\-side WebSocket handler.

First, let’s make sure that the right route is configured for WebAPI to receive the WebSocket upgrade request. You’ll need to run this command in your Application\_Start method:

``` csharp
routes.MapHttpRoute(
    name: "DefaultApi",
    routeTemplate: "api/{controller}/{id}",
    defaults: new { id = RouteParameter.Optional }
);
```

If you’re using an empty MVC project template, this should already be there for you in RouteConfig.cs. Next, let’s implement our WebAPI controller:

``` csharp
public class ChatController : ApiController
{
    public HttpResponseMessage Get(string username)
    {
        HttpContext.Current.AcceptWebSocketRequest(new ChatWebSocketHandler(username));
        return Request.CreateResponse(HttpStatusCode.SwitchingProtocols);
    }
 
    class ChatWebSocketHandler : WebSocketHandler
    {
        private static WebSocketCollection _chatClients = new WebSocketCollection();
        private string _username;
 
        public ChatWebSocketHandler(string username)
        {
            _username = username;
        }
 
        public override void OnOpen()
        {
            _chatClients.Add(this);
        }
 
        public override void OnMessage(string message)
        {
            _chatClients.Broadcast(_username + ": " + message);
        }
    }
}
```

Our controller has just one method, Get, which listens for WebSocket upgrade requests. Since the initial upgrade handshake for WebSockets looks just like an HTTP request/response, this allows us to go through the entire WebAPI pipeline just as if it were any other HTTP request/response. This means for example that message handlers will run, action filters get called, and model binding lets us bind the request to action parameters. In the example above, we’ve bound the username from the query string as an action parameter. The Get action then does two things. It first accepts the web socket request and sets up a WebSocketHandler to manage the connection. It then sends back a response with HTTP status code 101, notifying the client that is has in fact agreed to switch to the WebSocket protocol. The ChatWebSocketHandler then just takes care of managing a list of chat clients and broadcasting the message to all clients when it receives a message. So we’re able to have WebAPI handle the initial WebSocket upgrade request and create a web socket handler to manage the lifetime of the connection.

You’ll need the [Microsoft.WebSockets NuGet package](http://nuget.org/packages/Microsoft.WebSockets) to be able to build the controller above. Note that because of limitations of the WebSocket feature, you’ll need to deploy the app to IIS or IIS Express. This won’t work in the Visual Studio Development Server. Finally, you’ll need this in your Web.config to get WebSockets working:

``` xml
<configuration>
  <appSettings>
    <add key="aspnet:UseTaskFriendlySynchronizationContext" value="true" />
  </appSettings>
</configuration>
```

And there you go, you should be able to deploy your app to IIS and test your chat app. You can try opening multiple browser windows to see chat messages broadcast in real\-time to all the chat clients.
