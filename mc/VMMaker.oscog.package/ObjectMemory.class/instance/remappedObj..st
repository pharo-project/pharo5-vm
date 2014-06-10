gc -- compaction
remappedObj: forwardedObj
	"Answer the given forwardedOop's target value
	 during a compaction or become: operation."
	| fwdBlock targetObj |
	<inline: true>
	fwdBlock := self forwardingPointerOf: forwardedObj.
	self assert: (self fwdBlockValid: fwdBlock).
	targetObj := self longAt: fwdBlock.
	self assert: (self addressCouldBeObjWhileForwarding: targetObj).
	^targetObj