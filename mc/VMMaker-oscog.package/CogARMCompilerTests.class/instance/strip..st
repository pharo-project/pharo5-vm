accessing
strip: aFancyDisassembledInstruction
	"When havin an immediate > 15, the disassembler appends '	; 0x\d\d'. That is stripped."
	^((aFancyDisassembledInstruction 
		allButFirst: (aFancyDisassembledInstruction indexOf: $:) + 1)
			copyUpTo: $;) withBlanksTrimmed