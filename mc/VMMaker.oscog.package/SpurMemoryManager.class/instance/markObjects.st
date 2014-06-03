gc - global
markObjects
	<inline: false>
	"Mark all accessible objects."
	"If the incremental collector is running mark bits may be set; stop it and clear them if necessary."
	self cCode: '' inSmalltalk: [coInterpreter transcript nextPutAll: 'marking...'; flush].
	self runLeakCheckerForFullGC: true.

	self ensureAllMarkBitsAreZero.
	self ensureAdequateClassTableBitmap.
	self initializeUnscannedEphemerons.
	self initializeMarkStack.
	self initializeWeaklingStack.
	self markAccessibleObjects