encoding
mod: mod RM: regMode RO: regOpcode
	"See ModR/M byte & opcode syntax
	 In addition to the notation shown above in 'Mnemonic Syntax' on page 43,
	 the following notation indicates the size and type of operands in the syntax of an instruction opcode:
		/digit	Indicates that the ModRM byte specifies only one register or memory (r/m) operand.
				The digit is specified by the ModRM reg field and is used as an instruction-opcode extension.
				Valid digit values range from 0 to 7.
		/r		Indicates that the ModRM byte specifies both a register operand and a reg/mem (register or memory) operand."
	^mod << 6 + ((regOpcode bitAnd: 7) << 3) + (regMode bitAnd: 7)