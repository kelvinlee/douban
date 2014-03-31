// Generated by CoffeeScript 1.7.1

/*
--------------------------------------------
     Begin plugs.coffee
--------------------------------------------
 */
var ChangeCar, ChangeCar_s, DMHandler, GameCheck, Giccoo, Locals, SHAKE_THRESHOLD, addMarkBar, already, baiduMap, bingPointgotoMap, changeImage, deviceMotionHandler, fBindFormBtn, finishedLoad, gico, last_update, last_x, last_y, last_z, loadImg, loading, locals, map, myK, showGame, showGame1, showGame2, showGameEnd, showMap, showShake, showShareBox, _x, _y, _z;

Giccoo = (function() {
  function Giccoo(name) {
    this.name = name;
  }

  Giccoo.prototype.weixin = function(callback) {
    return document.addEventListener('WeixinJSBridgeReady', callback);
  };

  Giccoo.prototype.weixinHide = function() {
    return document.addEventListener('WeixinJSBridgeReady', function() {
      return WeixinJSBridge.call('hideToolbar');
    });
  };

  Giccoo.prototype.getRandoms = function(l, min, max) {
    var i, idx, isEqu, num, val, _i, _j, _ref;
    num = new Array();
    for (i = _i = 0; 0 <= l ? _i < l : _i > l; i = 0 <= l ? ++_i : --_i) {
      val = Math.ceil(Math.random() * (max - min) + min);
      isEqu = false;
      for (idx = _j = 0, _ref = num.length; 0 <= _ref ? _j < _ref : _j > _ref; idx = 0 <= _ref ? ++_j : --_j) {
        if (num[idx] === val) {
          isEqu = true;
          break;
        }
      }
      if (isEqu) {
        _i--;
      } else {
        num[num.length] = val;
      }
    }
    return num;
  };

  Giccoo.prototype.getParam = function(name) {
    var r, reg;
    reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    r = window.location.search.substr(1).match(reg);
    if (r !== null) {
      return unescape(r[2]);
    }
    return null;
  };

  Giccoo.prototype.checkOrientation = function() {
    var orientationChange, reloadmeta;
    orientationChange = function() {
      switch (window.orientation) {
        case 0:
          return reloadmeta(640, 0);
        case 90:
          return reloadmeta(641, "no");
        case -90:
          return reloadmeta(641, "no");
      }
    };
    reloadmeta = function(px, us) {
      return setTimeout(function() {
        var viewport;
        viewport = document.getElementsByName("viewport")[0];
        return viewport.content = "width=" + px + ", user-scalable=" + us + ", target-densitydpi=device-dpi";
      }, 100);
    };
    window.addEventListener('load', function() {
      orientationChange();
      return window.onorientationchange = orientationChange;
    });
    return window.addEventListener("load", function() {
      return setTimeout(function() {
        return window.scrollTo(0, 1);
      });
    });
  };

  Giccoo.prototype.BindShare = function(content, url, pic) {
    var $ep, list;
    if (url == null) {
      url = window.location.href;
    }
    $ep = this;
    list = {
      "qweibo": "http://v.t.qq.com/share/share.php?title={title}&url={url}&pic={pic}",
      "renren": "http://share.renren.com/share/buttonshare.do?title={title}&link={url}&pic={pic}",
      "weibo": "http://v.t.sina.com.cn/share/share.php?title={title}&url={url}&pic={pic}",
      "qzone": "http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url={url}&title={title}&pic={pic}",
      "facebook": "http://www.facebook.com/sharer/sharer.php?s=100&p[url]={url}}&p[title]={title}&p[summary]={title}&pic={pic}",
      "twitter": "https://twitter.com/intent/tweet?text={title}&pic={pic}",
      "kaixin": "http://www.kaixin001.com/rest/records.php?content={title}&url={url}&pic={pic}"
    };
    return $("a[data-share]").unbind('click').bind('click', function() {
      return $ep.fShare(list[$(this).data('share')], content, url, pic);
    });
  };

  Giccoo.prototype.fShare = function(url, content, sendUrl, pic) {
    var backUrl, shareContent;
    if (pic == null) {
      pic = "";
    }
    content = content;
    shareContent = encodeURIComponent(content);
    pic = encodeURIComponent(pic);
    url = url.replace("{title}", shareContent);
    url = url.replace("{pic}", pic);
    backUrl = encodeURIComponent(sendUrl);
    url = url.replace("{url}", backUrl);
    return window.open(url, '_blank');
  };

  Giccoo.prototype.fBindRadio = function(e) {
    var $e;
    $e = this;
    return e.each(function(i) {
      var $div, $i;
      $div = $('<div>').addClass('radio-parent ' + $(this).attr('class'));
      $i = $('<i>');
      $(this).before($div);
      $div.addClass($(this).attr('class')).append($(this));
      $div.append($i);
      return $(this).change(function() {
        var $o;
        $o = $(this);
        $('[name=' + $o.attr('name') + ']').parent().removeClass('on');
        console.log($('[name=' + $o.attr('name') + ']'));
        return setTimeout(function() {
          if ($o.is(':checked')) {
            return $o.parent().addClass('on');
          } else {
            return $o.parent().removeClass('on');
          }
        }, 10);
      });
    });
  };

  Giccoo.prototype.fBindCheckBox = function(e) {
    var $e;
    $e = this;
    return e.each(function(i) {
      var $div, $i;
      $div = $('<div>').addClass('checkbox-parent ' + $(this).attr('class'));
      $i = $('<i>');
      $(this).before($div);
      $div.addClass($(this).attr('class')).append($(this));
      $div.append($i);
      return $(this).change(function() {
        var $o;
        $o = $(this);
        return setTimeout(function() {
          if ($o.is(':checked')) {
            return $o.parent().addClass('on');
          } else {
            return $o.parent().removeClass('on');
          }
        }, 10);
      });
    });
  };

  Giccoo.prototype.fBindSelect = function(e) {
    var $e;
    $e = this;
    return e.each(function(i) {
      var $div, $i, $span;
      $div = $('<div>').addClass('select-parent');
      $span = $('<span>');
      $i = $('<i>');
      $(this).before($div);
      $div.addClass($(this).attr('class')).append($(this));
      if ($(this).val()) {
        $div.append($span.append($(this).find('option[value="' + $(this).val() + '"]').text()));
      } else {
        $div.append($span.append($(this).find('option').text()));
      }
      $div.append($i);
      return $(this).change(function() {
        var $o;
        $o = $(this);
        return setTimeout(function() {
          return $e.fChangeSelectVal($o);
        }, 10);
      });
    });
  };

  Giccoo.prototype.fChangeSelectVal = function(o) {
    if ($(o).val()) {
      return $(o).next().html($(o).find('option[value="' + $(o).val() + '"]').text());
    } else {
      return $(o).next().html($(o).find('option').text());
    }
  };

  Giccoo.prototype.fBindOrientation = function() {
    window.addEventListener('deviceorientation', this.orientationListener, false);
    window.addEventListener('MozOrientation', this.orientationListener, false);
    return window.addEventListener('devicemotion', this.orientationListener, false);
  };

  Giccoo.prototype.orientationListener = function(evt) {
    var alpha, beta, gamma;
    if (!evt.gamma && !evt.beta) {
      evt.gamma = evt.x * (180 / Math.PI);
      evt.beta = evt.y * (180 / Math.PI);
      evt.alpha = evt.z * (180 / Math.PI);
    }
    gamma = evt.gamma;
    beta = evt.beta;
    alpha = evt.alpha;
    if (evt.accelerationIncludingGravity) {
      gamma = event.accelerationIncludingGravity.x * 10;
      beta = -event.accelerationIncludingGravity.y * 10;
      alpha = event.accelerationIncludingGravity.z * 10;
    }
    if (this._lastGamma !== gamma || this._lastBeta !== beta) {
      oriencallback(beta.toFixed(2), gamma.toFixed(2), alpha !== (null ? alpha.toFixed(2) : 0), gamma, beta);
      this._lastGamma = gamma;
      return this._lastBeta = beta;
    }
  };

  Giccoo.prototype.fBindShake = function() {
    if (window.DeviceMotionEvent) {
      return window.addEventListener('devicemotion', deviceMotionHandler, false);
    }
  };

  Giccoo.prototype.fUnBindShake = function() {
    if (window.DeviceMotionEvent) {
      return window.removeEventListener('devicemotion', deviceMotionHandler, false);
    }
  };

  return Giccoo;

})();

