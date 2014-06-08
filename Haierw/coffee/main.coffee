# @codekit-prepend "js/vendor/Zepto.min.js" 
# @codekit-prepend "js/vendor/jquery.cookie.js"
# @codekit-prepend "js/vendor/slider.js"


isScrolling_move = false

canvas = {}
stage = {}

manilsit = [
	{id: "logo", src:"img/logo.png"}
	{id: "icon-happyface", src:"img/icon-happyface.png"}
	{id: "icon-message", src:"img/icon-message.png"}
	{id: "icon-success", src:"img/icon-success.png"}
	{id: "nextstep", src:"img/nextstep.png"}
	{id: "reset", src:"img/reset.png"}
	{id: "sharebtn", src:"img/sharebtn.png"}
	{id: "sound", src:"img/sound.png"}
	{id: "stop", src:"img/stop.png"}
	{id: "mistmark", src:"img/mistmark.png"}
	{id: "next", src:"img/next.jpg"}
	{id: "bg-70", src:"img/bg-70.jpg"}
	{id: "bg-80", src:"img/bg-80.jpg"}
	{id: "bg-90", src:"img/bg-90.jpg"}
	{id: "bg-00", src:"img/bg-00.jpg"}


	# {id: "playing", src:"mp3/playing.mp3"}
	# {id: "faild", src:"mp3/faild.mp3"}
]

rsqarr = [
	{id:"rsq-1",src:"rsq/1.png",name:"3D+系列"}
	{id:"rsq-1-r",src:"rsqr/1.png",name:"3D+系列"}

	{id:"rsq-2",src:"rsq/2.png",name:"3D系列"}
	{id:"rsq-2-r",src:"rsqr/2.png",name:"3D系列"}

	{id:"rsq-3",src:"rsq/3.png",name:"倍凝-N1"}
	{id:"rsq-3-r",src:"rsqr/3.png",name:"倍凝-N1"}

	{id:"rsq-4",src:"rsq/4.png",name:"倍恒-T3"}
	{id:"rsq-4-r",src:"rsqr/4.png",name:"倍恒-T3"}

	{id:"rsq-5",src:"rsq/5.png",name:"圣火之心超恒版-2"}
	{id:"rsq-5-r",src:"rsqr/5.png",name:"圣火之心超恒版-2"}

	{id:"rsq-6",src:"rsq/6.png",name:"圣火之心超恒版"}
	{id:"rsq-6-r",src:"rsqr/6.png",name:"圣火之心超恒版"}

	{id:"rsq-7",src:"rsq/7.png",name:"大容积落地式"}
	{id:"rsq-7-r",src:"rsqr/7.png",name:"大容积落地式"}

	{id:"rsq-8",src:"rsq/8.png",name:"安凝-X1"}
	{id:"rsq-8-r",src:"rsqr/8.png",name:"安凝-X1"}

	{id:"rsq-9",src:"rsq/9.png",name:"平衡新风-FEEA"}
	{id:"rsq-9-r",src:"rsqr/9.png",name:"平衡新风-FEEA"}

	{id:"rsq-10",src:"rsq/10.png",name:"敏睿"}
	{id:"rsq-10-r",src:"rsqr/10.png",name:"敏睿"}

	{id:"rsq-11",src:"rsq/11.png",name:"敏睿D5"}
	{id:"rsq-11-r",src:"rsqr/11.png",name:"敏睿D5"}

	{id:"rsq-12",src:"rsq/12.png",name:"新海贝"}
	{id:"rsq-12-r",src:"rsqr/12.png",name:"新海贝"}

	{id:"rsq-13",src:"rsq/13.png",name:"琥珀-D"}
	{id:"rsq-13-r",src:"rsqr/13.png",name:"琥珀-D"}

	{id:"rsq-14",src:"rsq/14.png",name:"简变U3"}
	{id:"rsq-14-r",src:"rsqr/14.png",name:"简变U3"}

	{id:"rsq-15",src:"rsq/15.png",name:"精睿-G3"}
	{id:"rsq-15-r",src:"rsqr/15.png",name:"精睿-G3"}

]




_fromPC = false
_dom = {}
preload = {}
loaded = 0
hideload = false
starBG = false
_decade = 0
RSQfade = false
RSQRfade = false
RSQRfadeO = false
fadeOutSDBG = false

