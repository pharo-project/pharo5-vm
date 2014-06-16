initialize-release
availableBits
	"Bits available for use as capability bits. Reserve high order bit as the
	extension bit, to be set true if additional bits are required in the future."
	
	"ImageFormat availableBits printStringBase: 2"

	| mask |
	mask := 0.
	self bitAssignments doWithIndex: [ :e :i |
		mask := mask bitAt: i put: (e isNil ifTrue: [ 1 ] ifFalse: [ 0 ])].
	^ mask
