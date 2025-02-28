import time

numbers = list(range(1000000))
start = time.time()
sum_result = sum(numbers)
end = time.time()
print(f"Time: {end - start} seconds")