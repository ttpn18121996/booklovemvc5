$('.top-menu ul li').hover(function() {
	$(this).children('ul').stop(true, false, true).slideToggle(300);
});