SHAKE_THRESHOLD = 1000;

if (navigator.userAgent.indexOf('iPhone') > -1) {
  SHAKE_THRESHOLD = 700;
} else if (navigator.userAgent.indexOf('QQ') > -1) {
  SHAKE_THRESHOLD = 1000;
}

last_update = 0;

_x = _y = _z = last_x = last_y = last_z = 0;

DMHandler = function() {};

deviceMotionHandler = function(eventData) {
  var acceleration, curTime, diffTime, speed;
  acceleration = eventData.accelerationIncludingGravity;
  curTime = new Date().getTime();
  if ((curTime - last_update) > 50) {
    diffTime = parseInt(curTime - last_update);
    last_update = curTime;
    _x = acceleration.x;
    _y = acceleration.y;
    _z = acceleration.z;
    speed = Math.abs(_x + _y + _z - last_x - last_y - last_z) / diffTime * 10000;
    console.log(_x, _y, _z);
    if (speed > SHAKE_THRESHOLD) {
      DMHandler();
    }
    last_x = _x;
    last_y = _y;
    return last_z = _z;
  }
};

gico = new Giccoo('normal');


/*
--------------------------------------------
     Begin loading.coffee
--------------------------------------------
 */

loading = (function() {
  function loading(data) {
    this.data = data;
  }

  loading.prototype._count = 0;

  loading.prototype._now = 0;

  loading.prototype.timeout = 4000;

  loading.prototype._finished = false;

  loading.prototype.init = function(data) {
    var i, img, _i, _len, _results;
    this._count = data.length;
    _results = [];
    for (_i = 0, _len = data.length; _i < _len; _i++) {
      i = data[_i];
      img = new Image();
      img.onload = this.loadimg;
      img.onerror = this.loadimg;
      img.pe = this;
      _results.push(img.src = i.src);
    }
    return _results;
  };

  loading.prototype.loadimg = function(e) {
    this.pe._now++;
    return this.pe._progress(this.pe._now);
  };

  loading.prototype._progress = function(n) {
    this.progress(n, this._count);
    if (n === this._count) {
      this._finished = true;
      return this.finished();
    }
  };

  loading.prototype.finished = function() {
    return console.log('finished');
  };

  loading.prototype.progress = function(now, count) {};

  return loading;

})();


