accessing
loadPICLiteralByteSize
	"Answer the byte size of a MoveCwR opcode's corresponding machine code
	 when the argument is a PIC.  This is for the self-reference at the end of a
	 closed PIC: leaq 0xffffffffffffff2b(%rip), %rcx : 48 8D 0D 2B FF FF FF"
	<inline: true>
	^7