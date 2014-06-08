# @codekit-prepend "js/vendor/Zepto.min.js"
# @codekit-prepend "line.coffee"
# @codekit-prepend "point.coffee"
# @codekit-prepend "js/vendor/jquery.cookie.js"

# miss  话筒调整
# miss  结束文案
# miss  戳我链接
# 



_colorList = ['#23378B','#009FE3','#E42313','#FCBD1B','#34002A']
_colori = parseInt(Math.random()*(_colorList.length-1+1)+1)-1
_dom = {}
_default =
	'width':640
	'height':920
manilsit = [
	{id: "logo", src:"img/logo.png"}
	{id: "durex", src:"img/durex.png"}
	{id: "point", src:"img/point.png"}
	{id: "line", src:"img/line.png"}
	{id: "icon-l-1", src:"img/icon-l-1.png"}
	{id: "icon-l-2", src:"img/icon-l-2.png"}
	{id: "icon-l-3", src:"img/icon-l-3.png"}
	{id: "icon-l-4", src:"img/icon-l-4.png"}
	{id: "icon-r-1", src:"img/icon-r-1.png"}
	{id: "icon-r-2", src:"img/icon-r-2.png"}
	{id: "icon-r-3", src:"img/icon-r-3.png"}
	{id: "icon-r-4", src:"img/icon-r-4.png"}
	{id: "icon-c-1", src:"img/icon-c-1.png"}
	{id: "icon-s-1", src:"img/icon-s-1.png"}
	{id: "icon-s-2", src:"img/icon-s-2.png"}
	{id: "icon-s-3", src:"img/icon-s-3.png"}
	{id: "icon-s-4", src:"img/icon-s-4.png"}
	{id: "icon-s-5", src:"img/icon-s-5.png"}
	{id: "icon-s-6", src:"img/icon-s-6.png"}
	{id: "weixin-share-bg", src:"img/weixin-share-bg.png"}
	{id: "finger", src:"img/finger.png"}
	{id: "point-w", src:"img/point-w.png"}


	{id: "playing", src:"mp3/playing.mp3"}
	{id: "faild", src:"mp3/faild.mp3"}
]

_growH = 0.3
downspeed = 12 #default down speed
moveVar = 5 # default move px.
loadingInterval = 0
canvas = {} # canvas
stage = {} # for stage
preload = {} # load everthing.
thep = {}
lines = []
gaming = false
moveTimes = 0
moveitemsShow = 20
moveHshow = 200
usetime = 0
starTime = null
endTime = null
_beforestart = false
# _tobottom = 300
_Breathing = true
_sp = 0

$("#mubu").css
	"background":_colorList[_colori]


