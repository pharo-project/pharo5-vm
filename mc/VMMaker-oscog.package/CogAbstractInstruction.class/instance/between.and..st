comparing
between: min and: max
	"Support for CogBytecodeFixup>targetInstruction testing:"
	<doNotGenerate>
	| opcodesArray |
	(min isInteger and: [max isInteger]) ifTrue:
		[^false].
	opcodesArray := cogit abstractOpcodes object.
	^(opcodesArray identityIndexOf: self)
		between: (opcodesArray identityIndexOf: min)
		and: (opcodesArray identityIndexOf: max)