_shareimgurl = ""


percent2radians = (percent)-> percent*Math.PI*2

init = ->
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
	stage = new createjs.Stage canvas
	# open touch 
	createjs.Touch.enable stage
	createjs.Ticker.setFPS 30
	createjs.Ticker.addEventListener "tick", tick

	_dom.load = new createjs.Container()
	_dom.load.alpha = 1

	l = new Image()
	l.src = "img/loading.jpg"
	l.onload = ->
		_dom.loadimg = new createjs.Bitmap l
		_dom.loadimg.y = (_dom.loadimg.height - canvas.height)/2
		_dom.load.addChildAt _dom.loadimg,0
		stage.update()
		# getdata64()

	
	_dom.loadtext = new createjs.Text "0%","normal 56px Arial","#4da6b7"
	_dom.loadtext.maxWidth = 1000
	_dom.loadtext.textAlign= "center"
	_dom.loadtext.lineHeight = 46
	_dom.loadtext.x = canvas.width/2
	_dom.loadtext.y = canvas.height/2 - 60/2

	_dom.loatra = new createjs.Shape()


	_dom.load.addChild _dom.loadtext,_dom.loatra
	stage.addChild _dom.load
	stage.update()

	photoid = getParam "photo_id"
	userid = getParam "user_id"
	if photoid and userid
		_fromPC = true
		manilsit.push {id:"frompc",src:"http://img3.douban.com/view/photo/photo/public/#{photoid}.jpg"}


	# 合并数组
	manilsit = manilsit.concat(rsqarr)

	preload = new createjs.LoadQueue()
	preload.installPlugin(createjs.Sound)
	preload.on('fileload',handleFileLoad,this)
	preload.on('complete',handleComplete,this)
	preload.loadManifest manilsit


handleFileLoad = (evt)->
	loaded++
	console.log loaded/manilsit.length*100
	pr = loaded/manilsit.length
	g = _dom.loatra.graphics
	g.clear()
	g.setStrokeStyle(2, 'round', 'round')
	g.beginStroke("#4da6b7")
	sectorAngle = percent2radians(pr);
	g.arc(canvas.width/2,canvas.height/2,100,1.5*Math.PI,1.5*Math.PI+sectorAngle)
	g.endFill()
	g.closePath()

	_dom.loadtext.text = Math.round(pr*100)+"%"

	stage.update()

handleComplete = (evt)->
	hideload = true


getdata64 = ->
	dataURL = canvas.toDataURL("image/png")
	console.log dataURL
	# submit the image and go to the new page create a share page link.
	# .replace(/^data:image\/(png|jpg);base64,/, "")
	if _fromPC
		postajaxPC dataURL
	else
		postajax dataURL

postajax = (data)->
	# http://battlepit.douban.com/custom/haier_reshuiqi/upload
	$.ajax
		type:"post"
		dataType:"json"
		url:"http://battlepit.douban.com/custom/haier_reshuiqi/upload"
		data:[{name:"image",value:data}]
		success: (msg)->
			console.log "success",msg
			$("#uploadsuccess").attr 'src','img/icon-success.png'
			$("#uploadsuccesstext").html "恭喜您，<br/>作品发布成功！"
			_shareimgurl = msg.src
			BindShare "有些话不愿大声说出来，不妨就写在充满雾气的浴室玻璃上吧！那些话，隐秘而伟大。","http://site.douban.com/haier_waterheater/",_shareimgurl
		error: (msg)->
			$("#uploadsuccess").attr 'src','img/icon-success.png'
			$("#uploadsuccesstext").html "上传失败了<br/>试试再玩一次！"

postajaxPC = (data)->
	photoid = getParam "photo_id"
	userid = getParam "user_id"
	$.ajax
		type:"post"
		dataType:"json"
		url:"http://battlepit.douban.com/custom/haierreshuiqi/changealbum?photoid=#{photoid}&userid=#{userid}"
		data:[{name:"image",value:data}]
		success: (msg)->
			console.log "success",msg
			$("#uploadsuccess").attr 'src','img/icon-success.png'
			$("#uploadsuccesstext").html "恭喜您，<br/>作品发布成功！"
			_shareimgurl = msg.src
			BindShare "有些话不愿大声说出来，不妨就写在充满雾气的浴室玻璃上吧！那些话，隐秘而伟大。","http://site.douban.com/haier_waterheater/",_shareimgurl
		error: (msg)->
			$("#uploadsuccess").attr 'src','img/icon-success.png'
			$("#uploadsuccesstext").html "上传失败了<br/>试试再玩一次！"

