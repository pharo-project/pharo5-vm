compile abstract instructions
genJumpNotSmallInteger: aRegister
	"Generate a compare and branch to test if aRegister contains other than a SmallInteger.
	 Answer the jump, or UnimplementedOperation if this cannot be done with a single register."
	<returnTypeC: #'AbstractInstruction *'>
	<inline: true>
	^cogit cCoerceSimple: UnimplementedOperation to: #'AbstractInstruction *'