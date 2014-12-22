# @codekit-prepend "../js/zepto.js"
# @codekit-prepend "js/vendor/touch.js"
# @codekit-prepend "js/vendor/exif.js"
# @codekit-prepend "../js/libs/sliders.js"
# @codekit-prepend "../js/libs/megapix-image.js"
# @codekit-prepend "coffee/global"
# @codekit-prepend "css3Prefix"
# @codekit-prepend "touch-ctrl"
# @codekit-prepend "wechat"


# _wechat =
# 	"appid": ""
# 	"img_url": "http://campaign.douban.com/files/campaign/casarte_NOCO/img/pro-1.png"
# 	"img_width": 200
# 	"img_height": 200
# 	"link": "http://campaign.douban.com/files/campaign/casarte_NOCO/default.html"
# 	"desc": "test1"
# 	"title": "test"

preload = {}
loadList = [
	{id: "logo", src:"img/logo.png"}
	{id: "bg", src:"img/bg.jpg"}
	{id: "pro-1", src:"img/pro-1.png"}
	{id: "pro-2", src:"img/pro-2.png"}
	{id: "pro-3", src:"img/pro-3.png"}
	{id: "co", src:"img/co.png"}
	{id: "co2", src:"img/co2.png"}
	{id: "code", src:"img/code.png"}
	{id: "no", src:"img/no.png"}
	{id: "text-bg", src:"img/text-bg.png"}
	{id: "name-1", src:"img/text-gold.png"}
	{id: "name-2", src:"img/text-silver.png"}
	{id: "name-3", src:"img/text-white.png"}
	{id: "btn-bg", src:"img/btn-bg.png"}
	{id: "input-bg", src:"img/input-bg.png"}
	{id: "upload-bg", src:"img/upload-bg.png"}
	{id: "goodjob", src:"img/goodjob.png"}
	{id: "reg-info", src:"img/reg-info.png"}
	# icon
	{id: "icon-wechat", src:"img/icon-wechat.png"}
	{id: "icon-weibo", src:"img/icon-weibo.png"}
	{id: "icon-qweibo", src:"img/icon-qweibo.png"}
	{id: "icon-douban", src:"img/icon-douban.png"}
	{id: "icon-qzone", src:"img/icon-qzone.png"}
	# template
	{id: "temp-1", src:"img/poster-1.jpg"}
	{id: "temp-1-m", src:"img/poster-1.png"}
	{id: "temp-2", src:"img/poster-2.jpg"}
	{id: "temp-2-m", src:"img/poster-2.png"}
	{id: "temp-3", src:"img/poster-3.jpg"}
	{id: "temp-3-m", src:"img/poster-3.png"}
	{id: "temp-4", src:"img/poster-4.jpg"}
	{id: "temp-4-m", src:"img/poster-4.png"}
	{id: "temp-5", src:"img/poster-5.jpg"}
	{id: "temp-5-m", src:"img/poster-5.png"}
	{id: "temp-6", src:"img/poster-6.jpg"}
	{id: "temp-6-m", src:"img/poster-6.png"}
	# {id: "temp-7", src:"img/poster-7.jpg"}
	# {id: "temp-7-m", src:"img/poster-7.png"}
	# {id: "temp-8", src:"img/poster-8.jpg"}
	# {id: "temp-8-m", src:"img/poster-8.png"}
]

tempMap = [
	{first:{x:150,y:240,color:"#000000",text:"拒绝"},second:{x:150,y:288,color:"#000000",text:"牵手"}}
	{first:{x:170,y:238,color:"#ffffff",text:"远离"},second:{x:170,y:286,color:"#ffffff",text:"关爱"}}
	{first:{x:124,y:252,color:"#ffffff",text:"拒绝"},second:{x:124,y:296,color:"#ffffff",text:"牵手"}}
	{first:{x:156,y:51,color:"#1d5065",text:"远离"},second:{x:156,y:92,color:"#1d5065",text:"关爱"}}
	# {first:{x:214,y:292,color:"#369a02",text:"拒绝"},second:{x:214,y:334,color:"#369a02",text:"牵手"}}
	# {first:{x:214,y:252,color:"#2e9e00",text:"远离"},second:{x:214,y:298,color:"#2e9e00",text:"关爱"}}
	# {first:{x:150,y:232,color:"#23acfc",text:"远离"},second:{x:150,y:282,color:"#23acfc",text:"关爱"}}
	{first:{x:150,y:134,color:"#ffffff",text:"远离"},second:{x:150,y:184,color:"#ffffff",text:"关爱"}}
	{first:{x:150,y:355,color:"#545454",text:"远离"},second:{x:150,y:405,color:"#545454",text:"关爱"}}
]