getParam = (name)->
	reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i")
	r = window.location.search.substr(1).match(reg)
	return unescape(r[2]) if (r != null) 
	return null
# 首页显示
localimg = {}
showFirstFrame = ->
	# 判断是否有user_id,photo_id
	# 有id流程. _fromPC
	_dom.bglist = {}
	_dom.bglists = {}
	_dom.bgdom = new createjs.Container()
	console.log getParam "photo_id"
	console.log getParam "user_id"
	
	if _fromPC
		_fromPC = true
		# photoid = getParam "photo_id"
		# localimg = new Image()
		# localimg.src = "http://img3.douban.com/view/photo/photo/public/#{photoid}.jpg"
		# localimg.onload = ->
		# frompc
		_dom.bglist.b1 = new createjs.Bitmap preload.getResult "bg-70"
		_dom.bgdom.addChild _dom.bglist.b1
		stage.addChild _dom.bgdom
		stage.update()
		startGame()
		return false


	# 全新流程.
	
	_dom.bglist.b1 = new createjs.Bitmap preload.getResult("bg-70")
	_dom.bglist.b2 = new createjs.Bitmap preload.getResult("bg-80")
	_dom.bglist.b3 = new createjs.Bitmap preload.getResult("bg-90")
	_dom.bglist.b4 = new createjs.Bitmap preload.getResult("bg-00")
	
	# _dom.bgdom.My = 0
	_dom.bglists.b1 = _dom.bglist.b1.clone()
	_dom.bglists.b1.My = _dom.bglists.b1.y = 0
	_dom.bglists.b2 = _dom.bglist.b2.clone()
	_dom.bglists.b2.My = _dom.bglists.b2.y = 1136
	_dom.bglists.b3 = _dom.bglist.b3.clone()
	_dom.bglists.b3.My = _dom.bglists.b3.y = 1136
	_dom.bglists.b4 = _dom.bglist.b4.clone()
	_dom.bglists.b4.My = _dom.bglists.b4.y = 1136
	_dom.bgdom.alpha = 0


	_dom.bgdom.addChild _dom.bglists.b1,_dom.bglists.b2,_dom.bglists.b3,_dom.bglists.b4
	stage.addChild _dom.bgdom
	stage.update()
	starBG = true
	# $(".decade").prepend preload.getResult("pop")
	
	# $(".selectres").show()

	bindDecade()

# 年代选择器
bindDecade = ->
	$(".decade .box")[0].addEventListener('touchstart',detouchstar)
	$(".decade .box")[0].addEventListener('touchmove',detouchmove)
	$(".decade .box")[0].addEventListener('touchend',detouchend)
	$(".decade .prev").click ->
		movePrevDecade()
	$(".decade .next").click ->
		moveNextDecade()
	$("#homenext").click ->
		showSecondFrame()

_oldy = 0
_cmh = 20
detouchstar = (evt)->
	evt.preventDefault()
	_oldy = evt.touches[0].pageY

detouchmove = (evt)->
	evt.preventDefault()
	# console.log evt.touches[0].pageY,_oldy
	moveNextDecade() if (evt.touches[0].pageY - _oldy) > _cmh
	movePrevDecade() if (evt.touches[0].pageY - _oldy) < -_cmh

detouchend = (evt)->
	$(".decade .box")[0].addEventListener('touchstart',detouchstar)
	$(".decade .box")[0].addEventListener('touchmove',detouchmove)

removeListenter = ->
	$(".decade .box")[0].removeEventListener('touchstar',detouchstar)
	$(".decade .box")[0].removeEventListener('touchmove',detouchmove)
	# $(".decade .box")[0].removeEventListener('touchend',detouchend)
