compaction
compactCompiledCode
	| objectHeaderValue source dest bytes |
	<var: #source type: #'CogMethod *'>
	<var: #dest type: #'CogMethod *'>
	compactionInProgress := true.
	objectHeaderValue := objectMemory nullHeaderForMachineCodeMethod.
	source := coInterpreter cCoerceSimple: baseAddress to: #'CogMethod *'.
	openPICList := nil.
	methodCount := 0.
	NewspeakVM ifTrue: [unpairedMethodList := nil].
	[source < self limitZony
	 and: [source cmType ~= CMFree]] whileTrue:
		[self assert: (cogit cogMethodDoesntLookKosher: source) = 0.
		 source objectHeader: objectHeaderValue.
		 source cmUsageCount > 0 ifTrue:
			[source cmUsageCount: source cmUsageCount // 2].
		 NewspeakVM ifTrue:
				[(source cmType = CMMethod
				  and: [(coInterpreter rawHeaderOf: source methodObject) asInteger ~= source asInteger]) ifTrue:
					[source nextMethodOrIRCs: unpairedMethodList.
					 unpairedMethodList := source asUnsignedInteger]].
		 SistaVM ifTrue:
			[self clearSavedPICUsageCount: source].
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
			 objectMemory mem: dest mo: source ve: bytes.
			 dest objectHeader: objectHeaderValue.
			 dest cmType = CMMethod
				ifTrue:
					["For non-Newspeak there should be a one-to-one mapping between bytecoded and
					  cog methods.  For Newspeak not necessarily, but only for anonymous accessors."
					"Only update the original method's header if it is referring to this CogMethod."
					 (coInterpreter rawHeaderOf: dest methodObject) asInteger = source asInteger
						ifTrue:
							[coInterpreter rawHeaderOf: dest methodObject put: dest asInteger]
						ifFalse:
							[self assert: (cogit noAssertMethodClassAssociationOf: dest methodObject) = objectMemory nilObject.
							 NewspeakVM ifTrue:
								[dest nextMethodOrIRCs: unpairedMethodList.
								 unpairedMethodList := dest asUnsignedInteger]]]
				ifFalse:
					[SistaVM ifTrue:
						[self clearSavedPICUsageCount: dest].
					dest cmType = CMOpenPIC ifTrue:
						[dest nextOpenPIC: openPICList asUnsignedInteger.
						 openPICList := dest]].
			 dest cmUsageCount > 0 ifTrue:
				[dest cmUsageCount: dest cmUsageCount // 2].
			 dest := coInterpreter
								cCoerceSimple: dest asUnsignedInteger + bytes
								to: #'CogMethod *'].
		 source := coInterpreter
							cCoerceSimple: source asUnsignedInteger + bytes
							to: #'CogMethod *'].
	mzFreeStart := dest asUnsignedInteger.
	methodBytesFreedSinceLastCompaction := 0.
	compactionInProgress := false