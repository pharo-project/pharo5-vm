sista bytecodes
respondToSistaTrap
	| ourContext |
	<sharedCodeInCase: #unconditionnalTrapBytecode>
	messageSelector := objectMemory splObj: SelectorSistaTrap.
	ourContext := self ensureFrameIsMarried: localFP SP: localSP.
	self internalPush: ourContext.
	argumentCount := 0.
	self normalSend