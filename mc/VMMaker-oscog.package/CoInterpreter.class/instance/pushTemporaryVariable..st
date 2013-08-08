stack bytecodes
pushTemporaryVariable: temporaryIndex
	"Override to use itemporary:in:put:"
	self internalPush: (self itemporary: temporaryIndex in: localFP)