comparing
<= anAbstractInstruction
	"Support for Cogit>>abstractInstruction:follows: and CogBytecodeFixup>targetInstruction testing:"
	<doNotGenerate>
	| opcodesArray |
	anAbstractInstruction isInteger ifTrue:
		[self assert: anAbstractInstruction < 16.
		 ^false]. 
	opcodesArray := cogit abstractOpcodes object.
	^(opcodesArray identityIndexOf: self) <= (opcodesArray identityIndexOf: anAbstractInstruction)