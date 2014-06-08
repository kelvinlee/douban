# @codekit-prepend "js/vendor/Zepto.min.js"
# @codekit-prepend "js/vendor/jquery.cookie.js"
# @codekit-prepend "js/vendor/slider.js"
isScrolling_move = false

stage = {}
canvas = {}

init = ->
	# 开始
	document.querySelector('#mySlider').addEventListener('slide', myFunction) if $("#mySlider").length>0
	canvas = document.getElementById("canvas")
	stage = new createjs.Stage canvas
	# insetIMG "img/car1.jpg"
	# messageField = new createjs.Text '努力加载中...', 'normal 36px Arial', "#000"
	# messageField.maxWidth = 1000
	# messageField.textAlign= "center"
	# messageField.lineHeight = 46
	# messageField.x = canvas.width/2
	# messageField.y = canvas.height/2
	# stage.addChild messageField
	# stage.update()
	date = new Date().getHours()
	# console.log date.getHours()
	if date >= 0 and date <8
		createAnimal 0
	else if date >= 8 and date <12
		createAnimal 1
	else if date >=12 and date <16
		createAnimal 2
	else if date >=16 and date <20
		createAnimal 3
	else
		createAnimal 4
createAnimal = (i)->
	for a in [0...6]
		$("#ani"+(a+1)).attr 'src','animal/'+((i*6)+a)+".jpg"
		$(".slide").eq(a).find("img").attr 'src','animal/'+((i*6)+a)+".jpg"
		console.log 'animal/'+((i*6)+a)+".jpg"
star = ->
	$(".homepage").hide()
	$(".secondpage").show()

selectType = (e)->

	$(".homepage").hide()
	$(".secondpage").hide()
	$(".thirdpage").show()
	x = $(".slide-group").width()*(e-1)
	console.log x,e,$(".slide-group").width()
	$(".slide-group").css
		"-webkit-transition": "0s"
		"transition": "0s"
		"-webkit-transform": "translate3d(-#{x}px, 0px, 0px)"
	$("#slidermini span").removeClass 'on'
	$("#slidermini span").eq(e-1).addClass 'on'


readyto = (e)->
	if isScrolling_move
		isScrolling_move = false
		return ''
	$(".homepage").hide()
	$(".secondpage").hide()
	$(".thirdpage").hide()
	insetIMG $(e).attr 'src'

myFunction = (evt)->
	$("#slidermini span").removeClass 'on'
	$("#slidermini span").eq(evt.detail.slideNumber).addClass 'on'

insetIMG = (url)->
	g = new Image()
	g.src = url
	g.onload = ->
		img = new createjs.Bitmap g
		stage.addChild img
		stage.update()
		$(".fourthpage").show()
		console.log "insert img"


createimg = ->
	val = $("[name=text]").val() || $("[name=text]").html()
	console.log val
	$("[name=text]").hide()
	messageField = new createjs.Text val, 'normal 24px Arial', "#ffd200"
	messageField.maxWidth = 445 - 40
	messageField.textAlign= "left"
	messageField.lineHeight = 34
	messageField.x = 20
	messageField.y = canvas.height-71*1.6

	bg = new createjs.Shape()
	# 背景黑
	# bg.alpha = 0.3
	# p  = bg.graphics.beginFill("#000").drawRect(0,canvas.height-80*1.6,445,200)


	stage.addChild bg,messageField
	stage.update()

	dataURL = canvas.toDataURL("image/png")
	console.log dataURL
	# submit the image and go to the new page create a share page link.
	postimg dataURL.replace(/^data:image\/(png|jpg);base64,/, "")

postimg = (data)->
	$.ajax
		type:"post"
		dataType:"json"
		url:"createimg.php"
		data:[{name:"data",value:data}]
		success: (msg)->
			console.log msg
			if msg.state is 'success'
				# alert '预约成功'
				window.location.href = 'share.php?id='+msg.id
			else
				alert msg.msg




