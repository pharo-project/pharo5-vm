stack access
stackSignedMachineIntegerValue: offset
	^self signedMachineIntegerValueOf: (self stackValue: offset)