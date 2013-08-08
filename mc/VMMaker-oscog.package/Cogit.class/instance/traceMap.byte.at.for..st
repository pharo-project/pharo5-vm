method map
traceMap: annotation byte: byte at: address for: mcpc
	<cmacro: '(ig,no,re,d) 0'>
	| s code bytecode |
	(compilationTrace anyMask: 16) ifTrue:
		[code := annotation isInteger ifTrue: [annotation] ifFalse: [annotation annotation].
		(s := coInterpreter transcript)
			ensureCr;
			print: code; nextPut: $/; nextPutAll: byte hex; space;
			nextPutAll: address hex; space; nextPutAll: mcpc hex; space;
			nextPutAll: (AnnotationConstantNames detect: [:name| (Cogit classPool at: name ifAbsent: []) = code]); cr; flush.
		(annotation isInteger not
		 and: [annotation instruction bcpc isInteger]) ifTrue:
			[s tab; print: annotation instruction bcpc; nextPut: $/.
			 annotation instruction bcpc printOn: s base: 16.
			 s space.
			 annotation instruction printStateOn: s.
			 s space.
			 bytecode := objectMemory fetchByte: annotation instruction bcpc ofObject: methodObj.
			 bytecode := bytecode + (self bytecodeSetOffsetForHeader: (coInterpreter headerOf: methodObj)).
			 (self generatorAt: bytecode) printStateOn: s.
			 s cr; flush]]