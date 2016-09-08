accessing
loadLiteralByteSize
	"Answer the byte size of a MoveCwR opcode's corresponding machine code. On ARM this is a single instruction pc-relative register load - unless we have made a mistake and not turned on the out of line literals manager"
	^4