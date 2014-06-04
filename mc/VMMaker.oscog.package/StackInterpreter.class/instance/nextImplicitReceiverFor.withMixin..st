newspeak bytecode support
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
	[(targetMixin = objectMemory nilObject "or: [implicitReceiver = objectMemory nilObject]") ifTrue:
		[^objectMemory nilObject].
	mixinApplication := self findApplicationOfTargetMixin: targetMixin
							startingAtNonMetaClass: (objectMemory fetchClassOf: implicitReceiver).
	 mixinApplication = objectMemory nilObject ifTrue:
		[^objectMemory nilObject].
	 dictionary := objectMemory followObjField: MethodDictionaryIndex ofObject: mixinApplication.
	 found := self lookupMethodInDictionary: dictionary.
	 found]
		whileFalse:
			[implicitReceiver := objectMemory fetchPointer: EnclosingObjectIndex ofObject: mixinApplication.
			 theMixin := objectMemory fetchPointer: MixinIndex ofObject: mixinApplication.
			 theMixin = objectMemory nilObject ifTrue:
				[^objectMemory nilObject].
			 targetMixin := objectMemory fetchPointer: EnclosingMixinIndex ofObject: theMixin].
	^implicitReceiver