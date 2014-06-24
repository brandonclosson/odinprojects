$(document).ready(function() {

  function startFresh(gridSize) {
    var grid = $('#grid');
    var gridHeight = grid.height();
    var gridWidth = grid.width();
    var gridRow = "";
    grid.html("");

    for(var i=1; i <= gridSize; i++) {
      gridRow += '<div class="tile"></div>';
    };

    for(var j=1; j <= gridSize; j++) {
      grid.append(gridRow);
    };

    $tiles = $('div .tile');
    var tileHeight = (gridHeight / gridSize) + "px";
    var tileWidth = (gridWidth / gridSize) + "px";
    $tiles.css("height", tileHeight);
    $tiles.css("width", tileWidth);
    $tiles.css("margin", 0);

    startGrid();
  }

  function startGrid() {
    if ($mode == "normal") {
      $tiles.mouseenter(function() {
        $(this).css("background-color", "grey");
      });
    } else if ($mode == "random") {
      $tiles.mouseenter(function() {
        $(this).css("background-color", randomColor());
      });
    };
  }

  function randomColor() {
      var hexes = '0123456789ABCDEF'.split('');
      var color = '#';
      for (var i = 0; i < 6; i++ ) {
          color += hexes[Math.floor(Math.random() * 16)];
      }
      return color;
  };

  $('#standard').on('click', function() {
    var size = 0;
    $mode = "normal";
    do {
      size = prompt("How many tiles high do you want your square?");
    } while (isNaN(size));

    startFresh(size);
  });

  $('#random').on('click', function() {
    var size = 0;
    $mode = "random";
    do {
      size = prompt("How many tiles high do you want your square?");
    } while (isNaN(size));

    startFresh(size);
  });
});