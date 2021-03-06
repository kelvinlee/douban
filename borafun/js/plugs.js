// Generated by CoffeeScript 1.6.3
var Giccoo, gico;

Giccoo = (function() {
  function Giccoo(name) {
    this.name = name;
    this.checkOrientation();
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
        viewport = document.getElementById("viewport");
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

  return Giccoo;

})();

gico = new Giccoo('normal');
