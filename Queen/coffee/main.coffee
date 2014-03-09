# public Variable
loader = {}
canvas = {}
stage = {}
exportRoot = {}
count = 0
loadingTxt = ""
publicW = publicH = 640
manifest = {}
images = {}
queen = {}
banner = {}

_facecenter = {x:360,y:460}
_faceovercenter = {x:310,y:320}

# firframe
_dom_border = {}
_dom_bg = {}
_dom_banner = {}
_dom_Bbegin = {}
_dom_Bnext = {}
_dom_mark = {}
_dom_welcomeText = {}
_dom_mc1 = {}
_dom_queen = {}
_dom_uploadText1 = {}
_dom_uploadText2 = {}
_dom_uploadfile1 = {}
_dom_uploadfile2 = {}
_dom_faceInfo1 = []
_dom_faceInfo2 = []
_dom_gamebg = {}
_dom_pop1 = {}
_dom_pop2 = {}
_dom_gameone_text = {}
_dom_gametwo_text = {}
_dom_gameover = {}
_dom_btn_again = {}
_act_shan = {}
_act_dj = {}
_hide_mark = 0
_remove_mark = false
# 缩放
_defaultMove = 0
_defaultscale = 1
tempscale = 1
_defaultscale1 = 1
_defaultscale2 = 2

myGetId = (id)->
	document.getElementById id
init = ->
	publicH = document.body.clientHeight*640/document.body.clientWidth
	# console.log publicH
	canvas = myGetId 'canvas'
	# $(canvas).attr 'width',640/document.body.clientWidth
	# $(canvas).attr 'height',publicH
	stage = new createjs.Stage canvas
	# stage.autoClear = false
	createjs.Touch.enable stage
	stage.enableMouseOver 10
	stage.mouseMoveOutside = true
	loadingTxt = new createjs.Text '', 'bold 24px Arial', '#000000'
	loadingTxt.x = 230
	loadingTxt.y = 450
	stage.addChild loadingTxt
	stage.update()
	loadImg()
	bindUploadFile()
	gotoTick()
	# loadingTxt.text = "99"
	# stage.update()
	# loadingTxt.text = "998"
	# testimg = new createjs.Bitmap "img/bg.jpg"
	# stage.addChild testimg
	# stage.update()
	
bindUploadFile = ->
	myGetId('firstface').addEventListener 'change',(e)->
		files = this.files 
		if files.length > 0
			handleLocalFile files[0],1
	myGetId('secondface').addEventListener 'change',(e)->
		files = this.files 
		if files.length > 0
			handleLocalFile files[0],2
loadImg = ->
	images = images||{}
	manifest = [
		{src:"img/bg.jpg", id:"bg"}
		{src:"img/banner.png", id:"banner"}
		{src:"img/border.png", id:"border"}
		{src:"img/btn-begin.png", id:"btn-begin"}
		{src:"img/btn-next.png", id:"btn-next"}
		{src:"img/btn-restart.png", id:"btn-restart"}
		{src:"img/queen.png", id:"queen"}
		{src:"img/mark.png", id:"mark"}
		{src:"img/gamebg.png", id:"gamebg"}
		{src:"img/game-1-1.png", id:"game-1-1"}
		{src:"img/game-2-1.png", id:"game-2-1"}
		{src:"img/game-1-2.png", id:"game-1-2"}
		{src:"img/game-2-2.png", id:"game-2-2"}
		{src:"img/game-over.png", id:"game-over"}
		{src:"img/game-again.png", id:"game-again"}
		{src:"img/share.png", id:"share"}
		{src:"img/over-text.png", id:"over-text"}
		{src:"img/action-shan.png", id:"action-shan"}
		{src:"img/action-dj.png", id:"action-dj"}
		{src:"img/chicken.png", id:"chicken"}
	]
	loader = new createjs.LoadQueue false
	loader.installPlugin createjs.Sound
	loader.addEventListener "fileload", handleFileLoad
	loader.addEventListener "complete", handleComplete
	loader.loadManifest manifest
# 加载中 0310
handleFileLoad = (evt)->
	$ '#loading'
	.hide()
	images[evt.item.id] = evt.result if evt.item.type is "image"
	count++
	loadingTxt.text = "加载了: "+Math.floor(count/manifest.length*100)+"%";
	stage.update()
	firstFrame() if count == manifest.length
# 加载结束,开启第一画面
handleComplete = (evt)->

