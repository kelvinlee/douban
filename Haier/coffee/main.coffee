# @codekit-prepend "js/vendor/Zepto.min.js"
# @codekit-prepend "js/vendor/fx.js"
_log = 0
$(document).ready ->
	$(".pics .pics-list").each ->
		this.addEventListener 'touchstart',startTouch
		this.addEventListener 'touchmove',moveTouch
		this.addEventListener 'touchend',endTouch
	$(".ctrl").each ->
		$ep = $(this)
		$(this).find(".left").click -> 
			moveTouchRight $ep.next()
		$(this).find(".right").click ->
			console.log "bb"
			moveTouchLeft $ep.next()
	$(".model1 a").click ->
		id = $(this).attr 'href'
		console.log  $(id).offset()
		ScrollTop $(id).offset().top/3,$(id).offset().top
		return false
	$(".gotop").click ->
		ScrollTop $(window).scrollTop()/3,0
	fBindCl()

fBindCl = ->
	$(".cltion").click ->
		$(".clpop").remove()
		clpop = $("<div>").addClass 'clpop'
		box = $("<div>").addClass 'box'
		box.append '<div class="close"></div><div class="img"><img src="'+$(this).data('img')+'"/></div>'+'<p>'+$(this).data('content')+'</p>'
		clpop.append box
		$("body").append clpop
		setTimeout ->
			clpop.find(".box").addClass 'show'
		,100
		clpop.click ->
			$(".clpop").remove()
		clpop.on 'touchmove', (e)->
			e.preventDefault()

interpolate = (source,target,pos)->
	return ( source + (target - source) * pos )
easing = (pos)->
	( -Math.cos( pos * Math.PI ) / 2 ) + 0.5
ScrollTop = (duration,tt = 0)->
	duration = duration || 1000
	start = Number new Date()
	startY = window.pageYOffset
	finish = start + duration
	interval = setInterval ->
		now = Number new Date()
		pos = if now>finish then 1 else (now-start) / duration
		# console.log 0,interpolate startY,1000,easing pos
		window.scrollTo 0,interpolate startY,tt,easing pos
		clearInterval interval if now>finish
		return true
	,15
	return 

_x = 0
_y = 0
_move = 0
startTouch = (e)->
	$(e.target).parents(".pics-list").removeClass 'animate'
	_x = e.touches[0].pageX
	_move = $(e.target).parents(".pics-list").attr 'move'
	if not _move?
		_move = 0
	console.log _move,_x
	# $(e.target).parents(".pics-list").css
moveTouch = (e)->
 
	x = e.touches[0].pageX
	move = x - _x + parseInt _move
	e.preventDefault() if Math.abs(x - _x)>10
	# console.log move,$(e.target).parents(".pics-list")
	$(e.target).parents(".pics-list").css "transform","translate("+move+"px,0)"
	$(e.target).parents(".pics-list").css "-webkit-transform","translate("+move+"px,0)"
	$(e.target).parents(".pics-list").attr 'move',move
endTouch = (e)->
	# console.log e.target
	$ep = $(e.target).parents(".pics-list")
	$ep.addClass 'animate'
	move = $ep.attr 'move'
	n = Math.abs Math.round move/640
	n = 0 if n<0 || move>0
	l = $ep.find(".item").length
	n = l-1 if n > l-1
	# console.log n,l
	$ep.addClass 'animate'
	$ep.attr 'move',n*-640
	$ep.css "transform","translate("+n*-640+"px,0)"
	$ep.css "-webkit-transform","translate("+n*-640+"px,0)"
	$ep.parent().next().find("span").removeClass 'on'
	$ep.parent().next().find("span").eq(n).addClass 'on'
	console.log $ep.parent().next()
moveTouchLeft = (ep)->
	e = ep.find(".pics-list")
	e.addClass 'animate'
	move = e.attr 'move'
	if not move?
		move = 0
	move -= 640
	n = Math.abs Math.round move/640
	n = 0 if n<0 || move>0
	l = e.find(".item").length
	n = l-1 if n > l-1
	e.attr 'move',n*-640
	e.css "transform","translate("+n*-640+"px,0)"
	e.css "-webkit-transform","translate("+n*-640+"px,0)"
	e.parent().next().find("span").removeClass 'on'
	e.parent().next().find("span").eq(n).addClass 'on'
moveTouchRight = (ep)->
	e = ep.find(".pics-list")
	e.addClass 'animate'
	move = e.attr 'move'
	if not move?
		move = 0
	move = parseInt move
	move += 640
	n = Math.abs Math.round move/640
	n = 0 if n<0 || move>0
	l = e.find(".item").length
	n = l-1 if n > l-1
	e.attr 'move',n*-640
	e.css "transform","translate("+n*-640+"px,0)"
	e.css "-webkit-transform","translate("+n*-640+"px,0)"
	e.parent().next().find("span").removeClass 'on'
	e.parent().next().find("span").eq(n).addClass 'on'
window.onscroll = (e)->
	top = $(window).scrollTop()
	h = $(window).height()
	if top > 500
		$(".gotop").show()
	else 
		$(".gotop").hide()
	if top > _log
		_log = top
		$("[scroll]").each ->
			if parseInt($(this).attr('scroll')) <= _log
				$(this).removeAttr('scroll')
				$('[data-src]',this).each ->
					$(this).css
						"background-image":"url("+$(this).data("src")+")"
		$("[scale]").each ->
			if ($(this).offset().top) <= (top+h-100)
				$ep = $(this)
				setTimeout ->
					$ep.removeAttr 'scale'
					$ep.addClass 'scale'
				,20
