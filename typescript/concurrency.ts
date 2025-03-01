import { Worker } from 'worker_threads';

const start = Date.now();
let completed = 0;

const workerScript = `
    const { parentPort } = require('worker_threads');
    let sum = 0;
    for (let i = 0; i < 1000000; i++) sum += i;
    parentPort.postMessage(sum);
`;

for (let i = 0; i < 100; i++) {
    const worker = new Worker(workerScript, { eval: true });
    worker.on('message', () => {
        completed++;
        if (completed === 100) {
            console.log(`Time: ${Date.now() - start} ms`);
        }
    });
    worker.on('error', (err) => {
        console.error(`Worker error: ${err}`);
    });
    worker.on('exit', (code) => {
        if (code !== 0) {
            console.error(`Worker stopped with exit code ${code}`);
        }
    });
}