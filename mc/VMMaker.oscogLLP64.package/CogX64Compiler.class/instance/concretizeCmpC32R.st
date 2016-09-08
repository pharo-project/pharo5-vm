generate machine code
concretizeCmpC32R
	"Will get inlined into concretizeAt: switch."
	"N.B. This use of 32-bit comparss allows us to squeak by and use a short jump
	 in PIC case dispatch, where a jump to the abort is 126 bytes (!!)."
	<inline: true>
	| value reg skip |
	value := operands at: 0.
	reg := operands at: 1.
	reg = RAX
		ifTrue:
			[machineCode at: 0 put: 16r3D.
			 skip := 0]
		ifFalse:
			[reg > 7
				ifTrue:
					[machineCode at: 0 put: 16r41.
					 skip := 2]
				ifFalse:
					[skip := 1].
			 machineCode
				at: skip - 1 put: 16r81;
				at: skip put:  (self mod: ModReg RM: reg RO: 7)].
	machineCode		
		at: skip + 1 put: (value bitAnd: 16rFF);
		at: skip + 2 put: (value >> 8 bitAnd: 16rFF);
		at: skip + 3 put: (value >> 16 bitAnd: 16rFF);
		at: skip + 4 put: (value >> 24 bitAnd: 16rFF).
	 ^machineCodeSize := 5 + skip