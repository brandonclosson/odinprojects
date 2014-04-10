/*
If we list all the natural numbers below 10 that are multiples 
of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
Find the sum of all the multiples of 3 or 5 below 1000.
*/

var findMultiples = function(max) {
  total = 0;
  for(var i = 0; i <= max; i++) {
    if ((i % 3 === 0) || (max % 5 === 0)) {
      total += i;
    }
  }
  return total;
};

console.log(findMultiples(1000));