message sending
ifAppropriateCompileToNativeCode: aMethodObj selector: selector
	| methodHeader cogMethod |
	<inline: true>
	<var: #cogMethod type: #'CogMethod *'>
	methodHeader := self rawHeaderOf: aMethodObj.
	(self isCogMethodReference: methodHeader)
		ifTrue: "makeBaseFrame: can create cog methods with nil selectors."
			[cogMethod := self cCoerceSimple: methodHeader to: #'CogMethod *'.
			 cogMethod selector = objectMemory nilObject ifTrue:
				[cogit setSelectorOf: cogMethod to: selector]]
		ifFalse:
			[(self methodWithHeaderShouldBeCogged: methodHeader)
				ifTrue: [cogit cog: aMethodObj selector: selector]
				ifFalse: [self maybeFlagMethodAsInterpreted: aMethodObj]]