debug printing
nameForOpcode: opcode "<Integer>"
	opcode < LastRTLCode ifTrue:
		[classPool associations do:
			[:assoc| | opcodeName |
			 assoc value = opcode ifTrue:
				[(((opcodeName := assoc key) beginsWith: 'First')
				   or: [(opcodeName beginsWith: 'Last')]) ifFalse:
					[^opcodeName]]]].
	^nil