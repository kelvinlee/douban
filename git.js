var http = require('http');
var url = require('url');
var exec = require("child_process").exec;
var port = 9998;

function gitpull(porject) { 
  exec("cd /my/demo/douban && git pull");
  return true;
}
function routes(req,res) {
  var pathname = url.parse(req.url).pathname;
  if (pathname==="/update" && req.method.toLowerCase()=="post") { 
    gitpull();
    console.log("I need run git.");
  }else{
    return "404";
  }
}
var req = http.createServer(function(req,res){
  res.writeHead(200, {'Content-Type': 'text/plain'}); 
  routes(req,res);
  // exec("ls");
  console.log(req,res);
  res.end(); 
}).listen(port);
console.log("Git Douban start.");