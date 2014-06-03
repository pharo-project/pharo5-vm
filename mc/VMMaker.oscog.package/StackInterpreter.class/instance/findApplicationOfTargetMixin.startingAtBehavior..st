newspeak bytecode support
findApplicationOfTargetMixin: targetMixin startingAtBehavior: aBehavior
	"This is used to implement the innards of the pushImplicitReceiverBytecode,
	 used for outer sends in NS2/NS3.  Find the MixinApplcation of which aBehavior
	 is a subclass that is an application of targetMixin.  This is an implementation derived from

	<ContextPart> findApplicationOfTargetMixin: targetMixin startingAtBehavior: aBehavior
	"
	| mixinOrMixinApplication mixin |
	mixinOrMixinApplication := aBehavior.
	[mixinOrMixinApplication = objectMemory nilObject
	 or: [mixinOrMixinApplication = targetMixin
	 or: [(mixin := objectMemory fetchPointer: MixinIndex ofObject: mixinOrMixinApplication) = targetMixin
	 or: [(objectMemory fetchClassOfNonImm: mixin) = targetMixin]]]] whileFalse:
		[mixinOrMixinApplication := objectMemory fetchPointer: SuperclassIndex ofObject: mixinOrMixinApplication].
	^mixinOrMixinApplication