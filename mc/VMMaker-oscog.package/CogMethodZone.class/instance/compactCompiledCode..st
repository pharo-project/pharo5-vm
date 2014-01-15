compaction
compactCompiledCode: objectHeaderValue
	| source dest bytes |
	<var: #source type: #'CogMethod *'>
	<var: #dest type: #'CogMethod *'>
	source := coInterpreter cCoerceSimple: baseAddress to: #'CogMethod *'.
	openPICList := nil.
	methodCount := 0.
	[source < self limitZony
	 and: [source cmType ~= CMFree]] whileTrue:
		[self assert: (cogit cogMethodDoesntLookKosher: source) = 0.
		 source objectHeader: objectHeaderValue.
		 source cmUsageCount > 0 ifTrue:
			[source cmUsageCount: source cmUsageCount // 2].
		 source cmType = CMOpenPIC ifTrue:
			[source nextOpenPIC: openPICList asUnsignedInteger.
			 openPICList := source].
		 methodCount := methodCount + 1.
		 source := self methodAfter: source].
	source >= self limitZony ifTrue:
		[^self halt: 'no free methods; cannot compact.'].
	dest := source.
	[source < self limitZony] whileTrue:
		[self assert: (cogit maybeFreeCogMethodDoesntLookKosher: source) = 0.
		 bytes := source blockSize.
		 source cmType ~= CMFree ifTrue:
			[methodCount := methodCount + 1.
			 self mem: dest mo: source ve: bytes.
			 dest objectHeader: objectHeaderValue.
			 dest cmType = CMMethod
				ifTrue:
					["For non-Newspeak there should ne a one-to-one mapping metween bytecoded and
					  cog methods. For Newspeak not necessarily, but only for anonymous accessors."
					 self assert: ((coInterpreter rawHeaderOf: dest methodObject) asInteger = source asInteger
								or: [(cogit noAssertMethodClassAssociationOf: dest methodObject) = objectMemory nilObject]).
					"Only update the original method's header if it is referring to this CogMethod."
					 (coInterpreter rawHeaderOf: dest methodObject) asInteger = source asInteger ifTrue:
						[coInterpreter rawHeaderOf: dest methodObject put: dest asInteger]]
				ifFalse:
					[dest cmType = CMOpenPIC ifTrue:
						[dest nextOpenPIC: openPICList asUnsignedInteger.
						 openPICList := dest]].
			 dest cmUsageCount > 0 ifTrue:
				[dest cmUsageCount: dest cmUsageCount // 2].
			 dest := coInterpreter
								cCoerceSimple: dest asInteger + bytes
								to: #'CogMethod *'].
		 source := coInterpreter
							cCoerceSimple: source asInteger + bytes
							to: #'CogMethod *'].
	mzFreeStart := dest asInteger.
	methodBytesFreedSinceLastCompaction := 0