/*
--------------------------------------------
     Begin locals.coffee
--------------------------------------------
 */

Locals = (function() {
  function Locals(name) {
    this.name = name;
    this.isLocals = window.localStorage ? true : false;
  }

  Locals.prototype.set = function(key, value) {
    if (this.isLocals) {
      return window.localStorage.setItem(key, value);
    }
  };

  Locals.prototype.get = function(key) {
    if (this.isLocals) {
      return window.localStorage.getItem(key);
    }
  };

  Locals.prototype.remove = function(key) {
    if (this.isLocals) {
      return window.localStorage.removeItem(key);
    }
  };

  return Locals;

})();


/*
--------------------------------------------
     Begin map.coffee
--------------------------------------------
 */

baiduMap = (function() {
  function baiduMap(name, r) {
    this.name = name;
    this.r = r;
    if (typeof BMap !== "undefined" && BMap !== null) {
      this.init(this.name, this.r);
    }
  }

  baiduMap.prototype.Point = function(lng, lat) {
    if (lng == null) {
      lng = 116.404;
    }
    if (lat == null) {
      lat = 39.915;
    }
    return new BMap.Point(lng, lat);
  };

  baiduMap.prototype.init = function(id, r) {
    var center, map;
    if (r == null) {
      r = 15;
    }
    map = new BMap.Map(id);
    center = this.Point();
    map.centerAndZoom(center, r);
    return this.bmap = map;
  };

  baiduMap.prototype.ShowLoading = function() {};

  baiduMap.prototype.HideLoading = function() {};

  baiduMap.prototype.pointClick = function(evt) {};

  baiduMap.prototype.getMy = function(callback) {
    var $this, geolocation, map;
    this.ShowLoading();
    $this = this;
    map = this.bmap;
    this.callbackalready = false;
    geolocation = new BMap.Geolocation();
    geolocation.getCurrentPosition(function(r) {
      var mk;
      if (this.getStatus() === BMAP_STATUS_SUCCESS) {
        mk = $this.ownMark(r.point, "It's my place.", 'mySelfPoint');
        map.addOverlay(mk);
        map.panTo(r.point);
        return callback(0, map, r.point);
      } else {
        return callback(this.getStatus(), true);
      }
    }, {
      enableHighAccuracy: true
    });
    return setTimeout(function() {
      return callback(9, true);
    }, 5000);
  };

  baiduMap.prototype.searchCity = function(keys, callback) {
    var myCity;
    myCity = new BMap.LocalCity();
    console.log("city", myCity);
    myCity.get(this.searchCityS);
    this.keys = keys;
    return this.callback = callback;
  };

  baiduMap.prototype.searchCityS = function(result) {
    var mk;
    console.log(map, result, result.name);
    mk = map.ownMark(result.center, "It's my place.", 'mySelfPoint');
    map.bmap.addOverlay(mk);
    map.bmap.panTo(result.center);
    return map.search(map.keys, result.center, map.callback);
  };

  baiduMap.prototype.search = function(keys, Spoint, callback) {
    var local, reload_local;
    this.local = new BMap.LocalSearch(this.bmap, {
      renderOptions: {
        autoViewport: true
      }
    });
    local = this.local;
    local.searchNearby(keys, Spoint);
    reload_local = function(sd, callback, times) {
      if (times >= 100) {
        return callback([]);
      }
      return setTimeout(function() {
        if (sd.length <= 0) {
          return reload_local(sd, callback, times++);
        } else {
          return callback(sd);
        }
      }, 50);
    };
    return reload_local(this.local.Sd, callback, 0);
  };

  baiduMap.prototype.addMark = function(list) {
    var a, marker, _i, _len, _results;
    if (list.length >= 2) {
      _results = [];
      for (_i = 0, _len = list.length; _i < _len; _i++) {
        a = list[_i];
        marker = this.ownMark(a.point, a.title, 'PointBar');
        _results.push(this.bmap.addOverlay(marker));
      }
      return _results;
    } else {

    }
  };

  baiduMap.prototype.ownMark = function(point, text, cls) {
    var mark, mp;
    mp = this.bmap;
    mark = function(point, text, cls) {
      this._point = point;
      this._text = text;
      return this._cls = cls;
    };
    mark.prototype = new BMap.Overlay();
    mark.prototype.initialize = function(map) {
      var div;
      this._map = map;
      div = this._div = document.createElement("div");
      div.style.zIndex = BMap.Overlay.getZIndex(this._point.lat);
      $(div).addClass(this._cls);
      div.innerHTML = '<img src="img/' + this._cls + '.png" /><div class="text">' + this._text + '</div>';
      cls = this._cls;
      $(div).swipe({
        tap: function(e, t) {
          return GameCheck(t, cls);
        }
      });
      mp.getPanes().labelPane.appendChild(div);
      return div;
    };
    mark.prototype.draw = function() {
      var div, map, pixel;
      map = this._map;
      pixel = map.pointToOverlayPixel(this._point);
      div = this._div;
      $(div).css({
        left: (pixel.x - $(div).width() / 2) + "px",
        top: (pixel.y - $(div).height() / 2) + "px"
      });
      if ($(div).is(".PointBar")) {
        $(div).css({
          top: (pixel.y - $(div).height()) + "px"
        });
      }
      return setTimeout(function() {
        return $(div).addClass('show');
      }, 550);
    };
    return new mark(point, text, cls);
  };

  return baiduMap;

})();