# fortest = ->
# 	showUpload 'first'
clickbg = (e)->
	# console.log e
window.onload = ->
	queen = new Queen()
	init()
handleLocalFile = (file,index)->
	if index is 1
		stage.removeChild _dom_uploadText1 
	else 
		stage.removeChild _dom_uploadText2

	url = webkitURL.createObjectURL file
	# console.log url
	$img = new Image()
	$img.onload = ->
		if index is 1 
			_dom_faceInfo1 = [{x:$img.width/2,y:$img.height/2,width:1,height:1}]
			deg = 0
			_dom_uploadfile1 = new createjs.Shape();
			_dom_uploadfile1.graphics.beginFill("#fff").drawRect(-1000,-1000,3000,3000).beginFill("#FFF");
			# _dom_uploadfile1 = new createjs.Bitmap $img
			# _dom_uploadfile1.setTransform 0,0,99,99
			_dom_uploadfile1.alpha = 0.01
			_dom_uploadfile1.cursor = "pointer"
			$img.id = "face1"
			# $imgc = $($img).clone()
			# $imgc.attr
			# 	"id":"face1"
			$("#mubu").append $img
			EditUploadFace deg
		else
			# 面部识别
			# $(".facehide").append $img
			# _dom_faceInfo2 = $($img).faceDetection
			# 	complete: ->
			# 		console.log "Done!"
			# 	error: (img,code,message)->
			# 		console.log message
			_dom_faceInfo2 = [{x:$img.width/2,y:$img.height/2,width:1,height:1}]
			deg = 0
			_dom_uploadfile2 = new createjs.Shape();
			_dom_uploadfile2.graphics.beginFill("#fff").drawRect(-1000,-1000,3000,3000).beginFill("#FFF");
			# _dom_uploadfile2 = new createjs.Bitmap $img
			# _dom_uploadfile2.setTransform 0,0
			_dom_uploadfile2.alpha = 0.01
			_dom_uploadfile2.cursor = "pointer"
			$img.id = "face2"
			$("#mubu").append $img
			EditUploadHappyFace deg
	$img.src = url
	$ ".firstframe,.secondframe"
	.hide()

changeface = (e)->
	# console.log e.values

gotoTick = ->
	createjs.Ticker.setFPS 30
	createjs.Ticker.addEventListener "tick", tick
	createjs.Ticker.addEventListener "tick", stage
firstFrame = ->
	queen.init images
	stage.removeChild loadingTxt
	# createjs.Ticker.addEventListener "tick", stage
	welcomeText = new createjs.Text '联想30年有你相伴\n今天你说了算', 'normal 36px MicrosoftYaHei', '#ffffff'
	welcomeText.textAlign = "center";
	welcomeText.setTransform 318,500
	border = queen.getDomBit "border"
	bg = queen.getDomBit "bg"
	mark = queen.getDomBit "mark"
	mark.setTransform 0,0,640,920
	banner = queen.getDomBit "banner"
	banner.setTransform 200,180
	begin = queen.getDomBit "btn-begin"
	begin.setTransform 220,735
	mc = new createjs.MovieClip null, 0, true, {start:0, middle:50}
	mc.timeline.addTween createjs.Tween.get(banner).to({y:220}).to({y:260}, 40).to({y:220}, 40)
	
	mc.gotoAndPlay 'middle'
	# set public var

	_dom_welcomeText = welcomeText
	_dom_border = border
	_dom_bg = bg
	_dom_banner = banner
	_dom_Bbegin = begin
	_dom_mc1 = mc
	_dom_mark = mark
	_dom_gamebg = queen.getDomBit 'gamebg'

	stage.removeAllChildren()
	# stage.clear()
	stage.addChild _dom_bg,_dom_Bbegin,_dom_mark,_dom_welcomeText,_dom_mc1,_dom_border
	# stage.addChild _dom_Bbegin
	# stage.update()
	mark.addEventListener 'click',startFirstFrame
	begin.addEventListener 'pressup',startUploadFace
	# startFirstFrame mark

