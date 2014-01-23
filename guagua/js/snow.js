var Snow = (function () {  
    function Snow(density, speed) {  
        this.startSnow(density, speed);  
    };  
    Snow.prototype.startSnow = function (density, speed) {  
        density = Math.floor(100 * (1 / density));  
        var me = this,  
            snowflakes = [],
            snowWrap = document.getElementById('snowWrap'),  
            snowWrapWidth = snowWrap.offsetWidth,  
            snowWrapHeight = snowWrap.offsetHeight;  
        var temp = 0;  
        setInterval(function () {  
            if (temp++ == density) {  
                temp = 0;  
                var el = document.createElement('div');  
                el.innerHTML = '*'; 
                el.ztop = -2;  
                el._ztop = 2 + Math.random() * 5;  
                el.zleft = Math.random() * snowWrapWidth;  
                el._zleft = Math.random() < 0.5 ? Math.random() : Math.random() * (-1);  
                el.style.fontSize = 3 * Math.random() + 'em';  
                el.style.width = el.style.height = 3 * Math.random() + 'em';  
                el.style.opacity = 0.5 + Math.random() * 0.5;  
                el.style.left = el.zleft + 'px';  
                snowWrap.appendChild(el);  
                snowflakes.push(el);  
            }  

            for (var i = 0; i < snowflakes.length; i++) {  
                snowflakes[i].ztop += snowflakes[i]._ztop;  
                snowflakes[i].zleft += snowflakes[i]._zleft;  
                if (snowflakes[i].ztop > snowWrapHeight) {  
                    snowWrap.removeChild(snowflakes[i]);  
                    snowflakes.splice(i, 1)  
                } else {  
                    snowflakes[i].style.top = snowflakes[i].ztop + 'px';  
                    snowflakes[i].style.left = snowflakes[i].zleft + 'px'  
                }  
            }  

        }, speed);  
    };  

    return Snow;  
}());  