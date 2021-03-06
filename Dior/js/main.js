// Generated by CoffeeScript 1.7.1
var Giccoo, changed, gico;

Giccoo = (function() {
  function Giccoo(name) {
    this.name = name;
  }

  Giccoo.prototype.weixin = function(callback) {
    return document.addEventListener('WeixinJSBridgeReady', callback);
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

  Giccoo.prototype.BindShare = function(content, url) {
    var $ep, list;
    if (url == null) {
      url = window.location.href;
    }
    $ep = this;
    list = {
      "qweibo": "http://v.t.qq.com/share/share.php?title={title}&url=",
      "renren": "http://share.renren.com/share/buttonshare.do?title={title}&link={url}",
      "weibo": "http://v.t.sina.com.cn/share/share.php?title={title}&url=",
      "qzone": "http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url={url}&title={title}",
      "facebook": "http://www.facebook.com/sharer/sharer.php?s=100&p[url]={url}}&p[title]={title}&p[summary]={title}",
      "twitter": "https://twitter.com/intent/tweet?text={title}"
    };
    return $('a[data-share]').click(function() {
      return $ep.fShare(list[$(this).data('share')], content, url);
    });
  };

  Giccoo.prototype.fShare = function(url, content, sendUrl) {
    var backUrl, pic, shareContent;
    content = content.val();
    shareContent = encodeURIComponent(content);
    pic = '';
    url = url.replace("{title}", shareContent);
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
      $div.append($span.append($(this).find('option:checked').html()));
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
    return $(o).next().html($(o).find('option:checked').html());
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

  return Giccoo;

})();

gico = new Giccoo('normal');


/* --------------------------------------------
     Begin main.coffee
--------------------------------------------
 */

$(document).ready(function() {});

changed = function(o) {
  console.log($(o).height());
  return $(".banner").attr("style", "padding-top:" + $(o).height() + "px");
};
