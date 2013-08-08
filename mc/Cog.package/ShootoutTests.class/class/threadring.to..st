benchmarking
threadring: arg to: output
   | done |
   (self threadRing: (done := Semaphore new) output: output) takeToken: arg.
   done wait