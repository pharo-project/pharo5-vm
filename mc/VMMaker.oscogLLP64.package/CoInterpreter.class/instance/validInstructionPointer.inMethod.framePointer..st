debug support
validInstructionPointer: instrPointer inMethod: aMethod framePointer: fp
	<var: #instrPointer type: #usqInt>
	<var: #aMethod type: #usqInt>
	<var: #fp type: #'char *'>
	| theInstrPointer cogMethod |
	<var: #theInstrPointer type: #usqInt>
	<var: #cogMethod type: #'CogMethod *'>
	instrPointer = cogit ceCannotResumePC ifTrue:
		[^self isMachineCodeFrame: fp].
	instrPointer = cogit ceReturnToInterpreterPC
		ifTrue:
			[(self isMachineCodeFrame: fp) ifTrue:
				[^false].
			 theInstrPointer := self iframeSavedIP: fp]
		ifFalse:
			[theInstrPointer := instrPointer.
			 NewspeakVM
				ifTrue:
					[(self isMachineCodeFrame: fp) ifTrue:
						[cogMethod := self mframeHomeMethod: fp.
						 ^theInstrPointer >= (cogMethod asUnsignedInteger + (cogit sizeof: CogMethod))
						   and: [theInstrPointer < (cogMethod asUnsignedInteger + cogMethod blockSize)]]]
				ifFalse:
					[| header |
					 header := self rawHeaderOf: aMethod.
					 ((self isCogMethodReference: header)
					   and: [theInstrPointer < objectMemory startOfMemory]) ifTrue:
					 	[cogMethod := self cCoerceSimple: header to: #'CogMethod *'.
					 	 ^theInstrPointer >= (header + (cogit sizeof: CogMethod))
					 	 and: [theInstrPointer < (header + cogMethod blockSize)]]]].
	^super validInstructionPointer: theInstrPointer inMethod: aMethod framePointer: fp