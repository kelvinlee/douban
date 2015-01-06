$(document).ready ->
	if $(".page").height() < 450
		$("body").addClass "iphone4"

	# $("[lz-src]").each ()->
		# $(this).attr "src",$(this).attr "lz-src"
	$("[data-page]").click ->
		parallax.runcode parseInt($(this).attr("data-page"))
	# $(".point.gray").on "touchstar", (e)->
	# 	selectPoint this
selectPaper = (e)->
	$(".tabs").removeClass "on1 on2 on3 on4 on5"
	.addClass "on"+e
selectPoint = (e)->
	$(e).removeClass "gray"
	if $(".point.gray").length <= 0
		setTimeout ->
			$("#firebox").addClass("fireon").html '<img src="img/page-7-fire.png" />'
		,500

_stopHeight = false
stopHeight = ->
	return "" if _stopHeight
	_stopHeight = true
	top = $(".step-list").offset()
	# alert top.height
	$(".page-content").css
		"top": top.height+"px"
readyLoaded = []
readyLoading = (index)->
	return true if readyLoaded[index] is "loaded"
	e = $("section.page").eq(index)
	# return true if e.length <= 0 or "true" is e.attr "loaded" 
	readyLoaded[index] = "loaded"
	# e.attr "loaded","true"
	e.find("[lz-src]").each (i)->
		$(this).attr "src",$(this).attr "lz-src"
		true
	e.find("[data-page]").each (i)->
		readyLoading -1+parseInt $(this).attr "data-page"
		true

parallax = $('.pages').parallax {
	irection: 'vertical'
	# swipeAnim: 'cover'
	drag:      false,		# 是否允许拖拽 (若 false 则只有在 touchend 之后才会翻页)
	loading:   false,		# 有无加载页
	indicator: false,		# 有无指示点
	arrow:     false,		# 有无指示箭头
	onchange: (index, element, direction)->
		# console.log "ready loading:",index
		readyLoading index
		readyLoading index+2
	orientationchange: (orientation)->
}