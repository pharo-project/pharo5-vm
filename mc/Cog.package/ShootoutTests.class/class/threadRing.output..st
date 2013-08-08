benchmarking
threadRing: aSemaphore output: output
   | first last |
   503 to: 1 by: -1 do: [:i|
      first := ShootoutThread named: i next: first done: aSemaphore output: output.
      last isNil ifTrue: [ last := first ].
   ].
   last nextThread: first.
   ^first 