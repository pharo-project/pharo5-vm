stack bytecodes
explicitOuterReceiver: n withObject: anObject withMixin: mixin 
	"This is used to implement the innards of the pushExplicitOuterReceiverBytecode,
	 used for explicit outer sends in NS2/NS3.  "
	| explicitReceiver mixinApplication  targetMixin  count |
	
	explicitReceiver := anObject.
	targetMixin := mixin.
	count := 0.
	[count < n] whileTrue:[
		count := count + 1.
		(targetMixin == nilObj or:[explicitReceiver == nilObj]) ifTrue:
		[^nilObj].
		mixinApplication := self
							findApplicationOfTargetMixin: targetMixin
							startingAtNonMetaClass: (self fetchClassOf: explicitReceiver).
		mixinApplication == nilObj ifTrue:[^nilObj]. "should never happen!"
		explicitReceiver := self fetchPointer: EnclosingObjectIndex 
								ofObject: mixinApplication.	
		targetMixin := self fetchPointer: EnclosingMixinIndex ofObject: targetMixin.	
	].
	
	^explicitReceiver