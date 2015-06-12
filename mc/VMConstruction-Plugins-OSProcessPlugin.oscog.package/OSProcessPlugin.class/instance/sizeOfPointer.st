private - conversion
sizeOfPointer
	"Size in bytes of a void pointer, for this C compiler on this machine."
	<inline: true>
	^self sizeof: #'void *'