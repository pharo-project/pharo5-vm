instruction decoding
popIntoTemporaryVariable: offset
	| vector |
	topIsVector
		ifTrue:
			[vector := currentContext top.
			 1 to: vector size do:
				[:i|
				vector
					at: i
					put: 'remote ', i printString,
						' @ ', (offset + 1) printString,
						' in ', currentContext startpc printString].
			 currentContext popIntoTemporaryVariable: offset]
		ifFalse:
			[currentContext pop]