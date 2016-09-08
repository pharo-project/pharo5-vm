memory access
byteSwapped64IfBigEndian: w
	"If the VM is big endian, then swap the bytes of w"
	<api>
	<var: 'w' type: #'unsigned long long'>
	<returnTypeC: #'unsigned long long'>
	self cppIf: VMBIGENDIAN
		ifTrue: [^w byteSwap64]
		ifFalse: [^w bitAnd: 16rFFFFFFFFFFFFFFFF]