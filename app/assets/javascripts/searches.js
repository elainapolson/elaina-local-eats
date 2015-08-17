$(function(){

  $(".about").on('click', function(){
    jumpToAbout();
  });

  $("#location").on('click', function(){
    setCurrentLocation();
  });

  $("form").submit(function(e){
    e.preventDefault();
    e.stopPropagation();    

    var fact = randomFact();
    var query = $("#search_query").val()
    
    $("#myModalLabel").html("Searching for locals' favorite " + query + " spots...")
    $('#myModal').children('div').children('div').children('div.modal-body').html("<h4>Did you Know?</h4><p>"+ fact +"</p>");
    $('#myModal').modal('show');

    var url = $(this).attr('action');
    var method = $(this).attr('method');
    var data = $(this).serializeArray();

    $.ajax({
      method: method,
      url: url,
      data: data,
      dataType: 'script'
    });
  })
});