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

myGetId = (id)->
	document.getElementById id
init = ->
	publicH = document.body.clientHeight*640/document.body.clientWidth
	console.log publicH
	canvas = myGetId 'canvas'
	# $(canvas).attr 'width',640/document.body.clientWidth
	# $(canvas).attr 'height',publicH
	stage = new createjs.Stage canvas
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
		console.log files.length
		console.log files[0]
		if files.length > 0
			handleLocalFile files[0],1
	myGetId('secondface').addEventListener 'change',(e)->
		files = this.files
		console.log files.length
		console.log files[0]
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
	]
	loader = new createjs.LoadQueue false
	loader.installPlugin createjs.Sound
	loader.addEventListener "fileload", handleFileLoad
	loader.addEventListener "complete", handleComplete
	loader.loadManifest manifest
# 加载中
handleFileLoad = (evt)->
	images[evt.item.id] = evt.result if evt.item.type is "image"
	count++
	loadingTxt.text = "加载了: "+Math.floor(count/manifest.length*100)+"%";
	# loadingTxt.text = "加载了: "+count+"   ,"+manifest.length+"   ,"
	# stage.update()
	firstFrame() if count == manifest.length
# 加载结束,开启第一画面
handleComplete = (evt)->
	# console.log evt
	# alert manifest.length+","+count
	# alert images.length
	# stage.removeChild loadingTxt
	# stage.update()
	# firstFrame()
	# createjs.Ticker.addEventListener "tick", tick
	# fortest()
fortest = ->
	showUpload 'first'
	 
clickbg = (e)->
	console.log e
window.onload = ->
	queen = new Queen()
	init()
handleLocalFile = (file,index)->
	if index is 1
		stage.removeChild _dom_uploadText1
		stage.update()
		_dom_uploadText1.text = "正在上传头像文件"
		stage.addChild _dom_uploadText1
		stage.update()
	else
		_dom_uploadText2.text = "正在上传头像文件"
		# stage.addChild _dom_uploadText2
		stage.update()
	url = webkitURL.createObjectURL file
	console.log url
	$img = new Image()
	$img.onload = ->
		
		w = 640/$img.width
		h = 1
		if w < 1
			h = w
		else
			w = h = 1
		# alert $img.width+","+$img.height
		console.log $img.width,$img.height,w,h
		if index is 1
			$(".facehide").append $img
			_dom_faceInfo1 = $($img).faceDetection
				complete: ->
					console.log "Done!"
				error: (img,code,message)->
					console.log message

			console.log _dom_faceInfo1
			deg = 0
			deg = 90 if $img.width > $img.height
			_dom_uploadfile1 = new createjs.Bitmap $img
			_dom_uploadfile1.setTransform 0,0,w,h,deg
			_dom_uploadfile1.cursor = "pointer"
			EditUploadFace deg
		else
			$(".facehide").append $img
			_dom_faceInfo2 = $($img).faceDetection
				complete: ->
					console.log "Done!"
				error: (img,code,message)->
					console.log message

			deg = 0
			deg = 90 if $img.width > $img.height
			_dom_uploadfile2 = new createjs.Bitmap $img
			_dom_uploadfile2.setTransform 0,0,w,h,deg
			_dom_uploadfile2.cursor = "pointer"
			EditUploadHappyFace deg
	$img.src = url


changeface = (e)->
	console.log e.values

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
	stage.removeAllChildren()
	stage.addChild _dom_bg,_dom_Bbegin,_dom_mark,_dom_welcomeText,_dom_mc1,_dom_border
	# stage.addChild _dom_Bbegin
	# stage.update()
	mark.addEventListener 'click',startFirstFrame
	begin.addEventListener 'pressup',startUploadFace
	# startFirstFrame mark

startUploadFace = ->
	_dom_queen = queen.getDomBit 'queen'
	_dom_banner.setTransform 20,100
	_dom_uploadText1 = new createjs.Text '上传生气的头像', 'normal 24px MicrosoftYaHei', '#cccccc'
	_dom_uploadText1.textAlign = "center";
	_dom_uploadText1.setTransform 348,460
	stage.removeAllChildren()

	stage.addChild _dom_queen,_dom_uploadText1,_dom_border
	stage.update()
	 
	showUpload "first"
	
	
showUpload = (text)->
	setTimeout ()->
		$ "."+text+"frame"
		.show()
	, 500
