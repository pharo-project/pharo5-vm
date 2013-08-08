compile abstract instructions
compileMethodBody
	"Compile the top-level method body."
	<inline: true>
	endPC < initialPC ifTrue: [^0]. "quick primitives"
	^self compileAbstractInstructionsFrom: initialPC through: endPC