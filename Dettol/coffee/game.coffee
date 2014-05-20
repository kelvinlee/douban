# public var
canvas = {}
stage = {}
images = {}
playing = true
count = 1
manifest = {}
overscore = 3
score = 0
runscore = 0
canaddBugs = true
bugsNum = 2
buglife = 3000
# game dom
loadingTxt = {}

_dom_score_box = {}
_dom_bugs_box = {}
_dom_score = {}
_dom_score_img = {}
_dom_bug1 = {}
_dom_bug2 = {}
_dom_bug3 = {}

audio = {}
# $(document).ready ->
# 	# init()
# 	loadImg()

_orien = 1
orientationChange = -> 
	switch window.orientation
		when 0 then backNormal()
		when 90 then GameH()
		when -90 then GameH()
window.onorientationchange = orientationChange
window.addEventListener 'load', ->
	orientationChange()
backNormal = ->
	_orien = 1
	$('.zoom5').removeClass 'zoom5'
	$("#mubu").css
		width:$("body").width()
		height:$("body").height()
GameH = ->
	_orien = 0 
	# alert $("body").height()
	# console.log  $("body").height(),$("body").width()
	# alert $(".main").height()
	# setTimeout ->
	# 	alert $(".main").height()
	# ,3000 
	$("#mubu").css
		width:$("body").width()
		height:$("body").height()
	$(".logo,.gameinfo,.menu,.clouds,.da-box,.activeinfo-box,.proinfo-box").addClass 'zoom5'
	# startGame()
myGetId = (id)->
	document.getElementById id
ranDom = (min,max)->
	return Math.ceil Math.random()*(max-min+1) + min
# 启动函数
init = ->
	publicH = document.body.clientHeight*640/document.body.clientWidth
	# console.log publicH
	canvas = myGetId 'canvas'
	# $(canvas).attr 'width',640/document.body.clientWidth
	$(canvas).attr 'height',$("#mubu").height()
	stage = new createjs.Stage canvas
	# stage.autoClear = false
	createjs.Touch.enable stage
	stage.enableMouseOver 10
	stage.mouseMoveOutside = true
	_dom_bugs_box = new createjs.Container()
	_dom_bugs_box.x = 0
	_dom_bugs_box.y = 0
	_dom_score_box = new createjs.Container()
	_dom_score_box.x = 0
	_dom_score_box.y = 0
	stage.addChild _dom_bugs_box,_dom_score_box
	# loadingTxt = new createjs.Text '', 'bold 24px Arial', '#000000'
	# loadingTxt.x = 230
	# loadingTxt.y = 450
	# stage.addChild loadingTxt
	stage.update()
	gotoTick()
	firstFrame()
# 监听画面变化
gotoTick = ->
	createjs.Ticker.setFPS 30
	createjs.Ticker.addEventListener "tick", tick
	createjs.Ticker.addEventListener "tick", stage
tick = (evt)->
	checkBugsMove()
	checkScoreMove()
checkScoreMove = ->
	l = _dom_score_box.getNumChildren()
	return false if l <= 0
	for i in [0...l]
		obj = _dom_score_box.getChildAt i
		if not obj?
			continue
		obj.Aa -= 0.06
		if obj.Aa <= 0
			obj.alpha -= 0.06
		obj.y -= 3
		if obj.alpha <= 0
			_dom_score_box.removeChildAt i

