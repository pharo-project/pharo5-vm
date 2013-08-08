accessing
findPreviouslyCompiledVersionOf: aMethodObj with: aSelectorOop
	<returnTypeC: #'CogMethod *'>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	((coInterpreter methodHasCogMethod: aMethodObj)
	and: [(coInterpreter methodClassAssociationOf: aMethodObj) = objectMemory nilObject]) ifTrue:
		[cogMethod := cogit cCoerceSimple: baseAddress to: #'CogMethod *'.
		[cogMethod < self limitZony] whileTrue:
			[(cogMethod cmType = CMMethod
			  and: [cogMethod selector = aSelectorOop
			  and: [cogMethod methodObject = aMethodObj]]) ifTrue:
				[^cogMethod].
			 cogMethod := self methodAfter: cogMethod]].
	^nil