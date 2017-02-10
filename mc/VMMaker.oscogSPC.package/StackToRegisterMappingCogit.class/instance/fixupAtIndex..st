compile abstract instructions
fixupAtIndex: index
	"The fixups Array maps to bytecode pcs such that initialPC maps to index 0.
	 fixupAt: does the conversion.  Override to add breakpointing for fixups of bytecode PCs."
	<cmacro: '(index) (&fixups[index])'>
	<returnTypeC: #'BytecodeFixup *'>
	((debugFixupBreaks includes: index + initialPC)
	 and: [breakMethod isNil or: [methodObj = breakMethod]]) ifTrue:
		[self halt].
	^self addressOf: (fixups at: index)