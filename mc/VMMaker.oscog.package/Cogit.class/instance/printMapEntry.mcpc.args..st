disassembly
printMapEntry: annotation mcpc: mcpc args: tupleOfStreamCodeRangesAndMethod
	"Print the Map entry's mcpc, its annotation and the corresponding bytecode pc, if any."
	<doNotGenerate>
	| printHex |
	printHex := disassemblingMethod
					ifNil: [[:pc| pc hex]]
					ifNotNil: [[:pc| '.+', (pc - disassemblingMethod asInteger printStringBase: 16 length: 4 padded: true)]].
	[:aStream :codeRanges :cogMethod|
	self startMcpcAndCogMethodForMcpc: mcpc in: cogMethod do:
		[:startmcpc :subMethod| | name codeRange |
		"Find the start of the block by searching the code ranges."
		codeRange := codeRanges detect: [:range| range includes: mcpc] ifNone: [codeRanges detect: [:range| range last + 1 = mcpc]].
		codeRange first = mcpc ifTrue:
			[aStream nextPutAll: 'startpc: '; print: codeRange startpc; cr].
		aStream
			next: 2 put: Character space;
			nextPutAll: (printHex value: mcpc);  space;
			nextPutAll: (name := self class annotationConstantNames at: annotation + 1);
			next: 20 - name size put: Character space;
			nextPut: $(;
			nextPutAll: (printHex value: (self findMapLocationForMcpc: mcpc inMethod: cogMethod)).
		(self isPCMappedAnnotation: annotation) ifTrue:
			[aStream
				nextPutAll: ', bc: ';
				print: (self bytecodePCFor: mcpc startBcpc: codeRange startpc in: subMethod)].
		(self isSendAnnotation: annotation) ifTrue:
			[| sel |
			sel := self selectorForSendAt: mcpc annotation: annotation in: cogMethod methodObject.
			sel isInteger ifTrue:
				[sel := self lookupAddress: sel].
			sel isString ifTrue:
				[aStream space; nextPutAll: sel]].
		aStream
			nextPut: $);
			cr; flush]]
		valueWithArguments: tupleOfStreamCodeRangesAndMethod.
	^0