_Progress = 0
clipicon = null
uploading = false

beginload = ->
	preload = new createjs.LoadQueue()
	preload.on('fileload',handleFileLoad,this)
	preload.on('complete',handleComplete,this)
	preload.loadManifest loadList

handleFileLoad = ->
	_Progress++
	Percentage = Math.ceil((_Progress/loadList.length)*100)
	# console.log Percentage
	$("#loadnum").text Percentage+"%"
	# if _Progress >= loadList.length

_ios7 = false
handleComplete = ->
	# console.log "Load finished",preload

	# ios
	if navigator.userAgent.toLowerCase().indexOf("iphone") > -1
		ios = Math.abs(navigator.userAgent.toLowerCase().split("iphone os ")[1].split(" ")[0].replace(/_/gi,""))
		ios = ios*10 if ios<100
		_ios7 = true if ios < 800
	
	for img in loadList
		$("[data-img="+img.id+"]").append '<img src="'+img.src+'" />'
		$("[data-bg="+img.id+"]").css
			"background-image": "url("+img.src+")"
	
	shareTo()
	# 背景图片
	$("body").css
		"background": "url(img/bg.jpg) no-repeat center center"
		"background-size": "cover"
	$(".logo").css
		"background": "url(img/logo.png) no-repeat top left"
		"background-size": "contain"
	$(".ProD").css
		"background": "url(img/pro-1.png) no-repeat center center"
		"background-size": "contain"

	iconp = $(".page-loading .icon-co")
	clipicon = iconp.clone()
	clipicon.css
		"position": "absolute"
		"z-index": 5001
		"top": iconp.offset().top+"px"
		"left": iconp.offset().left+"px"
	# 复制一个位移动画
	$("body").append clipicon

	$(".page-loading").on ANIMATION_END_NAME, PageloadEnd

	$(".text-note").on "swipeUp", (e)->
		$(".page-process").addClass "moveUp"
		stepPageShow()
		_hmt.push(['_trackEvent', 'home', 'select', 'temp'])
	$(".text-note").on "touchmove", (e)->
		e.preventDefault()
	$(".page-process .star").on TRANSITION_END_NAME, processPageHide

	setTimeout ->
		$(".page-loading").addClass "out"
	, 1000


	# document.querySelector('#mySlider').addEventListener('slide', slide)
	# document.querySelector('#selecttemp').addEventListener('slide', selecttemp)

	$("#mySlider").slider
		loop:true,autoPlay:false,showDot:false
		slide: (a,b)->
			$("#mySlider-name .name-list span").hide()
			$("#mySlider-name .name-list span").eq(b).show()
	$(".page-share").show()
	$("#mySlider2").slider
		loop:true,autoPlay:false,showDot:false
		slide: (a,b)->
			$("#mySlider2-name .name-list span").hide()
			$("#mySlider2-name .name-list span").eq(b).show()
	$(".page-share").hide()
	$("#mySlider a,#mySlider2 a").on "click",(e)->
		imgname = $(this).attr("href").replace("#","")
		showpop imgname
		_hmt.push(['_trackEvent', 'home', 'selectProduct', imgname])
	# $(".page-step").show()
	# $("#selecttemp").slider
		# loop:true,autoPlay:false,showDot:false
	# $(".page-step").hide()
	$(".page-share .pro-show").on "touchend", showpop
	$(".wechat-share").on "touchend", showWechat

	$(".select-temp").on "touchend",inputDeclaration
	$(".select-img").on "touchend",inputIMGTEXT
	$(".reset").on "touchend", ResetStepBar
	$(".uploadbtn").on "touchend", uploadFun
	$(".submit").on "touchend", uploadINFO
	CreateCanvas()

	# 分享内容.