moveNextDecade = ->
	removeListenter()
	# console.log "next"
	$e = $(".decade .boxlist .on").prev()
	if $e.is(".item") and $e.index() isnt 0
		$(".decade .boxlist .item").removeClass 'on'
		$e.addClass 'on'
		index = $e.index()-1
		$(".decade .boxlist").css "-webkit-transform": "translate3d(0px, -"+index*2+"rem, 0px)"
		moveDeBG index 
	
movePrevDecade = ->
	removeListenter()
	# console.log "prev"
	$e = $(".decade .boxlist .on").next()
	if $e.is ".item"
		$(".decade .boxlist .item").removeClass 'on'
		$e.addClass 'on'
		index = $e.index()-1
		$(".decade .boxlist").css "-webkit-transform": "translate3d(0px, -"+index*2+"rem, 0px)"
		moveDeBG index

_remendIndex = 0
moveDeBG = (index)->
	# _dom.bgdom.My = -index*canvas.height
	_remendIndex = index
	if index is 0
		_dom.bglists.b1.My = 0
		_dom.bglists.b2.My = 1136
		_dom.bglists.b3.My = 1136
		_dom.bglists.b4.My = 1136
	if index is 1
		_dom.bglists.b1.My = 0
		_dom.bglists.b2.My = 0
		_dom.bglists.b3.My = 1136
		_dom.bglists.b4.My = 1136
	if index is 2
		_dom.bglists.b1.My = 0
		_dom.bglists.b2.My = 0
		_dom.bglists.b3.My = 0
		_dom.bglists.b4.My = 1136
	if index is 3
		_dom.bglists.b1.My = 0
		_dom.bglists.b2.My = 0
		_dom.bglists.b3.My = 0
		_dom.bglists.b4.My = 0



starBGshow = ->
	_dom.bgdom.alpha += 0.03
	if _dom.bgdom.alpha >= 1
		_dom.bgdom.alpha = 1
		starBG = false
		$(".homepage").show()
		$(".selectde").removeClass 'hidethis'

# 选择热水器画面.
showSecondFrame = ->
	$(".selectde").removeClass 'hidethis'
	$(".selectde").addClass 'hidethis'
	$(".homepage").hide()
	$(".selectres").show()
	createRSQlist()
	setTimeout ->
		$(".selectres").addClass 'showthis'
	,1
selectRSQTo = (e)->
	# alert "aaa:#{e}"
	$(".selectres").removeClass 'showthis'
	setTimeout ->
		$(".selectres").hide()
	,200
	_dom.rsqdom = new createjs.Bitmap preload.getResult e
	console.log $(".decade .on").index()
	index = $(".decade .on").index()-1
	if index is 0
		_dom.rsqdom.x = 400
		_dom.rsqdom.y = 140
	if index is 1
		_dom.rsqdom.x = 410
		_dom.rsqdom.y = 100
	if index is 2
		_dom.rsqdom.x = 240
		_dom.rsqdom.y = 80
	if index is 3
		_dom.rsqdom.x = 100
		_dom.rsqdom.y = 440
	_dom.rsqdom.alpha = 0

	_dom.rsqrdom = new createjs.Bitmap preload.getResult e+'-r'
	_dom.rsqrdom.x = (canvas.width - preload.getResult(e+'-r').width)/2
	_dom.rsqrdom.My = (canvas.height - (canvas.height - preload.getResult(e+'-r').height)*2/3)/40
	_dom.rsqrdom.y = canvas.height
	_dom.rsqrdom.alpha = -1


	stage.addChild _dom.rsqdom,_dom.rsqrdom
	stage.update()

	RSQfade = true
	RSQRfade = true

	_dom.rsqrdom.addEventListener('click',ReadyStarGame)

RSQfadeIn = ->
	_dom.rsqdom.alpha += 0.05
	RSQfade = false if _dom.rsqdom.alpha >= 1

_rsqlfx = true
RSQRfadeIn = ->
	_dom.rsqrdom.y -= _dom.rsqrdom.My
	_dom.rsqrdom.alpha += 0.05
	RSQRfade = false if _dom.rsqrdom.alpha >= 1
RSQRfadeOut = ->
	RSQRfade = false
	_dom.rsqrdom.y += _dom.rsqrdom.My
	_dom.rsqrdom.alpha -= 0.05
	RSQRfadeO = false if _dom.rsqrdom.alpha <= -1

