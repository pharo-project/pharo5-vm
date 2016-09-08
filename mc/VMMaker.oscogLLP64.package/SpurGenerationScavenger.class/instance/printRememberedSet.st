debug support
printRememberedSet
	"Print the objects in the remembered set."
	<api>
	0 to: rememberedSetSize - 1 do:
		[:i|
		coInterpreter printNum: i; space; shortPrintOop: (rememberedSet at: i)]