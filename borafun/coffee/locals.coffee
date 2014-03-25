class Locals
	constructor: (@name) ->
		# ...
		@isLocals = if window.localStorage then true else false
	set: (key,value)->
		window.localStorage.setItem key,value if @isLocals
	get: (key)->
		window.localStorage.getItem key if @isLocals
	remove: (key)->
		window.localStorage.removeItem key if @isLocals