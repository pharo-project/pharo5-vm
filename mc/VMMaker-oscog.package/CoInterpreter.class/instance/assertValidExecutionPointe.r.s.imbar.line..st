debug support
assertValidExecutionPointe: lip r: lifp s: lisp imbar: inInterpreter line: ln
	<var: #lip type: #usqInt>
	<var: #lifp type: #'char *'>
	<var: #lisp type: #'char *'>
	| methodField cogMethod savedIP  |
	<var: #cogMethod type: #'CogMethod *'>
	self assert: stackPage = (stackPages stackPageFor: lifp) l: ln.
	self assert: stackPage = stackPages mostRecentlyUsedPage l: ln.
	self assert: (self deferStackLimitSmashAround: #assertValidStackLimits: asSymbol with: ln).
	self assert: lifp < stackPage baseAddress l: ln.
	self assert: lisp < lifp l: ln.
	self assert: lifp > lisp l: ln.
	self assert: lisp >= (stackPage realStackLimit - self stackLimitOffset) l: ln.
	self assert:  (lifp - lisp) < LargeContextSize l: ln.
	methodField := self frameMethodField: lifp.
	inInterpreter
		ifTrue:
			[self assert: (self isMachineCodeFrame: lifp) not l: ln.
			 self assert: method = methodField l: ln.
			 self cppIf: MULTIPLEBYTECODESETS
				ifTrue: [self assert: (self methodUsesAlternateBytecodeSet: method) = (bytecodeSetSelector = 256) l: ln].
			 ((self asserta: methodField asUnsignedInteger > objectMemory startOfMemory l: ln)
			   and: [self asserta: methodField asUnsignedInteger < objectMemory freeStart l: ln]) ifTrue:
				[lip = cogit ceReturnToInterpreterPC
					ifTrue:
						[savedIP := self iframeSavedIP: lifp.
						 self assert: (savedIP >= (methodField + (objectMemory lastPointerOf: methodField) + BaseHeaderSize - 1)
								  and: [savedIP < (methodField + (objectMemory byteLengthOf: methodField) + BaseHeaderSize)])
							l: ln]
					ifFalse:
						[self assert: (lip >= (methodField + (objectMemory lastPointerOf: methodField) + BaseHeaderSize - 1)
								  and: [lip < (methodField + (objectMemory byteLengthOf: methodField) + BaseHeaderSize)])
							l: ln]].
			 self assert: ((self iframeIsBlockActivation: lifp)
					or: [(self pushedReceiverOrClosureOfFrame: lifp) = (self iframeReceiver: lifp)])
				l: ln]
		ifFalse:
			[self assert: (self isMachineCodeFrame: lifp) l: ln.
			 ((self asserta: methodField asUnsignedInteger >= cogit minCogMethodAddress l: ln)
			  and: [self asserta: methodField asUnsignedInteger < cogit maxCogMethodAddress l: ln]) ifTrue:
				[cogMethod := self mframeHomeMethod: lifp.
				 self assert: (lip > (methodField + ((self mframeIsBlockActivation: lifp)
													ifTrue: [self sizeof: CogBlockMethod]
													ifFalse: [self sizeof: CogMethod]))
						and: [lip < (methodField + cogMethod blockSize)])
					l: ln].
			 self assert: ((self mframeIsBlockActivation: lifp)
					or: [(self pushedReceiverOrClosureOfFrame: lifp) = (self mframeReceiver: lifp)])
				l: ln].
	(self isBaseFrame: lifp) ifTrue:
		[self assert: (self frameHasContext: lifp) l: ln.
		 self assert: (self frameContext: lifp) = (stackPages longAt: stackPage baseAddress - BytesPerWord) l: ln]