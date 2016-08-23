initialization
genStoreHeader: header intoNewInstance: rcvrReg using: scratchReg
	"Generate the instructions to move the constant header into a new instance pointed to by rcvrReg."
	<inline: true>
	self flag: #endianness.
	cogit
		MoveCq: (self low32BitsOf: header) R: scratchReg;
		MoveR: scratchReg Mw: 0 r: rcvrReg;
		MoveCq: header >> 32 R: scratchReg;
		MoveR: scratchReg Mw: 4 r: rcvrReg