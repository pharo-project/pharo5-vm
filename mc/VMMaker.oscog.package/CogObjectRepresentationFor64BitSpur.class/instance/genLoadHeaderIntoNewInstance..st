initialization
genLoadHeaderIntoNewInstance: header
	"Generate the instructions to move the constant header into a new instance pointed to by ReceiverResultReg."
	<inline: true>
	self flag: #endianness.
	cogit
		MoveCq: header R: TempReg;
		MoveR: TempReg Mw: 0 r: ReceiverResultReg