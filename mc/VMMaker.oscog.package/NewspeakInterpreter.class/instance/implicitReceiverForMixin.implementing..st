stack bytecodes
implicitReceiverForMixin: mixin implementing: selector
	"This is used to implement the innards of the pushImplicitReceiverBytecode,
	 used for implicit receiver sends in NS2/NS3.  Find the nearest lexically-enclosing
	 implementation of selector by searching up the static chain of anObject,
	 starting at mixin's application.  This is an iterative implementation derived from

	<ContextPart> implicitReceiverFor: obj <Object>
					withMixin: mixin <Mixin>
					implementing: selector <Symbol> ^<Object
	 "
	| mixinApplication dictionary found |
	messageSelector := selector. "messageSelector is an implicit parameter of lookupMethodInDictionary:"
	mixinApplication := self
							findApplicationOfTargetMixin: mixin
							startingAtBehavior: (self fetchClassOf: receiver).
	 mixinApplication == nilObj ifTrue:
		[^receiver].
	 dictionary := self fetchPointer: MessageDictionaryIndex ofObject: mixinApplication.
	 found := self lookupMethodInDictionary: dictionary.
	 found ifFalse:
		[| implicitReceiverOrNil theMixin |
		 theMixin := self fetchPointer: MixinIndex ofObject: mixinApplication.
		 implicitReceiverOrNil := self nextImplicitReceiverFor: (self fetchPointer: EnclosingObjectIndex
																ofObject: mixinApplication)
									withMixin: (self fetchPointer: EnclosingMixinIndex ofObject: theMixin).
		 implicitReceiverOrNil ~= nilObj ifTrue:
			[^implicitReceiverOrNil]].
	^receiver