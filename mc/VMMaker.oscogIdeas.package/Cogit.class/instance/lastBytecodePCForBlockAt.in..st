method map
lastBytecodePCForBlockAt: startbcpc in: aMethodObj
	"Answer the 0-relative pc of the last bytecode in the block starting at the 0-relative startbcpc in aMethodObj."
	| aMethodHeader bcpc bsOffset byte descriptor |
	<var: #descriptor type: #'BytecodeDescriptor *'>
	aMethodHeader := objectMemory methodHeaderOf: aMethodObj.
	bcpc := startbcpc - (self blockCreationBytecodeSizeForHeader: aMethodHeader).
	bsOffset := self bytecodeSetOffsetForHeader: aMethodHeader.
	byte := (objectMemory fetchByte: bcpc ofObject: aMethodObj) + bsOffset.
	descriptor := self generatorAt: byte.
	^(self nextBytecodePCFor: descriptor at: bcpc exts: -1 in: aMethodObj) - 1