message sending
lookupImplicitReceiverSend
	"Do the full lookup for an implicit receiver send.
	IN: messageSelector
	IN: argumentCount
	OUT: localAbsentReceiver
	OUT: localAbsentReceiverOrZero
	OUT: newMethod
	OUT: primitiveIndex
	RESULT: LookupRuleImplicit or LookupRuleMNU"

	| methodReceiver candidateReceiver candidateMixin candidateMixinApplication dictionary found |
	messageSelector := objectMemory followMaybeForwarded: messageSelector.
	methodReceiver := self receiver.
	candidateReceiver := methodReceiver.
	self deny: (objectMemory isForwarded: method).
	candidateMixin := self methodClassOf: method.
	localAbsentReceiverOrZero := 0.
	[self deny: (objectMemory isForwarded: candidateMixin).
	self deny: (objectMemory isForwarded: candidateReceiver).
	candidateMixinApplication := self
		findApplicationOfTargetMixin: candidateMixin
		startingAtBehavior: (objectMemory fetchClassOf: candidateReceiver).
	self deny: (candidateMixinApplication = 0).
	self deny: (candidateMixinApplication = objectMemory nilObject).
	self deny: (objectMemory isForwarded: candidateMixinApplication).
	self assert: (self addressCouldBeClassObj: candidateMixinApplication).
	dictionary := objectMemory followObjField: MethodDictionaryIndex ofObject: candidateMixinApplication.
	found := self lookupMethodInDictionary: dictionary.
	found ifTrue:
		[localAbsentReceiver := candidateReceiver.
		^self lookupLexical: messageSelector from: candidateMixin rule: LookupRuleImplicit].
	candidateMixin := objectMemory followObjField: EnclosingMixinIndex ofObject: candidateMixin.
	self deny: (objectMemory isForwarded: candidateMixin).
	candidateMixin = objectMemory nilObject]
		whileFalse:
			[localAbsentReceiverOrZero := candidateReceiver := objectMemory followObjField: EnclosingObjectIndex ofObject: candidateMixinApplication].
	"There is no lexically visible method, so the implicit receiver is the method receiver."
	localAbsentReceiverOrZero := 0.
	localAbsentReceiver := methodReceiver.
	lkupClass := objectMemory fetchClassOf: methodReceiver. "MNU lookup starts here."
	^self lookupProtected: messageSelector startingAt: lkupClass rule: LookupRuleImplicit.