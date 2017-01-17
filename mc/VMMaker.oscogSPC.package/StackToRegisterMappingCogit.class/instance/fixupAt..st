compile abstract instructions
fixupAt: index
	<cmacro: '(index) (&fixups[index])'>
	<returnTypeC: #'BytecodeFixup *'>
	(debugFixupBreaks includes: index) ifTrue:
		[self halt].
	^self addressOf: (fixups at: index)