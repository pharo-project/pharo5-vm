bytecode generator support
genFallsThroughCountLogicCounterReg: counterReg counterAddress: counterAddress
	<inline: true>
	"Gen this when the branch has not been taken and forwarders have been followed."
	self SubCq: 1 R: counterReg. "Count untaken"
	self MoveR: counterReg A32: counterAddress. "write back"