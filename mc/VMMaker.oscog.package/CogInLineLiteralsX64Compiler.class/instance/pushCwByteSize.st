accessing
pushCwByteSize
	"With in-line literals we use a 12 byte sequence for loading a 64-bit immediate, which
	 is one more than strictly necessary.  The sequence ends with a 16r50 + reg opcode
	 (PushR) to allow us to distinguish between this and the (self mod: ModReg RM: rX RO: rY)
	 at the end of an ArithCwR sequence."
	<inline: true>
	^12