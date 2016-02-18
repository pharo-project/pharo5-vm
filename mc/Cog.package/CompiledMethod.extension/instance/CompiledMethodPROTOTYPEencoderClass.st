*Cog-method prototypes
CompiledMethodPROTOTYPEencoderClass
	"Answer the encoder class that encoded the bytecodes in this method.
	 The sign flag bit is used by the VM to select a bytecode set.  This formulation
	 may seem odd but this has to be fast, so no property probe unless needed."

	^self header >= 0
		ifTrue: 
			[PrimaryBytecodeSetEncoderClass]
		ifFalse:
			[PrimaryBytecodeSetEncoderClass == SecondaryBytecodeSetEncoderClass
				ifTrue: "Support for testing prior to installing another set"
					[(self propertyValueAt: #encoderClass) ifNil: [SecondaryBytecodeSetEncoderClass]]
				ifFalse:
					[SecondaryBytecodeSetEncoderClass]]