startUploadFace = ->
	
	_dom_queen = queen.getDomBit 'queen'
	_dom_banner.setTransform 20,100
	_dom_uploadText1 = new createjs.Text '上传生气的头像', 'normal 14px MicrosoftYaHei', '#000000'
	_dom_uploadText1.textAlign = "center";
	_dom_uploadText1.setTransform 308,320
	tixing = new createjs.Text '试试看拖动或者\n缩放你上传的照片', 'normal 18px MicrosoftYaHei', '#ffffff'
	tixing.textAlign = "center";
	tixing.setTransform 318,770
	stage.removeAllChildren()
	# stage.clear()
	stage.addChild _dom_gamebg,_dom_uploadText1,tixing,_dom_border,_dom_mc1
	showUpload "first"
	
showUpload = (text)->
	setTimeout ()->
		$ "."+text+"frame"
		.show()
	, 500
EditUploadFace = (deg)->
	
	# _dom_uploadfile1.addEventListener "touchmove",fileMove

	_dom_Bnext = queen.getDomBit 'btn-next'
	_dom_Bnext.setTransform 220,735
	
	# 脸部识别后,进行自动对其
	# container = new createjs.Container();
	# container.x = 0
	# container.y = 0
	
	# max = 0
	# for i in _dom_faceInfo1
		# max = i if i.width*i.height > max || i.width*i.height > max.width*max.height

	# console.log max
	#首先计算 横竖
	deg = 0
	scale = 1
	a = _dom_uploadfile1
	img = a.image
	# if img.width > img.height
	# 	deg = 90
	# 	scale = if img.height>640 then 640/img.height else 1
	# 	h = img.height * scale
	# 	w = img.width * scale
	# 	x = h+(_facecenter.x - h/2)
	# 	y = (_facecenter.y - w/2)
	# else 
	# if img.width > 640
	# 	scale = 640/img.width
	# 	h = img.height * scale
	# 	w = img.width * scale
	# 	x = (_facecenter.x - w/2)
	# 	y = (_facecenter.y - h/2)
	# else
	# 	h = img.height * scale
	# 	w = img.width * scale
	# 	x = (_facecenter.x - w/2)
	# 	y = (_facecenter.y - h/2)
	# _dom_uploadfile1.setTransform x,y,scale,scale,deg
	stage.removeAllChildren()
	# stage.clear()
	stage.addChild _dom_uploadfile1,_dom_gamebg,_dom_Bnext,_dom_border,_dom_mc1
	# stage.addChild _dom_uploadfile1
	# stage.update()
	# gotoTick()
	# hitArea = new createjs.Shape()
	# hitArea.graphics.beginFill("#FFF").drawRect(0, 0, _dom_uploadfile1.image.width, _dom_uploadfile1.image.height)
	# hitArea.x = 0
	# hitArea.y = 0
	# _dom_uploadfile1.hitArea = hitArea
	_dom_uploadfile1.addEventListener "mousedown",fileDown
	_dom_uploadfile1.addEventListener "pressmove",fileMove
	_dom_uploadfile1.addEventListener "pressup",fileMoveOver
	# 这里需要一个重新选择图片的,还有下面的注释要注意
	_dom_Bnext.addEventListener "click",startUploadHappyFace
	# _dom_Bnext.addEventListener "click",startGame
	# 恢复上传图片的文件.
	# _dom_uploadText1.text = "上传生气的头像"
startUploadHappyFace = ->
	$("#face1").hide()
	_defaultscale1 = _defaultscale
	_defaultMove = 0
	_defaultscale = 1
	tempscale = 1
	
	stage.removeAllChildren()
	# stage.clear()
	_dom_uploadText2 = new createjs.Text '上传开心的头像', 'normal 14px MicrosoftYaHei', '#000000'
	_dom_uploadText2.textAlign = "center";
	_dom_uploadText2.setTransform 308,320
	tixing = new createjs.Text '试试看拖动或者\n缩放你上传的照片', 'normal 18px MicrosoftYaHei', '#ffffff'
	tixing.textAlign = "center";
	tixing.setTransform 318,770
	stage.addChild _dom_gamebg,_dom_uploadText2,tixing,_dom_border,_dom_mc1
	showUpload "second"