fadeOutSDBGFun = ->
	_dom.sdbg.alpha += 0.01
	if _dom.sdbg.alpha >= 1
		fadeOutSDBG = false
		openGameNextStep()


createRSQlist = ->
	return false if $(".rxqlist .slide").length >= rsqarr.length
	for i in [1..15]
		items = $("<div>").addClass 'slide'
		# items.click ->
		# 	alert "bb?"
		$(".rxqlist .slide-group").append items if i%3 is 0 or i is 1
		item = $("<div>").addClass 'item'
		# console.log preload.getResult 'rsq-'+i
		item.attr 'rel','rsq-'+i
		item.append preload.getResult 'rsq-'+i
		$(".rxqlist .slide-group .slide").eq(Math.ceil(i/3)-1).append item
		# item.attr "onclick","selectRSQ(this)"
		item.click ->
			if isScrolling_move
				isScrolling_move = false
				return ''
			selectRSQTo $(this).attr 'rel'

	$tm = $(".rxqlist .slide-group .slide").eq(Math.ceil(15/3))
	console.log $tm.find(".item").length
	$tm.remove() if $tm.find(".item").length <= 0
	document.querySelector('#mySlider').addEventListener('slide', myFunction) if $("#mySlider").length>0

	$(".rxqlist .prev").click ->
		return false if _lsxm is 0 
		lw = $("#mySlider").width()
		$("#mySlider .slide-group").css
			"-webkit-transition": "0.2s"
			"transition": "0.2s"
			"-webkit-transform": "translate3d(-#{(_lsxm-1)*lw}px, 0px, 0px)"
		_lsxm--
	$(".rxqlist .next").click ->
		return false if _lsxm is $("#mySlider .slide").length-1
		lw = $("#mySlider").width()
		$("#mySlider .slide-group").css
			"-webkit-transition": "0.2s"
			"transition": "0.2s"
			"-webkit-transform": "translate3d(-#{(_lsxm+1)*lw}px, 0px, 0px)"
		_lsxm++

_lsxm = 0
myFunction = (evt)->
	# console.log evt.detail.slideNumber
	_lsxm = evt.detail.slideNumber


_openMessage = {}
openMessage = ->
	$(".gamestar").removeClass "hidethis"
	_openMessage = setTimeout ->
		$(".gamestar").addClass "hidethis"
	,4000
openGameNextStep = ->
	$(".gamestarpage").show()

startGame = ->
	stage.addEventListener('mousedown',Gametouchstart)
	stage.addEventListener('pressup',Gametouchend)
	stage.addEventListener('pressmove',Gametouchmove)

	openMessage()

	_dom.sdlayer = new createjs.Container()
	_dom.sdbg = new createjs.Bitmap preload.getResult 'mistmark'
	_dom.sdbg.alpha = 0
	_dom.sdbgmark = new createjs.Shape()
	if _fromPC
		# _dom.test = new createjs.Bitmap localimg
		_dom.sdlayer.addChild _dom.bglist.b1.clone()
	else
		_dom.sdlayer.addChild _dom.bglists.b1.clone(),_dom.bglists.b2.clone(),_dom.bglists.b3.clone(),_dom.bglists.b4.clone(),_dom.rsqdom.clone()
	stage.addChild _dom.sdbg,_dom.sdlayer
	updateCacheImage false
	fadeOutSDBG = true

	$("#reset").click ->
		# alert "clear"
		_dom.sdbgmark.graphics.clear()
		updateCacheImage true
	$("#gameend").click ->
		GameOver()



GameOver = ->
	stage.removeEventListener('mousedown',Gametouchstart)
	stage.removeEventListener('pressup',Gametouchend)
	stage.removeEventListener('pressmove',Gametouchmove)
	# alert "remove"
	$(".gamestarpage").hide()
	$('.gameend').removeClass 'hidethis'

	getdata64()

	$("#reload").click ->
		window.location.reload()
	$(".weixinshare").click ->
		$(".weixinshare").hide()
	$("#sharebtns").click ->
		if _shareimgurl is ""
			alert "请等待上传完成后再分享,不要着急哦."
			return ''
		$(".gameend").addClass 'showshare'
	$("[data-weixin]").click ->
		$(".weixinshare").show()
	# bind 分享文案.
	

