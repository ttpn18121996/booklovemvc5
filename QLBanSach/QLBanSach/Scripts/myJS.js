if ($(".scrolltop").length) {
	var scrollTrigger = 500;
	var backToTop = function () {
		var scrollTop = $(window).scrollTop();
		if (scrollTop > scrollTrigger) {
			$('.scrolltop').addClass('show-btn');
		} else {
			$('.scrolltop').removeClass('show-btn');
		}
	};
	backToTop();
	$(window).on('scroll', function() {
		backToTop();
	});
	$('.scrolltop').on('click', function(event) {
		event.preventDefault();
		$('html,body').animate({
			scrollTop: 0 
		}, 700);
	});
}