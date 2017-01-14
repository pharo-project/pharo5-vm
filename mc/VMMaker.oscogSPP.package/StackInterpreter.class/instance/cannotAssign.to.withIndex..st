stack bytecodes
cannotAssign: resultObj to: targetObj withIndex: index
	<option: #IMMUTABILITY>
	<inline: true> "because of use of normalSend..."
	self internalPush: targetObj.
	self internalPush: resultObj.
	self internalPush: (self integerObjectOf: index + 1).
	messageSelector := self splObj: SelectorAttemptToAssign.
	argumentCount := 2.
	^ self normalSend