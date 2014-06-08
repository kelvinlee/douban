class Point

	constructor: (@args) ->
		# body...
		{@img, @hitLine, @lineimg, @fingerimg, @pointw} = @args
		# console.log args
		@.initialize()
		if not @hitLine?
			@hitLine = ->
		@barde = ->
			@._barde()
		@Breathing = ->
			@._Breathing()
		@setDefault = ->
			@._default() 
		@DefaultPonitMove = -> 
			@._defaultPointMove()
		@DefaultFingerMove = ->
			@._defaultfingermove()
	p = Point.prototype = new createjs.Container()
	initialize: ()->
		# @.initialize()
		# console.log @img,@
		@line = new createjs.Bitmap @lineimg
		@line.y = @args.y-45
		@bar = new createjs.Bitmap @img
		@args.x = @args.x+35
		@args.y = @args.y+35
		@bar.x = @args.x
		@bar.y = @args.y
		@bar.regX = 35
		@bar.regY = 35
		# @bar.scaleX = @bar.scaleY = 0.8
		@bar.se = 1.1
		@bar.sd = 0.9
		@bar.big = true
		@bar.Mx = @args.x
		@bar.My = @args.y
		@bar.move = false
		@bar.canmove = true
		@bar.addEventListener('mousedown',@.touchstart)
		@bar.addEventListener('pressup',@.touchend)
		@bar.addEventListener('pressmove',@.touchmove)
		# @._defaultanimate()
		
		@finger = new createjs.Bitmap @fingerimg
		@finger.x = @args.x - 5
		@finger.y = @args.y - 5
		@finger.alpha = 1.4
		@fingerline = new createjs.Shape()
		@fingerline.alpha = 0.6
		# @ligth1 = new createjs.Bitmap @pointw
		
		# @ligth1.x = @args.x
		# @ligth1.y = @args.y
		# @ligth1.regX = 35
		# @ligth1.regY = 35
		# @ligth1.alpha = 0.6
		

		@ligth1 = new createjs.Shape()
		l1 = @ligth1.graphics
		l1.beginFill("#FFF").drawCircle(0,0,@img.width/2).arc(0, 0, @img.width/3, 0, Math.PI * 2, true).closePath()
		@ligth1.x = @args.x
		@ligth1.y = @args.y
		@ligth1.alpha = 0.9
		@ligth1.scaleX = 1
		@ligth1.scaleY = 1


		@ligth2 = new createjs.Shape()
		l2 = @ligth2.graphics
		l2.beginFill("#FFF").drawCircle(0,0,@img.width/2).arc(0, 0, @img.width/3, 0, Math.PI * 2, true).closePath()
		@ligth2.x = @args.x
		@ligth2.y = @args.y
		@ligth2.alpha = 0.9
		@ligth2.scaleX = 1
		@ligth2.scaleY = 1

		p.addChild @line,@ligth1,@ligth2,@fingerline,@finger,@bar

		console.log "index:",p.getChildIndex(@bar),p.getChildIndex @ligth1
	_default: ->
		@bar.Mx = @bar.x - @args.x
		@bar.My = @bar.y - @args.y
		@bar.move = true
		@bar.canmove = true
	_barde : ->
		@bar.scaleX = @bar.scaleY = 1
	_defaultanimate: -> 

	_fingerdefault : ->
		@finger.x = @args.x - 5
		@finger.y = @args.y - 5
		@finger.alpha = 1.4
		@fingerline.alpha = 0.6
		@ligth1.scaleX = @ligth1.scaleY = 1
		@ligth1.alpha = 0.9
		@ligth2.scaleX = @ligth2.scaleY = 1
		@ligth2.alpha = 0.9
		g = @fingerline.graphics
		g.clear()

	_defaultfingermove: ->
		if @bar.x is @args.x and @bar.y is @args.y
			if @ligth1.alpha > 0
				@ligth1.scaleX += 0.04
				@ligth1.scaleY += 0.04
				@ligth1.alpha -= 0.08
			if @ligth1.alpha <= 0 and @ligth2.alpha > 0
				@ligth2.scaleX += 0.04
				@ligth2.scaleY += 0.04
				@ligth2.alpha -= 0.08

			if @finger.alpha < -.4
				@._fingerdefault()
				return false
			if @finger.y < @args.y - 160
				@finger.alpha -= 0.04
				@fingerline.alpha -= 0.02
				return false
			@finger.y -= 10

			g = @fingerline.graphics
			g.clear()
			g.beginStroke("#ffffff")
			g.setStrokeStyle 10,"round"
			g.moveTo @args.x ,@args.y - 5
			g.lineTo @args.x ,@finger.y + 5 
			

		else
			@._hidefinger()
	_hidefinger: ->
		@finger.alpha = 0
		@fingerline.alpha = 0

	_Breathing: ->
		if @bar.scaleX < @bar.se and @bar.big
			@bar.scaleX = @bar.scaleY += 0.03 
			@bar.big = false if @bar.scaleX > @bar.se
		if @bar.scaleX > @bar.sd and not @bar.big
			@bar.scaleX = @bar.scaleY -= 0.03
			@bar.big = true if @bar.scaleX <= @bar.sd 

	_defaultPointMove : ->
		if not @bar.move

		else if Math.abs(@bar.x - @args.x) <= Math.abs(@bar.Mx/10)
			@bar.x = @args.x
			@bar.y = @args.y
			@bar.move = false
		else
			@bar.x -= (@bar.Mx/10)
			@bar.y -= (@bar.My/10)

	touchstart: (evt)->
		if evt.target.canmove
			# console.log evt,evt.target
			GameStar()
			o = evt.target
			o.move = false
			o.offset =
				x:o.x - evt.stageX
				y:o.y - evt.stageY
	touchmove:(evt)-> 
		if evt.target.canmove
			# console.log evt.stageX
			o = evt.target
			o.x = evt.stageX + o.offset.x
			o.y = evt.stageY + o.offset.y
	touchend: (evt)-> 
		if evt.target.canmove
			evt.target.canmove = false
			GameOver()