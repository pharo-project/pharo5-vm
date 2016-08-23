message sending
handleForwardedSelectorFaultFor: selectorOop
	"Handle a send fault that is due to a send using a forwarded selector.
	 Unforward the selector and follow the current method and special
	 selectors array to unforward the source of the forwarded selector."
	<option: #SpurObjectMemory>
	<inline: false>
	self assert: (objectMemory isOopForwarded: selectorOop).
	self followForwardedFieldsInCurrentMethod.
	objectMemory
		followForwardedObjectFields: (objectMemory splObj: SpecialSelectors)
		toDepth: 0.
	^objectMemory followForwarded: selectorOop