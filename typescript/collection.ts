const numbers = Array.from({ length: 1000000 }, (_, i) => i);
const start = Date.now();
const sum = numbers.reduce((a, b) => a + b, 0);
const end = Date.now();
console.log(`Time: ${end - start} ms`);