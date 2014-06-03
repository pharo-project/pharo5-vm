utilities
with: aNode ifAppropriateSetTo: aBoolean do: aBlock
	"If aNode is a TDefineNode for a variable, set it to the supplied boolean for the duration
	 of aBlock.  This avoids duplicating both arms of nested cppIf:ifTrue:[ifFalse:]'s."
	| savedOptions |
	(aNode isConstant and: [aNode name notEmpty and: [aNode name first isLetter]]) ifFalse:
		[^aBlock value].
	savedOptions := optionsDictionary.
	optionsDictionary := savedOptions
							ifNil: [Dictionary new]
							ifNotNil: [savedOptions copy].
	optionsDictionary at: aNode name put: aBoolean.
	^aBlock ensure: [optionsDictionary := savedOptions]