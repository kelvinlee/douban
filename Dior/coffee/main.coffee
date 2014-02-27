# @codekit-prepend "plugs.coffee";

$(document).ready ->

changed = (o)->
	console.log $(o).height()
	$(".banner").attr "style","padding-top:"+$(o).height()+"px"