disassembly
instructionSizeAt: pc
	"Answer the instruction size at pc.  This is very far from a full decode.
	 It only has to cope with the instructions generated in a block dispatch."
	| op |
	op := objectMemory byteAt: pc.
	^op caseOf:
		{	[16r0F]	->	[self twoByteInstructionSizeAt: pc].
			[16r3D]	->	[5]. "cmp EAX,imm32"
			[16r70]	->	[2]. "short conditional jumps"
			[16r71]	->	[2].
			[16r72]	->	[2].
			[16r73]	->	[2].
			[16r74]	->	[2].
			[16r75]	->	[2].
			[16r76]	->	[2].
			[16r77]	->	[2].
			[16r78]	->	[2].
			[16r79]	->	[2].
			[16r7A]	->	[2].
			[16r7B]	->	[2].
			[16r7C]	->	[2].
			[16r7D]	->	[2].
			[16r7E]	->	[2].
			[16r7F]	->	[2].
			[16r83]	->	[self sizeImmediateGroup1: op at: pc].
			[16r89]	->	[2]. "MOV Eb,Gb"
			[16r8B]	->	[self sizeHasModrm: op at: pc].
			[16r90]	->	[1]. "nop"
			[16rE9] ->	[5]. "long unconditional jump"
			[16rEB] ->	[2]. "short unconditional jump"
			[16rCC]	->	[1]. "int3" }