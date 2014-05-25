# @codekit-prepend "js/vendor/Zepto.min.js"

isScrolling_move = false


readygo = (evt)->
	# console.log evt
	closeAll()
	# $("#goback").attr 'href',document.referrer if document.referrer?
	# $("#goback").attr 'href',document.referrer
	# console.log document.referrer
	document.querySelector('#mySlider').addEventListener('slide', myFunction) if $("#mySlider").length>0
	checkForm()

$(document).ready ->
	readygo()
	window.addEventListener('push', readygo)
window.addEventListener "load", ->
	setTimeout -> 
		window.scrollTo 0,1
document.addEventListener 'WeixinJSBridgeReady', ->
	WeixinJSBridge.call 'hideToolbar'


showsecondbar = (o)->
	if $("#secondbar").is ".showthis"
		$("#secondbar").removeClass 'showthis'
		$(o).removeClass 'active'
		$(".tab-label",o).text '更多'
	else
		$("#secondbar").addClass 'showthis'
		$(o).addClass 'active'
		$(".tab-label",o).text '收起'
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

checkForm = ->
	if $("form input").length > 0
		$("input[type=checkbox]").each (i)->
			$div = $('<div>').addClass 'checkbox-parent '+$(this).attr 'class'
			$i = $ '<i>'
			$(this).before $div
			$div.addClass($(this).attr('class')).append $ this
			$div.addClass 'on' if $(this).is ':checked'
			$div.append $i 
			$(this).change ->
				$o = $(this)
				setTimeout ->
					if $o.is ':checked'
						$o.parent().addClass 'on'
					else
						$o.parent().removeClass 'on'
				,10

hidecancel = ->
	$("#cancel").removeClass 'active'
showcancel = (o,id)->
	$("#cancel").addClass 'active'
	$("#cancel").click (e)->
		if not ($(e.target).is(".popbody") || $(e.target).parents(".popbody").length>0)
			$("#cancel").removeClass 'active'

editadr = (id)->
	$("#adrctrl").addClass 'active'
	$("#adrctrl").click (e)->
		if not ($(e.target).is(".popbody") || $(e.target).parents(".popbody").length>0)
			$("#adrctrl").removeClass 'active'

hideAll = ->
	$(".pop").removeClass 'active'