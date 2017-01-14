I/O primitives
ioMousePoint
	| relPt |
	^displayForm
		ifNil: [99 << 16 + 66]
		ifNotNil: [relPt := Sensor cursorPoint - self displayLocation.
				relPt x << 16 + relPt y]