import time
import multiprocessing

def worker():
    sum([i for i in range(1000000)])

if __name__ == "__main__":
    start = time.time()
    processes = []
    
    for _ in range(100):
        p = multiprocessing.Process(target=worker)
        p.start()
        processes.append(p)

    for p in processes:
        p.join()

    end = time.time()
    print(f"Time: {end - start} seconds")
