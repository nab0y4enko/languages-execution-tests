(time (doall (pmap (fn [_] (reduce + (range 1000000))) (range 100))))
