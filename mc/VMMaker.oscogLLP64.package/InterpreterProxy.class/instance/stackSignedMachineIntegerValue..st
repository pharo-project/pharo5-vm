stack access
stackSignedMachineIntegerValue: offset
	<returnTypeC: #'sqIntptr_t'>
	^self signedMachineIntegerValueOf: (self stackValue: offset)