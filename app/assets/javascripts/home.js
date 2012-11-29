$(document).ready(function(){
    var $container = $('#all_images');
    $container.imagesLoaded(function(){
      $container.masonry({
        itemSelector: '.box',
        columnWidth: 100
      });
    });

     $('#myButton').click(function(e) {
          e.preventDefault();
	  $('#myModal').reveal({
     animation: 'fadeAndPop',
     animationspeed: 300,
     closeonbackgroundclick: true,
     dismissmodalclass: 'close-reveal-modal'
    });
  });
});
