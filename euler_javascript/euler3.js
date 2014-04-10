var largestPrime = function (max) {
  var largest_factor = 1;
  while (max % 2 === 0) {
    largest_factor = 2;
    max = max / 2;
  }

  var odd = 3;
  while (max != 1) {
    while (max % odd === 0) {
      max = max / odd;
      largest_factor = odd;
    }
    odd += 2;
  }
  
  return largest_factor;
};

console.log(largestPrime(600851475143));