memory access
at: index
	| value |
	value := simArray at: index+1.
	"Debug only..."
	value ifNil:
		[self error: 'attempt to read an uninitialized field'.
		^ super at: index  "Maybe it was set in Squeak.  Return the raw value"].
	(self bitsOf: value) ~= (super at: index) ifTrue:
		[self error: 'inconsistent values: ', (self bitsOf: value) printString, ' vs ', (super at: index) printString].
	^value