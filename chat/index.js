var app = require('express')();
var http = require('http').createServer(app);
var io = require('socket.io')(http);
var port = process.env.PORT || 3000;

var mustache = require('mustache-express');
var prevMessage = [];
app.engine('mustache',mustache());
app.set('view engine','mustache');
app.get('/',function(req,res){
    var username = req.query.username;
    var otherUser = req.query.otherUser;
    var roomname = (username>otherUser)? username+"#"+otherUser:otherUser+"#"+username;
    res.render(__dirname+'/index',{"username": username,"prevMessage":prevMessage[roomname],"otherUser":otherUser});
});

io.on('connection', function(socket){
    socket.on('room name', function(room){
        socket.join(room);
    });
    socket.on('chat message', function(data){
        io.to(data.room).emit('chat message',data);
        if(prevMessage[data.room]==undefined){
            prevMessage[data.room]=[];
        }
        prevMessage[data.room].push(data.msg);
    });
    socket.on('notification',function(data){
        io.to(data.username).emit('notification',data);
    })
});

http.listen(port, function(){
    console.log('listening on 3000');
});