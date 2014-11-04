newspeak bytecode support
implicitReceiverFor: methodReceiver mixin: methodMixin implementing: selector
	"This is used to implement implicit receiver sends in Newspeak. Find the nearest
	 lexically-enclosing implementation of selector by searching up the static chain of the
	 method's receiver, starting at mixin's application. This implementation is derived from

	<ContextPart> implicitReceiverFor: methodReceiver <Object>
					in: methodMixin <Mixin>
					implementing: selector <Symbol> ^<Object>"
	<api>
	<option: #NewspeakVM>
	| candidateReceiver candidateMixin candidateMixinApplication dictionary found |
	self deny: (objectMemory isOopForwarded: methodReceiver).
	self deny: (objectMemory isForwarded: methodMixin).
	"messageSelector is an implicit parameter of lookupMethodInDictionary:"
	messageSelector := objectMemory followMaybeForwarded: selector.
	candidateReceiver := methodReceiver.
	candidateMixin := methodMixin.
	[candidateMixinApplication := self
		findApplicationOfTargetMixin: candidateMixin
		startingAtBehavior: (objectMemory fetchClassOf: candidateReceiver).
	 self deny: (candidateMixinApplication = objectMemory nilObject).
	 dictionary := objectMemory followObjField: MethodDictionaryIndex ofObject: candidateMixinApplication.
	 found := self lookupMethodInDictionary: dictionary.
	 found ifTrue: [^candidateReceiver].
	 candidateMixin := objectMemory followObjField: EnclosingMixinIndex ofObject: candidateMixin.
	 candidateMixin = objectMemory nilObject]
		whileFalse:
			[candidateReceiver := objectMemory followObjField: EnclosingObjectIndex ofObject: candidateMixinApplication].
	^methodReceiver