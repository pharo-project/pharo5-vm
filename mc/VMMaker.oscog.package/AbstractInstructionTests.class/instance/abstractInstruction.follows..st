generating machine code
abstractInstruction: theAbstractInstruction follows: anAbstractInstruction
	<var: #theAbstractInstruction type: #'AbstractInstruction *'>
	<var: #anAbstractInstruction  type: #'AbstractInstruction *'>
	^opcodes notNil
	   and: [(opcodes identityIndexOf: theAbstractInstruction ifAbsent: [0])
			> (opcodes identityIndexOf: anAbstractInstruction ifAbsent: [1])]