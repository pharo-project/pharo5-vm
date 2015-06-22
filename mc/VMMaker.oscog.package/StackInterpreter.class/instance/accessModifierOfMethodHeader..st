compiled methods
accessModifierOfMethodHeader: header
	<option: #NewspeakVM>
	"accessModifier bits:
		 00 public
		 01 private
		 10 protected
		 11 undefined"
	^self cppIf: EnforceAccessControl
		ifTrue: [header >> MethodHeaderFlagBitPosition bitAnd: 3]
		ifFalse: [AccessModifierPublic]