init = ()-> 
	window.scrollTo 0,1
	h = document.body.clientHeight*2
	w = document.body.clientWidth*2
	console.log w,h
	if w > 640
		h = (640/w)*h
		w = 640
		if h < 800
			h = 800
	
	console.log w,h
	cvs = $("<canvas id='canvas' width='#{w}' height='#{h}'>");
	$("#mubu").append cvs
	canvas = document.getElementById("canvas")
	_default.height = h

	# 适配
	# console.log $("body").height()*2
	
	# alert document.body.clientWidth
	# $(canvas).attr 'height',h*2
	# _default.height = h*2
	# if $("body").width() > 640
	# 	_sp = 0
	# else if $("body").height()*2 > 880
		
	# 	_sp = 0
	# else 
	# 	$(canvas).attr 'height',h*2
	# 	_default.height = h*2
	# 	_sp = 20


	
	stage = new createjs.Stage canvas
	# open touch 
	createjs.Touch.enable stage
	createjs.Ticker.setFPS 30

	messageField = new createjs.Text '努力加载中...', 'normal 36px Arial', "#fff"
	messageField.maxWidth = 1000
	messageField.textAlign= "center"
	messageField.lineHeight = 46
	messageField.x = canvas.width/2
	messageField.y = canvas.height/2
	_dom.messageField = messageField

	timeText = new createjs.Text '0.00', 'normal 32px Arial', "#fff"
	timeText.maxWidth = 1000
	timeText.textAlign= "center"
	timeText.lineHeight = 46
	timeText.x = canvas.width/2
	timeText.y = 210
	timeText.alpha = 0

	_dom.timeText = timeText

	# line box
	linebox = new createjs.Container()
	linebox.width = canvas.width
	linebox.height = canvas.height
	_dom.linebox = linebox
	# for then game over.

	colorBG = new createjs.Container()
	colorBG.x = 0
	colorBG.y = 0
	colorBG.width = 640
	colorBG.height = 30
	# colorBG.graphics.beginFill("#00F").drawRect(0,0,200,200)
	color1 = new createjs.Shape();
	color2 = new createjs.Shape(new createjs.Graphics().f("#333333").dr(0,-canvas.height,canvas.width, canvas.height));
	_dom.color1 = color1
	_dom.color2 = color2
	colorBG.addChild color1,color2 
	_dom.colorBG = colorBG

	longtimeText = new createjs.Text 'Ta最长high过:', 'normal 32px Arial', "#fff"
	longtimeText.maxWidth = 1000
	longtimeText.textAlign= "center"
	longtimeText.lineHeight = 46
	longtimeText.x = canvas.width/2
	longtimeText.y = 256
	longtimeText.alpha = 0
	_dom.longtimeText = longtimeText

	showText = new createjs.Text '', 'normal 32px Arial', '#fff'
	showText.maxWidth = 1000
	showText.textAlign= "center"
	showText.lineHeight = 46
	showText.x = canvas.width/2
	showText.y = 256+46
	showText.alpha = 0
	_dom.showText = showText

	# btn back restar game
	restarbtn = new createjs.Container()
	restarbtn.width = 260
	restarbtn.height = 90
	restarbtn.y = 256+46+110
	restarbtn.x = 30
	r_bg = new createjs.Shape()
	p = r_bg.graphics.beginFill("#000").drawRoundRect(0,0,260,90,5)
	r_bg.alpha = 0.3
	btntext = new createjs.Text '重来','bold 40px Arial','#fff'
	btntext.textAlign= "center"
	btntext.maxWidth = 260 
	btntext.x = 260/2
	btntext.y = 45/2
	restarbtn.addChild r_bg,btntext
	restarbtn.alpha = 0 
	_dom.restartbtn = restarbtn
	# click me btn
	climebtn = new createjs.Container()
	climebtn.width = 260
	climebtn.height = 90
	climebtn.y = 256+46+110
	climebtn.x = 640-260-30
	c_bg = new createjs.Shape()
	p = c_bg.graphics.beginFill("#000").drawRoundRect(0,0,260,90,5)
	c_bg.alpha = 0.3
	btntext = new createjs.Text '戳我','bold 40px Arial','#fff'
	btntext.textAlign= "center"
	btntext.maxWidth = 260 
	btntext.x = 260/2
	btntext.y = 45/2
	climebtn.addChild c_bg,btntext
	climebtn.alpha = 0
	_dom.climetext = btntext
	_dom.climebtn = climebtn


	stage.addChild linebox,colorBG,messageField,timeText,longtimeText,showText,restarbtn,climebtn
	stage.update()

	preload = new createjs.LoadQueue()
	preload.installPlugin(createjs.Sound)
	preload.on('complete',handleComplete,this)
	preload.loadManifest manilsit


handleComplete = (event)->
	# load finished

	durex = new createjs.Bitmap preload.getResult("durex")
	durex.x = (canvas.width-preload.getResult("durex").width)/2
	durex.y = 0
	durex.alpha = 0
	_dom.durex = durex

	# share btn
	sharebtnlist = new createjs.Container()
	sharebtnlist.y = 522
	sharebtnlist.alpha = 0
	icons = [
		{id:1,url:"http://v.t.sina.com.cn/share/share.php?title={title}&url={url}&pic={pic}"}
		{id:2,url:"http://www.kaixin001.com/rest/records.php?content={title}&url={url}&starid=0&aid=0&style=11&stime=&sig=&pic={pic}"}
		{id:3,url:"weixin"}
		{id:4,url:"http://v.t.qq.com/share/share.php?title={title}&url={url}&pic={pic}"}
		{id:5,url:"http://www.douban.com/share/service?bm=&image={pic}&href={url}&updated=&name={title}"}
		{id:6,url:"http://share.renren.com/share/buttonshare?title={title}&link={url}&pic={pic}"}
	]
	for icon in icons
	  # body...
	  ic = new createjs.Bitmap preload.getResult "icon-s-"+icon.id
	  ic.x = 4+((icon.id-1)*102)
	  ic.url = icon.url
	  ic.shareid = icon.id
	  sharebtnlist.addChild ic
	  ic.addEventListener('pressup',shareEvent)

	_dom.sharebtnlist = sharebtnlist
	stage.addChild durex,sharebtnlist
	upload()

	clearInterval loadingInterval 
	createjs.Ticker.addEventListener "tick", tick
	FirstGameFrame()
	reStartGame()
	