# create canvas
canvas = null
stage = null
_temp = 0
_dom = {}
CreateCanvas = ->
	canvas = my.getid "ps"
	stage = new createjs.Stage canvas
	# open touch 
	createjs.Touch.enable stage
	createjs.Ticker.setFPS 30

	canvas.addEventListener "touchstart",_touch.star
	canvas.addEventListener "touchmove",_touch.move
	canvas.addEventListener "touchend",_touch.end

PageloadEnd = (e)->
	$(".page-loading").hide()

	clipicon.on TRANSITION_END_NAME, iconcoEnd

	clipicon.css
		"top": $(".page-init .icon-co").offset().top
		"left": (clipicon.offset().left+1)
	checkAndroid()

iconcoEnd = ->
	return false if not clipicon?
	# clipicon.hide()

	co = $(".page-init .icon-co")
	co.css
		"opacity": 1
	
	$(".ProD").css
		"opacity": 1
	
	$(".page-init p").show()
	$(".page-init .note-warring").show()

	noteH = 20
	if $(".ProD").height()/$(".ProD").width() > 5
		noteH = 40

	$(".page-init span.note")
	.css
		"top": clipicon.offset().top - noteH
	.show()
	$(".swipeBox").on "swipeUp", ->
		$(".page-init .note-warring").hide()
		$(".page-init .note").hide()
		co.addClass "toco2"
		setTimeout ->
			co.addClass "toco2img"
		,500
		_hmt.push(['_trackEvent', 'home', 'cotoco2', 'swipeUp'])
	$(".swipeBox").on "touchmove", (e)->
		e.preventDefault()

	co.on ANIMATION_END_NAME, FirstPage

	clipicon.remove()
	clipicon = null

FirstPage = ->
	$(".page-init .note-success").show()
	setTimeout ->
		$(".page-init").on TRANSITION_END_NAME, (e)->
			$(".page-init").hide()
		$(".page-init").addClass "fadeOutBig"
		$(".page-process").on TRANSITION_END_NAME, (e)->
			$("#icon-no").addClass "stamp"
		$(".page-process").addClass "on"

		$("#text1").text tempMap[0].first.text
		$("#text2").text tempMap[0].second.text
	,800

lastTime = 0
slide = (e)->
	# console.log "slide",e.detail.slideNumber,lastTime
	$(".name-list span").hide()
	$(".name-list span").eq(e.detail.slideNumber).show()
	if e.detail.slideNumber is 0 and lastTime is 0
		$(".slide-group",e.target).css
			"transition-duration": "0s"
			"-webkit-transition-duration": "0s"
			"-webkit-transform": "translate3d(-"+($(".slide-group",e.target).width()*(2))+"px, 0px, 0px)"
		$(".name-list span").hide()
		$(".name-list span").eq(2).show()
	if e.detail.slideNumber > 2
		# console.log "back to ", e.detail.slideNumber, e.detail.slideNumber-3
		$(".slide-group",e.target).css
			"transition-duration": "0s"
			"-webkit-transition-duration": "0s"
			"-webkit-transform": "translate3d(-"+($(".slide-group",e.target).width()*(e.detail.slideNumber-3))+"px, 0px, 0px)"
	lastTime = e.detail.slideNumber
	return 
	$("#mySlider .slide-left").show()
	$("#mySlider .slide-right").show()
	$("#mySlider .slide-right").hide() if e.detail.slideNumber is 0
	$("#mySlider .slide-left").hide() if e.detail.slideNumber is $("#mySlider .slide").length-1


stepPageShow = ()->
	$(".page-step")
processPageHide = (e)->
	return if $(".page-process").attr("class").indexOf("moveUp") < 0
	$(".page-process").hide()
	$(".page-step").show()
	setTimeout ->
		$(".page-step").addClass "on"
		$(".step-1").removeClass "none"

selecttemp = (e)->
	$("#selecttemp .slide-normal").removeClass "on"
	$("#selecttemp .slide-normal").eq(e.detail.slideNumber).addClass "on"
	$(".select-temp").attr "rel",e.detail.slideNumber

	$("#text1").text tempMap[e.detail.slideNumber].first.text
	$("#text2").text tempMap[e.detail.slideNumber].second.text


