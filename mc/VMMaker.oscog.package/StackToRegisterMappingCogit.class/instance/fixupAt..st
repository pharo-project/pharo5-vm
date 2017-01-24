compile abstract instructions
fixupAt: index
	<cmacro: '(index) (&fixups[index])'>
	<returnTypeC: #'BytecodeFixup *'>
	((debugFixupBreaks includes: index)
	 and: [breakMethod isNil or: [methodObj = breakMethod]]) ifTrue:
		[self halt].
	^self addressOf: (fixups at: index)