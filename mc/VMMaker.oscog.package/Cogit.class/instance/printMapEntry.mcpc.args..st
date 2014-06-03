disassembly
printMapEntry: annotation mcpc: mcpc args: tupleOfStreamCodeRangesAndMethod
	"Print the Map entry's mcpc, its annotation and the corresponding bytecode pc, if any."
	<doNotGenerate>
	[:aStream :codeRanges :cogMethod| | isAltInstSet |
	isAltInstSet := coInterpreter headerIndicatesAlternateBytecodeSet: cogMethod methodHeader.
	self startMcpcAndCogMethodForMcpc: mcpc in: cogMethod do:
		[:startmcpc :subMethod| | name codeRange |
		"Find the start of the block by searching the code ranges."
		codeRange := codeRanges detect: [:range| range includes: mcpc].
		codeRange first = mcpc ifTrue:
			[aStream nextPutAll: 'startpc: '; print: codeRange startpc; cr].
		aStream
			next: 2 put: Character space;
			nextPutAll: mcpc hex;  space;
			nextPutAll: (name := self class annotationConstantNames at: annotation + 1);
			next: 20 - name size put: Character space;
			nextPut: $(;
			nextPutAll: (self findMapLocationForMcpc: mcpc inMethod: cogMethod) hex.
		(self isPCMappedAnnotation: annotation alternateInstructionSet: isAltInstSet) ifTrue:
			[aStream
				nextPutAll: ', bc: ';
				print: (self bytecodePCFor: mcpc startBcpc: codeRange startpc in: subMethod)].
		(self isSendAnnotation: annotation) ifTrue:
			[| sel |
			sel := self selectorForSendAt: mcpc annotation: annotation.
			sel isInteger ifTrue:
				[sel := self lookupAddress: sel].
			sel isString ifTrue:
				[aStream space; nextPutAll: sel]].
		aStream
			nextPut: $);
			cr; flush]]
		valueWithArguments: tupleOfStreamCodeRangesAndMethod.
	^0