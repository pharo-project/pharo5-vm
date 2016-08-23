accessing
cmHomeMethod
	^cogit cogMethodSurrogateAt: ((SistaV1BytecodeSet and: [self cmIsFullBlock])
										ifTrue: [address]
										ifFalse: [address - self homeOffset])