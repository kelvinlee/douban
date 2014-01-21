# pugls.coffee

class Giccoo
	constructor : (@name)->
		this.checkOrientation()
		# this.BindShare()
	# 增加微信事件.
	weixin : (callback)->
		document.addEventListener 'WeixinJSBridgeReady', callback
	# 增加旋转判断.
	checkOrientation : ()->
		orientationChange = ->
			switch window.orientation
				when 0 then reloadmeta 640,0
				when 90 then reloadmeta 641,"no"
				when -90 then reloadmeta 641,"no"
		reloadmeta = (px,us)-> 
			setTimeout ->
				viewport = document.getElementById "viewport" 
				viewport.content = "width="+px+", user-scalable="+us+", target-densitydpi=device-dpi"
			,100
		window.addEventListener 'load', ->
			orientationChange()
			window.onorientationchange = orientationChange
		window.addEventListener "load", ->
			setTimeout -> 
					window.scrollTo 0,1
	BindShare: (content,url = window.location.href)->
		$ep = this
		list = 
			"qweibo":"http://v.t.qq.com/share/share.php?title={title}&url="
			"renren":"http://share.renren.com/share/buttonshare.do?title={title}&link={url}"
			"weibo":"http://v.t.sina.com.cn/share/share.php?title={title}&url="
			"qzone":"http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url={url}&title={title}"
		$('a[data-share]').click ->
			$ep.fShare list[$(this).data('share')],content,url
	fShare: (url,content,sendUrl)->
		# 分享内容
		content = content.val()
		shareContent = encodeURIComponent content
		pic = ''
		url = url.replace "{title}",shareContent
		# 分享地址
		backUrl = encodeURIComponent sendUrl
		url = url.replace "{url}",backUrl
		# console.log url
		window.open url,'_blank'


gico = new Giccoo 'normal'