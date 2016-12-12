disassembly
disassembleMethod: surrogateOrAddress on: aStream
	<doNotGenerate>
	| cogMethod |
	cogMethod := super disassembleMethod: surrogateOrAddress on: aStream.
	(cogMethod cmType = CMMethod
	 and: [cogMethod counters ~= 0]) ifTrue:
		[aStream nextPutAll: 'counters:'; cr.
		 numCounters := objectRepresentation numCountersFor: counters.
		 0 to: numCounters - 1 do:
			[:i| | addr |
			 addr := i * CounterBytes + counters.
			 addr printOn: aStream base: 16.
			 aStream nextPut: $:; space.
			 (objectMemory long32At: addr) printOn: aStream base: 16.
			 aStream cr].
		 aStream flush]