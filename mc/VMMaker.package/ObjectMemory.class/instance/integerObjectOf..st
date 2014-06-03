interpreter access
integerObjectOf: value
	"Convert the integer value, assumed to be in SmallInteger range, into a tagged SmallInteger object.
	 In C, use a shift and an add to set the tag bit.
	 In Smalltalk we have to work harder because the simulator works with strictly positive bit patterns."
	<returnTypeC: #sqInt>
	^self
		cCode: [(value << 1) + 1]
		inSmalltalk: [value >= 0
						ifTrue: [(value << 1) + 1]
						ifFalse: [((16r80000000 + value) << 1) + 1]]