(function($) {

	"use strict";

	var fullHeight = function() {

		$('.js-fullheight').css('height', $(window).height());
		$(window).resize(function(){
			$('.js-fullheight').css('height', $(window).height());
		});

	};
	fullHeight();

	$('#sidebarCollapse').on('click', function () {
      $('#sidebar').toggleClass('active');
	  $('#content').toggleClass('active');
  });

  $('#close-button').on('click', function () {
	$('#sidebar').toggleClass('active');
	$('#content').toggleClass('active');
});

	var width = $(window).width();
	$(window).on('resize', function() {
	if ($(this).width() !== width) {
		width = $(this).width();
		if(width >= 1050){
			$('#sidebar').toggleClass('active',false);
			$('#content').toggleClass('active',false);
		}
	}
	});

})(jQuery);