# step-1
inputDeclaration = (e)->
	selectNumber = parseInt $("#selecttemp .on").index()
	_temp = selectNumber
	_dom.mark = $("#selecttemp .on").data "img"
	mark = new createjs.Bitmap preload.getResult _dom.mark
	stage.removeAllChildren()
	stage.addChild mark
	stage.update()
	
	stepBar 0
	$(".step-1").on ANIMATION_END_NAME, ->
		$(".step-1").addClass "over"
		$(".step-2").removeClass("none fadeOut").addClass "fadeIn"
	$(".step-1").addClass "fadeOut"
	my.getid("uploadimg").addEventListener 'change',(e)->
		files = this.files
		# alert(files)
		if files.length > 0
			putToCanvas files[0]
	_hmt.push(['_trackEvent', 'home', 'selectTemplate', 'Template'])


_uploading = false
# step-2
inputIMGTEXT = (e)->
	first = $("[name=first]").val()
	second = $("[name=second]").val()

	# console.log uploading,_uploading

	return alert "请输入\""+$("[name=first]").prev().text()+"\"的内容." if first.length <= 0
	return alert "请输入\""+$("[name=second]").prev().text()+"\"的内容." if second.length <= 0
	# return alert "如果超过5秒,仍然无法进入下一步,表示您的系统拒绝上传请求,建议使用浏览器打开." if _uploading
	if uploading
		return showNoteAlert "waiting"

	stepBar 1
	$(".step-2").on ANIMATION_END_NAME, ->
		$(".step-2").removeClass("fadeIn fadeOut").addClass "over"
		$(".step-3").removeClass("none").addClass "fadeIn"
		$(".step-2").off ANIMATION_END_NAME
	$(".step-2").removeClass("fadeIn").addClass "fadeOut"

	_dom.first = new createjs.Text first,"normal 30px Helvetica",tempMap[_temp].first.color
	_dom.first.maxWidth = 360
	_dom.first.lineHeight = 46
	_dom.first.textAlign = "left"
	_dom.first.x = tempMap[_temp].first.x
	_dom.first.y = tempMap[_temp].first.y

	_dom.second = new createjs.Text second,"normal 30px Helvetica",tempMap[_temp].second.color
	_dom.second.maxWidth = 360
	_dom.second.lineHeight = 46
	_dom.second.textAlign = "left"
	_dom.second.x = tempMap[_temp].second.x
	_dom.second.y = tempMap[_temp].second.y

	stage.addChild _dom.first,_dom.second
	stage.update()
	_hmt.push(['_trackEvent', 'home', 'inputText', 'uploadimg'])

# step-3
uploadFun = ->
	dataURL = canvas.toDataURL("image/png")

	postajax dataURL
	$(".step-3").on ANIMATION_END_NAME, ->
		$(".step-3").removeClass("fadeIn fadeOut").addClass "over"
		$(".step-4").removeClass("none").addClass "fadeIn"
		$(".step-3").off ANIMATION_END_NAME
	$(".step-3").removeClass("fadeIn").addClass "fadeOut"
	stepBar 2
	_hmt.push(['_trackEvent', 'home', 'uploadWork', 'work'])

# step-4
uploadINFO = ->
	return alert("姓名不能为空!") if $("[name=username]").val().length <= 0
	return alert("手机号码必须是11位数字!") if !/^1[3-8]\d{9}$/g.test $("[name=mobile]").val()
	regajax {username:$("[name=username]").val(),mobile:$("[name=mobile]").val()}
	_hmt.push(['_trackEvent', 'home', 'uploadInfo', 'username-and-phonenumber'])
	# regajax $("[name=reg]").serializeArray()
	
uploadINFOafter = ->
	# 分享
	

	$(".step-4").on ANIMATION_END_NAME, ->
		$(".step-4").removeClass("fadeIn fadeOut").addClass "over"
		# $(".step-4").removeClass("none").addClass "fadeIn"
		$(".step-4").off ANIMATION_END_NAME
		$(".page-step").removeClass "on"
		$(".page-step").on ANIMATION_END_NAME, (e)->
			$(".page-share").show().addClass "fadeIn"	
			$(".page-step").hide().off ANIMATION_END_NAME
		
	$(".step-4").removeClass("fadeIn").addClass "fadeOut"
	stepBar 3