upload = ()->
	stage.update()


restart = ()->
	stage.removeAllChildren()
GameStar = (obj)->
	# body...
	return "" if gaming
	console.log "Game Star"
	# alert "Game Star 1"
	starTime = new Date().getTime()
	_dom.messageField.alpha = 0
	_dom.logo.alpha = 0
	_dom.timeText.alpha = 1
	_dom.longtimeText.alpha = 0
	_dom.showText.alpha = 0
	_dom.durex.alpha = 0
	_dom.restartbtn.alpha = 0
	_dom.climebtn.alpha = 0
	_dom.sharebtnlist.alpha = 0
	gaming = true
	_Breathing = false
	thep.barde()
	createjs.Sound.play("playing",{loop:-1});
	addLine('first')
	upload()
	_smq.push(['custom', 'G点达人', '游戏按钮', '开始']);
	_gaq.push(['_trackEvent', 'G点达人', '游戏按钮', '开始']);
reStartGame = (obj)->
	# body...
	console.log "Star the game."
	removeAllLine()
	# default var
	moveTimes = 0
	downspeed = 12
	# default dom
	_dom.messageField.alpha = 1
	_dom.logo.alpha = 1
	_dom.timeText.alpha = 0
	_dom.longtimeText.alpha = 0
	_dom.showText.alpha = 0
	_dom.durex.alpha = 0
	_dom.restartbtn.alpha = 0
	_dom.climebtn.alpha = 0
	_dom.sharebtnlist.alpha = 0

	thep.barde()
	_Breathing = true
	
	# Hold住G点，一直向上！避开所有干扰，"手指"要灵活，High得更长久！
	_dom.messageField.text = "Hold住G点，一直向上！\n避开所有干扰，\n\"手指\"要灵活，\nHigh得更长久！"
	_dom.messageField.y = canvas.height/2-20
	
	upload()
beforeReStart = ->
	_beforestart = false
	$("#mubu").css
		"background":_colorList[_colori]
	_dom.colorBG.removeChild _dom.color2
	reStartGame()

reStartGameEvent = ->
	console.log "pressup ?"
	thep.setDefault()
	_beforestart = true
	_dom.restartbtn.removeEventListener('click',reStartGameEvent)
	_dom.climebtn.removeEventListener('click',climeEvent)
	_smq.push(['custom', 'G点达人', '游戏按钮', '重来']);	_gaq.push(['_trackEvent', 'G点达人', '游戏按钮', '重来']);