EditUploadFace = (deg)->
	$ ".firstframe,.secondframe"
	.hide()
	# stage.removeAllChildren()
	# _dom_uploadfile1.addEventListener "touchmove",fileMove

	_dom_Bnext = queen.getDomBit 'btn-next'
	_dom_Bnext.setTransform 220,735
	
	# 脸部识别后,进行自动对其
	container = new createjs.Container();
	container.x = 0
	container.y = 0
	
	max = 0
	for i in _dom_faceInfo1
		max = i if i.width*i.height > max || i.width*i.height > max.width*max.height

	console.log max
	if max != 0
		_dom_uploadfile1.setTransform _dom_uploadfile1.x,_dom_uploadfile1.y,_dom_uploadfile1.scaleX,_dom_uploadfile1.scaleY,0
		w = max.width*_dom_uploadfile1.scaleX
		h = max.height*_dom_uploadfile1.scaleY
		state = new createjs.Shape new createjs.Graphics().beginFill("#999999").drawRect(0,0, w, h)
		x = max.x*_dom_uploadfile1.scaleX+w/2
		y = max.y*_dom_uploadfile1.scaleY+h/2
		state.x = _facecenter.x-x+max.x*_dom_uploadfile1.scaleX
		state.y = _facecenter.y-y+max.y*_dom_uploadfile1.scaleY
		console.log 360-x,460-y,w,h
		_dom_uploadfile1.x = _facecenter.x-x
		_dom_uploadfile1.y = _facecenter.y-y
	else if deg is 90
		w = _dom_uploadfile1.image.width*_dom_uploadfile1.scaleX
		h = _dom_uploadfile1.image.height*_dom_uploadfile1.scaleY
		console.log "daoli",_dom_uploadfile1.x+w,_dom_uploadfile1.y+h
		_dom_uploadfile1.setTransform _dom_uploadfile1.x+h,_dom_uploadfile1.y,_dom_uploadfile1.scaleX,_dom_uploadfile1.scaleY,deg

	# container.addChild state
		# break
		
	stage.addChild _dom_uploadfile1,_dom_queen,_dom_Bnext,_dom_border,_dom_mc1
	# stage.addChild _dom_uploadfile1
	# stage.update()
	gotoTick()
	hitArea = new createjs.Shape()
	hitArea.graphics.beginFill("#FFF").drawRect(0, 0, _dom_uploadfile1.image.width, _dom_uploadfile1.image.height)
	hitArea.x = 0
	hitArea.y = 0
	_dom_uploadfile1.hitArea = hitArea
	_dom_uploadfile1.addEventListener "mousedown",fileDown
	_dom_uploadfile1.addEventListener "pressmove",fileMove
	# 这里需要一个重新选择图片的,还有下面的注释要注意
	_dom_Bnext.addEventListener "click",startUploadHappyFace
	# _dom_Bnext.addEventListener "click",startGame
	# 恢复上传图片的文件.
	# _dom_uploadText1.text = "上传生气的头像"
startUploadHappyFace = ->
	stage.removeAllChildren()
	_dom_uploadText2 = new createjs.Text '上传开心的头像', 'normal 24px MicrosoftYaHei', '#cccccc'
	_dom_uploadText2.textAlign = "center";
	_dom_uploadText2.setTransform 348,460
	stage.addChild _dom_queen,_dom_uploadText2,_dom_border,_dom_mc1
	showUpload "second"
EditUploadHappyFace = (deg)->
	console.log "edit happy face"
	$ ".firstframe,.secondframe"
	.hide()
	stage.removeAllChildren()

	_dom_Bnext.removeEventListener "click",startUploadHappyFace


	console.log _dom_faceInfo2

	max = 0
	for i in _dom_faceInfo2
		max = i if i.width*i.height > max || i.width*i.height > max.width*max.height

	console.log max
	if max != 0
		_dom_uploadfile2.setTransform _dom_uploadfile2.x,_dom_uploadfile2.y,_dom_uploadfile2.scaleX,_dom_uploadfile2.scaleY,0
		w = max.width*_dom_uploadfile2.scaleX
		h = max.height*_dom_uploadfile2.scaleY
		state = new createjs.Shape new createjs.Graphics().beginFill("#999999").drawRect(0,0, w, h)
		x = max.x*_dom_uploadfile2.scaleX+w/2
		y = max.y*_dom_uploadfile2.scaleY+h/2
		state.x = _facecenter.x-x+max.x*_dom_uploadfile2.scaleX
		state.y = _facecenter.y-y+max.y*_dom_uploadfile2.scaleY
		console.log 360-x,460-y,w,h
		_dom_uploadfile2.x = _facecenter.x-x
		_dom_uploadfile2.y = _facecenter.y-y
	else if deg is 90
		w = _dom_uploadfile2.image.width*_dom_uploadfile2.scaleX
		h = _dom_uploadfile2.image.height*_dom_uploadfile2.scaleY
		console.log "daoli",_dom_uploadfile2.x+w,_dom_uploadfile2.y+h
		_dom_uploadfile2.setTransform _dom_uploadfile2.x+h,_dom_uploadfile2.y,_dom_uploadfile2.scaleX,_dom_uploadfile2.scaleY,deg


	stage.addChild _dom_uploadfile2,_dom_queen,_dom_Bnext,_dom_border,_dom_mc1

	hitArea = new createjs.Shape()
	hitArea.graphics.beginFill("#FFF").drawRect(0, 0, _dom_uploadfile2.image.width, _dom_uploadfile2.image.height)
	hitArea.x = 0
	hitArea.y = 0
	_dom_uploadfile2.hitArea = hitArea
	_dom_uploadfile2.addEventListener "mousedown",fileDown
	_dom_uploadfile2.addEventListener "pressmove",fileMove

	_dom_Bnext.addEventListener "click",startGame
	# 恢复上传图片的文件.
	# _dom_uploadText2.text = "上传生气的头像"
