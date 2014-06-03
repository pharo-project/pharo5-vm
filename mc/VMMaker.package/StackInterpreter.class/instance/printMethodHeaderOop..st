debug printing
printMethodHeaderOop: anOop
	"Override hook for CoInterpreter"
	<inline: true>
	^self printOopShort: anOop