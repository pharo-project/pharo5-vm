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
	messageSelector := selector. "messageSelector is an implicit parameter of lookupMethodInDictionary:"
	mixinApplication := self
							findApplicationOfTargetMixin: mixin
							startingAtBehavior: (objectMemory fetchClassOf: rcvr).
	 mixinApplication = objectMemory nilObject ifTrue:
		[^rcvr].
	 dictionary := objectMemory followObjField: MethodDictionaryIndex ofObject: mixinApplication.
	 found := self lookupMethodInDictionary: dictionary.
	 found ifFalse:
		[| implicitReceiverOrNil theMixin |
		 theMixin := objectMemory fetchPointer: MixinIndex ofObject: mixinApplication.
		 implicitReceiverOrNil := self nextImplicitReceiverFor: (objectMemory
																fetchPointer: EnclosingObjectIndex
																ofObject: mixinApplication)
									withMixin: (objectMemory
													fetchPointer: EnclosingMixinIndex
													ofObject: theMixin).
		 implicitReceiverOrNil ~= objectMemory nilObject ifTrue:
			[^implicitReceiverOrNil]].
	^rcvr