image formats
bitsInUse
	"Answer a mask of the bits used by all known version format numbers"

	"Transcript cr; show: (ImageFormat bitsInUse printStringBase: 2)"

	| mask |
	mask := 0.
	self bitAssignments doWithIndex: [ :e :i |
		mask := mask bitAt: i put: (e notNil ifTrue: [ 1 ] ifFalse: [ 0 ])].
	^ mask