/*
--------------------------------------------
     Begin main.coffee
--------------------------------------------
 */

locals = new Locals();

map = {};

loading = new loading();

already = false;

document.addEventListener('WeixinJSBridgeReady', function() {
  return WeixinJSBridge.call('hideToolbar');
});

$(document).ready(function() {
  window.scrollTo(0, 1);
  loadImg();
  $(".welcome").swipe({
    swipeLeft: function(e, t) {
      return ChangeCar();
    },
    swipeRight: function(e, t) {
      return ChangeCar();
    }
  });
  $(".car1,.car2").swipe({
    tap: function(e, t) {
      return ChangeCar();
    }
  });
  $(".close").swipe({
    tap: function(e, t) {
      $(".pop").hide();
      return $(".gamevideo .video-item").html("");
    }
  });
  $(".showre").swipe({
    tap: function(e, t) {
      $(".pop").hide();
      return $(".reser").show();
    }
  });
  $("#point").swipe({
    tap: function(e, t) {
      return showShake();
    }
  });
  $(".carinfo .item").hide();
  $(".carinfo .item:first").show();
  $(".carinfo-point span:first").addClass('on');
  $(".carinfo").swipe({
    swipeLeft: function(e, t) {
      var $ep;
      $ep = $(".carinfo .item:visible");
      if ($ep.next().is(".item")) {
        $(".carinfo-point span").removeClass('on');
        $(".carinfo .item").hide();
        $ep.next().show();
        return $(".carinfo-point span").eq($ep.next().index()).addClass('on');
      }
    },
    swipeRight: function(e, t) {
      var $ep;
      $ep = $(".carinfo .item:visible");
      if ($ep.prev().is(".item")) {
        $(".carinfo-point span").removeClass('on');
        $(".carinfo .item").hide();
        $ep.prev().show();
        return $(".carinfo-point span").eq($ep.prev().index()).addClass('on');
      }
    }
  });
  fBindFormBtn();
  myK("province").innerHTML = fGetHTMLP();
  myK("city").innerHTML = fGetHTMLC(myK("province").value);
  myK("dealer").innerHTML = fGetHTMLS(myK("province").value, myK("city").value);
  myK("province").onchange = function() {
    return setTimeout(function() {
      myK("city").innerHTML = fGetHTMLC(myK("province").value);
      myK("dealer").innerHTML = fGetHTMLS(myK("province").value, myK("city").value);
      $('#city').change();
      return $('#dealer').change();
    }, 20);
  };
  myK("city").onchange = function() {
    return setTimeout(function() {
      myK("dealer").innerHTML = fGetHTMLS(myK("province").value, myK("city").value);
      return $('#dealer').change();
    }, 20);
  };
  myK("hope").innerHTML = fGetCarTypeHTML();
  myK("cartype").innerHTML = fGetCarTypeHTMLS(myK("hope").value);
  myK("hope").onchange = function() {
    return setTimeout(function() {
      myK("cartype").innerHTML = fGetCarTypeHTMLS(myK("hope").value);
      $("#hope").change();
      return $("#cartype").change();
    }, 20);
  };
  gico.fBindSelect($('select'));
  bingPointgotoMap();
  $(".logo").swipe({
    tap: function(e, t) {
      $(".pop,.reser").hide();
      $("#point").addClass("shakeDom");
      $(".welcome").show();
      already = false;
      return $.cookie('now', 0);
    }
  });
  return $.cookie('now', 0);
});

