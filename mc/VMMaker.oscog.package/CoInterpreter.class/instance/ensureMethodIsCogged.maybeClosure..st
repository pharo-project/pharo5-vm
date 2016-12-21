frame access
ensureMethodIsCogged: methodObj maybeClosure: maybeClosure
	"Ensure that methodObj has been cogged.  It may be a FullBlockMethod if maybeClosure is a FullBlockClosure."
	<returnTypeC: #'CogMethod *'>
	| rawHeader cogMethod yetToCompact |
	<inline: true>
	<var: #cogMethod type: #'CogMethod *'>
	rawHeader := self rawHeaderOf: methodObj.
	(self isCogMethodReference: rawHeader) ifTrue:
		[^self cCoerceSimple: rawHeader to: #'CogMethod *'].
	yetToCompact := true.
	[(maybeClosure ~= objectMemory nilObject and: [(self isVanillaBlockClosure: maybeClosure) not])
		ifTrue: [cogMethod := cogit cogFullBlockMethod: methodObj numCopied: (self copiedValueCountOfFullClosure: maybeClosure)]
		ifFalse: [cogMethod := cogit cog: methodObj selector: objectMemory nilObject].
	 cogMethod == nil
	 and: [cogCompiledCodeCompactionCalledFor
	 and: [yetToCompact]]] whileTrue:
		[yetToCompact := false.
		 self commenceCogCompiledCodeCompaction].
	(self asserta: cogMethod ~~ nil) ifFalse:
		[self error: 'could not compile method that should have been compiled'].
	^cogMethod