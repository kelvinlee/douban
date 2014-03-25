# here is your CoffeeScript.
# @codekit-prepend "coffee/plugs.coffee";
# @codekit-prepend "coffee/loading.coffee";
# @codekit-prepend "locals.coffee"
# @codekit-prepend "map.coffee"

# 摇晃过一次之后,记录下对应的数据,下次摇晃直接调用.
locals = new Locals()
map = {}
loading = new loading()
already = false
# 地图定位时进行加载提示
document.addEventListener 'WeixinJSBridgeReady', ->
	WeixinJSBridge.call 'hideToolbar'

$(document).ready ->
	window.scrollTo(0, 1)
	loadImg()
	$(".welcome").swipe
		swipeLeft: (e,t)->
			ChangeCar()
		swipeRight: (e,t)->
			ChangeCar()
	$(".car1,.car2").swipe
		tap: (e,t)->
			ChangeCar()
	$(".close").swipe 
		tap: (e,t)->
			$(".pop").hide()
			$(".gamevideo .video-item").html ""
	$(".showre").swipe
		tap: (e,t)->
			$(".pop").hide()
			$(".reser").show()
	$("#point").swipe
		tap: (e,t)->
			showShake()
	$(".carinfo .item").hide()
	$(".carinfo .item:first").show()
	$(".carinfo-point span:first").addClass 'on'
	$(".carinfo").swipe
		swipeLeft:(e,t)->
			$ep = $(".carinfo .item:visible")
			if $ep.next().is ".item"
				$(".carinfo-point span").removeClass 'on'
				$(".carinfo .item").hide()
				$ep.next().show()
				$(".carinfo-point span").eq($ep.next().index()).addClass 'on'
		swipeRight:(e,t)->
			$ep = $(".carinfo .item:visible")
			if $ep.prev().is ".item"
				$(".carinfo-point span").removeClass 'on'
				$(".carinfo .item").hide()
				$ep.prev().show()
				$(".carinfo-point span").eq($ep.prev().index()).addClass 'on'

	fBindFormBtn()
	myK("province").innerHTML = fGetHTMLP()
	myK("city").innerHTML = fGetHTMLC myK("province").value
	myK("dealer").innerHTML = fGetHTMLS myK("province").value,myK("city").value
	myK("province").onchange = ->
		setTimeout ->
			myK("city").innerHTML = fGetHTMLC myK("province").value
			myK("dealer").innerHTML = fGetHTMLS myK("province").value,myK("city").value
			$('#city').change()
			$('#dealer').change() 
		,20
	myK("city").onchange = ->
		setTimeout -> 
			myK("dealer").innerHTML = fGetHTMLS myK("province").value,myK("city").value
			$('#dealer').change()
		,20
	myK("hope").innerHTML = fGetCarTypeHTML()
	myK("cartype").innerHTML = fGetCarTypeHTMLS myK("hope").value
	myK("hope").onchange = ->
		setTimeout ->
			myK("cartype").innerHTML = fGetCarTypeHTMLS myK("hope").value
			$("#hope").change()
			$("#cartype").change()
		,20

	gico.fBindSelect $ 'select'
	bingPointgotoMap()
	$(".logo").swipe
		tap:(e,t)->
			$(".pop,.reser").hide()
			$("#point").addClass "shakeDom"
			$(".welcome").show()
			already = false
			$.cookie 'now',0
	# for test , need delelt.
	# showMap()
	$.cookie 'now',0
changeImage = ->
	$("img[data-src]").each ->
		$(this).attr 'src',$(this).data 'src'
myK = (id)->
	document.getElementById(id)
fBindFormBtn = ->
	$('[name=submit]').click ->
		return alert '姓名不能为空' if $('[name=name]').val().length <=0
		# return alert '请选择性别' if $('[name=sex]').val().length <=0
		return alert '手机号码不能为空' if $('[name=mobile]').val().length <=0
		return alert '手机号码必须是11位数字' if $('[name=mobile]').val().length != 11 
		# return alert '邮箱地址不能为空' if $('[name=email]').val().length <=0
		# reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/
		# return alert '邮箱格式不正确' if not reg.test $('[name=email]').val() 2580
		return alert '请选择欲购车时间' if $('[name=buytime]').val().length <=0
		return alert '请选择感兴趣车型' if $('[name=cartype]').val().length <=0
		return alert '请选择感兴趣车系' if $('[name=hope]').val().length <=0
		return alert '请选择省份' if $('[name=province]').val().length <=0
		return alert '请选择城市' if $('[name=city]').val().length <=0
		return alert '请选择经销商' if $('[name=dealer]').val().length <=0 

		$.ajax
			type:"post"
			dataType:"json"
			url:"reservations.php"
			data:$('[name=register]').serializeArray()
			success: (msg)->
				console.log msg
				if msg.state is 'success'
					# alert '预约成功'
					# window.location.reload()
					showShareBox()
				else
					alert msg.msg
loadImg = ->
	loading.finished = ->
		finishedLoad()
	loading.init [
		{src:"img/btnbg.jpg",id:"btnbg"}
		{src:"img/bg.jpg",id:"bg"}
		{src:"img/logo.png",id:"logo"}
		{src:"img/mySelfPoint.png",id:"mySelfPoint"}
		{src:"img/PointBar.png",id:"PointBar"}
		{src:"img/car1.png",id:"car1"}
		{src:"img/car2.png",id:"car2"}
		{src:"img/yaoyiyao.png",id:"yaoyiyao"}
	]
finishedLoad = ->
	console.log "finished"
	$ "#loading"
	.fadeOut 500
	setTimeout ->
		$("#point").addClass "show"
	,700
	
