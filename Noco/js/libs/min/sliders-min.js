!function(){"use strict";var t,n,r,a,o,i,l,s,d,u,c,h,f,p=function(e){for(var t,n=document.querySelectorAll(".slider-normal > .slide-normal-group");e&&e!==document;e=e.parentNode)for(t=n.length;t--;)if(n[t]===e)return e},b=function(e,t){for(var n,r=t?"left":"right",a=document.querySelectorAll(".slider-normal > .slide-normal-"+r);e&&e!==document;e=e.parentNode)for(n=a.length;n--;)if(a[n]===e)return e},m=function(){if("webkitTransform"in r.style){var e=r.style.webkitTransform.match(/translate3d\(([^,]*)/),t=e?e[1]:0;return parseInt(t,10)}},g=function(e){var t=e?0>a?"ceil":"floor":"round";c=Math[t](m()/(f/r.children.length)),c+=e,c=Math.min(c,0),c=Math.max(-(r.children.length-1),c)},v=function(e){if(r=p(e.target)){var i=r.querySelector(".slide-normal");f=i.offsetWidth*r.children.length,h=void 0,u=r.offsetWidth,d=1,l=-(r.children.length-1),s=+new Date,t=e.touches[0].pageX,n=e.touches[0].pageY,a=0,o=0,g(0),r.style["-webkit-transition-duration"]=0}},w=function(e){e.touches.length>1||!r||(a=e.touches[0].pageX-t,o=e.touches[0].pageY-n,t=e.touches[0].pageX,n=e.touches[0].pageY,"undefined"==typeof h&&(h=Math.abs(o)>Math.abs(a)),h||(i=a/d+m(),e.preventDefault(),d=0===c&&a>0?t/u+1.25:c===l&&0>a?Math.abs(t)/u+1.25:1,r.style.webkitTransform="translate3d("+i+"px,0,0)"))},y=function(e){r&&!h&&(g(+new Date-s<1e3&&Math.abs(a)>15?0>a?-1:1:0),i=c*u,r.style["-webkit-transition-duration"]=".2s",r.style.webkitTransform="translate3d("+i+"px,0,0)",selecttemp({detail:{slideNumber:Math.abs(c)},setSlideNumber:function(){c=this.slideNumber},target:r,bubbles:!0,cancelable:!0}),r.parentNode.dispatchEvent(e))},N=function(t){var n=b(t.target,!1),a=b(t.target,!0);if(n||a){var o=n?n:a,s=n?!0:!1;r=o.parentNode.querySelector(".slide-normal-group"),u=r.offsetWidth,c="undefined"==typeof c?0:-Math.abs(parseInt(r.style.webkitTransform.replace("translate3d(","").replace("px, 0px, 0px)",""))/u),console.log(c),s?c++:c--;var d=r.querySelector(".slide-normal");return f=d.offsetWidth*r.children.length,u=r.offsetWidth,l=-(r.children.length-1),c>0&&(c=0),l>c&&(c=l),i=c*u,r.style["-webkit-transition-duration"]=".2s",r.style.webkitTransform="translate3d("+i+"px,0,0)",selecttemp({detail:{slideNumber:Math.abs(c)},setSlideNumber:function(){c=this.slideNumber},target:r,bubbles:!0,cancelable:!0}),"undefined"!=typeof r.parentNode?r.parentNode.dispatchEvent(e):void 0}};window.addEventListener("touchstart",v),window.addEventListener("touchmove",w),window.addEventListener("touchend",y),window.addEventListener("touchend",N)}();