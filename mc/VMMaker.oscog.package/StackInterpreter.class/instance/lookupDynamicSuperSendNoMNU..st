message sending
lookupDynamicSuperSendNoMNU: methodReceiver
	"Do the full lookup for a Newspeak super send.
	IN: messageSelector
	IN: argumentCount
	OUT: localAbsentReceiver
	OUT: newMethod
	OUT: primitiveIndex
	RESULT: 0 or SelectorDoesNotUnderstand"

	| methodMixin methodMixinApplication |
	localAbsentReceiver := methodReceiver.
	methodMixin := self methodClassOf: method.
	methodMixinApplication := self
		findApplicationOfTargetMixin: methodMixin
		startingAtBehavior: (objectMemory fetchClassOf: localAbsentReceiver).
	lkupClass := self superclassOf: methodMixinApplication. "For use by MNU"
	^self lookupProtectedNoMNU: messageSelector startingAt: lkupClass rule: LookupRuleDynamicSuper