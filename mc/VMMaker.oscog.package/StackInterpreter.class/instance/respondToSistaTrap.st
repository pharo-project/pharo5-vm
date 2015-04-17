sista bytecodes
respondToSistaTrap
	| ourContext tos |
	<sharedCodeInCase: #unconditionnalTrapBytecode>
	messageSelector := objectMemory splObj: SelectorSistaTrap.
	tos := self internalPopStack.
	ourContext := self ensureFrameIsMarried: localFP SP: localSP.
	messageSelector = objectMemory nilObject ifTrue:
		[self error: 'Sista trap but no trap selector installed'].
	self internalPush: ourContext.
	self internalPush: tos.
	argumentCount := 1.
	self normalSend