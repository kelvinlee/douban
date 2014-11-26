(function(window, undefined){
    var collClient = function(domain, cam_uid, coll_uid, secret){
      this.domain = domain;
      this.cam_uid = cam_uid;
      this.coll_uid = coll_uid;
      this.secret = secret;
      this.url = domain+'/api/'+cam_uid+'/coll/'+coll_uid+'?secret='+secret;
    };
    collClient.prototype.collXHR = function(method, data_dict, callback){
        if(window.XMLHttpRequest) {
            xmlhttp = new XMLHttpRequest();
            if(xmlhttp.overrideMimeType) {
                xmlhttp.overrideMimeType("text/html");
            }
        } else if (window.ActiveXObject){
            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
        if(xmlhttp){
            xmlhttp.onreadystatechange=state_change;
            xmlhttp.open("POST", this.url, true);
            xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            xmlhttp.setRequestHeader("X-HTTP-Method-Override",method);
            var send_data = '';
            for(var k in data_dict){
              send_data += (k+'='+data_dict[k]+'&');
            }
            function state_change(){
              if (xmlhttp.readyState==4)
              { 
                if (xmlhttp.status==200)
                {
                  data = JSON.parse(xmlhttp.responseText);
                  if(data){
                    if(data['status'] == 'successed'){
                        callback(1, data);
                    } else{
                        callback(-1, data['reason']);
                    }
                  } else{
                    callback(-1, 'error data or JSON is not supported');
                  }
                }
                else
                {
                  callback(-1, xmlhttp.statusText);
                }
              }
            }
            xmlhttp.send(send_data);
            return 1;
        } else{
            return -1;
        }
    };
    collClient.prototype.get = function(query, fields, order, start, limit, count, find_one, callback){
      var data_dict={"query":query, "fields":fields, "order":order, 
            "start":start, "limit":limit, "count":count, "find_one":find_one},
          method='GET';
      this.collXHR(method,data_dict,callback);
    };
    collClient.prototype.post = function(coll_data, callback){
      var data_dict={"data":coll_data},
          method='POST';
      this.collXHR(method,data_dict,callback);
    };
    collClient.prototype.put = function(query, coll_data, multi, upsert, callback){
      var data_dict={"query":query, "data":coll_data, "multi":multi, "upsert":upsert},
          method='PUT';
      this.collXHR(method,data_dict,callback);
    };
    collClient.prototype.delete = function(query, callback){
      var data_dict={"query":query},
          method='DELETE';
      this.collXHR(method,data_dict,callback);
    };
    window.collClient = collClient;
})(window);