checkBugsMove = ->
	l = _dom_bugs_box.getNumChildren()
	canaddBugs = false if l <= 0
	for i in [0...l]
		obj = _dom_bugs_box.getChildAt i
		if not obj?
			continue
		if obj.exy is "remove"
			if obj.alpha <= 0
				_dom_bugs_box.removeChildAt i
				checkRemoveBugs()
			else
				obj.alpha -= 0.06
			continue
		if obj.exy is "runaway"
			if obj.alpha <= 0
				_dom_bugs_box.removeChildAt i
				checkRemoveBugs()
			else
				obj.alpha -= 0.06
				obj.x += Math.random()*-10+5
				obj.y += Math.random()*-10+5
			continue
		if obj.exy is "big"
			obj.scaleX += obj.espeed*1.1
			obj.scaleY += obj.espeed*1.1
			obj.exy = "normal" if obj.scaleX >= (obj.esX+obj.esX*0.3)
		if obj.exy is "small"
			obj.scaleX -= obj.espeed/3
			obj.scaleY -= obj.espeed/3
			obj.exy = "big" if obj.scaleX <= (obj.esX-obj.esX*0.3)
		if obj.exy is "normal"
			obj.scaleX -= obj.espeed
			obj.scaleY -= obj.espeed
			obj.exy = "over" if obj.scaleX <= (obj.esX)
# 图片加载
loadImg = ->
	images = images||{}
	manifest = [
		{src:"img/bug-1.png", id:"bug-1"}
		{src:"img/bug-2.png", id:"bug-2"}
		{src:"img/bug-3.png", id:"bug-3"}
		{src:"img/bg-1.jpg", id:"bg-1"}
		{src:"img/bg-2.jpg", id:"bg-2"} 
		{src:"img/score-bg.png", id:"score-bg"}
	]
	loader = new createjs.LoadQueue false
	# loader.installPlugin createjs.Sound
	loader.addEventListener "fileload", handleFileLoad
	loader.addEventListener "complete", handleComplete
	loader.loadManifest manifest
# 加载中和完成
handleFileLoad = (evt)->
	images[evt.item.id] = evt.result if evt.item.type is "image"
	count++
	console.log "加载了: "+Math.floor(count/manifest.length*100)+"%";
	loadEnd() if count == manifest.length
handleComplete = (evt)->
	console.log "loadend:",evt
	loadEnd()
# 创建所有的游戏Dom
createAllDom = ->
	audio = document.createElement("audio")
	audio.src= "img/click.mp3"
	$(audio).bind 'pause', ->
		this.currentTime = 0.1
		console.log "pause"
	w = canvas.width
	h = canvas.height
	# console.log w,h
	# bug-1
	bug1_data =
		framerate:20
		images: [images['bug-1']]
		frames:
			width:220
			height:220
		animations:
			dead: [0,1]
	bug1_spritesheet = new createjs.SpriteSheet bug1_data
	_dom_bug1 = new createjs.Sprite bug1_spritesheet
	_dom_bug1.x = w/2
	_dom_bug1.y = h/2
	_dom_bug1.regX = 220/2
	_dom_bug1.regY = 220/2

	_dom_bug1.VA = -0.02
	_dom_bug1.alpha = 1
	_dom_bug1.esX = 1
	_dom_bug1.esY = 1
	_dom_bug1.espeed = 0.08
	_dom_bug1.exy = "small"
	# bug-2
	bug1_data.images = [images['bug-2']]
	bug2_spritesheet = new createjs.SpriteSheet bug1_data
	_dom_bug2 = new createjs.Sprite bug2_spritesheet
	_dom_bug2.x = w/2
	_dom_bug2.y = h/2
	_dom_bug2.regX = 220/2
	_dom_bug2.regY = 220/2
	# _dom_bug2.gotoAndStop 1
	_dom_bug2.VA = -0.02
	_dom_bug2.alpha = 1
	_dom_bug2.esX = 1
	_dom_bug2.esY = 1
	_dom_bug2.espeed = 0.08
	_dom_bug2.exy = "small"
	# bug-2
	bug1_data.images = [images['bug-3']]
	bug3_spritesheet = new createjs.SpriteSheet bug1_data
	_dom_bug3 = new createjs.Sprite bug3_spritesheet
	_dom_bug3.x = w/2
	_dom_bug3.y = h/2
	_dom_bug3.regX = 220/2
	_dom_bug3.regY = 220/2
	# _dom_bug3.gotoAndStop 1
	_dom_bug3.VA = -0.02
	_dom_bug3.alpha = 1
	_dom_bug3.esX = 1
	_dom_bug3.esY = 1
	_dom_bug3.espeed = 0.08
	_dom_bug3.exy = "small"

	_dom_score = new createjs.Container()
	_dom_score_img = new createjs.Bitmap images['score-bg']
	# _dom_score.addChild imgbg
	# stage.addChild _dom_score
	# _dom_bug1.gotoAndStop 1
	# stage.addChild _dom_bug1,_dom_bug2,_dom_bug3
	# stage.update()


