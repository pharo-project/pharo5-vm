C library simulation
st: aString rn: bString cpy: n
	<doNotGenerate>
	"implementation of strncpy(3)"
	aString isString
		ifTrue:
			[1 to: n do:
				[:i| | v |
				v := bString isString
						ifTrue: [bString at: i]
						ifFalse: [Character value: (self byteAt: bString + i - 1)].
				aString at: i put: v.
				v asInteger = 0 ifTrue: [^aString]]]
		ifFalse:
			[1 to: n do:
				[:i| | v |
				v := bString isString
						ifTrue: [(bString at: i) asInteger]
						ifFalse: [self byteAt: bString + i - 1].
				self byteAt: aString + i - 1 put: v.
				v = 0 ifTrue: [^aString]]].
	^aString