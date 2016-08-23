garbage collection
storeLiteral: literal atAnnotatedAddress: address using: instruction
	"With out-of-line literals, the IsObjectReference annotation refers to
	 the start of the literal and hence access the memory directly."
	<var: 'address' type: #usqInt>
	<var: 'instruction' type: #'AbstractInstruction *'>
	<inline: true>
	objectMemory longAt: address put: literal