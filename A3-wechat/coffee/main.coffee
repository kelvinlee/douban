# here is your CoffeeScript.
# @codekit-prepend "coffee/plugs.coffee";
# @codekit-prepend "loading.coffee";

loading = new loading()
# public for playing.
_playing = false
_pause = false
_playingradio = {car:"",idx:-1,idt:-1}
_page = "360"
_pointList = 
	"a32":[
		{times:"23''",header:"s-1",mp3:"http://audi.mconnect.cn/A3-wechat/mp3/s-1.mp3",name:"胡玲",title:"凤凰卫视北京站首席记者",t1:"更有型的外观设计",t2:"全新奥迪A3 Sportback拥有轿跑般的⻋顶线条 硬朗的⻋⾝腰线,以及动感的掀背式造型。独特的箭头造型前⼤灯和简洁的分体式尾灯宣扬着你毫不妥协的态度。短暂的⺫光接触,便⾜以令你⼼驰神往。",t3:"全新奥迪A3 Sportback与全新奥迪A3 Limousine的区别在于哪⾥里?",q1:"轿跑般的⻋顶线条、硬朗的⻋⾝腰线,以及动感的掀背式造型",q2:"除了⼀个是两厢,⼀个是三厢以外,没什么区别",answer:0}
		{times:"22''",header:"s-2",mp3:"http://audi.mconnect.cn/A3-wechat/mp3/s-2.mp3",name:"李黎",title:"网易副总裁",t1:"更轻盈的奥迪ultra轻量技术",t2:"全新奥迪A3 Sportback使⽤ultra轻量化⻋⾝技术,运⽤创新复合材料,提升⻋⾝的钢性,同时减少不必要的能量损耗,实现了灵活操控与安全强度的完美统⼀,带来更绿色的驾乘体验。",t3:"全新奥迪A3 Sportback使⽤的ultra轻量化⻋⾝技术,有什么作⽤?",q1:"全部使⽤碳纤维材质,⼤幅降低⻋⾝重量",q2:"提升⻋⾝的钢性,减少不必要的能量损",answer:1}
	]
	"a33":[
		{times:"15''",header:"l-1",mp3:"http://audi.mconnect.cn/A3-wechat/mp3/l-1.mp3",name:"崔莉莉",title:"搜狐集团高级副总裁",t1:"更有型的外观设计",t2:"全新奥迪A3 Limousine将经典三厢设计与双⻔轿跑理念完美结合,理所当然配备的LED⻋灯,性感明快的腰线,与两厢相⽐更加锐利的上升式尾部造型,都赋予了TA更加灵活、动 感的⾝姿。",t3:"与两厢版相⽐,全新奥迪A3 Limousine外观的最⼤特点是什么?",q1:"锐利的上升式尾部造型",q2:"配备的LED⻋灯",answer:0}
		{times:"22''",header:"l-2",mp3:"http://audi.mconnect.cn/A3-wechat/mp3/l-2.mp3",name:"张京秋",title:"爱卡汽车创始人",t1:"更轻盈的奥迪ultra轻量技术",t2:"驾驶全新奥迪A3 Limousine时,灵活是印⼊脑海的第⼀印象,强劲则是随之⽽来的直观感受。奥迪ultra轻量化技术,使⽤复合材料让⻋⾝更轻,但更加坚固安全,只为给你带来完美的驾驭感受。",t3:"全新奥迪A3 Limousine使⽤的奥迪ultra轻量化技术,究竟是什么让⻋⾝更轻?",q1:"创新材料和⻋⾝框架",q2:"碳纤维",answer:0}
	]
# ,t1:"",t2:"",t3:"",q1:"",q2:"",answer:0

