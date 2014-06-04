accessing
strip: aFancyDisassembledInstruction
	"When an immediate > 15, the disassembler appends '	; 0x\d\d'. That is stripped. Also strip any prepended stuff delimted by $: - perhaps memory addresses etc?"
	^((aFancyDisassembledInstruction 
		allButFirst: (aFancyDisassembledInstruction indexOf: $: ifAbsent:[-1]) + 1)
			copyUpTo: $;) withBlanksTrimmed