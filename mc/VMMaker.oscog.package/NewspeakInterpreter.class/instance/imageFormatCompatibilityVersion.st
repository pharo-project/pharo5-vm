image save/restore
imageFormatCompatibilityVersion
	"This VM is backward-compatible with the immediately preceeding non-closure version."

	BytesPerWord == 4
		ifTrue: [^6502]
		ifFalse: [^68000]