_poList =
	"a32": [
		{times:"14''",header:"s-3",mp3:"http://audi.mconnect.cn/A3-wechat/mp3/s-3.mp3",name:"张齐",title:"凤凰网汽车事业部总经理",t1:"更智能的MMI®多媒体交互系统",t2:"全新奥迪A3 Sportback搭载新⼀代MMI®多媒体交互系统。特有的触控轮,让导航和打电话变得轻松惬意。相信有那么⼀瞬间,你将体会到亲⼿触碰未来的感觉。",t3:"新⼀代MMI®系统怎样使全新奥迪A3 Sportback重新定义了⻋载信息娱乐系统?",q1:"新⼀代MMI®按钮更少,操作更直观便捷",q2:"新⼀代MMI®可以显⽰示⻋辆当前的时速",answer:0}
		{times:"20''",header:"s-4",mp3:"http://audi.mconnect.cn/A3-wechat/mp3/s-4.mp3",name:"刘晓科",title:"新浪全国商业运营总经理",t1:"更浑厚的Bang&Olufsen音响",t2:"为全新奥迪A3 Sportback度⾝定制的B&O音响系统,配备5.1环绕⽴体声和14个扬声器,震撼的效果仿佛⾝临其境。音量可随⻋速和噪音变化⾃动调整,让车舱秒变音乐秀场。",t3:"为全新奥迪A3 Sportback度⾝定制的B&O音响系统,有什么独特作⽤?",q1:"音量可随⻋速和噪音变化⾃动调整",q2:"可以进⾏录音",answer:0}
		{times:"19''",header:"s-5",mp3:"http://audi.mconnect.cn/A3-wechat/mp3/s-5.mp3",name:"云鹏",title:"极驾客执行主编",t1:"更敏捷的S tronic®双离合变速器",t2:"全新奥迪A3 Sportback配备的Stronic®双离合变速箱兼顾了更强动⼒与更低能耗。与TFSI® 发动机的完美搭配,将整⻋的动⼒与操控提升到了全新⾼度,充分释放你的驾驭激情。",t3:"全新奥迪A3 Sportback配备的S tronic®双离合变速箱,有什么特点?",q1:"有效减少变速箱内齿轮机构磨损",q2:"将整⻋的动⼒与操控提升到全新⾼度,并保证相对较低的能耗",answer:1}
		{times:"26''",header:"s-6",mp3:"http://audi.mconnect.cn/A3-wechat/mp3/s-6.mp3",name:"韩路",title:"汽车之家编辑部总监",t1:"更强劲的TFSI®发动机",t2:"全新奥迪A3 Sportback搭载的1.4 TFSI®发动机,将FSI®燃油直喷的⾼效与涡轮增压的⾼扭矩输出集于⼀⾝,动⼒输出强劲⽽流畅。启动发动机的⼀刻,澎湃动⼒早已蓄势待发。",t3:"全新奥迪A3 Sportback搭载的是什么发动机?",q1:"1.4/1.8 TFSI汽油直喷涡轮增压发动机",q2:"1.4/1.8 FSI汽油直喷发动机",answer:0}
	]
	"a33": [
		{times:"16''",header:"l-3",mp3:"http://audi.mconnect.cn/A3-wechat/mp3/l-3.mp3",name:"邹硕",title:"搜狐主编",t1:"更智能的MMI®多媒体交互系统",t2:"全新奥迪A3 Limousine搭载新⼀代MMI®多媒体交互系统, 独特的MMI ®触控轮,可⽀持⼿写⽅方式输⼊,让导航和打电话变得轻松惬意。指尖轻巧滑动,⼀切尽在掌握。",t3:"是什么装置,让全新奥迪A3 Limousine搭载的MMI®多媒体交互系统轻松便捷?",q1:"独⽴⼿写输⼊板",q2:"独特的MMI ®触控轮",answer:1}
		{times:"21''",header:"l-4",mp3:"http://audi.mconnect.cn/A3-wechat/mp3/l-4.mp3",name:"周全",title:"新浪全国商业运营总经理",t1:"更浑厚的Bang&Olufsen音响",t2:"全新奥迪A3 Limousine搭载丹⻨麦顶级B&O音响系统,配备5.1环绕⽴体声和14个扬声器,为你带来震撼的视听感受。系统可根据⾼低音呈现不同的LED照明效果,使客舱的时尚氛围动感即现。",t3:"全新奥迪A3 Limousine搭载的什么音响系统,具备可根据⾼低音呈现不同LED效果?",q1:"丹⻨麦顶级B&O音响系统",q2:"BOSE音响系统",answer:0}
		{times:"18''",header:"l-5",mp3:"http://audi.mconnect.cn/A3-wechat/mp3/l-5.mp3",name:"王洪浩",title:"易车网编辑运营中心总经理",t1:"更敏捷的S tronic®双离合变速器",t2:"0.2秒是全新奥迪A3 Limousine换挡的全过程时间。搭载Stronic®双离合变速器的Ta能在你毫⽆察觉的情况下完成⾼效换挡动作,你⼏乎感觉不到任何顿挫感。",t3:"全新奥迪A3 Limousine搭载的S tronic®双离合变速器,给你最直观的感受是?",q1:"换挡迅速且没有任何顿挫感",q2:"驾驶中不会感觉到颠簸",answer:0}
		{times:"22''",header:"l-6",mp3:"http://audi.mconnect.cn/A3-wechat/mp3/l-6.mp3",name:"闫闯",title:"汽车之家编辑",t1:"更强劲的TFSI®发动机",t2:"全新奥迪A3 Limousine搭载的新⼀代1.8T 发动机,匹配奥迪可变⽓门升程系统,输出⾼效动⼒的同时保证较低的油耗。什么是更强劲? 踩下油⻔,⼀切不⾔⾃明。",t3:"全新奥迪A3 Limousine可在动⼒强劲的同时,保证较低油耗,是搭载了什么装置?",q1:"汽缸按需运⾏系统",q2:"奥迪可变⽓门升程系统",answer:1}
	]
