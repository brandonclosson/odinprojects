currentInt = 1;
nextInt = 2;

$(document).ready(function() {

  $("#slider > img#1").fadeIn(300);
  startSlide();

});

function startSlide() {
  count = $("#slider > img").size();

  loop = setInterval(function() {
    if(nextInt > count) {
      currentInt = 1;
      nextInt = 1;
    }
    
    $("#slider > img").fadeOut(700);
    $("#slider > img#" + nextInt).fadeIn(700);
    currentInt = nextInt;
    nextInt += 1;
  }, 3700);

}

var newSlide = 1;

function prev() {
  newSlide = currentInt - 1;
  showSlide(newSlide);
}

function next() {
  newSlide = currentInt + 1;
  showSlide(newSlide);
}

function stopLoop() {
  window.clearInterval(loop);
}

function showSlide(id) {
    stopLoop();

    if(id > count) {
      id = 1;
    } else if(id < 1) {
      id = count;
    }

    $("#slider > img").fadeOut(700);
    $("#slider > img#" + id).fadeIn(700);

    currentInt = id;
    nextInt = id + 1;

    startSlide();
}

$("#slider > img").hover(
  function() {
    stopLoop();
  }, function() {
    startSlide();
  }
);