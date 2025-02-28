const { Worker } = require('worker_threads');

const start = Date.now();
let completed = 0;

for (let i = 0; i < 100; i++) {
    new Worker(`
        const { parentPort } = require('worker_threads');
        let sum = 0;
        for (let i = 0; i < 1000000; i++) sum += i;
        parentPort.postMessage(sum);
    `, { eval: true }).on('message', () => {
        completed++;
        if (completed === 100) {
            console.log(`Time: ${Date.now() - start} ms`);
        }
    });
}