document.addEventListener 'WeixinJSBridgeReady', ->
	forWeiXin()

forWeiXin = ->
	$("#qafs").attr 'src','img/qa.png'
	$(".car360inside .qatitle").click ->
		$(".weixinshare").show()
		$("body").addClass "open"
	$(".weixinshare")[0].addEventListener 'touchstart', (e)->
		e.preventDefault()
		$(".weixinshare").hide()
		$("body").removeClass "open"
$(document).ready ->
	if $("[data-rel=resertpage]").length<=0
		bind360Car()
		fBindQAanswer()
		fBindAudio()
		fBindImgs()
	bindChangeCar()
	loadImg()
	fBindCarInside()
	fBindFormBtn()
	bind360CarInside()
	$(".car-1").click ->
		_page = "360"
		create360Car 'a33'
		show360car()
	$(".car-2").click ->
		_page = "360"
		create360Car 'a32'
		show360car()
	$(".backhome").click ->
		$(".car360,.carsideinfo,.car360inside,.resertpage").removeClass('fadeInDownBig').addClass 'fadeOutUpBig'
		$(".homepage").removeClass('fadeOutUpBig').addClass 'fadeInDownBig'
		stopAllPlay()
		$("#audio")[0].pause()
		setTimeout ->
			$(".car360,.carsideinfo,.car360inside,.resertpage").hide()
		,500

	myK("province").innerHTML = fGetHTMLP()
	myK("city").innerHTML = fGetHTMLC myK("province").value
	myK("dealer").innerHTML = fGetHTMLS myK("province").value,myK("city").value
	myK("province").onchange = ->
		setTimeout ->
			myK("city").innerHTML = fGetHTMLC myK("province").value
			myK("dealer").innerHTML = fGetHTMLS myK("province").value,myK("city").value
			$('#city').change()
			$('#dealer').change() 
		,20
	myK("city").onchange = ->
		setTimeout -> 
			myK("dealer").innerHTML = fGetHTMLS myK("province").value,myK("city").value
			$('#dealer').change()
		,20

	gico.fBindSelect $("select")
	gico.fBindRadio $("input[type=radio]")
	$(".openresert").click ->
		$(".resertpage").removeClass("fadeOutUpBig").show().addClass 'animated fadeInDownBig'
		return false
myK = (id)->
	document.getElementById(id)
hideResertPage = ->
	$(".resertpage").removeClass 'animated fadeInDownBig'
	$(".resertpage").addClass 'animated fadeOutUpBig'
	setTimeout ->
		$(".resertpage").hide()
	,500
