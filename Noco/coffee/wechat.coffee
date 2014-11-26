_wechat_f = 
	"appid": ""
	"img_url": "http://campaign.douban.com/files/campaign/casarte_NOCO/img/wechat-share.png"
	"img_width": 200
	"img_height": 200
	"link": "http://campaign.douban.com/files/campaign/casarte_NOCO/default.html"
	"desc": "速速加入卡萨帝NOCO燃气热水器隐患大搜捕，赢取Kindle Paperwhite！"
	"title": "我代替NOCO消灭了隐患！"
_wechat =
	"appid": ""
	"img_url": "http://campaign.douban.com/files/campaign/casarte_NOCO/img/wechat-share.png"
	"img_width": 200
	"img_height": 200
	"link": "http://campaign.douban.com/files/campaign/casarte_NOCO/default.html"
	"desc": "嘘！我参加了卡萨帝燃气热水器代号NOCO的有奖神秘任务！"
	"title": "嘘！我参加了卡萨帝燃气热水器代号NOCO的有奖神秘任务！"

shareFriend = ->
	if window.WeixinJSBridge
		WeixinJSBridge.invoke 'sendAppMessage', _wechat_f
shareTimeline = ->
	if window.WeixinJSBridge
		WeixinJSBridge.invoke 'shareTimeline', _wechat

document.addEventListener 'WeixinJSBridgeReady', ->
	WeixinJSBridge.on 'menu:share:appmessage', (argv)->
		shareFriend()
	WeixinJSBridge.on 'menu:share:timeline', (argv)->
		shareTimeline()
