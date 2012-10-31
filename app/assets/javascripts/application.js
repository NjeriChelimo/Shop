// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .


$(function(){
  var $container = $('#images-container');
  $container.imagesLoaded( function(){
    $container.masonry({
      itemSelector : '.image',
      columnWidth : 100
    });
  });

  $container.infinitescroll({
          loading: {
              finishedMsg: 'No more pages to load.',
              msg: null,
              msgText: "<em>Loading the next set of posts...</em>",
              selector: null,
              speed: 'fast',
              start: undefined
          },
          state: {
            isDuringAjax: false,
            isInvalidPage: false,
            isDestroyed: false,
            isDone: false, // For when it goes all the way through the archive.
            isPaused: false,
            currPage: 1
          },
          // trigger Masonry as a callback
          function( newElements ) {
            // hide new items while they are loading
            var $newElems = $( newElements ).css({ opacity: 0 });
            // ensure that images load before adding to masonry layout
            $newElems.imagesLoaded(function(){
              // show elems now they're ready
              $newElems.animate({ opacity: 1 });
              $container.masonry( 'appended', $newElems, true );
            });
          }
        );
});


$(document).ready(function() {
     $('#myButton').click(function(e) {
          e.preventDefault();
	  $('#myModal').reveal({
     animation: 'fadeAndPop',
     animationspeed: 300,
     closeonbackgroundclick: true,
     dismissmodalclass: 'close-reveal-modal'
  });
});