showShake = ->
	map = new baiduMap 'map'
	map.ShowLoading = ->
		$("#loading2").show()
	map.HideLoading = -> 
		$("#loading2").hide()
	$("#point").removeClass 'shakeDom'
	$(".handshake").addClass 'shakeDom'
	$("#shakeremind").show() 
	$("#shakeremind .point-s").each (i)->
		$this = $(this)
		setTimeout ->
			$this.addClass 'show'
		,700+i*300
	gico.fBindShake()

addMarkBar = (list)->
	console.log list
	# if not $.cookie 'point-list'
	re = [list[0],list[Math.ceil(list.length/2)],list[list.length-1]]
	# 	$.cookie 'point-list',true
	# 	locals.set 'point-list',JSON.stringify re
	# 	# alert re
	# 	# alert locals.get 'point-list'
	# else 
	# 	re = list
	console.log re
	$(".welcome,#shakeremind").fadeOut 500
	map.HideLoading()
	changeImage()
	return alert '对不起,附近没有找到兴趣点' if re.length <= 2
	setTimeout ->
		map.addMark re
	,530

GameCheck = (t,cls)->
	if cls is 'PointBar'
		$ep = $(t).parents("."+cls)
		if $ep.is ".on"
			showGame $ep,$ep.attr 'rel'
		else
			console.log $.cookie('now')?,$.cookie('now')
			if not $.cookie('now')?
				$.cookie 'now',1
			else
				$.cookie 'now',parseInt($.cookie('now'))+1
			$ep.attr 'rel',$.cookie 'now'
			$ep.addClass 'on gray'
			showGame $ep

showGame = (e)->
	game = $(e).attr 'rel'
	if game is "1"
		showGame1()
	else if game is "2"
		showGame2()
	else
		showGameEnd()
showGame1 = ->
	# fanz
	$(".gamevideo .video-item").html '<iframe height=320 width=480 src="http://player.youku.com/embed/XNjg3NjcyMzQ0" frameborder=0 allowfullscreen></iframe>'
	$(".gamevideo,.carinfo,.medal").removeClass 'fanz'
	$(".pop,.gamevideo").show()
	$(".gamevideo").css
		"border-radius":"10px"
	$(".carinfo,.medal").hide()
	setTimeout ->
		$(".gamevideo").addClass("fanz")
	,10
showGame2 = ->
	$(".gamevideo,.carinfo,.medal").removeClass 'fanz'
	$(".pop,.carinfo").show()
	$("#carinfo").css
		"border-radius":"20px"
	$(".gamevideo,.medal").hide()
	setTimeout ->
		$(".carinfo").addClass("fanz")
	,10
showGameEnd = ->
	$(".gamevideo,.carinfo,.medal").removeClass 'fanz'
	$(".pop,.medal").show()
	$(".carinfo,.gamevideo").hide()
	setTimeout ->
		$(".medal").addClass("fanz")
	,10
# homepage
ChangeCar = ->
	$(".car1,.car2").addClass 'moveout'
	setTimeout ->
		ChangeCar_s()
	,300
ChangeCar_s = ->
	$(".car1,.car2").removeClass 'moveout'
	if $(".car1").is '.hide1'
		$(".car1").removeClass 'hide1'
		$(".car2").addClass 'hide2'
	else
		$(".car1").addClass 'hide1'
		$(".car2").removeClass 'hide2'

# Map show
showMap = ->
	return '' if already
	map.ShowLoading()
	gico.fUnBindShake()
	already = true
	map.getMy (err,smap,point)->
		if err
			if err is 2
				alert "对不起,位置结果未知,无法定位你的位置"
			else if err is 3
				alert "对不起,导航结果未知"
			else if err is 4
				alert "地图接口,非法密钥"
			else if err is 5
				alert "非法请求."
			else if err is 6
				alert "没有权限,您已拒绝/关闭定位,或禁止浏览器定位."
			else if err is 7
				alert "定位服务不可用,将导航到您所在城市."
			else if err is 8
				alert "连接超时,请您待网络较好的情况下访问."
			else
				# alert "对不起,位置结果未知,无法定位你的位置"
			already = false
			if not map.callbackalready
				map.callbackalready = smap
				map.searchCity ["美食","KTV","酒吧"], addMarkBar
		else
			# if $.cookie 'point-list'
			# 	console.log locals.get 'point-list'
			# 	addMarkBar JSON.parse locals.get 'point-list'
			# else
			map.callbackalready = true
			map.search ["美食","KTV","酒吧"], point, addMarkBar
bingPointgotoMap = ->
	$(".point-s .point").swipe
		tap:(e,t)->
			showMap()	
showShareBox = ->
	
	content = "#玩的FUN，全城拾趣#全新宝来，时刻趣动生活。我刚刚寻找到了属于自己的1枚FUN勋章！和全新宝来一起，摇动手机加入全城拾趣的队列，赢取丰富礼遇吧！@一汽-大众宝来"
	pic = "http://mobi.mconnect.cn/borafun/img/share.jpg"
	sendUrl = "http://mobi.mconnect.cn/borafun"
	gico.BindShare content,sendUrl,pic
	# url = "http://v.t.sina.com.cn/share/share.php?title={title}&url={url}&pic={pic}"
	# shareContent = encodeURIComponent(content)
	# pic = encodeURIComponent(pic)
	# url = url.replace("{title}", shareContent)
	# url = url.replace("{pic}", pic)
	# backUrl = encodeURIComponent(sendUrl)
	# url = url.replace("{url}", backUrl)
	# # window.open(url, '_blank')
	# window.location.href = url
	$(".gamevideo,.carinfo,.medal").hide()
	$(".pop,.sharebox").show()
DMHandler = ->
	showMap()