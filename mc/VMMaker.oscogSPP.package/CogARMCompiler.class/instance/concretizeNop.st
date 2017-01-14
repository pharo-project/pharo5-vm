generate machine code - concretize
concretizeNop
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	"(CogARMCompiler new  mov: 0 rn: 0 ) hex -> MOV r0, r0"
	self machineCodeAt: 0 put: 16rE1A00000.
	^machineCodeSize := 4
			