newspeak bytecode support
enclosingObjectAt: n withObject: anObject withMixin: mixin 
	"This is used to implement the innards of the pushEnclosingObjectBytecode,
	 used for explicit outer sends in NS2/NS3.  "
	| enclosingObject mixinApplication targetMixin count |
	
	enclosingObject := anObject.
	targetMixin := mixin.
	count := 0.
	[count < n] whileTrue:
		[count := count + 1.
		(targetMixin = objectMemory nilObject or:[enclosingObject = objectMemory nilObject]) ifTrue:
			[^objectMemory nilObject].
		mixinApplication := self
								findApplicationOfTargetMixin: targetMixin
								startingAtNonMetaClass: (objectMemory fetchClassOf: enclosingObject).
		mixinApplication = objectMemory nilObject ifTrue:
			[^objectMemory nilObject]. "should never happen!"
		enclosingObject := objectMemory fetchPointer: EnclosingObjectIndex ofObject: mixinApplication.	
		targetMixin := objectMemory fetchPointer: EnclosingMixinIndex ofObject: targetMixin].
	
	^enclosingObject