!function(){"use strict";var e=function(e){for(var t,n=document.querySelectorAll("a");e&&e!==document;e=e.parentNode)for(t=n.length;t--;)if(n[t]===e)return e},t=function(t){var n=e(t.target);return n&&n.hash?document.querySelector(n.hash):void 0};window.addEventListener("touchend",function(e){var n=t(e);n&&(n&&n.classList.contains("modal")&&n.classList.toggle("active"),e.preventDefault())})}(),!function(){"use strict";var e,t=function(e){for(var t,n=document.querySelectorAll("a");e&&e!==document;e=e.parentNode)for(t=n.length;t--;)if(n[t]===e)return e},n=function(){e.style.display="none",e.removeEventListener("webkitTransitionEnd",n)},a=function(){var t=document.createElement("div");return t.classList.add("backdrop"),t.addEventListener("touchend",function(){e.addEventListener("webkitTransitionEnd",n),e.classList.remove("visible"),e.parentNode.removeChild(a)}),t}(),r=function(n){var a=t(n.target);if(a&&a.hash&&!(a.hash.indexOf("/")>0)){try{e=document.querySelector(a.hash)}catch(r){e=null}if(null!==e&&e&&e.classList.contains("popover"))return e}},i=function(e){var t=r(e);t&&(t.style.display="block",t.offsetHeight,t.classList.add("visible"),t.parentNode.appendChild(a))};window.addEventListener("touchend",i)}(),!function(){"use strict";var e=function(e){for(var t,n=document.querySelectorAll(".segmented-control .control-item");e&&e!==document;e=e.parentNode)for(t=n.length;t--;)if(n[t]===e)return e};window.addEventListener("touchend",function(t){var n,a,r,i=e(t.target),o="active",s="."+o;if(i&&(n=i.parentNode.querySelector(s),n&&n.classList.remove(o),i.classList.add(o),i.hash&&(r=document.querySelector(i.hash)))){a=r.parentNode.querySelectorAll(s);for(var c=0;c<a.length;c++)a[c].classList.remove(o);r.classList.add(o)}}),window.addEventListener("click",function(t){e(t.target)&&t.preventDefault()})}(),!function(){"use strict";var e,t,n,a,r,i,o,s,c,l,d,u,h,f=function(e){for(var t,n=document.querySelectorAll(".slider > .slide-group");e&&e!==document;e=e.parentNode)for(t=n.length;t--;)if(n[t]===e)return e},v=function(){if("webkitTransform"in n.style){var e=n.style.webkitTransform.match(/translate3d\(([^,]*)/),t=e?e[1]:0;return parseInt(t,10)}},g=function(e){var t=e?0>a?"ceil":"floor":"round";d=Math[t](v()/(h/n.children.length)),d+=e,d=Math.min(d,0),d=Math.max(-(n.children.length-1),d)},p=function(i){if(n=f(i.target)){var d=n.querySelector(".slide");h=d.offsetWidth*n.children.length,u=void 0,l=n.offsetWidth,c=1,o=-(n.children.length-1),s=+new Date,e=i.touches[0].pageX,t=i.touches[0].pageY,a=0,r=0,g(0),n.style["-webkit-transition-duration"]=0}},m=function(s){s.touches.length>1||!n||(a=s.touches[0].pageX-e,r=s.touches[0].pageY-t,e=s.touches[0].pageX,t=s.touches[0].pageY,"undefined"==typeof u&&(isScrolling_move=!0,u=Math.abs(r)>Math.abs(a)),u||(i=a/c+v(),s.preventDefault(),c=0===d&&a>0?e/l+1.25:d===o&&0>a?Math.abs(e)/l+1.25:1,n.style.webkitTransform="translate3d("+i+"px,0,0)"))},w=function(e){n&&!u&&(g(+new Date-s<1e3&&Math.abs(a)>15?0>a?-1:1:0),i=d*l,n.style["-webkit-transition-duration"]=".2s",n.style.webkitTransform="translate3d("+i+"px,0,0)",e=new CustomEvent("slide",{detail:{slideNumber:Math.abs(d)},bubbles:!0,cancelable:!0}),n.parentNode.dispatchEvent(e))};window.addEventListener("touchstart",p),window.addEventListener("touchmove",m),window.addEventListener("touchend",w)}(),!function(){"use strict";var e={},t=!1,n=!1,a=!1,r=function(e){for(var t,n=document.querySelectorAll(".toggle");e&&e!==document;e=e.parentNode)for(t=n.length;t--;)if(n[t]===e)return e};window.addEventListener("touchstart",function(n){if(n=n.originalEvent||n,a=r(n.target)){var i=a.querySelector(".toggle-handle"),o=a.clientWidth,s=i.clientWidth,c=a.classList.contains("active")?o-s:0;e={pageX:n.touches[0].pageX-c,pageY:n.touches[0].pageY},t=!1}}),window.addEventListener("touchmove",function(r){if(r=r.originalEvent||r,!(r.touches.length>1)&&a){var i=a.querySelector(".toggle-handle"),o=r.touches[0],s=a.clientWidth,c=i.clientWidth,l=s-c;if(t=!0,n=o.pageX-e.pageX,!(Math.abs(n)<Math.abs(o.pageY-e.pageY))){if(r.preventDefault(),0>n)return i.style.webkitTransform="translate3d(0,0,0)";if(n>l)return i.style.webkitTransform="translate3d("+l+"px,0,0)";i.style.webkitTransform="translate3d("+n+"px,0,0)",a.classList[n>s/2-c/2?"add":"remove"]("active")}}}),window.addEventListener("touchend",function(e){if(a){var r=a.querySelector(".toggle-handle"),i=a.clientWidth,o=r.clientWidth,s=i-o,c=!t&&!a.classList.contains("active")||t&&n>i/2-o/2;r.style.webkitTransform=c?"translate3d("+s+"px,0,0)":"translate3d(0,0,0)",a.classList[c?"add":"remove"]("active"),e=new CustomEvent("toggle",{detail:{isActive:c},bubbles:!0,cancelable:!0}),a.dispatchEvent(e),t=!1,a=!1}})}();