# loading
loadImg = ->
	loading.finished = ->
		finishedLoad()
	loading.init [
		{src:"img/logo.png",id:"logo"}
		{src:"img/car-1.png",id:"car-1"} 
		{src:"img/car-2.png",id:"car-2"}
		{src:"img/index-text.png",id:"index-text"}
		{src:"img/index-sound.png",id:"index-sound"}
		{src:"img/index-chance.png",id:"index-chance"}
		{src:"img/point.png",id:"point"}
		{src:"img/icon-sound.png",id:"icon-sound"}
		{src:"img/sound-w.png",id:"sound-w"}
		{src:"img/qa.png",id:"qa"}
		{src:"img/register.png",id:"register"}
		{src:"img/bg-car.jpg",id:"bg-car"}
		{src:"img/a3s-back.png",id:"a3s-back"}
		{src:"img/a3l-back.png",id:"a3l-back"}
		{src:"img/l-1.jpg",id:"l-1"}
		{src:"img/l-2.jpg",id:"l-2"}
		{src:"img/l-3.jpg",id:"l-3"}
		{src:"img/l-4.jpg",id:"l-4"}
		{src:"img/l-5.jpg",id:"l-5"}
		{src:"img/l-6.jpg",id:"l-6"}
		{src:"img/s-1.jpg",id:"s-1"}
		{src:"img/s-2.jpg",id:"s-2"}
		{src:"img/s-3.jpg",id:"s-3"}
		{src:"img/s-4.jpg",id:"s-4"}
		{src:"img/s-5.jpg",id:"s-5"}
		{src:"img/s-6.jpg",id:"s-6"}

	]
finishedLoad = ->
	console.log "finished"
	$(".loading").hide()
	# 初始化预约图片
	animateGo() 


animateGo = ->
	$("[data-animate]").each ->
		$(this).addClass $(this).data 'animate'

# for inside 
_animate = false
fBindImgs = ->
	if $("#img-list").length >=0
		console.log "band"
		$("#img-list")[0].addEventListener 'touchstart', imgstouchStart
		$("#img-list")[0].addEventListener 'touchmove', imgstouchMove
		$("#img-list")[0].addEventListener 'touchend', imgstouchEnd
		$("#img-list .left").click ->
			startMove 'right'
		$("#img-list .right").click ->
			startMove 'left'
		$("#img-list .bottom").click ->
			startMove 'up'
_xd = 0
_yd = 0
imgstouchStart = (e)->
	_xd = e.touches[0].pageX
	_yd = e.touches[0].pageY
imgstouchMove = (e)->
	# e.preventDefault()
	x = e.touches[0].pageX
	y = e.touches[0].pageY
	e.preventDefault()
	# console.log Math.round(_yd-y),Math.round(_xd-x)
	if Math.round(_yd-y) > 20
		console.log "up?"
		startMove 'up'
		removeEventListener()
	else if Math.round(_yd-y) < -20
		console.log "down?"
		startMove 'down'
		removeEventListener()
	else if Math.round(_xd-x) > 20
		console.log "left?"
		startMove 'left'
		removeEventListener()
		# MoveLeft
	else if Math.round(_xd-x) < -20
		console.log "rigth?"
		startMove 'right'
		removeEventListener()
	# else
		# console.log "down?"
		# removeEventListener()
imgstouchEnd = (e)->
	console.log "addEventListener"
	# $("#img-list")[0].addEventListener 'touchstart', imgstouchStart
	$("#img-list")[0].addEventListener 'touchmove', imgstouchMove
	# $("#img-list")[0].addEventListener 'touchend', imgstouchEnd
	
removeEventListener = ->
	# $("#img-list")[0].removeEventListener 'touchstart', imgstouchStart
	$("#img-list")[0].removeEventListener 'touchmove', imgstouchMove
	# $("#img-list")[0].removeEventListener 'touchend', imgstouchEnd
