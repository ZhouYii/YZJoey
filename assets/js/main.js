$(document).ready(function() {

	//Replace .svg with .png for old browsers
	if(!Modernizr.svg) {
		$('img[src*="svg"]').attr('src',function() {
			return $(this).attr('src').replace('.svg', '.png');
		}); 
	}

	var snapperState;
	var snapper = new Snap({
        element: document.getElementById('content'),
        disable: 'right',
        easing: 'ease-in'
    });

	//Check state on end of drag to update events
	//In Android firefox it wasnt not updating the event
	snapper.on('end', function(){
	   snapperState = snapper.state();
	});
	
	$("#open-left").on('click', function(){ 
		if( snapperState.state === "left" ){
	        snapper.close();
	    } else {
	        snapper.open('left');
	    }
	});
             
});