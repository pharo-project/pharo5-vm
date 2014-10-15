newspeak bytecode support
implicitReceiverFor: rcvr mixin: mixin implementing: selector
	"This is used to implement the innards of the pushImplicitReceiverBytecode,
	 used for implicit receiver sends in NS2/NS3.  Find the nearest lexically-enclosing
	 implementation of selector by searching up the static chain of anObject,
	 starting at mixin's application.  This is an iterative implementation derived from

	<ContextPart> implicitReceiverFor: obj <Object>
					withMixin: mixin <Mixin>
					implementing: selector <Symbol> ^<Object>"
	<api>
	<option: #NewspeakVM>
	| mixinApplication dictionary found |
	self deny: (objectMemory isOopForwarded: rcvr).
	self deny: (objectMemory isForwarded: mixin).
	"messageSelector is an implicit parameter of lookupMethodInDictionary:"
	messageSelector := objectMemory followMaybeForwarded: selector.
	mixinApplication := self
							findApplicationOfTargetMixin: mixin
							startingAtBehavior: (objectMemory fetchClassOf: rcvr).
	 mixinApplication = objectMemory nilObject ifTrue:
		[^rcvr].
	 dictionary := objectMemory followObjField: MethodDictionaryIndex ofObject: mixinApplication.
	 found := self lookupMethodInDictionary: dictionary.
	 found ifFalse:
		[| implicitReceiverOrNil theMixin |
		 theMixin := objectMemory followObjField: MixinIndex ofObject: mixinApplication.
		 implicitReceiverOrNil := self nextImplicitReceiverFor: (objectMemory
																followObjField: EnclosingObjectIndex
																ofObject: mixinApplication)
									withMixin: (objectMemory
													followObjField: EnclosingMixinIndex
													ofObject: theMixin).
		 implicitReceiverOrNil ~= objectMemory nilObject ifTrue:
			[^implicitReceiverOrNil]].
	^rcvr