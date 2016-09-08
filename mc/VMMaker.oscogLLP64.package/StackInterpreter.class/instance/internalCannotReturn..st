return bytecodes
internalCannotReturn: resultOop
	| ourContext |
	<inline: true>
	ourContext := self ensureFrameIsMarried: localFP SP: localSP.
	self internalPush: ourContext.
	self internalPush: resultOop.
	messageSelector := objectMemory splObj: SelectorCannotReturn.
	argumentCount := 1.
	^self normalSend