EditUploadHappyFace = (deg)->
	# console.log "edit happy face"

	_dom_Bnext.removeEventListener "click",startUploadHappyFace
	# console.log _dom_faceInfo2
	# max = 0
	# for i in _dom_faceInfo2
	# 	max = i if i.width*i.height > max || i.width*i.height > max.width*max.height
	# console.log max
	
	#首先计算 横竖
	deg = 0
	scale = 1
	a = _dom_uploadfile2
	img = a.image 
	stage.removeAllChildren()
	# stage.clear()
	stage.addChild _dom_uploadfile2,_dom_gamebg,_dom_Bnext,_dom_border,_dom_mc1

	# hitArea = new createjs.Shape()
	# hitArea.graphics.beginFill("#FFF").drawRect(0, 0, _dom_uploadfile2.image.width, _dom_uploadfile2.image.height)
	# hitArea.x = 0
	# hitArea.y = 0
	# _dom_uploadfile2.hitArea = hitArea
	_dom_uploadfile2.addEventListener "mousedown",fileDown
	_dom_uploadfile2.addEventListener "pressmove",fileMove
	_dom_uploadfile2.addEventListener "pressup",fileMoveOver

	_dom_Bnext.addEventListener "click",startGame
	# 恢复上传照片的文件.
	# _dom_uploadText2.text = "上传生气的头像"
startGame = ->
	$("#face1").show()
	$("#face2").hide()
	random = Math.random()*100
	# console.log random
	if random > 49
		Gameone()
	else
		Gametwo()
Gametwo = ->
	# 游戏1,倒啤酒
	createActiontwo()
	_dom_gametwo_stuff1 = queen.getDomBit 'chicken'
	_dom_gametwo_stuff1.setTransform 300,705
	_dom_gameone_text = new createjs.Text '点击小人开始倒酒', 'normal 24px MicrosoftYaHei', '#ffffff'
	_dom_gameone_text.textAlign = "center";
	_dom_gameone_text.setTransform 310,790
	# console.log _dom_uploadfile1.image.width*_dom_uploadfile1.scaleX
	stage.removeAllChildren()
	# stage.clear()
	stage.addChild _dom_uploadfile1,_dom_gamebg,_dom_gametwo_stuff1,_act_dj,_dom_pop1,_dom_gameone_text,_dom_border
	
	_act_dj.addEventListener 'pressup',playactiontwo
	
	_dom_uploadfile1.removeEventListener "mousedown",fileDown
	_dom_uploadfile1.removeEventListener "pressmove",fileMove
	_dom_uploadfile1.removeEventListener "pressup",fileMoveOver
	_dom_uploadfile2.removeEventListener "mousedown",fileDown
	_dom_uploadfile2.removeEventListener "pressmove",fileMove
	_dom_uploadfile2.removeEventListener "pressup",fileMoveOver
_numdj = 0
_cangoto = true
playactiontwo = ->
	if _cangoto
		_numdj++
		_act_dj.play()
		_dom_gameone_text.text = "再倒"+(5-_numdj)+"杯"
		_dom_gameone_text.text = "继续点击" if _numdj is 3
		if _numdj is 4
			stage.removeChild _dom_pop1
			stage.addChild _dom_pop2
		return gametwoOver() if _numdj >= 5
		_cangoto = false
		setTimeout ()-> 
			pauseactiontwo()
		, 500
pauseactiontwo = ->
	_act_dj.gotoAndStop 0
	_cangoto = true
Gameone = ->
	# 游戏1,扇扇子
	createActionone()
	_dom_gameone_text = new createjs.Text '按住屏幕3秒给女王降降温', 'normal 24px MicrosoftYaHei', '#ffffff'
	_dom_gameone_text.textAlign = "center";
	_dom_gameone_text.setTransform 348,670
	# console.log _dom_uploadfile1.image.width*_dom_uploadfile1.scaleX
	stage.removeAllChildren()
	# stage.clear()
	stage.addChild _dom_uploadfile1,_dom_gamebg,_act_shan,_dom_pop1,_dom_gameone_text,_dom_border
	
	_dom_gamebg.addEventListener 'mousedown',playaction
	_dom_gamebg.addEventListener 'pressup',stopaction
	
	_dom_uploadfile1.removeEventListener "mousedown",fileDown
	_dom_uploadfile1.removeEventListener "pressmove",fileMove
	_dom_uploadfile1.removeEventListener "pressup",fileMoveOver
	_dom_uploadfile2.removeEventListener "mousedown",fileDown
	_dom_uploadfile2.removeEventListener "pressmove",fileMove
	_dom_uploadfile2.removeEventListener "pressup",fileMoveOver
	# alert "start game"
	# showTextinfo '按住屏幕5s给女王降降温'
_game_one_over = false
_game_one_over_go = {}

