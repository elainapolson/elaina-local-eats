function setCurrentLocation() {
  $("#search_near").val("Looking for your location...");
  navigator.geolocation.getCurrentPosition(function(position){
    var crd = position.coords;
    var latitude = crd.latitude;
    var longitude = crd.longitude;
    var ll = latitude + ',' + longitude;
    $("#search_ll").val(ll);

    var google_geocoder = gon.google_geocoder
    var link = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + ll + "&key=" + google_geocoder
    
    $.getJSON(link)
    .done(function(data){
      var address = data['results'][3]['formatted_address']
      $("#search_near").val(address);
    })
    .fail(function(){
    alert("Oops, we couldn't find your location. Please enter a neighborhood.");
    });
  });
};