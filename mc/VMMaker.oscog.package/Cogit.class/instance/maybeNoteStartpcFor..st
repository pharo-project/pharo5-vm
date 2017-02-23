disassembly
maybeNoteStartpcFor: thing "<CogBlockStart|CogCodeRange>"
	<doNotGenerate>
	(self class initializationOptions at: #tempNames ifAbsent: nil) ifNotNil:
		[self class initializationOptions
			at: #startpc put: thing startpc;
			at: #numArgs put: ([thing cogMethod ifNil: [-1] ifNotNil: [:cm| cm cmNumArgs]] "CogCodeRange"
									on: MessageNotUnderstood
									do: [:ex| thing numArgs])] "CogBlockStart"