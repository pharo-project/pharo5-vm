accessing
moveCwRByteSize
	"With in-line literals we use an 11 byte sequence for loading a 64-bit immediate,
	 which is one more than strictly necessary.  We plant a nop at the end of the
	 sequence to allow us to distinguish between this and the
	 (self mod: ModReg RM: rX RO: rY) at the end of an ArithCwR sequence."
	<inline: true>
	^11