playaction = ->
	# console.log "play"
	_game_one_over_go = setTimeout ()-> 
		# console.log "over"
		_dom_gamebg.removeEventListener 'pressup',stopaction
		gameoneOver()
	, 3000
	_act_shan.play()
	stage.removeChild _dom_pop1,_dom_gameone_text
	stage.addChild _dom_pop2
	# stage.update()
stopaction = ->
	# console.log "stop"
	clearTimeout _game_one_over_go
	_act_shan.gotoAndStop 0
	stage.removeChild _dom_pop2
	stage.addChild _dom_pop1
createActionone = ->
	feng = new createjs.SpriteSheet
		"animations":
			"run": [0,1,"run"]
		"images": ["img/action-shan.png"]
		"frames":
			"height":400
			"width":340
			"regX":0
			"regY":0
			"count":2
	grant = new createjs.Sprite feng
	grant.x = 10
	grant.y = 450
	_act_shan = grant

	_dom_pop1 = queen.getDomBit "game-1-1"
	_dom_pop1.setTransform 20,290
	_dom_pop2 = queen.getDomBit "game-1-2"
	_dom_pop2.setTransform 20,290
	_dom_gameover = queen.getDomBit "game-over"
	_dom_gameover.setTransform 20,290
createActiontwo = ->
	feng = new createjs.SpriteSheet
		"framerate":20
		"animations":
			"run": [0,1,"run"]
		"images": ["img/action-dj.png"]
		"frames":
			"height":340
			"width":250
			"regX":0
			"regY":0
			"count":2
	grant = new createjs.Sprite feng
	grant.x = 395
	grant.y = 430
	_act_dj = grant

	_dom_pop1 = queen.getDomBit "game-2-1"
	_dom_pop1.setTransform 20,290
	_dom_pop2 = queen.getDomBit "game-2-2"
	_dom_pop2.setTransform 20,290
	_dom_gameover = queen.getDomBit "game-over"
	_dom_gameover.setTransform 20,290
createGameOverContent = ->


gametwoOver = ->
	$("#face1").fadeOut(500)
	$("#face2").fadeIn(500)
	mark = new createjs.Shape new createjs.Graphics().beginFill("#000000").drawRect(0,0, 640, 920)
	mark.set
		alpha:0.5
	overtext = queen.getDomBit 'over-text'
	overtext.setTransform 32.5,500
	sharetext = queen.getDomBit 'share'
	sharetext.setTransform 445,35
	_dom_btn_again = queen.getDomBit 'game-again'
	_dom_btn_again.setTransform 218.5,705
	_dom_btn_again.addEventListener 'pressup',gameagain
	stage.removeAllChildren()
	# stage.clear()
	stage.addChild _dom_uploadfile2,_dom_gamebg,_act_dj,_dom_gameover,mark,overtext,_dom_btn_again,sharetext,_dom_border

	_act_dj.removeEventListener 'pressup',playactiontwo
	_dom_Bnext.removeEventListener "click",startGame

gameoneOver = ->
	# $("#face1").fadeIn(500)
	# $("#face2").fadeOut(500)

	$("#face1").fadeOut(500)
	$("#face2").fadeIn(500)
	mark = new createjs.Shape new createjs.Graphics().beginFill("#000000").drawRect(0,0, 640, 920)
	mark.set
		alpha:0.5
	overtext = queen.getDomBit 'over-text'
	overtext.setTransform 32.5,500
	sharetext = queen.getDomBit 'share'
	sharetext.setTransform 445,35
	_dom_btn_again = queen.getDomBit 'game-again'
	_dom_btn_again.setTransform 218.5,705
	_dom_btn_again.addEventListener 'pressup',gameagain
	stage.removeAllChildren()
	# stage.clear()
	stage.addChild _dom_uploadfile2,_dom_gamebg,_act_shan,_dom_gameover,mark,overtext,_dom_btn_again,sharetext,_dom_border

	_dom_gamebg.removeEventListener 'mousedown',playaction
	_dom_gamebg.removeEventListener 'pressup',stopaction
	_dom_Bnext.removeEventListener "click",startGame

gameagain = ->
	$("#face1").hide()
	$("#face2").hide()
	window.location.reload()
# function

