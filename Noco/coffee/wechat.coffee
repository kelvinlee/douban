_wechat_f = 
	"appid": ""
	"img_url": "http://campaign.douban.com/files/campaign/casarte_NOCO/img/wechat-share.png"
	"img_width": 200
	"img_height": 200
	"link": "http://campaign.douban.com/files/campaign/casarte_NOCO/default.html"
	"desc": "速速加入卡萨帝NOCO燃气热水器隐患大搜捕，赢取Kindle Paperwhite！"
	"title": "NOCO帮我消灭了CO隐患！"
_wechat =
	"appid": ""
	"img_url": "http://campaign.douban.com/files/campaign/casarte_NOCO/img/wechat-share.png"
	"img_width": 200
	"img_height": 200
	"link": "http://campaign.douban.com/files/campaign/casarte_NOCO/default.html"
	"desc": "嘘！我参加了卡萨帝燃气热水器代号NOCO有奖神秘任务！"
	"title": "嘘！我参加了卡萨帝燃气热水器代号NOCO有奖神秘任务！"
_wechat_bool = false
shareFriend = ->
	if window.WeixinJSBridge
		WeixinJSBridge.invoke 'sendAppMessage', _wechat_f
shareTimeline = ->
	if window.WeixinJSBridge
		WeixinJSBridge.invoke 'shareTimeline', _wechat

document.addEventListener 'WeixinJSBridgeReady', ->
	_wechat_bool = true
	WeixinJSBridge.on 'menu:share:appmessage', (argv)->
		shareFriend()
	WeixinJSBridge.on 'menu:share:timeline', (argv)->
		shareTimeline()
	nav = navigator.userAgent.toLowerCase()
	if nav.indexOf "android" > -1
		arr = Math.abs(navigator.userAgent.toLowerCase().split("android")[1].split(";")[0].replace(".",""))
		arr = if arr<100 then arr*10 else arr
		if arr > 440
			# url = "http://mp.weixin.qq.com/mp/redirect?url={url}"
			# url = url.replace "{url}",encodeURI "http://www.baidu.com"
			bindWechatNote()
bindWechatNote = ->
	$("#uploadimg").remove()
	$(".upload").on "touchend",(e)->
		showWechatNote()




shareToPs = (img)->
	url = "http://campaign.douban.com/files/campaign/casarte_NOCO/default.html"
	if img
		url = "http://campaign.douban.com/files/campaign/casarte_NOCO/share.html#"+img
		_wechat.link = _wechat_f.link = url
		shareFriend()
		shareTimeline()
