message sending
handleSpecialSelectorSendFaultFor: obj fp: theFP sp: theSP
	"Handle a special send fault that may be due to a special selector
	 send accessing a forwarded object.
	 Unforward the object on the stack and in inst vars and answer its target."
	<inline: false>
	<var: #theFP type: #'char *'>
	<var: #theSP type: #'char *'>
	self assert: (objectMemory isOopForwarded: obj).

	self followForwardedFrameContents: theFP stackPointer: theSP.
	(objectMemory isPointers: (self frameReceiver: theFP)) ifTrue:
		[objectMemory
			followForwardedObjectFields: (self frameReceiver: theFP)
			toDepth: 0].
	^objectMemory followForwarded: obj