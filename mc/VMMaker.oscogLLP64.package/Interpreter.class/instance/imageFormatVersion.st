image save/restore
imageFormatVersion
	"Return a magic constant that changes when the image format changes. Since the image reading code uses this to detect byte ordering, one must avoid version numbers that are invariant under byte reversal."

	self wordSize == 4
		ifTrue: [^6504]
		ifFalse: [^68002]