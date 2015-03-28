# @codekit-prepend "../../libs/js/min/preloadjs-0.4.1.min.js"
# @codekit-prepend "../../libs/coffee/css3Prefix"
# @codekit-prepend "../../libs/coffee/requestanimation"
# @codekit-prepend "coffee/global"
# @codekit-prepend "../../libs/coffee/share"
# @codekit-prepend "../../libs/coffee/load"

# load list
debug = true

loadList = [
	{id: "logo", src:"img/loading-normal.png"}
]

_wechat_f = 
	"appid": ""
	"img_url": "http://campaign.douban.com/files/campaign/peugeot308s/img/share.jpg"
	"img_width": 300
	"img_height": 300
	"link": "http://campaign.douban.com/files/campaign/peugeot308s/default.html"
	"desc": "这位贵人何不留步，算一卦!"
	"title": "这位贵人何不留步，算一卦!"
_wechat =
	"appid": ""
	"img_url": "http://campaign.douban.com/files/campaign/peugeot308s/img/share.jpg"
	"img_width": 300
	"img_height": 300
	"link": "http://campaign.douban.com/files/campaign/peugeot308s/default.html"
	"desc": "这位贵人何不留步，算一卦!"
	"title": "这位贵人何不留步，算一卦!"
refreshShare = (title)->
	_wechat.title = title
	_wechat_f.title = title
	window.parent.update title if window.parent and window.parent.update
	reloadWechat()


app = angular.module('kelvin', ["ngRoute","ngTouch","ngAnimate"])
.config ["$routeProvider", "$locationProvider" ,($routeProvider, $locationProvider)->
	$routeProvider.when '/',{
		templateUrl: "home.html"
	}
	$routeProvider.when '/Divination',{
		templateUrl: "Divination.html"
	}
	$routeProvider.when '/end/:id',{
		templateUrl: "end.html"
	}
	$routeProvider.when '/over/:id',{
		templateUrl: "over.html"
	}
	$routeProvider.when '/:rd', {
		templateUrl: "home.html"
	}
]
_tempH = 0
# finishedRiver = ->


# 主要加载
app.controller 'MainController', ($rootScope, $scope, $location, $timeout)->
	if $("body").height() <= 440
		$("body").addClass "iphone4"
	beginload $scope
		# for a in loadList
			# $("img[data-lz=#{a.id}]").attr "src", a.src
	$rootScope.$on "$routeChangeSuccess", ->
		LoadFinished "angular",$scope
	$scope.$watch "loaded", ->
		$(".loaded").removeClass "loaded" if $scope.loaded
	


app.controller 'HomeController', ($rootScope, $scope, $location, $timeout)->
	this.pop = false
	tis = this
	refreshShare "这位贵人何不留步，算一卦!"
	this.star = ->
		# return false
		$location.path("/Divination")
	$rootScope.root = 'here'

app.controller 'DivinationController', ($rootScope, $scope, $location)->
	if $rootScope.root isnt "here"
		$location.path("/")
	temp = false
	$(".divina3")[0].addEventListener ANIMATION_END_NAME, (evt)->
		unless temp
			$scope.$apply ->
				$location.path("/end/"+next)
			temp = true
	acc = {x:0,y:0,z:0}
	SHAKE_THRESHOLD = 800
	last_update = 0
	next = parseInt(Math.random()*4)+1
	shares = ["返璞归真","超炫迷彩","极简歌德","黑超风暴"]
	# 我今日的潮流卦XXXX，这位贵人何不留步，卜一卦！
	refreshShare "我今日的潮流卦【#{shares[next-1]}】，这位贵人何不留步，卜一卦！"
	tis = this
	this.StarMotion = (bool)->
		if bool
			window.addEventListener('devicemotion',tis.deviceMotionHandler, false) if window.DeviceMotionEvent?
		else
			window.removeEventListener('devicemotion',tis.deviceMotionHandler, false) if window.DeviceMotionEvent?
	this.deviceMotionHandler = (eventData)->
		acceleration = eventData.accelerationIncludingGravity
		curTime = new Date().getTime()
		if (curTime - last_update ) > 100
			diffTime = curTime - last_update
			last_update = curTime
			speed = Math.abs(acceleration.x + acceleration.y + acceleration.z - acc.x - acc.y - acc.z)/diffTime*10000
			# console.log speed
			tis.CheckShrimp() if speed > SHAKE_THRESHOLD
			acc.x = acceleration.x
			acc.y = acceleration.y
			acc.z = acceleration.z
	this.CheckShrimp = ->
		# alert "hahahaha"
		$scope.$apply ->
			tis.run = "run"
	this.StarMotion(true)

	# setTimeout ->
	# 	$scope.$apply ->
	# 		$location.path("/end/"+next)
	# ,3000

app.controller 'endController', ($rootScope, $scope, $location, $timeout, $route)->
	if $rootScope.root isnt "here"
		$location.path("/")
	this.endid = $route.current.params.id
	goto = true
	$scope.runPage = (bool)->
		console.log goto and not bool
		if goto and not bool
			goto = false
			$scope.$apply ->
				$location.path("/over/"+$route.current.params.id)



app.controller 'overController', ($rootScope, $scope, $location, $timeout, $route)->
	if $rootScope.root isnt "here"
		$location.path("/")
	console.log $route
	this.id = $route.current.params.id
	this.wechat = false
	shares = ["返璞归真","超炫迷彩","极简歌德","黑超风暴"]
	# refreshShare "我今日的潮流卦#{shares[next-1]}，这位贵人何不留步，卜一卦！"
	BindShare "我今日的潮流卦【#{shares[this.id-1]}】，这位贵人何不留步，卜一卦！", window.location.href, "http://campaign.douban.com/files/campaign/peugeot308s/img/pc-share.jpg"
	this.show = (bool)->
		this.wechat = bool


app.directive "parallax", ($location)->
	return {
		restrict: 'EA'
		link: (scope, elem, attrs)->
			# console.log attrs["noCtrl"]
			_d = {
				x: 0
				y: 0
				birthday: 0
				run: false
			}
			elem.on "touchstart", (evt)->
				touch = evt.touches[0]
				_d.x = touch.pageX
				_d.y = touch.pageY
				_d.birthday = new Date().getTime()
			elem.on "touchmove", (evt)->
				touch = evt.touches[0]
				gone = _d.y - touch.pageY
				# console.log "move",gone
				if gone < -50 and not _d.run and attrs["noCtrl"] isnt "up"
					scope.runPage true
				if gone > 50 and not _d.run and attrs["noCtrl"] isnt "down"
					scope.runPage false
				evt.preventDefault()
			elem.on "touchend", (evt)->
				# scope.runPage true
				_d.run = false
	}