changeImage = function() {
  return $("img[data-src]").each(function() {
    return $(this).attr('src', $(this).data('src'));
  });
};

myK = function(id) {
  return document.getElementById(id);
};

fBindFormBtn = function() {
  return $('[name=submit]').click(function() {
    if ($('[name=name]').val().length <= 0) {
      return alert('姓名不能为空');
    }
    if ($('[name=mobile]').val().length <= 0) {
      return alert('手机号码不能为空');
    }
    if ($('[name=mobile]').val().length !== 11) {
      return alert('手机号码必须是11位数字');
    }
    if ($('[name=buytime]').val().length <= 0) {
      return alert('请选择欲购车时间');
    }
    if ($('[name=cartype]').val().length <= 0) {
      return alert('请选择感兴趣车型');
    }
    if ($('[name=hope]').val().length <= 0) {
      return alert('请选择感兴趣车系');
    }
    if ($('[name=province]').val().length <= 0) {
      return alert('请选择省份');
    }
    if ($('[name=city]').val().length <= 0) {
      return alert('请选择城市');
    }
    if ($('[name=dealer]').val().length <= 0) {
      return alert('请选择经销商');
    }
    return $.ajax({
      type: "post",
      dataType: "json",
      url: "reservations.php",
      data: $('[name=register]').serializeArray(),
      success: function(msg) {
        console.log(msg);
        if (msg.state === 'success') {
          return showShareBox();
        } else {
          return alert(msg.msg);
        }
      }
    });
  });
};

