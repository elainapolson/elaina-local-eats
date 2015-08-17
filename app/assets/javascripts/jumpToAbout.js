function jumpToAbout(){
    $('html, body').animate({
        scrollTop: $("#about").offset().top
    }, 2000);
};