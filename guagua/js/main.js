// Generated by CoffeeScript 1.6.3
var GameEnd, GameEndBool, canvas, checkCanvas, clearMove, ctx, firstStep, loadimg, model, mouseCoords, mouseMove, mouseOver, movexx, prev, pshow, r, rxl, size;

size = {
  w: 640,
  h: 960
};

canvas = {};

ctx = {};

pshow = 65;

rxl = 59;

r = 70;

model = 1;

prev = {
  x: -1,
  y: -1
};

GameEndBool = true;

movexx = function() {
  return $("#note").css({
    "top": "101%",
    "margin": "0px"
  });
};

checkCanvas = function() {
  var imageData, index, offset, op, p, ps, x, y, _i, _j, _ref, _ref1;
  prev = {
    x: -1,
    y: -1
  };
  imageData = ctx.getImageData(0, 0, $('#canvas').width(), $('#canvas').height());
  offset = 3;
  op = 0;
  for (y = _i = 0, _ref = imageData.height; 0 <= _ref ? _i < _ref : _i > _ref; y = 0 <= _ref ? ++_i : --_i) {
    for (x = _j = 0, _ref1 = imageData.width; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; x = 0 <= _ref1 ? ++_j : --_j) {
      index = y * imageData.width + x;
      p = index * 4;
      if (imageData.data[p + offset] === 0) {
        op++;
      }
    }
  }
  ps = op / imageData.data.length * 4 * 100;
  if (parseInt(ps) > pshow) {
    return GameEnd();
  }
};

mouseMove = function(ev) {
  var mouse, mousePos;
  ev = ev || window.event;
  ev.preventDefault();
  mousePos = mouseCoords(ev);
  mouse = mouseOver(mousePos);
  if (mouse.x < 0 && mouse.y < 0) {
    return '';
  }
  clearMove(mouse.x, mouse.y);
  if (r <= 42) {
    return r++;
  }
};

clearMove = function(x, y) {
  var prex;
  if (prev.x < 0) {
    prev.x = x;
    prev.y = y;
    ctx.moveTo(x, y);
    movexx();
    return false;
  }
  if (prev.y < 0) {
    prev.x = x;
    prev.y = y;
    ctx.moveTo(x, y);
    return false;
  }
  ctx.lineTo(x, y);
  prex = {
    x: x,
    y: y
  };
  return ctx.stroke();
};

mouseCoords = function(ev) {
  ev = ev.targetTouches[0];
  if (ev.pageX || ev.pageY) {
    ({
      x: ev.pageX,
      y: ev.pageY
    });
  }
  return {
    x: ev.clientX + document.body.scrollLeft - document.body.clientLeft,
    y: ev.clientY + document.body.scrollTop - document.body.clientTop
  };
};

mouseOver = function(ev1) {
  var body, jx;
  body = $('body');
  jx = 0;
  if ($("#canvas").width() - body.width() > 0) {
    jx = ($("#canvas").width() - body.width()) / 2;
  }
  return {
    x: ev1.x + jx,
    y: ev1.y
  };
};

GameEnd = function() {
  GameEndBool = true;
  $("#canvas").fadeOut(500);
  $("#replay").css({
    bottom: "0px"
  });
  $("#logo").css({
    top: "0px"
  });
  $("#fly").css({
    left: "0px"
  });
  return $("#replay").swipe({
    tap: function(e, t) {
      return window.location.reload();
    }
  });
};

loadimg = function() {
  var body, epsize, obsize, ss;
  body = $('body');
  obsize = {};
  epsize = {
    w: body.width(),
    h: body.height()
  };
  $('#img').width(epsize.w);
  $('#img,#canvas').css({
    'margin-left': '-' + $('#img').width() / 2 + 'px'
  });
  if (epsize.h > size.h) {
    obsize.h = epsize.h;
    $('#img').height(obsize.h);
    $('#img,#canvas').css({
      'margin-left': '-' + $('#img').width() / 2 + 'px'
    });
  } else {
    if (size.w > epsize.w) {
      $('#img').width(epsize.w);
      $('#img,#canvas').css({
        'margin-left': '-' + $('#img').width() / 2 + 'px'
      });
    }
  }
  $("#canvas").attr({
    'width': $('#img').width()
  });
  $("#canvas").attr({
    'height': $('#img').height()
  });
  canvas = stackBlurImage("img", "canvas", 20, false);
  ctx = canvas.getContext('2d');
  ctx.globalCompositeOperation = "destination-out";
  ctx.lineWidth = r;
  ctx.lineCap = 'round';
  ctx.lineJoin = 'round';
  ctx.beginPath();
  $("#loading").hide();
  GameEndBool = false;
  $("#note").css({
    "top": "50%"
  });
  $("#fly").addClass('b' + model);
  return ss = new Snow(20, 60);
};

firstStep = function() {
  var body, img, ran, src;
  body = $('body');
  if (body.width() > size.w) {
    $("#loading span").text('请使用手机浏览,并刷新.');
    return false;
  }
  ran = parseInt(Math.random() * 100);
  src = "img/bg-1.jpg";
  if (ran > rxl) {
    model = 2;
    src = "img/bg-2.jpg";
  }
  img = document.getElementById('img');
  img.onload = loadimg;
  return img.src = src;
};

$(document).ready(function() {
  $(document).on('touchstart', function() {
    if (GameEndBool) {
      return false;
    }
    mouseMove();
    return document.addEventListener("touchmove", mouseMove);
  });
  return $(document).on('touchend', function() {
    if (GameEndBool) {
      return false;
    }
    document.removeEventListener("touchmove", mouseMove);
    checkCanvas();
    return r = 70;
  });
});

firstStep();