loadImg = function() {
  loading.finished = function() {
    return finishedLoad();
  };
  return loading.init([
    {
      src: "img/btnbg.jpg",
      id: "btnbg"
    }, {
      src: "img/bg.jpg",
      id: "bg"
    }, {
      src: "img/logo.png",
      id: "logo"
    }, {
      src: "img/mySelfPoint.png",
      id: "mySelfPoint"
    }, {
      src: "img/PointBar.png",
      id: "PointBar"
    }, {
      src: "img/car1.png",
      id: "car1"
    }, {
      src: "img/car2.png",
      id: "car2"
    }, {
      src: "img/yaoyiyao.png",
      id: "yaoyiyao"
    }
  ]);
};

finishedLoad = function() {
  console.log("finished");
  $("#loading").fadeOut(500);
  return setTimeout(function() {
    return $("#point").addClass("show");
  }, 700);
};

showShake = function() {
  map = new baiduMap('map');
  map.ShowLoading = function() {
    return $("#loading2").show();
  };
  map.HideLoading = function() {
    return $("#loading2").hide();
  };
  $("#point").removeClass('shakeDom');
  $(".handshake").addClass('shakeDom');
  $("#shakeremind").show();
  $("#shakeremind .point-s").each(function(i) {
    var $this;
    $this = $(this);
    return setTimeout(function() {
      return $this.addClass('show');
    }, 700 + i * 300);
  });
  return gico.fBindShake();
};

addMarkBar = function(list) {
  var re;
  console.log(list);
  re = [list[0], list[Math.ceil(list.length / 2)], list[list.length - 1]];
  console.log(re);
  $(".welcome,#shakeremind").fadeOut(500);
  map.HideLoading();
  changeImage();
  if (re.length <= 2) {
    return alert('对不起,附近没有找到兴趣点');
  }
  return setTimeout(function() {
    return map.addMark(re);
  }, 530);
};

GameCheck = function(t, cls) {
  var $ep;
  if (cls === 'PointBar') {
    $ep = $(t).parents("." + cls);
    if ($ep.is(".on")) {
      return showGame($ep, $ep.attr('rel'));
    } else {
      console.log($.cookie('now') != null, $.cookie('now'));
      if ($.cookie('now') == null) {
        $.cookie('now', 1);
      } else {
        $.cookie('now', parseInt($.cookie('now')) + 1);
      }
      $ep.attr('rel', $.cookie('now'));
      $ep.addClass('on gray');
      return showGame($ep);
    }
  }
};

