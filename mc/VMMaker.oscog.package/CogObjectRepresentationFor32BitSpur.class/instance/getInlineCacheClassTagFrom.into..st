compile abstract instructions
getInlineCacheClassTagFrom: sourceReg into: destReg
	"Extract the inline cache tag for the object in sourceReg into destReg. The inline
	 cache tag for a given object is the value loaded in inline caches to distinguish
	 objects of different classes.  In Spur this is either the tags for immediates, (with
	 1 & 3 collapsed to 1 for SmallIntegers, and 2 collapsed to 0 for Characters), or
	 the receiver's classIndex.  Generate something like this:
		Limm:
			andl $0x1, rDest
			j Lcmp
		Lentry:
			movl rSource, rDest
			andl $0x3, rDest
			jnz Limm
			movl 0(%edx), rDest
			andl $0x3fffff, rDest
		Lcmp:
	 At least on a 2.2GHz Intel Core i7 the following is slightly faster than the above,
	 136m sends/sec vs 130m sends/sec for nfib in tinyBenchmarks
		Lentry:
			movl rSource, rDest
			andl $0x3, rDest
			jz LnotImm
			andl $1, rDest
			j Lcmp
		LnotImm:
			movl 0(%edx), rDest
			andl $0x3fffff, rDest
		Lcmp:
	 But we expect most SMallInteger arithmetic to be performwd in-line and so prefer the
	 version that is faster for non-immediates (because it branches for immediates only)."
	| immLabel jumpNotImm entryLabel jumpCompare |
	<var: #immLabel type: #'AbstractInstruction *'>
	<var: #jumpNotImm type: #'AbstractInstruction *'>
	<var: #entryLabel type: #'AbstractInstruction *'>
	<var: #jumpCompare type: #'AbstractInstruction *'>
	false
		ifTrue:
			[cogit AlignmentNops: BytesPerWord.
			 entryLabel := cogit Label.
			 cogit MoveR: sourceReg R: destReg.
			 cogit AndCq: objectMemory tagMask R: destReg.
			 jumpNotImm := cogit JumpZero: 0.
			 cogit AndCq: 1 R: destReg.
			 jumpCompare := cogit Jump: 0.
			 "Get least significant half of header word in destReg"
			 self flag: #endianness.
			 jumpNotImm jmpTarget:
				(cogit MoveMw: 0 r: sourceReg R: destReg).
			 jumpCompare jmpTarget:
				(cogit AndCq: objectMemory classIndexMask R: destReg)]
		ifFalse:
			[cogit AlignmentNops: BytesPerWord.
			 immLabel := cogit Label.
			 cogit AndCq: 1 R: destReg.
			 jumpCompare := cogit Jump: 0.
			 cogit AlignmentNops: BytesPerWord.
			 entryLabel := cogit Label.
			 cogit MoveR: sourceReg R: destReg.
			 cogit AndCq: objectMemory tagMask R: destReg.
			 cogit JumpNonZero: immLabel.
			 self flag: #endianness.
			 "Get least significant half of header word in destReg"
			 cogit MoveMw: 0 r: sourceReg R: destReg.
			 cogit AndCq: objectMemory classIndexMask R: destReg.
			 jumpCompare jmpTarget: cogit Label].
	^entryLabel