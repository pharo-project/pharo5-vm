object memory support
preGCAction: gcModeArg
	"Override to void debugStackPointers on any GC/remap"
	debugStackDepthDictionary ifNotNil:
		[debugStackDepthDictionary := Dictionary new].
	^super preGCAction: gcModeArg