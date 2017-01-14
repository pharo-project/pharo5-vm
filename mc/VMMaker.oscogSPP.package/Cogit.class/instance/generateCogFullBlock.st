compile abstract instructions
generateCogFullBlock
	"We handle jump sizing simply.  First we make a pass that asks each
	 instruction to compute its maximum size.  Then we make a pass that
	 sizes jumps based on the maxmimum sizes.  Then we make a pass
	 that fixes up jumps.  When fixing up a jump the jump is not allowed to
	 choose a smaller offset but must stick to the size set in the second pass."
	<returnTypeC: #'CogMethod *'>
	<option: #SistaV1BytecodeSet>
	| codeSize headerSize mapSize totalSize startAddress result method |
	<var: #method type: #'CogMethod *'>
	headerSize := self sizeof: CogMethod.
	methodLabel address: methodZone freeStart.
	self computeMaximumSizes.
	methodLabel concretizeAt: methodZone freeStart.
	codeSize := self generateInstructionsAt: methodLabel address + headerSize.
	mapSize := self generateMapAt: nil start: methodLabel address + cbNoSwitchEntryOffset.
.
	totalSize := methodZone roundUpLength: headerSize + codeSize + mapSize.
	totalSize > MaxMethodSize ifTrue:
		[^self cCoerceSimple: MethodTooBig to: #'CogMethod *'].
	startAddress := methodZone allocate: totalSize.
	startAddress = 0 ifTrue:
		[^self cCoerceSimple: InsufficientCodeSpace to: #'CogMethod *'].
	self assert: startAddress + cbEntryOffset = fullBlockEntry address.
	self assert: startAddress + cbNoSwitchEntryOffset = fullBlockNoContextSwitchEntry address.
	result := self outputInstructionsAt: startAddress + headerSize.
	self assert: startAddress + headerSize + codeSize = result.
	backEnd padIfPossibleWithStopsFrom: result to: startAddress + totalSize - mapSize - 1.
	self generateMapAt: startAddress + totalSize - 1 start: startAddress + cbNoSwitchEntryOffset.
	self flag: #TOCHECK. "It's not clear we want the same header than regular methods. 
	It could be of the same size, but maybe the cmType could be different and the selector could be ignored." 
	method := self fillInMethodHeader: (self cCoerceSimple: startAddress to: #'CogMethod *')
					size: totalSize
					selector: objectMemory nilObject.
	method cpicHasMNUCaseOrCMIsFullBlock: true.
	postCompileHook ifNotNil:
		[self perform: postCompileHook with: method.
		 postCompileHook := nil].
	^method