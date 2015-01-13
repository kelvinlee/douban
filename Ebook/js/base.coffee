parallax = {}
getNUMs = 1682
audio1 = document.getElementById("audiobg")
audio2 = document.getElementById("audioss")
audioPlaying = true
# audio2.addEventListener "ended", runAudio
_playIndex = 0
runAudio = (index = 0)->
	_playIndex = index
	if audioPlaying
		if index is 16
			$(".audios .text").show()
			audio2.currentTime = 0 if audio2.currentTime >= 2
			audio2.play()
			audio1.pause()
		else
			$(".audios .text").hide()
			audio2.pause()
			audio1.play()
	if index is 16
		$(".audios .text").show()
	else
		$(".audios .text").hide()
musicIcon = ->
	console.log "audio:",audioPlaying
	if not audioPlaying
		audioPlaying = true
		runAudio _playIndex
		$(".audios .icon").addClass "on"
	else
		audio1.pause()
		audio2.pause()
		audioPlaying = false
		$(".audios .icon").removeClass "on"

sharewechat = (bool = true)->
	if bool
		$(".wechat").removeClass("hide").addClass "show"
	else
		$(".wechat").removeClass("show").addClass "hide"


selectPaper = (e)->
	$(".tabs").removeClass "on1 on2 on3 on4 on5"
	.attr "now", e
	.addClass "on"+e
selectPoint = (e)->
	$(e).removeClass "gray"
	if $(".point.gray").length <= 0
		setTimeout ->
			$("#firebox").addClass("fireon").html '<img src="img/page-7-fire.png" class="firemove" />'
			runFire()
		,500
_stopParallax = null
_nows = ""
runFire = ->
	if _nows is ""
		_nows = "2"
	else
		_nows = ""
	setTimeout ->
		$(".firemove").attr "src","img/page-7-fire#{_nows}.png"
		runFire()
	,150

checkPageNine = ->
	e = parseInt $(".tabs").attr "now"
	e++
	selectPaper e
	_stopParallax = null if e >= 5
		
_stopHeight = false
stopHeight = ->
	return "" if _stopHeight
	_stopHeight = true
	top = $(".step-list").offset()
	# alert top.height
	$(".page-content").css
		"top": (top.height-1)+"px"

readyLoaded = []
readyLoading = (index)->
	return true if readyLoaded[index] is "loaded"
	e = $("section.page").eq(index)
	# return true if e.length <= 0 or "true" is e.attr "loaded" 
	readyLoaded[index] = "loaded"
	# e.attr "loaded","true"
	e.find("[lz-src]").each (i)->
		# $(this).attr "onload","lzload(#{index})"
		$(this).attr "src",$(this).attr "lz-src"
		true
	e.find("[data-page]").each (i)->
		readyLoading -1+parseInt $(this).attr "data-page"
		true
lzloadlist = []
lzload = (index)->
	if not lzloadlist[index]?
		lzloadlist[index] = 0
	lzloadlist[index] += 1

changeNUMs = (n)->
	n = 99999 if n > 99999
	n = 1 if n < 1
	e = $("#nums")
	n = (n+"").split("").reverse()
	e.find(".num").each (i)->
		if n[4-i]?
			$(this).attr("n",n[4-i]) 
		else
			$(this).attr("n",0)
_timeout = null

init = ->
	parallax = $('.pages').parallax {
		irection: 'vertical'
		drag:      false,		# 是否允许拖拽 (若 false 则只有在 touchend 之后才会翻页)
		loading:   true,		# 有无加载页
		indicator: false,		# 有无指示点
		arrow:     false,		# 有无指示箭头
		onchange: (index, element, direction)->
			# console.log "ready loading:",index
			if $(".page").height() < 450
				$("body").addClass "iphone4"
			else
				$("body").removeClass "iphone4"
			$(".loading").hide() if index is 0
			if index is 1 and $("#boxlist")[0].style.clip?
				box = $("#boxlist").offset()
				$("#boxlist").css
					"transition-duration": "2.5s"
					"transition-delay": "400ms"
					"clip": "rect(-#{box.width/2}px,#{box.width*1.5}px,#{box.height*1.5}px,-#{box.height/2}px)"
			else if $("#boxlist")[0].style.clip? and index isnt 2
				box = $("#boxlist").offset()
				$("#boxlist").css
					"transition-duration": "0s"
					"transition-delay": "0s"
					"clip": "rect(#{box.width}px,0px,0px,#{box.height}px)"
			if index is 8 and _stopParallax is false
				_stopParallax = true
			else
				_stopParallax = false
			runAudio index
			readyLoading index
			readyLoading index+2
			if index is 17
				_timeout = setTimeout ->
					changeNUMs getNUMs
				,1200
			else
				clearTimeout _timeout
				changeNUMs 1
		# orientationchange: (orientation)->
	}

$(document).ready ->
	
	readyLoading 0
	readyLoading 1
	$("#gif").css
		"-webkit-animation": "none"
	if $("#boxlist")[0].style.clip?
		$("#boxlist").addClass("boxlist").css
			"clip": "rect(160px,0px,0px,160px)"
	$("#text5").on "webkitAnimationEnd", ()->
		console.log "finished stamp"
	
	$("[lazy-src]").each ()->
		$(this).attr "src",$(this).attr "lazy-src"
	$("[data-page]").click ->
		parallax.runcode parseInt($(this).attr("data-page"))
	# $(".point.gray").on "touchstar", (e)->
	# 	selectPoint this
	init()
