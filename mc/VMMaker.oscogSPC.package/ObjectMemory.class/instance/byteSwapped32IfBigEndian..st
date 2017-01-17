memory access
byteSwapped32IfBigEndian: w
	"If the VM is big endian, then swap the bytes of w"
	<api>
	<var: 'w' type: #'unsigned int'>
	<returnTypeC: #'unsigned int'>
	self cppIf: VMBIGENDIAN
		ifTrue: [^w byteSwap32]
		ifFalse: [^w bitAnd: 16rFFFFFFFF]