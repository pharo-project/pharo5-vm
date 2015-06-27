compiled methods
accessModifierOfMethodHeader: header
	<option: #NewspeakVM>
	<inline: true>
	"accessModifier bits:
		 00 public
		 01 private
		 10 protected
		 11 undefined"
	^EnforceAccessControl
		ifTrue: [header >> MethodHeaderFlagBitPosition bitAnd: 3]
		ifFalse: [AccessModifierPublic]