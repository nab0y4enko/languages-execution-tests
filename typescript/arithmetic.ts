const start = Date.now();
let sum = 0;
for (let i = 1; i <= 100000000; i++) {
    sum += i;
}
const end = Date.now();
console.log(`Time: ${end - start} ms`);