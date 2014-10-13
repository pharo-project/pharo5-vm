stack bytecodes
enclosingObjectAt: n withObject: anObject withMixin: mixin 
	"This is used to implement the innards of the pushEnclosingObjectBytecode,
	 used for explicit outer sends in NS2/NS3.  "
	| enclosingObject mixinApplication targetMixin count |
	
	enclosingObject := anObject.
	targetMixin := mixin.
	count := 0.
	[count < n] whileTrue:
		[count := count + 1.
		(targetMixin = nilObj or:[enclosingObject = nilObj]) ifTrue:
			[^nilObj].
		mixinApplication := self
							findApplicationOfTargetMixin: targetMixin
							startingAtNonMetaClass: (self fetchClassOf: enclosingObject).
		mixinApplication == nilObj ifTrue:[^nilObj]. "should never happen!"
		enclosingObject := self fetchPointer: EnclosingObjectIndex 
								ofObject: mixinApplication.	
		targetMixin := self fetchPointer: EnclosingMixinIndex ofObject: targetMixin].
	
	^enclosingObject