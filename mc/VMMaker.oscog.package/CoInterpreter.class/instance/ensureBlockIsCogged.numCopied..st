frame access
ensureBlockIsCogged: methodObj numCopied: numCopied
	<returnTypeC: #'CogMethod *'>
	| rawHeader cogMethod |
	<inline: true>
	<var: #cogMethod type: #'CogMethod *'>
	rawHeader := self rawHeaderOf: methodObj.
	(self isCogMethodReference: rawHeader) ifTrue:
		[^self cCoerceSimple: rawHeader to: #'CogMethod *'].
	cogMethod := cogit cogFullBlockMethod: methodObj numCopied: numCopied.
	(cogMethod = nil
	 and: [cogCompiledCodeCompactionCalledFor]) ifTrue:
		[self commenceCogCompiledCodeCompaction.
		 cogMethod := cogMethod := cogit cogFullBlockMethod: methodObj numCopied: numCopied].
	(self asserta: cogMethod ~= nil) ifFalse:
		[self error: 'could not compile method that should have been compiled'].
	^cogMethod