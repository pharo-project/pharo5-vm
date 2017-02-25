initialization
cogit: aCogit
	<doNotGenerate>
	"There is no support for synthesizing 64-bit constants using inline instructions in this code generator."
	self assert: aCogit objectMemory wordSize = 4.
	super cogit: aCogit