#!/bin/bash

# Define test directories
TS_DIR="./typescript"
GO_DIR="./golang"
PY_DIR="./python"
CLJ_DIR="./clojure"
LOG_FILE="execution_results.log"
RESULTS_FILE="execution_results.md"
TEMP_RESULTS="temp_results.txt"

# Clear previous logs
echo "Running benchmarks..." > "$LOG_FILE"
> "$TEMP_RESULTS"  # Create an empty temp results file

run_test() {
    echo "Running $1..." | tee -a "$LOG_FILE"
    OUTPUT=$(eval "$2" 2>&1 | tee -a "$LOG_FILE")
    echo "----------------------------------" >> "$LOG_FILE"

    # Extract execution time (handles `ms`, `seconds`, `µs`)
    TIME=$(echo "$OUTPUT" | grep -oE 'Time: [0-9.]+ (ms|seconds|µs)' | awk '{print $2}')
    UNIT=$(echo "$OUTPUT" | grep -oE 'Time: [0-9.]+ (ms|seconds|µs)' | awk '{print $3}')

    # Extract Clojure times (formatted as `"Elapsed time: X msecs"`)
    if [[ -z "$TIME" ]]; then
        TIME=$(echo "$OUTPUT" | grep -oE '"Elapsed time: [0-9.]+' | awk '{print $3}')
        UNIT="ms"
    fi

    # Handle Golang times (fallback when standard extraction fails)
    if [[ -z "$TIME" ]]; then
        TIME=$(echo "$OUTPUT" | grep -oE '[0-9.]+(ms|µs)' | grep -oE '[0-9.]+' | head -1)
        UNIT=$(echo "$OUTPUT" | grep -oE '[0-9.]+(ms|µs)' | grep -oE '(ms|µs)' | head -1)
    fi

    # Convert seconds to milliseconds
    if [[ "$UNIT" == "seconds" ]]; then
        TIME=$(echo "$TIME * 1000" | bc -l)
    fi

    # Convert microseconds (µs) to milliseconds
    if [[ "$UNIT" == "µs" ]]; then
        TIME=$(echo "scale=6; $TIME / 1000" | bc -l)
    fi

    # Format time correctly
    if [[ -n "$TIME" ]]; then
        FORMATTED_TIME=$(printf "%.2f" "$TIME") # Ensures two decimal places
        echo "$1,$FORMATTED_TIME" >> "$TEMP_RESULTS"
    else
        echo "$1,N/A" >> "$TEMP_RESULTS"
    fi
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

# Generate Markdown Table
{
    echo "# Benchmark Results"
    echo ""
    echo "| Test Name                   | TypeScript (ms) | Golang (ms) | Python (ms) | Clojure (ms) |"
    echo "|-----------------------------|----------------|-------------|-------------|--------------|"

    TESTS=("Arithmetic" "String Manipulation" "Collection Processing" "Concurrency Test")

    for TEST in "${TESTS[@]}"; do
        TS=$(grep "TypeScript $TEST" "$TEMP_RESULTS" | cut -d',' -f2)
        GO=$(grep "Golang $TEST" "$TEMP_RESULTS" | cut -d',' -f2)
        PY=$(grep "Python $TEST" "$TEMP_RESULTS" | cut -d',' -f2)
        CLJ=$(grep "Clojure $TEST" "$TEMP_RESULTS" | cut -d',' -f2)

        echo "| $TEST | ${TS:-N/A} | ${GO:-N/A} | ${PY:-N/A} | ${CLJ:-N/A} |"
    done
} > "$RESULTS_FILE"

# Cleanup temp file
rm "$TEMP_RESULTS"

echo "Benchmark completed. Results saved to $LOG_FILE and $RESULTS_FILE"
