accessing
strip: aFancyDisassembledInstruction
	"Convert e.g. '00000000: movl %rax, 0x2(%rax) : 89 40 02' to  'movl %rax, 0x2(%rax)'"
	^((((aFancyDisassembledInstruction
		copyReplaceAll: '%ds:' with: '')
			copyReplaceAll: '%ss:' with: '')
				allButFirst: (aFancyDisassembledInstruction indexOf: $:) + 1)
					copyUpTo: $:)
						allButLast: 1