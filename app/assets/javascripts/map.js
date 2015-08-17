function createMap(locations){

  var locations = locations;

  var bounds = new google.maps.LatLngBounds();

  var styling = [{"featureType":"administrative","elementType":"labels.text.fill","stylers":[{"color":"#444444"}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#f2f2f2"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"all","stylers":[{"saturation":-100},{"lightness":45}]},{"featureType":"road","elementType":"geometry","stylers":[{"lightness":"64"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"lightness":"100"},{"saturation":"-81"}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"lightness":"100"}]},{"featureType":"road.highway","elementType":"all","stylers":[{"visibility":"simplified"}]},{"featureType":"road.arterial","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"water","elementType":"all","stylers":[{"color":"#c4ccd6"},{"visibility":"on"}]}]
  
  
  var map;
  if(locations.length > 0){
    map = new google.maps.Map(document.getElementById('map'), {
      zoom: 15,
      center: new google.maps.LatLng(locations[0][1], locations[0][2]),
      styles: styling,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });
 }else{
   map = new google.maps.Map(document.getElementById('map'), {
      zoom: 15,
      center: new google.maps.LatLng(40.7052802,-74.0131287),
      styles: styling,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });
 }

  var infowindow = new google.maps.InfoWindow();

  var marker, i;

  for (i = 0; i < locations.length; i++) {  
    marker = new google.maps.Marker({
      position: new google.maps.LatLng(locations[i][1], locations[i][2]),
      map: map
    });

    bounds.extend(marker.position);

    google.maps.event.addListener(marker, 'click', (function(marker, i) {
      return function() {
        infowindow.setContent("<b>" + locations[i][0] + "</b>" + "<br>" + locations[i][4] + "<br> Foursquare rating: " + locations[i][5]);
        infowindow.open(map, marker);
      }
    })(marker, i));
  }

  map.fitBounds(bounds);

};