delayRun = null
putToCanvas = (file)->
	# return if !canvas
	uploading = true

	url = my.createObjectURL file

	return _ios7putToCanvas(file) if _ios7
	delayRun = setTimeout ->
		putIMGto $img,false if $(".step-2.over").length <= 0
	,4000
	$img = new Image()
	$img.onload = ->
		EXIF.getData $img, ->
			info = EXIF.getTag $img, "Orientation"
			if info? and info is 6
				putIMGto $img,true if delayRun?
			else
				putIMGto $img,false if delayRun?
	$img.onerror = ->
		alert "抱歉,权限不足无法使用相册或相机照片."
	$img.src = url
	
_ios7putToCanvas = (file)->
	mpImg = new MegaPixImage(file)
	ios7 = document.createElement("canvas")
	mpImg.render ios7, { maxWidth: 360, maxHeight: 450 }, ->
		dataURL = ios7.toDataURL("image/png")
		$img = new Image()
		$img.onload = ->
			putIMGto $img,false
		$img.src = dataURL

_putIMGto = false
putIMGto = ($img,ori)->
	clearTimeout delayRun
	return "" if _putIMGto
	createjs.Ticker.removeEventListener "tick", tick
	createjs.Ticker.addEventListener "tick", tick
	_putIMGto = true
	uploading = false
	delayRun = null
	# console.log $img.width,$img.height
	scale = 360 / $img.width
	img = new createjs.Bitmap $img
	mark = new createjs.Bitmap preload.getResult _dom.mark+"-m"

	if ori
		scale = 360 / $img.height
		img.rotation = 90
		# img.regX = $img.width/2
		img.regY = $img.height
	img.scaleX = img.scaleY = scale if !debug
	stage.removeAllChildren()
	stage.addChild img,mark
	stage.update()
	_touch.dom = img

stepBar = (Number)->
	$(".step-bar .item").eq(Number).addClass "over"
	$(".step-bar .item").eq(Number+1).addClass "on"

ResetStepBar = ->
	$(".step-bar .item").removeClass "on over"
	$(".step-bar .item").eq(0).addClass "on"
	$(".step-1,.step-2,.step-3,.step-4").removeClass("fadeIn fadeOut over").addClass "none"
	$(".step-1").removeClass "none"
	document.uploadimgform.reset()
	_uploading = false
	uploading = false
	_putIMGto = false
	_hmt.push(['_trackEvent', 'home', 'ResetStep', 'gotoStepOne'])


showpop = ->
	# $("body").css "overflow","hidden"
	$(".pop").remove()
	pop = $("<div>").addClass "pop"
	pop.append "<img src='img/pop.png' />"
	close = $("<div>").addClass "close"
	pop.append close
	_slider = $("<div>")
	i = 1
	for item in ["http://www.casarte.cn/wap.php?mod=goods&goods_id=159","http://www.casarte.cn/wap.php?mod=goods&goods_id=183","http://www.casarte.cn/wap.php?mod=goods&goods_id=182"]
		_slider.append '<div><a href="'+item+'" target="_blank"><img lazyload="img/pro-'+i+'.png" /></a></div>'
		i++
	pop.append _slider
	namelist = $("<div>").addClass "pro-name"
	# namelist.append "<p class='black'>卡萨帝传奇系列燃气热水器</p>"
	_namelist = $("<div>").addClass "name-list"
	_namelist.append "<span class='gold'><img src='img/text-gold.png'></span>"
	_namelist.append "<span class='silver'><img src='img/text-silver.png'></span>"
	_namelist.append "<span class='white'><img src='img/text-white.png'></span>"
	namelist.append _namelist
	pop.append namelist
	$("body").append pop
	_slider.slider
		loop:true,autoPlay:false,showDot:false
		slide: (a,b)->
			$(".name-list span",pop).hide()
			$(".name-list span",pop).eq(b).show()


	close.on "touchend",(e)->
		pop.remove()
		# $("body").css "overflow","auto"

showWechat = ->
	$(".wechat").remove()
	wechat = $("<div>").addClass "wechat"
	$("body").append wechat
	wechat.on "touchend",(e)->
		wechat.remove()
	_hmt.push(['_trackEvent', 'home', 'share', "weixin"])
showNoteAlert = (classname)->
	$("."+classname).remove()
	wechat = $("<div>").addClass classname
	$("body").append wechat
	wechat.on "touchend",(e)->
		wechat.remove()
	_hmt.push(['_trackEvent', 'home', 'error', classname])
