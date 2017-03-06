$(document).ready(function () {
    if ( $("#beertable").length>0 ) {

      $("#name").click(function (e) {
          BEERS.sort_by_name();
          BEERS.show();
          e.preventDefault();
      });

      $("#style").click(function (e) {
          BEERS.sort_by_style();
          BEERS.show();
          e.preventDefault();
      });

      $("#brewery").click(function (e) {
          BEERS.sort_by_brewery();
          BEERS.show();
          e.preventDefault();
      });


      $.getJSON('beers.json', function (beers) {
        BEERS.list = beers;
        BEERS.sort_by_name;
        BEERS.show();
      });

    }
});