abstract instructions
JumpFPGreaterOrEqual: jumpTarget
	"Floating-point jumps are a little weird on some processors.  Defer to
	 the backEnd to allow it to generate any special code it may need to."
	<returnTypeC: #'AbstractInstruction *'>
	<var: #jumpTarget type: #'void *'>
	<inline: false>
	^backEnd genJumpFPGreaterOrEqual: jumpTarget