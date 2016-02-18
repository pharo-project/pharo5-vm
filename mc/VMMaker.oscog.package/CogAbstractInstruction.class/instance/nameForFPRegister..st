printing
nameForFPRegister: reg "<Integer>"
	"subclasses with special purpose registers may need to override."
	<doNotGenerate>
	^CogAbstractRegisters nameForFPRegister: reg