import time

start = time.time()
sum_result = sum(range(1, 100000001))
end = time.time()
print(f"Time: {end - start} seconds")