BindShare = (content,url = window.location.href,pic)->
	list = 
		"qweibo":"http://v.t.qq.com/share/share.php?title={title}&url={url}&pic={pic}"
		"renren":"http://share.renren.com/share/buttonshare?title={title}&link={url}&pic={pic}"
		"weibo":"http://v.t.sina.com.cn/share/share.php?title={title}&url={url}&pic={pic}"
		"qzone":"http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url={url}&title={title}&pic={pic}"
		"facebook":"http://www.facebook.com/sharer/sharer.php?s=100&p[url]={url}}&p[title]={title}&p[summary]={title}&pic={pic}"
		"twitter":"https://twitter.com/intent/tweet?text={title}&pic={pic}"
		"kaixin":"http://www.kaixin001.com/rest/records.php?content={title}&url={url}&pic={pic}"
		"douban":"http://www.douban.com/share/service?bm=&image={pic}&href={url}&updated=&name={title}"
	$("[data-share]").unbind('click').bind 'click', ->
		fShare list[$(this).data('share')],content,url,pic
fShare = (url,content,sendUrl,pic = "")->
	# 分享内容
	content = content
	shareContent = encodeURIComponent content
	pic = encodeURIComponent pic
	url = url.replace "{title}",shareContent
	url = url.replace "{pic}",pic
	# 分享地址
	backUrl = encodeURIComponent sendUrl
	url = url.replace "{url}",backUrl
	# console.log url
	window.open url,'_blank'




oldPt = {}
oldMidPt = {}
Gametouchstart = (evt)->
	console.log evt
	oldPt = new createjs.Point(stage.mouseX, stage.mouseY)
	oldMidPt = oldPt
Gametouchend = (evt)-> 
	updateCacheImage true

Gametouchmove = (evt)->
	console.log oldPt,oldMidPt

	midPoint = new createjs.Point(oldPt.x + stage.mouseX >> 1, oldPt.y + stage.mouseY >> 1)
	_dom.sdbgmark.graphics
	# .clear()
	.setStrokeStyle(40, "round", "round")
	.beginStroke("rgba(0,0,0,0.85)")
	.moveTo(midPoint.x, midPoint.y)
	.curveTo(oldPt.x, oldPt.y, oldMidPt.x, oldMidPt.y)

	oldPt.x = stage.mouseX
	oldPt.y = stage.mouseY
	oldMidPt.x = midPoint.x
	oldMidPt.y = midPoint.y

	updateCacheImage true
updateCacheImage = (update)->
	if update
		# destination-out
		_dom.sdbgmark.updateCache()
	else
		_dom.sdbgmark.cache 0,0,canvas.width,canvas.height

	maskFilter = new createjs.AlphaMaskFilter(_dom.sdbgmark.cacheCanvas)
	_dom.sdlayer.filters = [maskFilter]

	if update
		_dom.sdlayer.updateCache 0,0,canvas.width,canvas.height
	else
		_dom.sdlayer.cache 0,0,canvas.width,canvas.height

	stage.update()

ReadyStarGame = ->
	RSQRfadeO = true
	startGame()



# 隐藏loading
# 
hideloadAnimate = ->
	# console.log "??"
	if _dom.load.alpha < -0.1
		hideload = false
		showFirstFrame()
	_dom.load.alpha -= 0.03


tick = (e)->
	stage.update e
	hideloadAnimate() if hideload
	starBGshow() if starBG
	RSQfadeIn() if RSQfade
	RSQRfadeIn() if RSQRfade
	RSQRfadeOut() if RSQRfadeO
	fadeOutSDBGFun() if fadeOutSDBG

	if _dom.bgdom?
		for i in [0..._dom.bgdom.getNumChildren()]
			temp = _dom.bgdom.getChildAt i
			continue if temp.My is temp.y
			# console.log temp.My,temp.y
			temp.y -= 50 if temp.My < temp.y 
			temp.y += 50 if temp.My > temp.y 
			temp.y = temp.My if Math.abs(temp.y - temp.My) <= 50*1.5
				

