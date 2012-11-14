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
  var $container = $('#all_images');
  $container.imagesLoaded( function(){
    $container.masonry({
      itemSelector : '.image',
      columnWidth : 100,
      isAnimated: true
    });
  });

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
});

$(document).ready(function () {
	var ratingModal = {
		container: null,
		init: function () {
			$(".image").click(function (e) {
				e.preventDefault();

				$("#rating_modal").modal({
					overlayId: 'ratingModal-overlay',
					containerId: 'ratingModal-container',
					closeHTML: null,
					minHeight: 120,
					opacity: 65,
					position: ['0',],
					overlayClose: true,
					onOpen: ratingModal.open,
					onClose: ratingModal.close
				});
			});
		},
		open: function (d) {
			var self = this;
			self.container = d.container[0];
			d.overlay.fadeIn('slow', function () {
				$("#rating_modal", self.container).show();
				var title = $("#rating_modal-title", self.container);
				title.show();
				d.container.slideDown('fast', function () {
					setTimeout(function () {
						var h = $("#rating_modal", self.container).height()
							+ title.height()
							+ 20; // padding
						d.container.animate(
							{height: h},
							200,
							function () {
								$("div.close", self.container).show();
								$("#rating_modal", self.container).show();
							}
						);
					}, 300);
				});
			})
		},
		close: function (d) {
			var self = this; // this = SimpleModal object
			d.container.animate(
				{top:"-" + (d.container.height() + 20)},
				100,
				function () {
					self.close(); // or $.modal.close();
				}
			);
		}
	};

	ratingModal.init();

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


$(document).ready(function() {
	  simpleCart({
		  cartColumns: [
          { attr: "name" , label: "Name" } ,
          { attr: "price" , label: "Price", view: 'currency' } ,
          { view: "decrement" , label: true , text: "Less" } ,
          { attr: "quantity" , label: "Qty" } ,
          { view: "increment" , label: true , text: "More" } ,
          { attr: "total" , label: "SubTotal", view: 'currency' } ,
          { view: "remove" , text: "Remove" , label: "Remove" }
      ]
      checkout: {
        type: "SendForm" ,
        url: "http://localhost:3000/carts/new"
    }

   });
});
