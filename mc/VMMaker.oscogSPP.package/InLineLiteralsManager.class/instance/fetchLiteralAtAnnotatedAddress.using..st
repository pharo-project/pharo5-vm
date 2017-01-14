garbage collection
fetchLiteralAtAnnotatedAddress: address using: instruction
	"Normally literals are embedded in instructions and the annotation is at the start of
	 the following instruction, to cope with literals embedded in variable-length instructions,
	 since, e.g. on x86, the literal typically comes at the end of the instruction."
	<var: 'instruction' type: #'AbstractInstruction *'>
	<inline: true>
	^instruction literalBeforeFollowingAddress: address