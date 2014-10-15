newspeak bytecode support
findApplicationOfTargetMixin: targetMixin startingAtNonMetaClass: aClass
	"This is used to implement the innards of the pushImplicitReceiverBytecode,
	 used for outer sends in NS2/NS3.  Find the MixinApplcation of which aClass
	 is a subclass that is an application of targetMixin.  This is an implementation derived from

	<ContextPart> findApplicationOfTargetMixin: targetMixin startingAtNonMetaClass: aClass
	"
	| mixinOrMixinApplication |
	self deny: (objectMemory isForwarded: targetMixin).
	self deny: (objectMemory isForwarded: aClass).
	mixinOrMixinApplication := aClass.
	[mixinOrMixinApplication = objectMemory nilObject
	 or: [mixinOrMixinApplication = targetMixin
	 or: [(objectMemory followObjField: MixinIndex ofObject: mixinOrMixinApplication) = targetMixin]]] whileFalse:
		[mixinOrMixinApplication := objectMemory followObjField: SuperclassIndex ofObject: mixinOrMixinApplication].
	^mixinOrMixinApplication