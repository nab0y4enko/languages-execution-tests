const start = Date.now();
let str = "";
for (let i = 0; i < 1000000; i++) {
    str += "Hello";
}
const end = Date.now();
console.log(`Time: ${end - start} ms`);