# @codekit-prepend "coffee/plugs.coffee"
# @codekit-prepend "game.coffee"
audio = {}

$(document).ready ->
	# init()
	h = $("body").height()
	$("#mubu").css
		width:$("body").width()
		height:$("body").height()
	if h-170-160 < 500
		$(".gameinfo").addClass 'zoom'
	$(".close").click ->
		$('.da,.pop').addClass 'hideda'
		_smq.push(['custom', '游戏页面', '弹窗', '关闭'])
		_gaq.push(['_trackEvent', '游戏页面', '弹窗', '关闭'])
		setTimeout ()->
			$('.da,.pop').addClass 'hidez'
		, 500
	$(".activeinfo").click ->
		$("#acinfo").removeClass 'hideda hidez'
	$(".proinfo").click ->
		# $("#proinfo").removeClass 'hideda hidez'
	_smq.push(['custom', '游戏页面', '弹窗', '图片1'])
	_gaq.push(['_trackEvent', 'DettolGame-LHW', '按钮', '开始按钮'])
	$("#list").swipeLeft -> 
		$e = $("#list img:visible").next()
		if $e.is "img"
			$("#list img").hide()
			$("#list").next().find("span").removeClass 'on'
			$("#list").next().find("span").eq($e.index()).addClass 'on'
			_smq.push(['custom', '游戏页面', '弹窗', '图片'+$e.index()])
			_gaq.push(['_trackEvent', '游戏页面', '弹窗', '图片'+$e.index()])
			$e.show()
		if not $e.is "img"
			$('.da,.pop').addClass 'hideda'
			setTimeout ()->
				$('.da,.pop').addClass 'hidez'
			, 500
	.swipeRight ->
		$e = $("#list img:visible").prev()
		if $e.is "img"
			$("#list img").hide()
			$("#list").next().find("span").removeClass 'on'
			$("#list").next().find("span").eq($e.index()).addClass 'on'
			_smq.push(['custom', '游戏页面', '弹窗', '图片'+$e.index()])
			_gaq.push(['_trackEvent', '游戏页面', '弹窗', '图片'+$e.index()])
			$e.show()
	$("#procontent").swipeLeft -> 
		$e = $("#procontent .item:visible").next()
		if $e.is ".item"
			$("#procontent .item").hide()
			$("#procontent").next().find("span").removeClass 'on'
			$("#procontent").next().find("span").eq($e.index()).addClass 'on'
			$e.show()
	.swipeRight -> 
		$e = $("#procontent .item:visible").prev()
		if $e.is ".item"
			$("#procontent .item").hide()
			$("#procontent").next().find("span").removeClass 'on'
			$("#procontent").next().find("span").eq($e.index()).addClass 'on'
			$e.show()
	loadImg()
	fBindMenuBtn()
	orientationChange()
loadEnd = ->
	$(".loading").hide()
	
	# audio.addEventListener 'ended', ->
	# 	setTimeout ->
	# 		# audio.play()
	# 	,500
	# , false
	# audio.play()
fBindMenuBtn = ->
	$(".startgame").click ->
		startGame()
	$(".gotoshare").click ->
		showShare()
	$(".proinfo").click ->
	$(".activeinfo").click ->

startGame = ->
	$(".clouds").hide()
	$ "#mubu"
	.css
		"z-index":10099 
	$ ".gameinfo,.menu"
	.addClass "hide hide-menu"
	$(".main").addClass 'gamestart' 
	init()
endGame = (score)->
	$(".clouds").show()
	$ "#mubu"
	.css
		"z-index":9
	$ ".gameinfo .score"
	.text score
	$ ".gameinfo,.menu"
	.removeClass "hide hide-menu"
	$ ".gameinfo .gamebox,.gameinfo .sharebox"
	.hide()
	$ ".gameinfo .gameoverbox"
	.show()
	$(".main").removeClass 'gamestart'
	gico.BindShare '#细菌别流传，快乐不间断# 灭菌有神器，滴露送好礼。我刚刚神勇地消灭了'+score+'个细菌！和Angela一起，刷新好成绩，留住健康更哈皮，快来挑战吧！@滴露官方微博','http://m.dettol.com.cn/qr/LHW','http://m.dettol.com.cn/qr/LHW/img/share.jpg'

showShare = ->
	$ ".gameinfo,.menu"
	.removeClass "hide hide-menu"
	$ ".gameinfo .gamebox,.gameinfo .gameoverbox"
	.hide()
	$ ".gameinfo .sharebox"
	.show()

changeBackgroud = ->
	if _orien
		if $(".main").is '.bg1'
			$(".main").removeClass 'bg1 bg2'
			$(".main").addClass 'bg2'
		else if $(".main").is ".bg2"
			$(".main").removeClass 'bg1 bg2'
		else
			$(".main").removeClass 'bg1 bg2'
			$(".main").addClass 'bg1'
