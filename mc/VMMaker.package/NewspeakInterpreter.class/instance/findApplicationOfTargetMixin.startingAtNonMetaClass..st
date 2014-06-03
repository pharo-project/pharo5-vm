stack bytecodes
findApplicationOfTargetMixin: targetMixin startingAtNonMetaClass: aClass
	"This is used to implement the innards of the pushImplicitReceiverBytecode,
	 used for outer sends in NS2/NS3.  Find the MixinApplcation of which aClass
	is a subclass that is an application of targetMixin.  This is an implementation derived from

	<ContextPart> findApplicationOfTargetMixin: targetMixin startingAtNonMetaClass: aClass
	"
	| mixinOrMixinApplication |
	mixinOrMixinApplication := aClass.
	[mixinOrMixinApplication == nilObj
	 or: [mixinOrMixinApplication == targetMixin
	 or: [(self fetchPointer: MixinIndex ofObject: mixinOrMixinApplication) == targetMixin]]] whileFalse:
		[mixinOrMixinApplication := self fetchPointer: SuperclassIndex ofObject: mixinOrMixinApplication].
	^mixinOrMixinApplication