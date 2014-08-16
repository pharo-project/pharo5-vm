sista bytecodes
respondToClassTrap
	| ourContext tos |
	<sharedCodeInCase: #extTrapIfNotInstanceOfBehaviorsBytecode>
	messageSelector := objectMemory splObj: SelectorClassTrap.
	tos := self internalPopStack.
	ourContext := self ensureFrameIsMarried: localFP SP: localSP.
	messageSelector = objectMemory nilObject ifTrue:
		[self error: 'class trap'].
	self internalPush: ourContext.
	self internalPush: tos.
	argumentCount := 1.
	self normalSend