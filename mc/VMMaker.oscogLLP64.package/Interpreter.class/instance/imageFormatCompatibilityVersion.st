image save/restore
imageFormatCompatibilityVersion
	"This VM is backward-compatible with the immediately preceding non-closure version."

	self wordSize == 4
		ifTrue: [^6502]
		ifFalse: [^68000]