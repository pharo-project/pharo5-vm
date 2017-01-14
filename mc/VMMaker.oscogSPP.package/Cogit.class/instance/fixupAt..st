compile abstract instructions
fixupAt: index
	<cmacro: '(index) (&fixups[index])'>
	<returnTypeC: #'BytecodeFixup *'>
	^self addressOf: (fixups at: index)