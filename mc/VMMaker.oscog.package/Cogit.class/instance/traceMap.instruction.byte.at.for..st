method map
traceMap: annotation instruction: instruction byte: byte at: address for: mcpc
	<cmacro: '(ig,no,r,e,d) 0'>
	| s bytecode |
	(compilationTrace anyMask: 16) ifTrue:
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
			 bytecode := bytecode + (self bytecodeSetOffsetForHeader: (objectMemory methodHeaderOf: methodObj)).
			 (self generatorAt: bytecode) printStateOn: s.
			 s cr; flush]]