fileDown = (evt)->
	o = evt.target
	# _defaultscale.scaleX = o.scaleX
	# _defaultscale.scaleY = o.scaleY
	# console.log _defaultscale
	# if evt.nativeEvent.targetTouches.length > 1
	# 	a = evt.nativeEvent.targetTouches[0]
	# 	b = evt.nativeEvent.targetTouches[1]
	# 	x = a.clientX - b.clientY
	# 	y = a.clientY - b.clientY
	# 	x = if x > 0 then x else -x
	# 	y = if y > 0 then y else -y
	# 	_defaultMove = Math.sqrt x*x+y*y
		# o.parent.addChild o
	o.offset = 
		x:o.x-evt.stageX
		y:o.y-evt.stageY
	# console.log o.offset
	yes
fileMove = (evt)->
	# alert evt.nativeEvent.targetTouches.length
	o = evt.target
	if evt.nativeEvent && evt.nativeEvent.targetTouches && evt.nativeEvent.targetTouches.length > 1
		a = evt.nativeEvent.targetTouches[0]
		b = evt.nativeEvent.targetTouches[1]
		x = a.clientX - b.clientY
		y = a.clientY - b.clientY
		x = if x > 0 then x else -x
		y = if y > 0 then y else -y
		demov = Math.sqrt x*x+y*y
		if _defaultMove is 0
			_defaultMove = demov 
			return true
		scale = (demov - _defaultMove)*0.2
		# alert _defaultscale - scale/100
		# console.log scale
		# o.scaleX = _defaultscale.scaleX + _defaultscale.scaleX/100*scale
		# o.scaleY = _defaultscale.scaleY + _defaultscale.scaleY/100*scale
		# o.x = o.offset.x + o.offset.x/100*scale
		# o.y = o.offset.y + o.offset.y/100*scale
		tempscale = (_defaultscale + scale/100)
		$("#face1").css "transform":"scale("+tempscale+")" if $("#face1").is ':visible'
		$("#face2").css "transform":"scale("+tempscale+")" if $("#face2").is ':visible'
	else if _defaultMove != 0

	else
		o.x = evt.stageX+ o.offset.x
		o.y = evt.stageY+ o.offset.y
	if $("#face1").is ':visible'
		$("#face1").css
			left:o.x+"px"
			top:o.y+"px"
	if $("#face2").is ':visible'
		$("#face2").css
			left:o.x+"px"
			top:o.y+"px"
	# console.log o.offset,o.x,o.y
	yes
fileMoveOver = (evt)->
	if evt.nativeEvent.targetTouches.length <= 0
		_defaultMove = 0
		_defaultscale = tempscale
startFirstFrame = (mark)->
	# console.log mark.target
	_hide_mark = 0.025
tick = (event)->
	deltaS = event.delta/1000
	# console.log "a"
	if _hide_mark && !(_hide_mark >= 1) 
		_hide_mark +=0.05
		hideMark()
	else if _hide_mark >= 1 && !_remove_mark
		removeMark()

	stage.update event
removeMark = ->
	mark = _dom_mark #queen.getDomBit "mark"
	text = _dom_welcomeText
	stage.removeChild mark,text
	stage.update()
hideMark = ->
	value = (Math.sin(_hide_mark) * 360)
	mark = _dom_mark #queen.getDomBit "mark"
	text = _dom_welcomeText
	mark.setTransform mark.x,mark.y,mark.scaleX,mark.scaleY
	text.setTransform text.x,text.y,text.scaleX,text.scaleY,value
	text.scaleX -= 0.05
	text.scaleY -= 0.05
	mark.scaleX = 640-(_hide_mark*640)
	mark.scaleY = 920-(_hide_mark*920)
	mark.x = (_hide_mark*320)
	mark.y = (_hide_mark*920/2)


class Queen
	images:[]
	# doms:[]
	init: (images)->
		this.images = images
	getDomBit: (name)->
		# console.log loader.getResult name
		hill = new createjs.Bitmap loader.getResult name
		hill
	getDom : (name,x=0,y=0)->
		# return this.findDom name if this.findDom name
		console.log 
		data = 
			images:[this.images[name]]
			frames:
				width:this.images[name].width
				height:this.images[name].height
		spriteSheet = new createjs.SpriteSheet data
		dom = new createjs.Sprite spriteSheet
		dom.x = x
		dom.y = y
		# this.doms.push {name:name,dom:dom}
		dom
	findDom: (name)->
		for a in this.doms
			return a.dom
		return false
	removeDom: (name)->
		# console.log this.findDom(name).dom
		stage.removeChild this.findDom(name).dom
		stage.update()


