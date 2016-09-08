memory access
vmEndianness
	<api>
	"1 = big, 0 = little"
	^self cCode: [VMBIGENDIAN] inSmalltalk: [self subclassResponsibility]