method map
addToMap: annotation instruction: instruction byte: byte at: address for: mcpc
	<inline: true>
	objectMemory byteAt: address put: byte.
	self cCode: [] inSmalltalk:
		[| s bytecode |
		(compilationTrace anyMask: 64) ifTrue:
			[(s := coInterpreter transcript)
				ensureCr;
				print: annotation; nextPut: $/; nextPutAll: byte hex; space;
				nextPutAll: address hex; space; nextPutAll: mcpc hex; space;
				nextPutAll: (AnnotationConstantNames detect: [:name| (Cogit classPool at: name ifAbsent: []) = annotation]); cr; flush.
			 (instruction notNil
			  and: [instruction bcpc isInteger]) ifTrue:
				[s tab; print: instruction bcpc; nextPut: $/.
				 instruction bcpc printOn: s base: 16.
				 s space.
				 instruction printStateOn: s.
				 s space.
				 bytecode := objectMemory fetchByte: instruction bcpc ofObject: methodObj.
				 bytecode := bytecode + (self bytecodeSetOffsetForHeader: methodHeader).
				 (self generatorAt: bytecode) printStateOn: s.
				 s cr; flush]]]