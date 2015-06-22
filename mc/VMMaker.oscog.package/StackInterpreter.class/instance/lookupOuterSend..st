message sending
lookupOuterSend: depth
	"Do the full lookup for a self or outer send.
	IN: messageSelector
	IN: argumentCount
	OUT: localAbsentReceiver
	OUT: localAbsentReceiverOrZero
	OUT: newMethod
	OUT: primitiveIndex
	RESULT: [depth] or LookupRuleMNU"

	| targetMixin count mixinApplication |
	localAbsentReceiver := self receiver.
	localAbsentReceiverOrZero := 0.
	targetMixin := self methodClassOf: method.
	count := 0.
	[count < depth] whileTrue:
		[count := count + 1.
		mixinApplication := self
			findApplicationOfTargetMixin: targetMixin
			startingAtBehavior: (objectMemory fetchClassOf: localAbsentReceiver).
		localAbsentReceiverOrZero := localAbsentReceiver := objectMemory followObjField: EnclosingObjectIndex ofObject: mixinApplication.
		targetMixin := objectMemory followObjField: EnclosingMixinIndex ofObject: targetMixin].
	^self lookupLexical: messageSelector from: targetMixin rule: depth