shareEvent = (evt)->
	# **’**”
	if evt.target.shareid is 1
		_smq.push(['custom', 'G点达人', '分享', '新浪微博']);	_gaq.push(['_trackEvent', 'G点达人', '分享', '新浪微博']); 
	if evt.target.shareid is 2
		_smq.push(['custom', 'G点达人', '分享', '开心网']);	_gaq.push(['_trackEvent', 'G点达人', '分享', '开心网']);
	if evt.target.shareid is 3
		_smq.push(['custom', 'G点达人', '分享', '微信']);	_gaq.push(['_trackEvent', 'G点达人', '分享', '微信']);
	if evt.target.shareid is 4
		_smq.push(['custom', 'G点达人', '分享', '腾讯微博']);	_gaq.push(['_trackEvent', 'G点达人', '分享', '腾讯微博']);
	if evt.target.shareid is 5
		_smq.push(['custom', 'G点达人', '分享', '豆瓣']);	_gaq.push(['_trackEvent', 'G点达人', '分享', '豆瓣']);
	if evt.target.shareid is 6
		_smq.push(['custom', 'G点达人', '分享', '人人网']);	_gaq.push(['_trackEvent', 'G点达人', '分享', '人人网']);
	console.log evt.target.shareid
	u = evt.target.url
	ut = Math.round(usetime/1000*100)/100
	ut = (ut+"").replace '.','’'
	content = "我刚让Ta high了#{ut}”， 我要当#G点达人#，你的手指比我更厉害吗？"
	url = "http://8c8fia.c.admaster.com.cn/c/a19082,b200401613,c1316,i0,m101,h"
	pic = "http://m.durex.com.cn/qr/Gmaster/img/share.png"
	if u is "weixin"
		return showWeiXin()
	u = u.replace '{title}',encodeURIComponent content
	u = u.replace '{url}',encodeURIComponent url
	u = u.replace '{pic}',encodeURIComponent pic
	console.log u
	window.open u
showWeiXin = ->
	b = new createjs.Container()
	i = new createjs.Bitmap preload.getResult 'weixin-share-bg'
	
	b.addChild i
	stage.addChild b

	stage.addEventListener 'mousedown', (e)->
		stage.removeChild b
		stage.removeEventListener 'mousedown'

climeEvent = ->
	# clime Event
	# alert "open a link"
	if usetime < 35000
		_smq.push(['custom', 'G点达人', '游戏按钮', '戳我']);	_gaq.push(['_trackEvent', 'G点达人', '游戏按钮', '戳我']);
		window.open "http://www.j1.com/%25E6%259D%259C%25E8%2595%25BE%25E6%2596%25AF/1/1-0-0-1/ss.html"
	else if usetime <= 60000
		_smq.push(['custom', 'G点达人', '游戏按钮', '奖励10元']);	_gaq.push(['_trackEvent', 'G点达人', '游戏按钮', '奖励10元']);
		window.open "http://www.j1.com/activity/dlsmj.html?from:ad01"
	else if usetime > 60000
		_smq.push(['custom', 'G点达人', '游戏按钮', '7折买兔子']);	_gaq.push(['_trackEvent', 'G点达人', '游戏按钮', '7折买兔子']);
		window.open "http://www.j1.com/activity/rhj.html?from:ad01"

GameEnd = ()->
	# body...
	

	console.log "End the game."
GameOver = ()->
	# hit the line game over.
	# 
	console.log "hit line game over"
	_colori++
	_colori = 0 if _colori > _colorList.length-1
	tempY = 522+100
	if _sp > 0
		tempY = 522+100
	thep.bar.My = tempY+35

	gaming = false
	thep.bar.canmove = false
	endTime = new Date().getTime()
	usetime = endTime - starTime
	time = Math.round(usetime/1000*100)/100
	_dom.colorBG.removeChild _dom.color2
	_dom.color2 = new createjs.Shape(new createjs.Graphics().f(_colorList[_colori]).dr(0,-canvas.height,canvas.width, canvas.height));
	_dom.colorBG.addChild _dom.color2
	_dom.color2.My = tempY

	if thep.bar.y <= tempY
		thep.bar.My = tempY+35
		thep.bar.Ny = thep.bar.y


	# use cookie remend the longest time.
	console.log "longtime:",usetime,$.cookie("longtime") < usetime
	$.cookie("longtime",usetime) if not $.cookie("longtime") or $.cookie("longtime") < usetime
	longtime = Math.round(parseInt($.cookie("longtime"))/1000*100)/100
	# 清除线
	# removeAllLine()
	_dom.durex.alpha = 1
	_dom.longtimeText.text = "Ta最长high过:"+changeTimeText longtime
	_dom.climetext.text = "戳我"
	if usetime < 20000
		_dom.showText.text = "新手吧？努力锻炼手指或\n去找杜蕾斯“震震棒”求助！" 
	else if usetime < 35000
		_dom.showText.text = "不错哦！杜蕾斯“脉冲棒”是\n你的绝配，让对方尖叫！"
	else if usetime < 50000
		_dom.showText.text = "厉害哦！杜蕾斯“霹雳棒” \n能让你再来一轮！"
		_dom.climetext.text = "奖励10元"
	else if usetime < 60000
		_dom.showText.text = "太赞了！果然是G点达人！\n快让杜蕾斯霹雳棒帮你继续high！"
		_dom.climetext.text = "奖励10元"
	else
		 _dom.showText.text = "你就是传说中的黄金手指！\n你的绝配是杜蕾斯脉冲棒！"
		 _dom.climetext.text = "7折买震震棒"

	_dom.timeText.text = "你让Ta high了:"+changeTimeText time
	# console.log stage.getChildIndex _dom.colorBG
	# console.log "the game over. live time:"+usetime
	createjs.Sound.stop()
	createjs.Sound.play("faild",createjs.Sound.INTERUPT_LATE, 0, 0.8);

	upload()
