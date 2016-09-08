testing
stats
	| oop fieldAddr fieldOop last stats v d |
	stats := Bag new.
	oop := self firstObject.

'Scanning the image...' displayProgressAt: Sensor cursorPoint
	from: oop to: endOfMemory
	during: [:bar |

	[oop < endOfMemory] whileTrue:
		[(self isFreeObject: oop) ifFalse:
			[stats add: #objects.
			fieldAddr := oop + (self lastPointerOf: oop).
			[fieldAddr > oop] whileTrue:
				[fieldOop := self longAt: fieldAddr.
				(self isIntegerObject: fieldOop)
					ifTrue: [v := self integerValueOf: fieldOop.
							(v between: -16000 and: 16000)
								ifTrue: [stats add: #ints32k]
								ifFalse: [stats add: #intsOther]]
					ifFalse: [fieldOop = nilObj ifTrue: [stats add: #nil]
							ifFalse:
							[d := fieldOop - oop.
							(d between: -16000 and: 16000)
								ifTrue: [stats add: #oops32k]
								ifFalse: [stats add: #oopsOther]]].
				fieldAddr := fieldAddr - self wordSize]].
		bar value: oop.
		last := oop.
		last := last.
		oop := self objectAfter: oop]].
	^ stats sortedElements