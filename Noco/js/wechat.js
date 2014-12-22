var shareFriend,shareTimeline,shareToPs,_wechat,_wechat_f;_wechat_f={appid:"",img_url:"http://campaign.douban.com/files/campaign/casarte_NOCO/img/wechat-share.png",img_width:200,img_height:200,link:"http://campaign.douban.com/files/campaign/casarte_NOCO/default.html",desc:"速速加入卡萨帝NOCO燃气热水器隐患大搜捕，赢取Kindle Paperwhite！",title:"NOCO帮我消灭了CO隐患！"},_wechat={appid:"",img_url:"http://campaign.douban.com/files/campaign/casarte_NOCO/img/wechat-share.png",img_width:200,img_height:200,link:"http://campaign.douban.com/files/campaign/casarte_NOCO/default.html",desc:"嘘！我参加了卡萨帝燃气热水器代号NOCO有奖神秘任务！",title:"嘘！我参加了卡萨帝燃气热水器代号NOCO有奖神秘任务！"},shareFriend=function(){return window.WeixinJSBridge?WeixinJSBridge.invoke("sendAppMessage",_wechat_f):void 0},shareTimeline=function(){return window.WeixinJSBridge?WeixinJSBridge.invoke("shareTimeline",_wechat):void 0},
document.addEventListener("WeixinJSBridgeReady",function(){
	WeixinJSBridge.on("menu:share:appmessage",function(e){return shareFriend()});
	WeixinJSBridge.on("menu:share:timeline",function(e){return shareTimeline()});
	nav = navigator.userAgent.toLowerCase();
  if (nav.indexOf("android" > -1)) {
    arr = Math.abs(navigator.userAgent.toLowerCase().split("android")[1].split(";")[0].replace(".", ""));
    arr = arr < 100 ? arr * 10 : arr;
    if (arr > 440) {
      window.frames["inc_iframe"].bindWechatNote();
    }
  }
}),
shareToPs=function(e){var i;return i="http://campaign.douban.com/files/campaign/casarte_NOCO/default.html",e?(i="http://campaign.douban.com/files/campaign/casarte_NOCO/share.html#"+e,_wechat.link=_wechat_f.link=i,shareFriend(),shareTimeline()):void 0};