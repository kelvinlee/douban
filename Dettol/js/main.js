// Generated by CoffeeScript 1.7.1

/*
--------------------------------------------
     Begin plugs.coffee
--------------------------------------------
 */
var DMHandler, GameH, GameOver, Giccoo, SHAKE_THRESHOLD, addSomeBugs, audio, backNormal, bugclick, buglife, bugsNum, canaddBugs, canvas, changeBackgroud, checkBugsMove, checkRemoveBugs, checkScoreMove, count, createAllDom, deviceMotionHandler, endGame, fBindMenuBtn, firstFrame, gico, gotoTick, handleComplete, handleFileLoad, images, init, last_update, last_x, last_y, last_z, loadEnd, loadImg, loadingTxt, manifest, myGetId, orientationChange, overscore, playing, ranDom, randomBugs, runawayBug, runscore, score, showShare, stage, startGame, tick, _dom_bug1, _dom_bug2, _dom_bug3, _dom_bugs_box, _dom_score, _dom_score_box, _dom_score_img, _orien, _x, _y, _z;

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

  Giccoo.prototype.cWeek = function(week, pre) {
    if (pre == null) {
      pre = "周";
    }
    if (week === 1) {
      return pre + "一";
    }
    if (week === 2) {
      return pre + "二";
    }
    if (week === 3) {
      return pre + "三";
    }
    if (week === 4) {
      return pre + "四";
    }
    if (week === 5) {
      return pre + "五";
    }
    if (week === 6) {
      return pre + "六";
    }
    if (week === 0) {
      return pre + "日";
    }
  };

  Giccoo.prototype.getRandom = function(max, min) {
    return parseInt(Math.random() * (max - min + 1) + min);
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
      "renren": "http://share.renren.com/share/buttonshare?title={title}&link={url}&pic={pic}",
      "weibo": "http://v.t.sina.com.cn/share/share.php?title={title}&url={url}&pic={pic}",
      "qzone": "http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url={url}&title={title}&pic={pic}",
      "facebook": "http://www.facebook.com/sharer/sharer.php?s=100&p[url]={url}}&p[title]={title}&p[summary]={title}&pic={pic}",
      "twitter": "https://twitter.com/intent/tweet?text={title}&pic={pic}",
      "kaixin": "http://www.kaixin001.com/rest/records.php?content={title}&url={url}&pic={pic}",
      "douban": "http://www.douban.com/share/service?bm=&image={pic}&href={url}&updated=&name={title}"
    };
    return $("[data-share]").unbind('click').bind('click', function() {
      var rep;
      if ($(this).attr('content')) {
        rep = $(this).attr('content');
        content = content.replace('{content}', rep);
      }
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
      if ($(this).is(':checked')) {
        $div.addClass('on');
      }
      return $(this).change(function() {
        var $o;
        $o = $(this);
        $('[name=' + $o.attr('name') + ']').parent().removeClass('on');
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

  Giccoo.prototype.mobilecheck = function() {
    if (navigator.userAgent.match(/Android/i) || navigator.userAgent.match(/webOS/i) || navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i) || navigator.userAgent.match(/iPod/i) || navigator.userAgent.match(/BlackBerry/i) || navigator.userAgent.match(/Windows Phone/i)) {
      return true;
    }
    return false;
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
     Begin game.coffee
--------------------------------------------
 */

canvas = {};

stage = {};

images = {};

playing = true;

count = 1;

manifest = {};

overscore = 3;

score = 0;

runscore = 0;

canaddBugs = true;

bugsNum = 2;

buglife = 3000;

loadingTxt = {};

_dom_score_box = {};

_dom_bugs_box = {};

_dom_score = {};

_dom_score_img = {};

_dom_bug1 = {};

_dom_bug2 = {};

_dom_bug3 = {};

audio = {};

_orien = 1;

orientationChange = function() {
  switch (window.orientation) {
    case 0:
      return backNormal();
    case 90:
      return GameH();
    case -90:
      return GameH();
  }
};

window.onorientationchange = orientationChange;

window.addEventListener('load', function() {
  return orientationChange();
});

backNormal = function() {
  _orien = 1;
  $('.zoom5').removeClass('zoom5');
  return $("#mubu").css({
    width: $("body").width(),
    height: $("body").height()
  });
};

GameH = function() {
  _orien = 0;
  $("#mubu").css({
    width: $("body").width(),
    height: $("body").height()
  });
  return $(".logo,.gameinfo,.menu,.clouds,.da-box,.activeinfo-box,.proinfo-box").addClass('zoom5');
};

myGetId = function(id) {
  return document.getElementById(id);
};

ranDom = function(min, max) {
  return Math.ceil(Math.random() * (max - min + 1) + min);
};

init = function() {
  var publicH;
  publicH = document.body.clientHeight * 640 / document.body.clientWidth;
  canvas = myGetId('canvas');
  $(canvas).attr('height', $("#mubu").height());
  stage = new createjs.Stage(canvas);
  createjs.Touch.enable(stage);
  stage.enableMouseOver(10);
  stage.mouseMoveOutside = true;
  _dom_bugs_box = new createjs.Container();
  _dom_bugs_box.x = 0;
  _dom_bugs_box.y = 0;
  _dom_score_box = new createjs.Container();
  _dom_score_box.x = 0;
  _dom_score_box.y = 0;
  stage.addChild(_dom_bugs_box, _dom_score_box);
  stage.update();
  gotoTick();
  return firstFrame();
};

gotoTick = function() {
  createjs.Ticker.setFPS(30);
  createjs.Ticker.addEventListener("tick", tick);
  return createjs.Ticker.addEventListener("tick", stage);
};

tick = function(evt) {
  checkBugsMove();
  return checkScoreMove();
};

checkScoreMove = function() {
  var i, l, obj, _i, _results;
  l = _dom_score_box.getNumChildren();
  if (l <= 0) {
    return false;
  }
  _results = [];
  for (i = _i = 0; 0 <= l ? _i < l : _i > l; i = 0 <= l ? ++_i : --_i) {
    obj = _dom_score_box.getChildAt(i);
    if (obj == null) {
      continue;
    }
    obj.Aa -= 0.06;
    if (obj.Aa <= 0) {
      obj.alpha -= 0.06;
    }
    obj.y -= 3;
    if (obj.alpha <= 0) {
      _results.push(_dom_score_box.removeChildAt(i));
    } else {
      _results.push(void 0);
    }
  }
  return _results;
};

checkBugsMove = function() {
  var i, l, obj, _i, _results;
  l = _dom_bugs_box.getNumChildren();
  if (l <= 0) {
    canaddBugs = false;
  }
  _results = [];
  for (i = _i = 0; 0 <= l ? _i < l : _i > l; i = 0 <= l ? ++_i : --_i) {
    obj = _dom_bugs_box.getChildAt(i);
    if (obj == null) {
      continue;
    }
    if (obj.exy === "remove") {
      if (obj.alpha <= 0) {
        _dom_bugs_box.removeChildAt(i);
        checkRemoveBugs();
      } else {
        obj.alpha -= 0.06;
      }
      continue;
    }
    if (obj.exy === "runaway") {
      if (obj.alpha <= 0) {
        _dom_bugs_box.removeChildAt(i);
        checkRemoveBugs();
      } else {
        obj.alpha -= 0.06;
        obj.x += Math.random() * -10 + 5;
        obj.y += Math.random() * -10 + 5;
      }
      continue;
    }
    if (obj.exy === "big") {
      obj.scaleX += obj.espeed * 1.1;
      obj.scaleY += obj.espeed * 1.1;
      if (obj.scaleX >= (obj.esX + obj.esX * 0.3)) {
        obj.exy = "normal";
      }
    }
    if (obj.exy === "small") {
      obj.scaleX -= obj.espeed / 3;
      obj.scaleY -= obj.espeed / 3;
      if (obj.scaleX <= (obj.esX - obj.esX * 0.3)) {
        obj.exy = "big";
      }
    }
    if (obj.exy === "normal") {
      obj.scaleX -= obj.espeed;
      obj.scaleY -= obj.espeed;
      if (obj.scaleX <= obj.esX) {
        _results.push(obj.exy = "over");
      } else {
        _results.push(void 0);
      }
    } else {
      _results.push(void 0);
    }
  }
  return _results;
};

loadImg = function() {
  var loader;
  images = images || {};
  manifest = [
    {
      src: "img/bug-1.png",
      id: "bug-1"
    }, {
      src: "img/bug-2.png",
      id: "bug-2"
    }, {
      src: "img/bug-3.png",
      id: "bug-3"
    }, {
      src: "img/bg-1.jpg",
      id: "bg-1"
    }, {
      src: "img/bg-2.jpg",
      id: "bg-2"
    }, {
      src: "img/score-bg.png",
      id: "score-bg"
    }
  ];
  loader = new createjs.LoadQueue(false);
  loader.addEventListener("fileload", handleFileLoad);
  loader.addEventListener("complete", handleComplete);
  return loader.loadManifest(manifest);
};

handleFileLoad = function(evt) {
  if (evt.item.type === "image") {
    images[evt.item.id] = evt.result;
  }
  count++;
  console.log("加载了: " + Math.floor(count / manifest.length * 100) + "%");
  if (count === manifest.length) {
    return loadEnd();
  }
};

handleComplete = function(evt) {
  console.log("loadend:", evt);
  return loadEnd();
};

createAllDom = function() {
  var bug1_data, bug1_spritesheet, bug2_spritesheet, bug3_spritesheet, h, w;
  audio = document.createElement("audio");
  audio.src = "img/click.mp3";
  $(audio).bind('pause', function() {
    this.currentTime = 0.1;
    return console.log("pause");
  });
  w = canvas.width;
  h = canvas.height;
  bug1_data = {
    framerate: 20,
    images: [images['bug-1']],
    frames: {
      width: 220,
      height: 220
    },
    animations: {
      dead: [0, 1]
    }
  };
  bug1_spritesheet = new createjs.SpriteSheet(bug1_data);
  _dom_bug1 = new createjs.Sprite(bug1_spritesheet);
  _dom_bug1.x = w / 2;
  _dom_bug1.y = h / 2;
  _dom_bug1.regX = 220 / 2;
  _dom_bug1.regY = 220 / 2;
  _dom_bug1.VA = -0.02;
  _dom_bug1.alpha = 1;
  _dom_bug1.esX = 1;
  _dom_bug1.esY = 1;
  _dom_bug1.espeed = 0.08;
  _dom_bug1.exy = "small";
  bug1_data.images = [images['bug-2']];
  bug2_spritesheet = new createjs.SpriteSheet(bug1_data);
  _dom_bug2 = new createjs.Sprite(bug2_spritesheet);
  _dom_bug2.x = w / 2;
  _dom_bug2.y = h / 2;
  _dom_bug2.regX = 220 / 2;
  _dom_bug2.regY = 220 / 2;
  _dom_bug2.VA = -0.02;
  _dom_bug2.alpha = 1;
  _dom_bug2.esX = 1;
  _dom_bug2.esY = 1;
  _dom_bug2.espeed = 0.08;
  _dom_bug2.exy = "small";
  bug1_data.images = [images['bug-3']];
  bug3_spritesheet = new createjs.SpriteSheet(bug1_data);
  _dom_bug3 = new createjs.Sprite(bug3_spritesheet);
  _dom_bug3.x = w / 2;
  _dom_bug3.y = h / 2;
  _dom_bug3.regX = 220 / 2;
  _dom_bug3.regY = 220 / 2;
  _dom_bug3.VA = -0.02;
  _dom_bug3.alpha = 1;
  _dom_bug3.esX = 1;
  _dom_bug3.esY = 1;
  _dom_bug3.espeed = 0.08;
  _dom_bug3.exy = "small";
  _dom_score = new createjs.Container();
  return _dom_score_img = new createjs.Bitmap(images['score-bg']);
};

randomBugs = function(min, max) {
  var h, h2, i, random, w, _i, _results;
  w = canvas.width;
  h = canvas.height;
  h2 = $(".main").height();
  random = Math.random() * (max - min) + min;
  if (h2 > 600) {
    h2 = 600;
  }
  _results = [];
  for (i = _i = 0; 0 <= random ? _i < random : _i > random; i = 0 <= random ? ++_i : --_i) {
    setTimeout(function() {
      var obj, scale, whos, x1, y1, y2;
      obj = {};
      whos = Math.ceil(Math.random() * (400 - 100 + 1) + 100);
      scale = (Math.ceil(Math.random() * (90 - 50 + 1) + 50)) / 100;
      if (whos <= 199) {
        obj = _dom_bug1.clone();
      }
      if (whos >= 200 && whos <= 299) {
        obj = _dom_bug2.clone();
      }
      if (whos >= 300) {
        obj = _dom_bug3.clone();
      }
      x1 = 110;
      y1 = 260;
      y2 = 220;
      h = h - 50;
      if (!_orien) {
        x1 = 110;
        y1 = 50;
        h = h2 - 50;
        y2 = 50;
        scale = scale * 0.6;
      }
      obj.x = ranDom(100, w - x1);
      obj.y = Math.random() * (h - y1) + y2;
      console.log(obj.x + 220 / 2, obj.y + 220 / 2);
      obj.regX = 220 / 2;
      obj.regY = 220 / 2;
      obj.VA = -0.02;
      obj.alpha = 1;
      obj.scaleX = obj.scaleY = 1;
      obj.esX = obj.esY = scale;
      obj.espeed = 0.08;
      obj.exy = "small";
      obj.runaway = setTimeout(function() {
        return runawayBug(obj);
      }, buglife);
      _dom_bugs_box.addChild(obj);
      stage.update();
      return obj.addEventListener('click', bugclick);
    }, Math.random() * 1000);
    _results.push(true);
  }
  return _results;
};

addSomeBugs = function() {
  if (bugsNum > 2) {
    changeBackgroud();
  }
  randomBugs(bugsNum - 1, bugsNum + 1);
  return bugsNum += 1.5;
};

bugclick = function(evt) {
  var dom_score, fsize, text;
  console.log(evt);
  clearTimeout(evt.target.runaway);
  evt.target.gotoAndStop(1);
  evt.target.exy = "remove";
  evt.target.removeEventListener('click', bugclick);
  if (score < 10) {
    fsize = 24;
  }
  if (score < 100) {
    fsize = 20;
  } else {
    fsize = 18;
  }
  score += 1;
  text = new createjs.Text("+" + score, fsize + "px Arial", "#ff0000");
  if (score < 10) {
    text.x = 35;
    text.y = 20;
  }
  if (score < 100) {
    text.x = 35;
    text.y = 22;
  } else {
    text.x = 32;
    text.y = 24;
  }
  text.textAlign = "center";
  dom_score = _dom_score.clone();
  dom_score.x = evt.stageX;
  dom_score.y = evt.stageY;
  dom_score.Aa = 1;
  audio.pause();
  audio.play(0, 1);
  dom_score.addChild(_dom_score_img.clone(), text);
  return _dom_score_box.addChild(dom_score);
};

runawayBug = function(obj) {
  obj.removeEventListener("click", bugclick);
  obj.exy = "runaway";
  return runscore += 1;
};

checkRemoveBugs = function() {
  if (runscore >= overscore && playing) {
    playing = false;
    return GameOver();
  } else if (_dom_bugs_box.getNumChildren() <= 0 && playing) {
    return addSomeBugs();
  }
};

firstFrame = function() {
  createAllDom();
  return addSomeBugs();
};

GameOver = function() {
  createjs.Ticker.removeEventListener("tick", tick);
  createjs.Ticker.removeEventListener("tick", stage);
  endGame(score);
  playing = true;
  count = 0;
  manifest = {};
  overscore = 3;
  score = 0;
  runscore = 0;
  canaddBugs = true;
  return bugsNum = 2;
};


/*
--------------------------------------------
     Begin main.coffee
--------------------------------------------
 */

audio = {};

$(document).ready(function() {
  var h;
  h = $("body").height();
  $("#mubu").css({
    width: $("body").width(),
    height: $("body").height()
  });
  if (h - 170 - 160 < 500) {
    $(".gameinfo").addClass('zoom');
  }
  $(".close").click(function() {
    $('.da,.pop').addClass('hideda');
    _smq.push(['custom', '游戏页面', '弹窗', '关闭']);
    _gaq.push(['_trackEvent', '游戏页面', '弹窗', '关闭']);
    return setTimeout(function() {
      return $('.da,.pop').addClass('hidez');
    }, 500);
  });
  $(".activeinfo").click(function() {
    return $("#acinfo").removeClass('hideda hidez');
  });
  $(".proinfo").click(function() {});
  _smq.push(['custom', '游戏页面', '弹窗', '图片1']);
  _gaq.push(['_trackEvent', 'DettolGame-LHW', '按钮', '开始按钮']);
  $("#list").swipeLeft(function() {
    var $e;
    $e = $("#list img:visible").next();
    if ($e.is("img")) {
      $("#list img").hide();
      $("#list").next().find("span").removeClass('on');
      $("#list").next().find("span").eq($e.index()).addClass('on');
      _smq.push(['custom', '游戏页面', '弹窗', '图片' + $e.index()]);
      _gaq.push(['_trackEvent', '游戏页面', '弹窗', '图片' + $e.index()]);
      $e.show();
    }
    if (!$e.is("img")) {
      $('.da,.pop').addClass('hideda');
      return setTimeout(function() {
        return $('.da,.pop').addClass('hidez');
      }, 500);
    }
  }).swipeRight(function() {
    var $e;
    $e = $("#list img:visible").prev();
    if ($e.is("img")) {
      $("#list img").hide();
      $("#list").next().find("span").removeClass('on');
      $("#list").next().find("span").eq($e.index()).addClass('on');
      _smq.push(['custom', '游戏页面', '弹窗', '图片' + $e.index()]);
      _gaq.push(['_trackEvent', '游戏页面', '弹窗', '图片' + $e.index()]);
      return $e.show();
    }
  });
  $("#procontent").swipeLeft(function() {
    var $e;
    $e = $("#procontent .item:visible").next();
    if ($e.is(".item")) {
      $("#procontent .item").hide();
      $("#procontent").next().find("span").removeClass('on');
      $("#procontent").next().find("span").eq($e.index()).addClass('on');
      return $e.show();
    }
  }).swipeRight(function() {
    var $e;
    $e = $("#procontent .item:visible").prev();
    if ($e.is(".item")) {
      $("#procontent .item").hide();
      $("#procontent").next().find("span").removeClass('on');
      $("#procontent").next().find("span").eq($e.index()).addClass('on');
      return $e.show();
    }
  });
  loadImg();
  fBindMenuBtn();
  return orientationChange();
});

loadEnd = function() {
  return $(".loading").hide();
};

fBindMenuBtn = function() {
  $(".startgame").click(function() {
    return startGame();
  });
  $(".gotoshare").click(function() {
    return showShare();
  });
  $(".proinfo").click(function() {});
  return $(".activeinfo").click(function() {});
};

startGame = function() {
  $(".clouds").hide();
  $("#mubu").css({
    "z-index": 10099
  });
  $(".gameinfo,.menu").addClass("hide hide-menu");
  $(".main").addClass('gamestart');
  return init();
};

endGame = function(score) {
  $(".clouds").show();
  $("#mubu").css({
    "z-index": 9
  });
  $(".gameinfo .score").text(score);
  $(".gameinfo,.menu").removeClass("hide hide-menu");
  $(".gameinfo .gamebox,.gameinfo .sharebox").hide();
  $(".gameinfo .gameoverbox").show();
  $(".main").removeClass('gamestart');
  return gico.BindShare('#细菌别流传，快乐不间断# 灭菌有神器，滴露送好礼。我刚刚神勇地消灭了' + score + '个细菌！和Angela一起，刷新好成绩，留住健康更哈皮，快来挑战吧！@滴露官方微博', 'http://m.dettol.com.cn/qr/LHW', 'http://m.dettol.com.cn/qr/LHW/img/share.jpg');
};

showShare = function() {
  $(".gameinfo,.menu").removeClass("hide hide-menu");
  $(".gameinfo .gamebox,.gameinfo .gameoverbox").hide();
  return $(".gameinfo .sharebox").show();
};

changeBackgroud = function() {
  if (_orien) {
    if ($(".main").is('.bg1')) {
      $(".main").removeClass('bg1 bg2');
      return $(".main").addClass('bg2');
    } else if ($(".main").is(".bg2")) {
      return $(".main").removeClass('bg1 bg2');
    } else {
      $(".main").removeClass('bg1 bg2');
      return $(".main").addClass('bg1');
    }
  }
};
