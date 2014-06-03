generate machine code
generateCogMethod: selector
	"We handle jump sizing simply.  First we make a pass that asks each
	 instruction to compute its maximum size.  Then we make a pass that
	 sizes jumps based on the maxmimum sizes.  Then we make a pass
	 that fixes up jumps.  When fixing up a jump the jump is not allowed to
	 choose a smaller offset but must stick to the size set in the second pass.

	 Override to add counters"
	<returnTypeC: #'CogMethod *'>
	| codeSize headerSize mapSize countersSize totalSize startAddress result method |
	<var: #method type: #'CogMethod *'>
	headerSize := self sizeof: CogMethod.
	methodLabel address: headerSize negated.
	self computeMaximumSizes.
	methodLabel concretizeAt: (methodZone allocate: 0).
	codeSize := self generateInstructionsAt: methodLabel address + headerSize.
	mapSize := self generateMapAt: 0 start: methodLabel address + cmNoCheckEntryOffset.
	countersSize := counterIndex * CounterBytes.
	totalSize := methodZone roundUpLength: headerSize + codeSize + mapSize + countersSize.
	totalSize > MaxMethodSize ifTrue:
		[^self cCoerceSimple: MethodTooBig to: #'CogMethod *'].
	startAddress := methodZone allocate: totalSize.
	startAddress = 0 ifTrue:
		[^self cCoerceSimple: InsufficientCodeSpace to: #'CogMethod *'].
	self assert: startAddress + cmEntryOffset = entry address.
	self assert: startAddress + cmNoCheckEntryOffset = noCheckEntry address.
	self regenerateCounterReferences: startAddress + totalSize.
	result := self outputInstructionsAt: startAddress + headerSize.
	self assert: startAddress + headerSize + codeSize = result.
	backEnd nopsFrom: result to: startAddress + totalSize - mapSize.
	self generateMapAt: startAddress + totalSize - countersSize - 1 start: startAddress + cmNoCheckEntryOffset.
	self fillInBlockHeadersAt: startAddress.
	self fillInCounters: counterIndex atEndAddress: startAddress + totalSize.
	method := self fillInMethodHeader: (self cCoerceSimple: startAddress to: #'CogMethod *')
					size: totalSize
					selector: selector.
	postCompileHook notNil ifTrue:
		[self perform: postCompileHook with: method with: primInvokeLabel.
		 postCompileHook := nil].
	processor flushICacheFrom: startAddress to: startAddress + headerSize + codeSize.
	^method