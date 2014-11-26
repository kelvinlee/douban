_touch =
	defaultMove: 0
	offset:{x:-1,y:-1}
	cnum: 0.001
	scale: -1
	dom: false
	x:0
	y:0
# _touch.target ;

_touch.star = (evt)->
	return if !_touch.dom
	Finger_one = evt.touches[0]
	_touch.x = _touch.dom.x
	_touch.y = _touch.dom.y
	# console.log "dom:",_touch.dom.x,_touch.dom.y
_touch.move = (evt)->
	return if !_touch.dom
	if evt.touches.length>1
		Finger_one = evt.touches[0]
		Finger_two = evt.touches[1]
		x = Finger_one.clientX - Finger_two.clientY
		y = Finger_one.clientY - Finger_two.clientY
		x = if x > 0 then x else -x
		y = if y > 0 then y else -y

		demov = Math.sqrt x*x+y*y
		_touch.defaultMove = demov if _touch.defaultMove is 0
		_touch.scale = _touch.dom.scaleX if _touch.scale is -1
		scale = (demov - _touch.defaultMove)*_touch.cnum
		_touch.dom.scaleX = _touch.dom.scaleY = _touch.scale + scale
	else
		Finger_one = evt.touches[0]
		if (_touch.offset.x is -1) and (_touch.offset.y is -1)
			_touch.offset.x = Finger_one.clientX
			_touch.offset.y = Finger_one.clientY
			# console.log "offset",_touch.x,_touch.dom.x
		x = Finger_one.clientX - _touch.offset.x
		y = Finger_one.clientY - _touch.offset.y
		_touch.dom.x = _touch.x+x
		_touch.dom.y = _touch.y+y

_touch.end = (evt)->
	return if !_touch.dom
	_touch.defaultMove = 0
	_touch.offset.x = -1
	_touch.offset.y = -1
	_touch.scale = -1