startGame = ->
	console.log "random game: "+Math.random()
	# 等比缩放移动面部
	testX = _faceovercenter.x-(_facecenter.x-_dom_uploadfile1.x)*0.4
	testY = _faceovercenter.y-(_facecenter.y-_dom_uploadfile1.y)*0.4
	scaleX = _dom_uploadfile1.scaleX*0.4
	scaleY = _dom_uploadfile1.scaleY*0.4
	_dom_uploadfile1.setTransform testX,testY,scaleX,scaleY
	testX = _faceovercenter.x-(_facecenter.x-_dom_uploadfile2.x)*0.4
	testY = _faceovercenter.y-(_facecenter.y-_dom_uploadfile2.y)*0.4
	scaleX = _dom_uploadfile2.scaleX*0.4
	scaleY = _dom_uploadfile2.scaleY*0.4
	_dom_uploadfile2.setTransform testX,testY,scaleX,scaleY
	_dom_gamebg = queen.getDomBit 'gamebg'

	if Math.random()*100 > 50
		Gameone()
	else
		Gametwo()
Gametwo = ->
	# 游戏1,倒啤酒
	stage.removeAllChildren()
	createActiontwo()
	_dom_gameone_text = new createjs.Text '点击小人开始倒酒', 'normal 24px MicrosoftYaHei', '#ffffff'
	_dom_gameone_text.textAlign = "center";
	_dom_gameone_text.setTransform 310,760
	# console.log _dom_uploadfile1.image.width*_dom_uploadfile1.scaleX
	stage.addChild _dom_uploadfile1,_dom_gamebg,_act_dj,_dom_pop1,_dom_gameone_text,_dom_border
	
	_act_dj.addEventListener 'pressup',playactiontwo
	
	_dom_uploadfile1.removeEventListener "mousedown",fileDown
	_dom_uploadfile1.removeEventListener "pressmove",fileMove
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
	stage.removeAllChildren()
	createActionone()
	_dom_gameone_text = new createjs.Text '按住屏幕5秒给女王降降温', 'normal 24px MicrosoftYaHei', '#ffffff'
	_dom_gameone_text.textAlign = "center";
	_dom_gameone_text.setTransform 348,670
	# console.log _dom_uploadfile1.image.width*_dom_uploadfile1.scaleX
	stage.addChild _dom_uploadfile1,_dom_gamebg,_act_shan,_dom_pop1,_dom_gameone_text,_dom_border
	# stage.addChild _dom_uploadfile1,_dom_gamebg
	# stage.addChild _dom_uploadfile1
	# alert "start game"
	# gotoTick()
	# alert "start game"
	_dom_gamebg.addEventListener 'mousedown',playaction
	_dom_gamebg.addEventListener 'pressup',stopaction
	
	_dom_uploadfile1.removeEventListener "mousedown",fileDown
	_dom_uploadfile1.removeEventListener "pressmove",fileMove
	# alert "start game"
	# showTextinfo '按住屏幕5s给女王降降温'
_game_one_over = false
_game_one_over_go = {}

playaction = ->
	console.log "play"
	_game_one_over_go = setTimeout ()-> 
		console.log "over"
		_dom_gamebg.removeEventListener 'pressup',stopaction
		gameoneOver()
	, 5000
	_act_shan.play()
	stage.removeChild _dom_pop1,_dom_gameone_text
	stage.addChild _dom_pop2
	# stage.update()
stopaction = ->
	console.log "stop"
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
	grant.x = 360
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
	stage.removeAllChildren()

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
	stage.addChild _dom_uploadfile2,_dom_gamebg,_act_dj,_dom_gameover,mark,overtext,_dom_btn_again,sharetext,_dom_border

	_act_dj.removeEventListener 'pressup',playactiontwo
	_dom_Bnext.removeEventListener "click",startGame

gameoneOver = ->
	stage.removeAllChildren()

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
	stage.addChild _dom_uploadfile2,_dom_gamebg,_act_shan,_dom_gameover,mark,overtext,_dom_btn_again,sharetext,_dom_border

	_dom_gamebg.removeEventListener 'mousedown',playaction
	_dom_gamebg.removeEventListener 'pressup',stopaction
	_dom_Bnext.removeEventListener "click",startGame

gameagain = ->
	window.location.reload()
# function
fileDown = (evt)->
	o = evt.target
	# o.parent.addChild o
	o.offset = 
		x:o.x-evt.stageX
		y:o.y-evt.stageY
	# console.log o.offset
	yes
fileMove = (evt)->
	o = evt.target
	o.x = evt.stageX+ o.offset.x
	o.y = evt.stageY+ o.offset.y
	# console.log o.offset,o.x,o.y
	yes
	
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
		console.log this.findDom(name).dom
		stage.removeChild this.findDom(name).dom
		stage.update()


