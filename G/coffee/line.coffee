class Line
	constructor: (@args) ->
		# body...
		# {@img} = @args
		@parent = new createjs.Container()
		max = 3
		min = 1
		@r = @.getrandom max,min
		@.initialize()
		
		# return @parent
		# console.log "create line"
	# Line.prototype = new createjs.Container()
	# parent: new createjs.Container()
	initialize : ->
		# @.removeAllChildren() 
		switch @r
			when 1 then @.createLeft()
			when 2 then @.createRight()
			when 3 then @.createCenter()
			else
				console.log "none"
		return @
	createCenter:->
		@icon1 = new createjs.Bitmap preload.getResult "icon-c-1"
		@icon2 = new createjs.Bitmap preload.getResult "icon-r-3"
		@icon1w = preload.getResult("icon-c-1").width
		@icon1h = preload.getResult("icon-c-1").height
		@icon2w = preload.getResult("icon-r-3").width
		@icon2h = preload.getResult("icon-r-3").height
		@linebox = new createjs.Shape()
		@.parent.x = 10
		g = @linebox.graphics
		g.beginStroke("#ffffff")
		g.setStrokeStyle 4,"round"
		g.moveTo 76,74
		g.lineTo 210,74
		g.moveTo 640-210,74
		g.lineTo 640-@icon2w,74
		@icon1.y = 3
		@icon2.x = 640- @icon2w - 10
		@icon1.x = 10
		@.parent.height = 75
		@.parent.width = 640
		g.closePath()
		@parent.addChild @icon1,@icon2,@linebox

	createRight:->
		ln = @.getrandom 4,1
		@icon = new createjs.Bitmap preload.getResult "icon-r-"+ln
		@iconw = preload.getResult("icon-r-"+ln).width
		@iconh = preload.getResult("icon-r-"+ln).height
		@linebox = new createjs.Shape()
		@ln = ln
		@.parent.x = 640-400-10
		g = @linebox.graphics
		g.beginStroke("#ffffff")
		g.setStrokeStyle 4,"round"
		switch ln
			when 1
				g.moveTo 370,77
				g.lineTo 0,77
				@icon.x = 400- @iconw - 10
				@.parent.height = 77
				@.parent.width = 400
			when 2
				g.moveTo 329,73
				g.lineTo 0,73
				@icon.x = 400- @iconw - 10
				@.parent.height = 75
				@.parent.width = 400
			when 3
				g.moveTo 329,73
				g.lineTo 0,73
				@icon.x = 400- @iconw - 10
				@.parent.height = 75
				@.parent.width = 400
			when 4
				g.moveTo 349,72
				g.lineTo 0,72
				@icon.x = 400- @iconw - 10
				@.parent.height = 75
				@.parent.width = 400
		g.closePath()
		@parent.addChild @icon,@linebox
	createLeft : ->
		ln = @.getrandom 1,4
		@icon = new createjs.Bitmap preload.getResult "icon-l-"+ln
		@iconw = preload.getResult("icon-l-"+ln).width
		@iconh = preload.getResult("icon-l-"+ln).height
		@linebox = new createjs.Shape()
		@ln = ln
		g = @linebox.graphics
		g.beginStroke("#ffffff")
		g.setStrokeStyle 4,"round"
		switch ln
			when 1
				g.moveTo 50,57
				g.lineTo 400,57
				@icon.x = 10
				@.parent.height = 60
				@.parent.width = 400
			when 2
				g.moveTo 43,10
				g.lineTo 43,0
				g.moveTo 43,0
				g.lineTo 400,0
				@icon.x = 10
				@icon.y = 10
				@.parent.height = 106
				@.parent.width = 400
			when 3
				g.moveTo 72,73 
				g.lineTo 400,73
				@icon.x = 10
				@icon.y = 0
				@.parent.height = 75
				@.parent.width = 400
			when 4
				g.moveTo 72,66
				g.lineTo 400,66
				@icon.x = 10
				@icon.y = 0
				@.parent.height = 72
				@.parent.width = 400
		g.closePath()
		@parent.addChild @icon,@linebox
	getrandom : (max,min)->
		return parseInt(Math.random()*(max-min+1)+min)
	hitLine : (pointx,pointy,hit) ->
		# console.log @.x,@.y,@linebox.x,@linebox.y
		if @r is 3
			return @.checkCenter pointx,pointy,hit
		if pointx > @.parent.x + @.parent.width
			return false
		if pointx + hit < @.parent.x
			return false
		if pointy > @.parent.y + @.parent.height
			return false
		if pointy + hit < @.parent.y
			return false
		_x = pointx - @.parent.x
		_y = pointy - @.parent.y
		# console.log "maybe hit: ",@ln,_x,@iconw,_y,@iconh,@iconh-hit
		switch @r
			when 1
				# console.log "maybe hit: ",@ln,_x,@iconw,_y,@iconh,@iconh-hit
				@.checkLeft(_x,_y,@iconw,@iconh,hit)
			when 2 
				@.checkRight(_x,_y,@iconw,@iconh,hit) 
	checkCenter: (pointx,pointy,hit)->
		
		if pointy > @.parent.y + @.parent.height
			return false
		if pointy + hit < @.parent.y
			return false
		if (pointx > 210 and pointx < 640-210)
			return false
		_x = pointx - @.parent.x
		_y = pointy - @.parent.y
		# console.log "center:",_x,_y
		GameOver() if _y <= @icon2h - 2 and _y > @icon2h- hit - 4 
		# if pointy + hit < @.parent.y + @icon2h + 4 and


	checkRight:(_x,_y,@iconw,@iconh,hit)->
		# console.log _x,_y,@iconw,@iconh,hit
		fd = 0
		fd = 20 if @ln is 1
		# GameOver() if _x + hit > 640 - @icon.x + fd
		switch @ln
			when 1
				GameOver() if _y <= @iconh - 2 and _y > @iconh- hit - 4 
			when 2
				GameOver() if _y <= @iconh - 2 and _y > @iconh- hit - 4 
			when 3
				GameOver() if _y <= @iconh - 2 and _y > @iconh- hit - 4 
			when 4
				GameOver() if _y <= @iconh - 2 and _y > @iconh- hit - 4 

	checkLeft: (_x,_y,@iconw,@iconh,hit)->
		# if _x < @iconw
		# 	GameOver()
		switch @ln
			when 1 
				GameOver() if _y <= @iconh - 2 and _y > @iconh- hit - 4 
			when 2 
				GameOver() if _y <= 4
			when 3
				GameOver() if _y <= @iconh and _y > @iconh- hit - 4 
			when 4
				GameOver() if _y <= @iconh and _y > @iconh- hit - 4 