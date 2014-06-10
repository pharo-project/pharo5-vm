method map
lastBytecodePCForBlockAt: startbcpc in: aMethodObj
	"Answer the 0-relative pc of the last bytecode in the block starting at the 0-relative startbcpc in aMethodObj."
	| methodHeader bcpc bsOffset byte descriptor |
	<var: #descriptor type: #'BytecodeDescriptor *'>
	methodHeader := coInterpreter headerOf: aMethodObj.
	bcpc := startbcpc - (self blockCreationBytecodeSizeForHeader: methodHeader).
	bsOffset := self bytecodeSetOffsetForHeader: methodHeader.
	byte := (objectMemory fetchByte: bcpc ofObject: aMethodObj) + bsOffset.
	descriptor := self generatorAt: byte.
	^(self nextBytecodePCFor: descriptor at: bcpc exts: -1 in: aMethodObj) - 1