_nowNex = 0
startMove = (fx)->
	$e = $("#img-list .img-list")
	$ep = $("#img-list .movectrl")
	model = $e.attr 'model'
	if model is fx
		return ''
	$(".right",$ep).show()
	$(".left",$ep).show()
	$(".bottom",$ep).show()

	classs = "fadeInRightBig fadeInLeftBig fadeInDownBig fadeInUpBig"
	$("[remove]",$e).removeClass classs
	$("[remove]",$e).each ->
		$(this).addClass $(this).attr 'remove'
		$removethis = $(this)
		setTimeout ->
			$removethis.remove()
		,1500
	
	_nowNex = 0
	# $("img",$e).not($("img",$e).eq(0)).remove()
	if fx is 'left' and model is 'right'
		$e.attr 'model','center'
		changePoint 'point3'
		# $("img",$e).not($("img",$e).eq(0)).remove()
	else if fx is 'right' and model is 'left'
		$e.attr 'model','center'
		changePoint 'point3'
	else if fx is 'left'
		$e.attr 'model','left'
		_nowNex = 1
		$(".right",$ep).hide()
		$e.append '<img src="img/title-2.jpg" remove="fadeOutRightBig" class="bn animated fadeInRightBig"/>'
		changePoint 'point4'
	else if fx is 'right'
		$e.attr 'model','right'
		_nowNex = 2
		$(".left",$ep).hide()
		$e.append '<img src="img/title-3.jpg" remove="fadeOutLeftBig" class="bn animated fadeInLeftBig"/>'
		changePoint 'point5'
	else if fx is 'down'
		$e.attr 'model','down'
		changePoint 'point3'
	else if fx is 'up'
		$e.attr 'model','up'
		_nowNex = 3
		$(".bottom",$ep).hide()
		$e.append '<img src="img/title-4.jpg" remove="fadeOutDownBig" class="bn animated fadeInUpBig"/>'
		changePoint 'point6'
	else if fx is 'up' and model is 'down'
		$e.attr 'model','center'
		# $("#pointinside").addClass 'point3'
		changePoint 'point3'
defaultNS = (play = true)->
	_nowNex = 0
	$e = $("#img-list .img-list")
	$e.attr 'model','center'
	$ep = $("#img-list")
	$("[remove]",$ep).remove()
	$(".bottom,.left,.right",$ep).show()
	changePoint 'point3', play
# _poList
changePoint = (p,play = true)->
	# setTimeout ->
	$("#pointinside").removeClass 'point3 point4 point5 point6' 
	$("#pointinside").addClass p
	insideUserCtrl play
	# stopAllPlay()
	# ,500
insideUserCtrl = (play = true)->
	# _nowCar,_nowNex
	$("#pointinside .header").html loading.list[_poList[_nowCar][_nowNex].header]
	$("#pointinside .name h4").text _poList[_nowCar][_nowNex].name
	$("#pointinside .name p").text _poList[_nowCar][_nowNex].title
	console.log "can play",play
	# if play
		# auto2Audio()
	$("#audio")[0].pause()
	showPlayGif()
	
	

fBindCarInside = ->
	$(".interior").click ->
		console.log "interior",_animate
		return '' if _animate 
		_animate = true 
		$(".car360").removeClass 'animated fadeOutRight fadeInLeft fadeInDownBig'
		$(".car360").addClass 'animated fadeOutRight' #fadeOut
		$(".carsideinfo").removeClass 'animated fadeOutRight fadeInLeft'
		$(".carsideinfo").show().addClass 'animated fadeInLeft'
		_page = "interior"
		stopMove360()
		# $("#audio")[0].pause()
		defaultNS()
		# auto2Audio()
		# changePoint 3

		setTimeout ->
			_animate = false
			$(".car360").hide()
		,500
	$(".exterior").click ->
		console.log "exterior",_animate
		return '' if _animate
		_animate = true
		_page = "360"
		$(".car360").removeClass 'animated fadeOutRight fadeInLeft'
		$(".car360").show().addClass 'animated fadeInLeft' #fadeOut
		$(".carsideinfo").removeClass 'animated fadeOutRight fadeInLeft'
		$(".carsideinfo").addClass 'animated fadeOutRight'
		# starMove360()
		# $("#audio")[0].pause()
		autoAudioX()
		$("#list360 .car").hide()
		$("#list360 .car").eq(1).show()
		hidePoint()
		starMove360()
		setTimeout ->
			_animate = false
			$(".carsideinfo").hide()
			defaultNS false
		,500

	$(".drive").click ->
		# $(".")
