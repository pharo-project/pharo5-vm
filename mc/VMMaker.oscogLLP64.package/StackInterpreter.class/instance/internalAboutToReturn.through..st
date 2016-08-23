return bytecodes
internalAboutToReturn: resultOop through: aContext
	| ourContext |
	<inline: true>
	ourContext := self ensureFrameIsMarried: localFP SP: localSP.
	self internalPush: ourContext.
	self internalPush: resultOop.
	self internalPush: aContext.
	messageSelector := objectMemory splObj: SelectorAboutToReturn.
	argumentCount := 2.
	^self normalSend