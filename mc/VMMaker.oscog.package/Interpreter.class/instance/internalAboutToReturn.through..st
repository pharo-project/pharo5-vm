return bytecodes
internalAboutToReturn: resultObj through: aContext
	<inline: true>
	self internalPush: activeContext.
	self internalPush: resultObj.
	self internalPush: aContext.
	messageSelector := self splObj: SelectorAboutToReturn.
	argumentCount := 2.
	^self normalSend