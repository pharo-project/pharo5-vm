stack bytecodes
nextImplicitReceiverFor: anObject withMixin: mixin
	"This is used to implement the innards of the pushImplicitReceiverBytecode,
	 used for implicit receiver sends in NS2/NS3.  Find the nearest lexically-enclosing
	 implementation of selector by searching up the static chain of anObject,
	 starting at mixin's application.  This is an iterative implementation derived from

	<ContextPart> nextImplicitReceiverFor: obj <Object>
				withMixin: mixin <Mixin>
				implementing: selector <Symbol> ^<Object>"
	| implicitReceiver mixinApplication theMixin targetMixin dictionary found |
	implicitReceiver := anObject.
	targetMixin := mixin.
	[(targetMixin == nilObj "or: [implicitReceiver == nilObj]") ifTrue:
		[^nilObj].
	mixinApplication := self
							findApplicationOfTargetMixin: targetMixin
							startingAtNonMetaClass: (self fetchClassOf: implicitReceiver).
	 mixinApplication == nilObj ifTrue:
		[^nilObj].
	 dictionary := self fetchPointer: MessageDictionaryIndex ofObject: mixinApplication.
	 found := self lookupMethodInDictionary: dictionary.
	 found]
		whileFalse:
			[implicitReceiver := self fetchPointer: EnclosingObjectIndex ofObject: mixinApplication.
			 theMixin := self fetchPointer: MixinIndex ofObject: mixinApplication.
			 theMixin == nilObj ifTrue:[^nilObj].
			 targetMixin := self fetchPointer: EnclosingMixinIndex ofObject: theMixin].
	^implicitReceiver