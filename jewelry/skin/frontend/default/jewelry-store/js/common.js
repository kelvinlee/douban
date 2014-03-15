//Home Page Main Slider
jQuery(window).load(function() {
    jQuery('#slider').nivoSlider({
        effect: 'random', // Specify sets like: 'fold,fade,sliceDown'
        slices: 15, // For slice animations
        boxCols: 8, // For box animations
        boxRows: 4, // For box animations
        animSpeed: 2000, // Slide transition speed
		pauseTime: 5000, // How long each slide will show
		controlNav: true, // 1,2,3... navigation
		directionNav:false
    });
});


//Back to Top Button
jQuery(function() {
	jQuery(window).scroll(function() {
		if(jQuery(this).scrollTop() > 300) {
			jQuery('#back_top').fadeIn();	
		} else {
			jQuery('#back_top').fadeOut();
		}
	});
 
	jQuery('#back_top').click(function() {
		jQuery('body,html').animate({scrollTop:0},500);
	});	
});

//Top Cart
jQuery(document).ready(function(){
	jQuery(".shoppingCart").append("<div class='cartView'></div>");
	jQuery(".shoppingCart").hover(function() {
		jQuery(this).find("div").animate({opacity: "show", height:"toggle"}, 400);
	    jQuery(this).find(".cartView").text(hoverText);
	}, function() {
		jQuery(this).find(".cartView").animate({opacity: "hide", height:"toggle"}, 400);
	});
});