# for 360
_nowCar = 'a33'
show360car = ->
	# $(".homepage").addClass 'animated fadeOutUpBig' if $(".homepage").not '.animated'
	# $(".car360").show().addClass 'animated fadeInDownBig'
	$(".homepage").removeClass("fadeOutUpBig fadeInDownBig").addClass 'animated fadeOutUpBig'
	$(".car360,.carsideinfo,.car360inside,.resertpage").hide().removeClass('fadeInDownBig fadeOutRight fadeInLeft fadeOutUpBig')
	$(".car360").show().addClass 'animated fadeInDownBig'
_only = {"a32":true,"a33":true}
create360Car = (e)->
	_nowCar = e
	console.log "page: ",_page
	$("#list360 .imglist").html ''
	for i in [1..12]
		$("#list360 .imglist").append "<img class='car' src='img/#{e}/#{i}.png' />"
	$("#list360 .car").hide()
	$("#list360 .car").eq(1).show()

	if _page is "360"
		autoAudioX()
	else
		defaultNS()
	# showPoint 1
	hidePoint()
	if _nowCar is 'a33'
		$("#back-image,#changed-image").attr 'src','img/a3s-back.png'
	else
		$("#back-image,#changed-image").attr 'src','img/a3l-back.png'

bindChangeCar = ->
	$(".car-back").click ->
		# defaultNSS()
		if _nowCar is 'a33'
			create360Car 'a32'
		else
			create360Car 'a33'


_x360 = 0
_tmove = null
_speedfor = 2000
_stopmovenext = false

stopMove360 = ->
	_stopmovenext = true
	clearTimeout _tmove
	# clearInterval _tmove
	
startTimeGo = ->
	time = _speedfor
	if $("#list360 .car:visible").next().is '.car'
		$e = $("#list360 .car:visible").next()
	else
		$e = $("#list360 .car:first")
	# console.log $e.index()
	if $e.index() is 4 or $e.index() is 0
		time = time * 3
	return '' if _stopmovenext
	_tmove = setTimeout -> 
		showNext360Img()
		startTimeGo()
	,time
starMove360 = ->
	_stopmovenext = false
	startTimeGo()
	# _tmove = setInterval ->
	# 	showNext360Img()
	# ,_speedfor
bind360Car = ->
	$("#list360")[0].addEventListener 'touchstart',touch360carstart
	$("#list360")[0].addEventListener 'touchmove',touch360carmove
	$("#list360")[0].addEventListener 'touchend',touch360carend
	starMove360()  
touch360carstart = (e)->
	_x360 = e.touches[0].pageX
	# hidePoint()
	stopMove360()
touch360carmove = (e)->
	e.preventDefault() # for android
	x = e.touches[0].pageX
	mx = Math.round _x360-x
	abs= Math.abs mx
	# alert mx
	if mx >= 20
		showNext360Img()
		_x360 = e.touches[0].pageX
		# console.log 'move next img'
	if mx <= -20
		showPrev360Img()
		_x360 = e.touches[0].pageX
		# console.log 'move prev img'
		
touch360carend = (e)->
	console.log "start _tmove"
	starMove360()
showNext360Img = ->
	# console.log $("#list360 img:visible").next().is 'img'
	# return "" if _stopmovenext
	if $("#list360 .car:visible").next().is '.car'
		$e = $("#list360 .car:visible").next()
		$("#list360 .car").hide()
		$e.show()
	else
		$e = $("#list360 .car:first")
		$("#list360 .car").hide()
		$e.show()
	if $e.index() is 11
		showPoint(1)
	else if $e.index() is 3
		showPoint(2)
	else
		hidePoint()
showPrev360Img = ->
	if $("#list360 .car:visible").prev().is '.car'
		$e = $("#list360 .car:visible").prev()
		$("#list360 .car").hide()
		$e.show()
	else
		$e = $("#list360 .car:last")
		$("#list360 .car").hide()
		$e.show()
	if $e.index() is 11
		showPoint(1)
	else if $e.index() is 3
		showPoint(2)
	else
		hidePoint() 