showWechatNote = ->
	$(".wechat-note").remove()
	wechat = $("<div>").addClass "wechat-note"
	$("body").append wechat
	wechat.on "touchend",(e)->
		wechat.remove()
	_hmt.push(['_trackEvent', 'home', 'error', "android4.4,cannt upload."])


checkAndroid = ->
	nav = navigator.userAgent.toLowerCase()
	# alert nav.indexOf "android" > -1
	if (nav.indexOf "android" > -1) and _wechat_bool
		arr = Math.abs(navigator.userAgent.toLowerCase().split("android")[1].split(";")[0].replace(".",""))
		arr = if arr<100 then arr*10 else arr
		if arr > 440
			showNoteAlert("android-note")


tick = (evt)->
	stage.update()

$(document).ready ->
	# ios5+
	window.scrollTo 0,1
	$(".page-loading .content").on ANIMATION_END_NAME, (e)->
		beginload()



# ajax
postajax = (data)->
	# http://battlepit.douban.com/custom/casarte_NOCO/upload ready success
	# console.log data
	# return false
	t = new Date()
	$.ajax
		type:"post"
		dataType:"json"
		url:"http://battlepit.douban.com/custom/casarte_NOCO/upload"
		data:[{name:"image",value:data}]
		success: (msg)->
			# console.log msg.src
			# console.log msg,new Date()-t
			shareTo msg.src
			window.parent.shareToPs msg.src if window.parent and window.parent.shareToPs

		error: (msg)->
			# console.log msg

regajax = (data)->
	# doesnt work.
	coll = new collClient "http://campaign.douban.com","casarte_NOCO","casarte_NOCO_info","17dffd1a73b011e4b337"
	post_data = JSON.stringify data
	coll.post post_data , (msg)->
		# console.log msg
		uploadINFOafter()
	return
	# $.ajax
	# 	type:"post"
	# 	dataType:"json"
	# 	url:"http://campaign.douban.com/api/casarte_NOCO/coll/casarte_NOCO_info?secret=17dffd1a73b011e4b337"
	# 	data:[{name:"data",value:post_data}]
	# 	success: (msg)->



shareTo = (img)->
	content = "安全大搜捕-代号NOCO"
	url = "http://campaign.douban.com/files/campaign/casarte_NOCO/default.html"
	BindShare content,url,"http://campaign.douban.com/files/campaign/casarte_NOCO/img/pro-1.png"
	if img
		url = "http://campaign.douban.com/files/campaign/casarte_NOCO/share.html#"+img
		BindShare content,url,img
		# _wechat.title = _wechat_f.title = "test2"
		_wechat.link = _wechat_f.link = url
		# _wechat.img_url = img
		# _wechat_f.img_url = img
		# _wechat.img_width = _wechat_f.img_width = 360
		# _wechat.img_height = _wechat_f.img_height = 450
		shareFriend()
		shareTimeline()


BindShare = (content,url = window.location.href,pic)->
	list = 
		"qweibo":"http://v.t.qq.com/share/share.php?title={title}&url={url}&pic={pic}"
		"renren":"http://share.renren.com/share/buttonshare.do?title={title}&link={url}&pic={pic}"
		"weibo":"http://v.t.sina.com.cn/share/share.php?title={title}&url={url}&pic={pic}"
		"qzone":"http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url={url}&title={title}&pic={pic}"
		"facebook":"http://www.facebook.com/sharer/sharer.php?s=100&p[url]={url}}&p[title]={title}&p[summary]={title}&pic={pic}"
		"twitter":"https://twitter.com/intent/tweet?text={title}&pic={pic}"
		"kaixin":"http://www.kaixin001.com/rest/records.php?content={title}&url={url}&pic={pic}"
		"douban": "http://www.douban.com/share/service?bm=&image={pic}&href={url}&updated=&name={title}"
	# $("a[data-share]").off('click').on 'click', ->
	$("a[data-share]").each (e)->
		$(this).attr "href",fShare list[$(this).data('share')],content,url,pic
	$("a[data-share]").click (e)->
		_hmt.push(['_trackEvent', 'home', 'share', $(this).data('share')])

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
	# window.location.href url
	return url

