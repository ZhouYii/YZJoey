$(document).ready(function() {

	//Replace .svg with .png for old browsers
	if(!Modernizr.svg) {
		$('img[src*="svg"]').attr('src',function() {
			return $(this).attr('src').replace('.svg', '.png');
		}); 
	}

});