hidePoint = ()->
	$("#point").hide()
	$("#point").removeClass "animated tada"
_nowNet = 0

showPoint = (index)->
	$("#point").removeClass 'point2 point3 point4'
	_nowNet = index-1
	
	if index is 2
		$("#point").addClass 'point2'
		
	# else

	# $("#human").attr 'src',_pointList[_nowCar][index-1].header
	# console.log loading.list[_pointList[_nowCar][index-1].header]
	$("#point .header").html loading.list[_pointList[_nowCar][index-1].header]
	$("#point .name h4").text _pointList[_nowCar][index-1].name
	$("#point .name p").text _pointList[_nowCar][index-1].title
	$("#times").text _pointList[_nowCar][index-1].times

	console.log _playingradio,_nowCar,_nowNet
	if _playingradio.car is _nowCar and _playingradio.idt is _nowNet
		$("#point .play").show()
	else
		$("#point .play").hide()
		console.log "playing this."

	$("#point").show() 
	$("#point").addClass "animated tada" 
	# bind360CarInside()
stopAllPlay = ->
	$("#point .play").hide()
	$("#pointinside .play").hide()
	$(".radioinfo .radio .play").hide()

auto2Audio = ->
	info = _poList[_nowCar][_nowNex]
	console.log info.mp3,info.mp3 isnt $("#audio").attr 'src'
	if info.mp3 isnt $("#audio").attr 'src'
		$("#audio").attr 'src',info.mp3
	$("#audio")[0].play()
autoAudioX = ()->
	# _only[_nowCar] = false
	return ""
	info = _pointList[_nowCar][1]
	_nowNet = 1
	$("#audio").attr 'src',info.mp3
	$("#audio")[0].play()
autoAudio = -> 
	_only[_nowCar] = false
	console.log _nowCar,_nowNet
	info = _pointList[_nowCar][_nowNet] 
	console.log "click audio play",info.mp3 isnt $("#audio").attr 'src'
	if info.mp3 isnt $("#audio").attr 'src'
		$("#audio").attr 'src',info.mp3
	$("#audio")[0].play()
	# $("#audio")[0].addEventListener 'ended',endAudio
	# _playing = true
endAudio = ->
	console.log "end play"
	_playing = false
pauseAudio = ()->
	_playing = false
	$("#audio")[0].pause()

# 360car inside
showCarInside = (side)->
	user = {}
	if side is 'inside'
		user = _poList[_nowCar][_nowNex]
		bg = "inside-"+(_nowNex+1)+".jpg"
	else
		user = _pointList[_nowCar][_nowNet]
		bg = _nowCar+"-"+(_nowNet+1)+".jpg"

	console.log bg
	$(".car360inside").css
		'background-image':"url(img/#{bg})"

	$(".car360inside .qaright").remove()

	$(".car360inside .avatar").html $(loading.list[user.header]).clone()
	$(".car360inside .userinfo h3").text user.name
	$(".car360inside .userinfo p").text user.title

	$(".car360inside .radioinfo h4").text user.t1
	$(".car360inside .radioinfo p").text user.t2
	$(".car360inside .qa h2").text user.t3
	$(".car360inside .qa .question .item").eq(0).find("p").text user.q1
	$(".car360inside .qa .question .item").eq(1).find("p").text user.q2

	$(".car360inside .qa .question .item").eq(user.answer).append '<div class="qaright"><img src="img/qaright.png" /></div>'

	$(".car360inside .radio span").text user.times
	$(".car360inside").removeClass 'animated fadeOutUpBig'
	$(".car360inside").show().addClass 'animated fadeInDownBig'
	$("#audio").attr 'src',user.mp3
	stopAllPlay()
	# $("#audio")[0].play()
	# $(".car360inside .radio .play").hide()
	# $(".car360inside .radio .stop").hide()
