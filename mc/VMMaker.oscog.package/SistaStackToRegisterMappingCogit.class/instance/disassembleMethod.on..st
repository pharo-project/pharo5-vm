disassembly
disassembleMethod: surrogateOrAddress on: aStream
	<doNotGenerate>
	| cogMethod firstCounter |
	cogMethod := super disassembleMethod: surrogateOrAddress on: aStream.
	(cogMethod cmType = CMMethod
	 and: [cogMethod numCounters > 0]) ifTrue:
		[aStream nextPutAll: 'counters:'; cr.
		 firstCounter := cogMethod address + cogMethod blockSize - (cogMethod numCounters * CounterBytes).
		 0 to: cogMethod numCounters - 1 do:
			[:i| | addr |
			 addr := i * CounterBytes + firstCounter.
			 addr printOn: aStream base: 16.
			 aStream nextPut: $:; space.
			 (objectMemory longAt: addr) printOn: aStream base: 16.
			 aStream cr].
		 aStream flush]