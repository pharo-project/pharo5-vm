message sending
handleSpecialSelectorSendFaultFor: obj fp: theFP sp: theSP
	"Handle a special send fault that may be due to a special selector
	 send accessing a forwarded object.  obj is forwarded.
	 Unforward stack contents and and inst vars and answer obj's target."
	<inline: false>
	<var: #theFP type: #'char *'>
	<var: #theSP type: #'char *'>
	| rcvr |
	self assert: (objectMemory isOopForwarded: obj).
	self followForwardedFrameContents: theFP stackPointer: theSP.
	rcvr := self frameReceiver: theFP.
	(objectMemory isPointers: rcvr) ifTrue:
		[objectMemory
			followForwardedObjectFields: rcvr
			toDepth: 0].
	^objectMemory followForwarded: obj