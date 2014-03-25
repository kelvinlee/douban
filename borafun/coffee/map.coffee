class baiduMap
	constructor: (@name,@r) ->
		if BMap?
			this.init @name,@r
		# ... 
	Point: (lng = 116.404,lat = 39.915)->
		return new BMap.Point lng,lat
	init: (id,r = 15)->
		map = new BMap.Map id
		center = this.Point()
		map.centerAndZoom center, r
		@bmap = map
	ShowLoading: ->
	HideLoading: ->
	pointClick: (evt)->
	getMy: (callback)->
		this.ShowLoading()
		$this = this
		map = @bmap
		@callbackalready = false
		geolocation = new BMap.Geolocation()
		geolocation.getCurrentPosition (r)->
			if this.getStatus() == BMAP_STATUS_SUCCESS
				mk = $this.ownMark r.point, "It's my place.", 'mySelfPoint'
				map.addOverlay mk
				map.panTo r.point
				callback 0,map,r.point
			else
				callback this.getStatus(),true
		, {enableHighAccuracy:true}
		setTimeout ->
			callback 9,true
		,5000
	searchCity: (keys,callback)->
		myCity = new BMap.LocalCity()
		console.log "city",myCity
		myCity.get this.searchCityS
		@keys = keys
		@callback = callback
	searchCityS: (result)->
		console.log map,result,result.name
		# map._map.setCenter result.name
		mk = map.ownMark result.center, "It's my place.", 'mySelfPoint'
		map.bmap.addOverlay mk
		map.bmap.panTo result.center
		map.search map.keys,result.center,map.callback
	search: (keys,Spoint,callback)->
		@local = new BMap.LocalSearch @bmap,{renderOptions:{autoViewport:true}}
		local = @local
		local.searchNearby keys, Spoint 
		reload_local = (sd,callback,times)->
			return callback [] if times >= 100
			setTimeout ->
				if sd.length <= 0
					reload_local sd,callback,times++
				else
					callback sd
			,50
		reload_local @local.Sd,callback,0
	addMark : (list)->
		if list.length >= 2
			for a in list
				marker = this.ownMark a.point,a.title, 'PointBar'
				@bmap.addOverlay marker
		else

	ownMark : (point, text, cls)->
		mp = @bmap
		mark = (point, text, cls)->
			this._point = point
			this._text = text
			this._cls = cls
		mark.prototype = new BMap.Overlay()
		mark.prototype.initialize = (map)->
			this._map = map
			div = this._div = document.createElement "div"
			div.style.zIndex = BMap.Overlay.getZIndex this._point.lat
			$(div).addClass this._cls
			div.innerHTML = '<img src="img/'+this._cls+'.png" /><div class="text">'+this._text+'</div>'
			cls = this._cls
			$ div
			.swipe
				tap: (e,t)->
					GameCheck t,cls
			mp.getPanes().labelPane.appendChild div
			return div
		mark.prototype.draw = -> 
			map = this._map
			pixel = map.pointToOverlayPixel this._point
			div = this._div
			$ div
			.css
				left:(pixel.x - $(div).width()/2) + "px"
				top :(pixel.y - $(div).height()/2 ) + "px"
			if $(div).is ".PointBar"
				$ div
				.css 
					top :(pixel.y - $(div).height() ) + "px"

			setTimeout ->
				$ div
				.addClass 'show' 
			,550
		return new mark point, text, cls