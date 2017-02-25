initialization
genStoreHeader: header intoNewInstance: rcvrReg using: scratchReg
	"Generate the instructions to move the constant header into a new instance pointed to by rcvrReg."
	<inline: true>
	cogit
		MoveCq: header R: scratchReg;
		MoveR: scratchReg Mw: 0 r: rcvrReg