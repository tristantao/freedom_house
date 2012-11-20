$(window).bind("load", function() {
   var $container = $('#grid');
   $container.imagesLoaded(function(){
     $container.masonry({
       itemSelector : '.gridItem',
       isAnimated: true,
       isFitWidth: true,
       isResizable: true,
       columnWidth: 20
     });
   });
});
