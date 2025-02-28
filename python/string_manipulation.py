import time

start = time.time()
s = ["Hello"] * 1000000  # Create a list of 1,000,000 "Hello"
s = "".join(s)  # Join the list into a single string
end = time.time()

print(f"Time: {end - start} seconds")
