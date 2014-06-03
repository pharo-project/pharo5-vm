simulation only
printCountersFor: cogMethod on: aStream
	| firstCounter |
	firstCounter := cogMethod address + cogMethod blockSize - (cogMethod numCounters * CounterBytes).
	0 to: cogMethod numCounters - 1 do:
		[:i| | addr |
		addr := i * CounterBytes + firstCounter.
		addr printOn: aStream base: 16.
		aStream nextPut: $:; space.
		(objectMemory longAt: addr) printOn: aStream base: 16.
		aStream cr]