newspeak bytecode support
findApplicationOfTargetMixin: targetMixin startingAtBehavior: aBehavior
	"This is used to implement implicit receiver and enclosing object lookup
	 for Newspeak. Find the mixin applcation of which aClass is a subclass that
	 is an application of targetMixin. This is an implementation derived from

	<ContextPart> findApplicationOf: targetMixin startingAt: aBehavior
	"
	| mixinApplication mixin |
	mixinApplication := aBehavior.
	[mixinApplication = objectMemory nilObject
	 or: [mixinApplication = targetMixin
	 or: [(mixin := objectMemory fetchPointer: MixinIndex ofObject: mixinApplication) = targetMixin]]] whileFalse:
		[mixinApplication := objectMemory fetchPointer: SuperclassIndex ofObject: mixinApplication].
	^mixinApplication