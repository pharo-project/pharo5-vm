message sending
lookupDynamicSuperSend
	"Do the full lookup for a Newspeak super send.
	IN: messageSelector
	IN: argumentCount
	OUT: localAbsentReceiver
	OUT: newMethod
	OUT: primitiveIndex
	RESULT: LookupRuleDynamicSuper or LookupRuleMNU"

	| methodMixin methodMixinApplication |
	localAbsentReceiver := self receiver.
	localAbsentReceiverOrZero := 0.
	methodMixin := self methodClassOf: method.
	methodMixinApplication := self
		findApplicationOfTargetMixin: methodMixin
		startingAtBehavior: (objectMemory fetchClassOf: localAbsentReceiver).
	lkupClass := self superclassOf: methodMixinApplication. "MNU lookup starts here."
	^self lookupProtected: messageSelector startingAt: lkupClass rule: LookupRuleDynamicSuper