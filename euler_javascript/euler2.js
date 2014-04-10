var evenFib = function(max) {
  var a = 0;
  var b = 1;
  var c = 2;
  var total = 0;

  while(total < max) {
    if (b % 2 === 0) {
      total += b;
    }

    a = b + c;
    b = c;
    c = a;
  }

  return total;
};

console.log(evenFib(4000000));