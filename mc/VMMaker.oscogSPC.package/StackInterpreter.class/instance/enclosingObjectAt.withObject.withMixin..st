newspeak bytecode support
enclosingObjectAt: depth withObject: methodReceiver withMixin: methodMixin 
	"This is used to implement outer sends and outer expressions in Newspeak."
	| enclosingObject mixinApplication targetMixin count |
	
	enclosingObject := methodReceiver.
	targetMixin := methodMixin.
	count := 0.
	[count < depth] whileTrue:
		[count := count + 1.
		self deny: (targetMixin = objectMemory nilObject).
		mixinApplication := self
							findApplicationOfTargetMixin: targetMixin
							startingAtBehavior: (objectMemory fetchClassOf: enclosingObject).
		self deny: (mixinApplication = objectMemory nilObject).
		enclosingObject := objectMemory followObjField: EnclosingObjectIndex ofObject: mixinApplication.	
		targetMixin := objectMemory followObjField: EnclosingMixinIndex ofObject: targetMixin].
	
	^enclosingObject