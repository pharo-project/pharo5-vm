newspeak bytecode support
explicitOuterReceiver: n withObject: anObject withMixin: mixin 
	"This is used to implement the innards of the pushExplicitOuterReceiverBytecode,
	 used for explicit outer sends in NS2/NS3.  "
	| explicitReceiver mixinApplication  targetMixin  count |
	
	explicitReceiver := anObject.
	targetMixin := mixin.
	count := 0.
	[count < n] whileTrue:
		[count := count + 1.
		(targetMixin = objectMemory nilObject or:[explicitReceiver = objectMemory nilObject]) ifTrue:
			[^objectMemory nilObject].
		mixinApplication := self
								findApplicationOfTargetMixin: targetMixin
								startingAtNonMetaClass: (objectMemory fetchClassOf: explicitReceiver).
		mixinApplication = objectMemory nilObject ifTrue:
			[^objectMemory nilObject]. "should never happen!"
		explicitReceiver := objectMemory fetchPointer: EnclosingObjectIndex ofObject: mixinApplication.	
		targetMixin := objectMemory fetchPointer: EnclosingMixinIndex ofObject: targetMixin].
	
	^explicitReceiver