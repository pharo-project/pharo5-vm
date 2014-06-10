disassembly
disassemble: targetmcpc from: startpc to: endpc arg: aStream
	<doNotGenerate>
	| startbcpc |
	self disassembleFrom: startpc to: endpc - 1 labels: Dictionary new on: aStream.
	startbcpc := (self cCoerceSimple: targetmcpc - (self sizeof: CogBlockMethod) to: #'CogBlockMethod *') startpc.
	aStream nextPutAll: 'block startpc: '.
	startbcpc printOn: aStream base: 16.
	aStream nextPut: $/.
	(objectMemory integerObjectOf: startbcpc) printOn: aStream base: 16.
	aStream cr; flush.
	^0