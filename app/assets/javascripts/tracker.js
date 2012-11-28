$(window).bind("load", function() {
   var $container = $('#grid');
   $container.masonry({
     itemSelector : '.gridItem',
     isAnimated: true,
     isFitWidth: true,
     columnWidth: 20
   });
});
