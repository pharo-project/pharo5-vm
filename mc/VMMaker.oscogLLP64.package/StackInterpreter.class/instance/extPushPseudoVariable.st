stack bytecodes
extPushPseudoVariable
	"SistaV1:	*	82			01010010			Push thisContext, (then e.g. Extend B 1 = push thisProcess)"
	| theThingToPush |
	extB
		caseOf: {
			[0]	->	[theThingToPush := self ensureFrameIsMarried: localFP SP: localSP].
			[1]	->	[theThingToPush := self activeProcess] }
		otherwise:
			[self respondToUnknownBytecode].
	self fetchNextBytecode.
	self internalPush: theThingToPush.
	extB := 0