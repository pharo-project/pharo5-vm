private - conversion
sizeOfPointer
	"Size in bytes of a void pointer, for this C compiler on this machine."

	^ self cCode: 'sizeof(void *)' inSmalltalk: [4].
