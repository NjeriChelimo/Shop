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








$(document).ready(function(){

    var $container = $('#all_images');

    $container.imagesLoaded(function(){
      $container.masonry({
        itemSelector: '.box',
        columnWidth: 100
      });
    });

    $container.infinitescroll({
      navSelector  : '#page-nav',    // selector for the paged navigation
      nextSelector : '#page-nav a',  // selector for the NEXT link (to page 2)
      itemSelector : '.box',     // selector for all items you'll retrieve
      loading: {
          finishedMsg: 'No more pages to load.',
          img: 'http://i.imgur.com/6RMhx.gif'
        }
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









//$(function(){
  //var $container = $('#all_images');
  //$container.imagesLoaded( function(){
    //$container.masonry({
      //itemSelector : '.image',
      //columnWidth : 100,
      //isAnimated: true
    //});
  //});

//  $container.infinitescroll({
//          loading: {
//              finishedMsg: 'No more pages to load.',
//              //img: 'http://i.imgur.com/6RMhx.gif'
//            }
//          },
//          // trigger Masonry as a callback
//          function( newElements ) {
//            // hide new items while they are loading
//            var $newElems = $( newElements ).css({ opacity: 0 });
//            // ensure that images load before adding to masonry layout
//            $newElems.imagesLoaded(function(){
//              // show elems now they're ready
//              $newElems.animate({ opacity: 1 });
//              $container.masonry( 'appended', $newElems, true );
//            });
//          }
//        );



//
//});





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


$(document).ready(function() {
	  simpleCart({
		  cartColumns: [
          { attr: "name" , label: "Name" } ,
          { attr: "id" , label: "Id" }.
          { attr: "price" , label: "Price", view: 'currency' } ,
          { view: "decrement" , label: true , text: "Less" } ,
          { attr: "quantity" , label: "Qty" } ,
          { view: "increment" , label: true , text: "More" } ,
          { attr: "total" , label: "SubTotal", view: 'currency' } ,
          { view: "remove" , text: "Remove" , label: "Remove" }
      ]

   });
});