randomBugs = (min,max)->
	w = canvas.width
	h = canvas.height
	h2 = $(".main").height()
	random = Math.random()*(max-min)+min
	h2 = 600 if h2>600
	for i in [0...random]
		setTimeout ()->
			obj = {}
			whos = Math.ceil(Math.random()*(400-100+1) + 100)
			scale = (Math.ceil(Math.random()*(90-50+1) + 50))/100
			obj = _dom_bug1.clone() if whos <= 199
			obj = _dom_bug2.clone() if whos >= 200 && whos <= 299
			obj = _dom_bug3.clone() if whos >= 300
			x1 = 110
			y1 = 260
			y2 = 220
			h = h-50
			if not _orien
				x1 = 110
				y1 = 50
				h = h2-50
				y2 = 50
				scale = scale*0.6
			obj.x = ranDom(100,w-x1)
			obj.y = Math.random()*(h-y1)+y2
			console.log obj.x+220/2,obj.y+220/2
			obj.regX = 220/2
			obj.regY = 220/2
			obj.VA = -0.02
			obj.alpha = 1
			obj.scaleX = obj.scaleY = 1
			obj.esX = obj.esY = scale
			obj.espeed = 0.08
			obj.exy = "small"
			obj.runaway = setTimeout ()->
				runawayBug obj
			, buglife
			_dom_bugs_box.addChild obj
			stage.update()
			obj.addEventListener 'click',bugclick
		, Math.random()*1000
		yes
addSomeBugs = ->
	if bugsNum > 2
		changeBackgroud()
	randomBugs bugsNum-1,bugsNum+1
	bugsNum += 1.5

bugclick = (evt)->
	console.log evt
	clearTimeout evt.target.runaway
	evt.target.gotoAndStop 1
	evt.target.exy = "remove"
	evt.target.removeEventListener 'click',bugclick
	if score < 10
		fsize = 24
	if score < 100
		fsize = 20
	else 
		fsize = 18
	score += 1
	text = new createjs.Text "+"+score,fsize+"px Arial","#ff0000"
	
	if score < 10
		text.x = 35
		text.y = 20
	if score < 100
		text.x = 35
		text.y = 22
	else 
		text.x = 32
		text.y = 24
	text.textAlign = "center"
	dom_score = _dom_score.clone()
	dom_score.x = evt.stageX
	dom_score.y = evt.stageY
	dom_score.Aa = 1
	audio.pause()
	audio.play(0,1)
	dom_score.addChild _dom_score_img.clone(),text
	_dom_score_box.addChild dom_score

	
runawayBug = (obj)->
	obj.removeEventListener "click",bugclick
	obj.exy = "runaway"
	runscore += 1
checkRemoveBugs = ->
	if runscore >= overscore && playing
		playing = false
		GameOver()
	else if _dom_bugs_box.getNumChildren() <= 0 && playing
		addSomeBugs()

# 第一画面
firstFrame = ->
	createAllDom()
	addSomeBugs()

# 游戏结束
GameOver = ->
	createjs.Ticker.removeEventListener "tick", tick
	createjs.Ticker.removeEventListener "tick", stage
	endGame score

	# canvas = {}
	# stage = {}
	# images = {}
	playing = true
	count = 0
	manifest = {}
	overscore = 3
	score = 0
	runscore = 0
	canaddBugs = true
	bugsNum = 2
	# buglife = 5000
	# game dom
	# loadingTxt = {}

	# _dom_bug1 = {}
	# _dom_bug2 = {}
	# _dom_bug3 = {}



	# alert 'Game over Score:'+score