showGame = function(e) {
  var game;
  game = $(e).attr('rel');
  if (game === "1") {
    return showGame1();
  } else if (game === "2") {
    return showGame2();
  } else {
    return showGameEnd();
  }
};

showGame1 = function() {
  $(".gamevideo .video-item").html('<iframe height=320 width=480 src="http://player.youku.com/embed/XNjg3NjcyMzQ0" frameborder=0 allowfullscreen></iframe>');
  $(".gamevideo,.carinfo,.medal").removeClass('fanz');
  $(".pop,.gamevideo").show();
  $(".gamevideo").css({
    "border-radius": "10px"
  });
  $(".carinfo,.medal").hide();
  return setTimeout(function() {
    return $(".gamevideo").addClass("fanz");
  }, 10);
};

showGame2 = function() {
  $(".gamevideo,.carinfo,.medal").removeClass('fanz');
  $(".pop,.carinfo").show();
  $("#carinfo").css({
    "border-radius": "20px"
  });
  $(".gamevideo,.medal").hide();
  return setTimeout(function() {
    return $(".carinfo").addClass("fanz");
  }, 10);
};

showGameEnd = function() {
  $(".gamevideo,.carinfo,.medal").removeClass('fanz');
  $(".pop,.medal").show();
  $(".carinfo,.gamevideo").hide();
  return setTimeout(function() {
    return $(".medal").addClass("fanz");
  }, 10);
};

ChangeCar = function() {
  $(".car1,.car2").addClass('moveout');
  return setTimeout(function() {
    return ChangeCar_s();
  }, 300);
};

ChangeCar_s = function() {
  $(".car1,.car2").removeClass('moveout');
  if ($(".car1").is('.hide1')) {
    $(".car1").removeClass('hide1');
    return $(".car2").addClass('hide2');
  } else {
    $(".car1").addClass('hide1');
    return $(".car2").removeClass('hide2');
  }
};

showMap = function() {
  if (already) {
    return '';
  }
  map.ShowLoading();
  gico.fUnBindShake();
  already = true;
  return map.getMy(function(err, smap, point) {
    if (err) {
      if (err === 2) {
        alert("对不起,位置结果未知,无法定位你的位置");
      } else if (err === 3) {
        alert("对不起,导航结果未知");
      } else if (err === 4) {
        alert("地图接口,非法密钥");
      } else if (err === 5) {
        alert("非法请求.");
      } else if (err === 6) {
        alert("没有权限,您已拒绝/关闭定位,或禁止浏览器定位.");
      } else if (err === 7) {
        alert("定位服务不可用,将导航到您所在城市.");
      } else if (err === 8) {
        alert("连接超时,请您待网络较好的情况下访问.");
      } else {

      }
      already = false;
      if (!map.callbackalready) {
        map.callbackalready = smap;
        return map.searchCity(["美食", "KTV", "酒吧"], addMarkBar);
      }
    } else {
      map.callbackalready = true;
      return map.search(["美食", "KTV", "酒吧"], point, addMarkBar);
    }
  });
};

bingPointgotoMap = function() {
  return $(".point-s .point").swipe({
    tap: function(e, t) {
      return showMap();
    }
  });
};

showShareBox = function() {
  var content, pic, sendUrl;
  content = "#玩的FUN，全城拾趣#全新宝来，时刻趣动生活。我刚刚寻找到了属于自己的1枚FUN勋章！和全新宝来一起，摇动手机加入全城拾趣的队列，赢取丰富礼遇吧！@一汽-大众宝来";
  pic = "http://mobi.mconnect.cn/borafun/img/share.jpg";
  sendUrl = "http://mobi.mconnect.cn/borafun";
  gico.BindShare(content, sendUrl, pic);
  $(".gamevideo,.carinfo,.medal").hide();
  return $(".pop,.sharebox").show();
};

DMHandler = function() {
  return showMap();
};
