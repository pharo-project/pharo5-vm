return bytecodes
internalCannotReturn: resultObj
	<inline: true>
	self internalPush: activeContext.
	self internalPush: resultObj.
	messageSelector := self splObj: SelectorCannotReturn.
	argumentCount := 1.
	^ self normalSend