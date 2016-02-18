printing
nameForRegister: reg "<Integer>"
	<doNotGenerate>
	reg < 0 ifTrue: [^super nameForRegister: reg].
	^MIPSConstants nameForRegister: reg