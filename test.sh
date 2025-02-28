#!/bin/bash

# Define test directories
TS_DIR="./typescript"
GO_DIR="./golang"
PY_DIR="./python"
CLJ_DIR="./clojure"
LOG_FILE="execution_results.log"

# Clear previous logs
echo "Running benchmarks..." > "$LOG_FILE"

run_test() {
    echo "Running $1..." | tee -a "$LOG_FILE"
    eval "$2" 2>&1 | tee -a "$LOG_FILE"
    echo "----------------------------------" >> "$LOG_FILE"
}

# TypeScript Tests (Node.js required)
if command -v node &> /dev/null; then
    run_test "TypeScript Arithmetic" "node $TS_DIR/arithmetic.ts"
    run_test "TypeScript String Manipulation" "node $TS_DIR/string_manipulation.ts"
    run_test "TypeScript Collection Processing" "node $TS_DIR/collection.ts"
    run_test "TypeScript Concurrency Test" "node $TS_DIR/concurrency.ts"
else
    echo "Node.js not found. Skipping TypeScript tests." | tee -a "$LOG_FILE"
fi

# Golang Tests
if command -v go &> /dev/null; then
    run_test "Golang Arithmetic" "go run $GO_DIR/arithmetic.go"
    run_test "Golang String Manipulation" "go run $GO_DIR/string_manipulation.go"
    run_test "Golang Collection Processing" "go run $GO_DIR/collection.go"
    run_test "Golang Concurrency Test" "go run $GO_DIR/concurrency.go"
else
    echo "Golang not found. Skipping Golang tests." | tee -a "$LOG_FILE"
fi

# Python Tests
if command -v python3 &> /dev/null; then
    run_test "Python Arithmetic" "python3 $PY_DIR/arithmetic.py"
    run_test "Python String Manipulation" "python3 $PY_DIR/string_manipulation.py"
    run_test "Python Collection Processing" "python3 $PY_DIR/collection.py"
    run_test "Python Concurrency Test" "python3 $PY_DIR/concurrency.py"
else
    echo "Python3 not found. Skipping Python tests." | tee -a "$LOG_FILE"
fi

# Clojure Tests
if command -v clojure &> /dev/null; then
    run_test "Clojure Arithmetic" "clojure $CLJ_DIR/arithmetic.clj"
    run_test "Clojure String Manipulation" "clojure $CLJ_DIR/string_manipulation.clj"
    run_test "Clojure Collection Processing" "clojure $CLJ_DIR/collection.clj"
    run_test "Clojure Concurrency Test" "clojure $CLJ_DIR/concurrency.clj"
else
    echo "Clojure CLI not found. Skipping Clojure tests." | tee -a "$LOG_FILE"
fi

echo "Benchmark completed. Results saved to $LOG_FILE"
