I/O primitives
ioMousePoint
	| relPt |
	^displayForm == nil
		ifTrue: [99 < 16 + 66]
		ifFalse: [relPt := Sensor cursorPoint - self displayLocation.
				relPt x << 16 + relPt y]