fBindAudio = ->
	$("#audio")[0].addEventListener "ended",audioEnded
	$("#audio")[0].addEventListener "playing",audioPlaying
	$("#audio")[0].addEventListener "pause",audioPause
	$(".radio").click ->
		if _playing
			$("#audio")[0].pause()
			audioEnded {}
		else
			$("#audio")[0].play()
			$(".car360inside .radio .play").show()
audioPause = (e)->
	console.log "播放暂停"
	_playing = false
	_pause = true
	stopAllPlay()
audioPlaying = (e)->
	_playingradio.car = _nowCar
	_playingradio.idx = _nowNex
	_playingradio.idt = _nowNet
	console.log "播放",e
	_playing = true
	_pause = false
	showPlayGif()
audioEnded = (e)->
	console.log "播放结束"
	$(".car360inside .radio .play").hide()
	_playing = false
	_pause = false
	_playingradio = {car:"",idx:-1,idt:-1}
	stopAllPlay()
	# $(".car360inside .radio .stop").show()
	# fBindQAanswer()
showPlayGif = ->
	stopAllPlay()
	if _playingradio.car is _nowCar and _playingradio.idx is _nowNex and _playing and not _pause
		$("#pointinside .play").show()
	if _playingradio.car is _nowCar and _playingradio.idt is _nowNet and _playing and not _pause
		$("#point .play").show()
	if _playing and not _pause and $(".car360inside").is ".fadeInDownBig"
		$(".car360inside .radio .play").show()
fBindQAanswer = ->
	# console.log $(".car360inside .item")
	$(".car360inside .item").click ->
		$(".car360inside .item .qaright").show().addClass 'animated fadeInLeft'


backCarInside = ->
	$(".car360inside").removeClass 'animated fadeInDownBig'
	$(".car360inside").addClass 'animated fadeOutUpBig'
	$("#audio")[0].pause()
	starMove360()
	setTimeout ->
		$(".car360inside").hide()
	,500
bind360CarInside = ->
	$("#point .header").click ->
		showCarInside 'outside'
		stopMove360()
	$("#point .sound").click ->
		console.log _playingradio,_nowCar,_nowNet,_playing
		if _playingradio.car is _nowCar and _playingradio.idt is _nowNet and _playing
			pauseAudio()
		else
			console.log "run"
			autoAudio()
	$("#pointinside .header").click ->
		showCarInside 'inside'
	$("#pointinside .sound").click -> 
		if _playing and _playingradio.car is _nowCar and _playingradio.idx is _nowNex and _playing
			pauseAudio()
		else
			auto2Audio()

playMusic = (e)->
	if e is 1
		info = _pointList["a33"][0]
		$("#audio").attr 'src',info.mp3
		$("#audio")[0].play()
	if e is 2
		info = _pointList["a32"][0]
		$("#audio").attr 'src',info.mp3
		$("#audio")[0].play()


fBindFormBtn = ->
	$('[name=submit]').click ->
		return alert '姓名不能为空' if $('[name=username]').val().length <=0
		return alert '请选择性别' if $('[name=sex]').val().length <=0
		return alert '手机号码不能为空' if $('[name=mobile]').val().length <=0
		return alert '手机号码必须是11位数字' if $('[name=mobile]').val().length != 11 
		return alert '邮箱地址不能为空' if $('[name=email]').val().length <=0
		reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/
		return alert '邮箱格式不正确' if not reg.test $('[name=email]').val()
		# return alert '请选择欲购车时间' if $('[name=passport]').val().length <=0
		return alert '请选择感兴趣车型' if $('[name=cartype]').val().length <=0
		return alert '请选择购车意向' if $('[name=buytime]').val().length <=0
		return alert '请选择省份' if $('[name=province]').val().length <=0
		return alert '请选择城市' if $('[name=city]').val().length <=0
		return alert '请选择经销商' if $('[name=dealer]').val().length <=0 

		$.ajax
			type:"post"
			dataType:"json"
			url:"reservations.php"
			data:$('[name=register]').serializeArray()
			success: (msg)->
				# console.log msg
				if msg.state is 'success'
					alert '预约成功'
					window.location.reload()
				else
					alert msg.msg