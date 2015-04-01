// Generated by CoffeeScript 1.8.0
var deviceMotionHandler;

deviceMotionHandler = function(eventData) {
  var acceleration;
  acceleration = eventData.accelerationIncludingGravity;
  return $(".log").html(parseInt(acceleration.x) + "," + parseInt(acceleration.y) + "," + parseInt(acceleration.z));
};

$(document).ready(function() {
  $(".log").html("ready");
  return window.addEventListener('devicemotion', deviceMotionHandler, false);
});