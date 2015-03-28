deviceMotionHandler = (eventData)->
	acceleration = eventData.accelerationIncludingGravity
	$(".log").html parseInt(acceleration.x)+","+parseInt(acceleration.y)+","+parseInt(acceleration.z)
$(document).ready ->
	$(".log").html "ready"
	window.addEventListener('devicemotion',deviceMotionHandler, false)

# alert window.DeviceMotionEvent