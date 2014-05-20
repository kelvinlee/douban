# @codekit-prepend "js/vendor/Zepto.min.js"
# @codekit-prepend "js/vendor/fx.js"
_log = 0
$(document).ready ->

goshow = ->
	setTimeout ->
		$("#loadingpage").remove()
		$(".bird2,.bird3").addClass 'on'
	,1000
scrollWin = (e)-> 
	top = $(window).scrollTop()
	h = $(window).height() 
	if top > _log
		_log = top 
		$("[scale]").each ->
			if ($(this).offset().top) <= (top+h-100)
				$ep = $(this)
				setTimeout -> 
					$ep.removeAttr 'scale'
					$ep.addClass 'on'
				,20
window.onscroll = scrollWin