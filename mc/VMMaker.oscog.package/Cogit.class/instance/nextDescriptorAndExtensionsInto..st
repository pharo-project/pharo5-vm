bytecode generator support
nextDescriptorAndExtensionsInto: aTrinaryBlock
	"Peek ahead and deliver the next descriptor plus extension bytes."
	<inline: true>
	| savedB0 savedB1 savedB2 savedB3 savedEA savedEB descriptor bcpc |
	<var: #descriptor type: #'BytecodeDescriptor *'>
	descriptor := self generatorAt: byte0.
	savedB0 := byte0. savedB1 := byte1. savedB2 := byte2. savedB3 := byte3.
	savedEA := extA. savedEB := extB.
	bcpc := bytecodePC + descriptor numBytes.
	[bcpc > endPC ifTrue:
		[^aTrinaryBlock value: nil value: 0 value: 0].
	 byte0 := (objectMemory fetchByte: bcpc ofObject: methodObj)  + bytecodeSetOffset.
	 descriptor := self generatorAt: byte0.
	 self loadSubsequentBytesForDescriptor: descriptor at: bcpc.
	 descriptor isExtension ifFalse:
		[| eA eB |
		 eA := extA. eB := extB.
		 extA := savedEA. extB := savedEB.
		 byte0 := savedB0. byte1 := savedB1. byte2 := savedB2. byte3 := savedB3.
	 	 ^aTrinaryBlock value: descriptor value: eA value: eB].
	 self perform: descriptor generator.
	 bcpc := bcpc + descriptor numBytes.
	 true] whileTrue