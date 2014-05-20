# @codekit-prepend "js/vendor/Zepto.min.js"

isScrolling_move = false


readygo = (evt)->
	# console.log evt
	closeAll()
	$("#goback").attr 'href',document.referrer
	console.log document.referrer
	document.querySelector('#mySlider').addEventListener('slide', myFunction) if $("#mySlider").length>0
	

$(document).ready ->
	readygo()
	window.addEventListener('push', readygo)
window.addEventListener "load", ->
	setTimeout -> 
		window.scrollTo 0,1
	
showsecondbar = (o)->
	if $("#secondbar").is ".showthis"
		$("#secondbar").removeClass 'showthis'
		$(o).removeClass 'active'
	else
		$("#secondbar").addClass 'showthis'
		$(o).addClass 'active'
myFunction = (evt)->
	# console.log evt.detail.slideNumber
	$("#mySlider .slide-point span").removeClass 'on'
	$("#mySlider .slide-point span").eq(evt.detail.slideNumber).addClass 'on'

closeAll = ->
	$(".pop,.model").removeClass 'active'
signpop = ->
	$("#nologin").addClass 'active'
	$("#nologin").click (e)->
		if not ($(e.target).is(".popbody") || $(e.target).parents(".popbody").length>0)
			$("#nologin").removeClass 'active'
gotopage = (url,animate = true, anit = "slide-in")->
	# console.log isScrolling_move
	if isScrolling_move
		isScrolling_move = false
		return ''

	# alert "go to nextpage"
	if animate
		PUSH
			url : url,
			hash : window.location.hash,
			timeout : null,
			transition : anit
	else
		window.location.href = url;