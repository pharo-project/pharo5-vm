frame access
ensureMethodIsCogged: methodObj
	<returnTypeC: #'CogMethod *'>
	| rawHeader cogMethod |
	<inline: true>
	<var: #cogMethod type: #'CogMethod *'>
	rawHeader := self rawHeaderOf: methodObj.
	(self isCogMethodReference: rawHeader) ifTrue:
		[^self cCoerceSimple: rawHeader to: #'CogMethod *'].
	cogMethod := cogit cog: methodObj selector: objectMemory nilObject.
	(cogMethod = nil
	 and: [cogCompiledCodeCompactionCalledFor]) ifTrue:
		[self commenceCogCompiledCodeCompaction.
		 cogMethod := cogit cog: methodObj selector: objectMemory nilObject].
	(self asserta: cogMethod ~= nil) ifFalse:
		[self error: 'could not compile method that should have been compiled'].
	^cogMethod