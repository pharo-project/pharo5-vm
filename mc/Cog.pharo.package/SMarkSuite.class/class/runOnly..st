benchmarking
runOnly: aSelector
  "aSelector should refer to a benchmark method.
   Example:
     SMarkLoops runOnly: #benchFloatLoop
  "
  ^ self defaultRunner execute: (self new runOnly: aSelector)