showGameOver = ->
	console.log "bind restar btn"
	_dom.restartbtn.alpha = 1
	_dom.climebtn.alpha = 1
	_dom.longtimeText.alpha = 1
	_dom.showText.alpha = 1
	_dom.sharebtnlist.alpha = 1
	_dom.restartbtn.addEventListener('click',reStartGameEvent)
	_dom.climebtn.addEventListener('click',climeEvent)
FirstGameFrame = ()->
	thep = new Point
		img:preload.getResult "point"
		lineimg:preload.getResult "line"
		fingerimg:preload.getResult "finger"
		pointw:preload.getResult "point-w"
		parent:stage
		x: (_default.width - preload.getResult("point").width)/2
		y: _default.height - preload.getResult("point").height - 100 + _sp
	# console.log p
	_dom.logo = new createjs.Bitmap preload.getResult "logo"
	_dom.logo.x = (_default.width - preload.getResult("logo").width)/2
	_dom.logo.y = 100 - _sp
	logo = _dom.logo

	stage.addChild thep,logo
	upload()

removeAllLine = ->
	console.log "remove all line"
	for i in [0..lines.length]
		if lines[i]?
	 		_dom.linebox.removeChild lines[i].parent 
	lines = []
addLine = (first)->
	# setTimeout ->
	moveTimes = 0
	downspeed += _growH
	downspeed = 40 if downspeed > 40
	newline = new Line id:"line"+lines.length
	newline.parent.y = -newline.parent.height
	# alert "add the line."+first
	_dom.linebox.addChild newline.parent
	# newline.hitLine(1,1)
	lines.push newline
	upload()
removeLine = (line)->
	for i in [0..lines.length]
		 if lines[i] is line
		 	_dom.linebox.removeChild lines[i].parent
		 	delete lines[i]
runTime = ->
	if gaming
		usetime = new Date().getTime() - starTime
		_dom.timeText.text = changeTimeText Math.round(usetime/1000*100)/100
# for tick animate, delay or move speed , I need write some code.

changeTimeText = (time)->
	t = (time+"").replace ".","’"
	t+"’0" if /^[0-9]*[1-9][0-9]*$/.test time
	return t+"”"
tick = (event)-> 
	stage.update event
	thep.DefaultPonitMove()
	thep.DefaultFingerMove()
	
	if _beforestart
		v = canvas.height - _dom.color2.My
		if canvas.height - _dom.color2.y < v/10
			_dom.color2.y = canvas.height
			beforeReStart()
		else
			_dom.color2.y += v/10

	if gaming 
		for line in lines
			if line?
				line.parent.y += downspeed
				line.hitLine thep.bar.x-35,thep.bar.y-35,70
				removeLine line if line.y > 1000
		addLine() if lines[lines.length-1].parent.y > moveHshow
		runTime()
	# if _Breathing
	# 	thep.Breathing()

	if not gaming and _dom.color2.My > _dom.color2.y 
		if _dom.color2.My - _dom.color2.y < _dom.color2.My/13
			_dom.color2.y = _dom.color2.My
			showGameOver()
		else
			_dom.color2.y += _dom.color2.My/14
	if not gaming and thep.bar.y < thep.bar.My
		console.log "move bar"
		thep.bar.y += (thep.bar.My-thep.bar.Ny)/14


