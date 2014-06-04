C library simulation
mem: aString cp: bString y: n
	<doNotGenerate>
	"implementation of memcpy(3)"
	aString isString
		ifTrue:
			[1 to: n do:
				[:i| | v |
				v := bString isString
						ifTrue: [bString at: i]
						ifFalse: [Character value: (self byteAt: bString + i - 1)].
				aString at: i put: v]]
		ifFalse:
			[1 to: n do:
				[:i| | v |
				v := bString isString
						ifTrue: [(bString at: i) asInteger]
						ifFalse: [self byteAt: bString + i - 1].
				self byteAt: aString + i - 1 put: v]].
	^aString