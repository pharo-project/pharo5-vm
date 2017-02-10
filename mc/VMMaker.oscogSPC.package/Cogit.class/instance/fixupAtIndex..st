compile abstract instructions
fixupAtIndex: index
	"The fixups Array maps to bytecode pcs such that initialPC maps to index 0.
	 fixupAt: does the conversion."
	<cmacro: '(index) (&fixups[index])'>
	<returnTypeC: #'BytecodeFixup *'>
	^self addressOf: (fixups at: index)