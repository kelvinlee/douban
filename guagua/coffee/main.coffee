# here is your CoffeeScript.
size = 
	w:640
	h:960
canvas = {}
ctx = {}
# 模糊度
Fuzzy = 120
# 完成百分比,显示 不能高于85
pshow = 65
# 概率基数
rxl = 59
# 半径
r = 70
# 移动时的基础点位
model = 1
prev = {x:-1,y:-1}
GameEndBool = true
# first step


movexx = ->
	$("#note").css
		"top":"101%"
		"margin":"0px"
checkCanvas = ->
	prev =
		x:-1
		y:-1
	imageData = ctx.getImageData 0, 0, $('#canvas').width(), $('#canvas').height()
	offset = 3
	op = 0
	for y in [0...imageData.height]
		for x in [0...imageData.width]
			index = y * imageData.width + x
			p = index * 4
			op++ if imageData.data[p + offset] is 0
	ps = (op/imageData.data.length*4*100)
	# console.log ps+"%"
	if parseInt(ps) > pshow#65
		GameEnd()


mouseMove = (ev)->
	ev= ev || window.event
	ev.preventDefault()
	mousePos = mouseCoords ev
	mouse = mouseOver mousePos
	return '' if mouse.x < 0 && mouse.y < 0
	clearMove mouse.x,mouse.y
	r++ if r <=42


clearMove = (x,y)->
	if prev.x < 0
		prev.x = x
		prev.y = y
		ctx.moveTo x,y
		movexx()
		return false
	if prev.y < 0
		prev.x = x
		prev.y = y
		ctx.moveTo x,y
		return false 
	ctx.lineTo x,y
	prex =
		x:x
		y:y
	ctx.stroke()

	# ctx.clearRect x,y,r,r
mouseCoords = (ev)->
	ev = ev.targetTouches[0]
	{x:ev.pageX, y:ev.pageY} if ev.pageX || ev.pageY
	{x:ev.clientX + document.body.scrollLeft - document.body.clientLeft, y:ev.clientY + document.body.scrollTop - document.body.clientTop }

mouseOver = (ev1)->
	body = $ 'body'
	jx = 0
	if $("#canvas").width() - body.width() > 0
		jx = ($("#canvas").width() - body.width())/2
	{x:ev1.x+jx,y:ev1.y}

GameEnd = ->
	GameEndBool = true
	# console.log "Game End"
	$("#canvas").fadeOut 500
	# console.log "Fade In"
	$("#replay").css
		bottom:"0px"
	$("#logo").css
		top:"0px"
	$("#fly").css
		left:"0px"
	$("#replay").swipe
		tap: (e,t)->
			window.location.reload()
loadimg = ->
	body = $ 'body'
	obsize = {} 
	epsize = 
		w:body.width()
		h:body.height()
	$('#img').width epsize.w
	$('#img,#canvas').css 
		'margin-left':'-'+$('#img').width()/2+'px'
	console.log epsize.h,$('#img').height()
	if epsize.h>=$('#img').height()
		obsize.h = epsize.h
		$('#img').width 'auto'
		$('#img').height epsize.h
		$('#img,#canvas').css 
			'margin-left':'-'+$('#img').width()/2+'px'
	else
		if size.w>epsize.w
			$('#img').width epsize.w
			$('#img,#canvas').css 
				'margin-left':'-'+$('#img').width()/2+'px'

	$("#canvas").attr 'width':$('#img').width()
	$("#canvas").attr 'height':$('#img').height()
	# alert $('#img').width()+","+$('#img').height()
	canvas = stackBlurImage "img", "canvas", Fuzzy, false
	ctx = canvas.getContext '2d'
	ctx.globalCompositeOperation = "destination-out"
	ctx.lineWidth = r
	ctx.lineCap = 'round'
	ctx.lineJoin = 'round'
	ctx.beginPath()
	# 关闭loading
	# $("#loading").fadeOut 500
	$("#loading").hide()
	GameEndBool = false
	$("#note").css
		"top":"50%"
	$("#fly").addClass 'b'+model
	# setTimeout movexx,2000
	ss = new Snow 20, 60 if model is 1
	
firstStep = ->
	body = $ 'body'
	# if body.width() > size.w 
	# 	$("#loading span").text '请使用手机浏览,并刷新.'
	# 	return false
	ran = parseInt Math.random()*100
	src = "img/bg-1.jpg"
	if ran > rxl
		model = 2
		src = "img/bg-2.jpg"
	img = document.getElementById 'img'
	img.onload = loadimg
	img.src = src;

$(document).ready -> 
	
	$(document).on 'touchstart',->
		return false if GameEndBool
		mouseMove()
		document.addEventListener "touchmove",mouseMove
	$(document).on 'touchend', ->
		return false if GameEndBool
		document.removeEventListener "touchmove",mouseMove
		checkCanvas()
		r = 70
	firstStep()