stack access
stackPositiveMachineIntegerValue: offset
	<returnTypeC: #'usqIntptr_t'>
	^self positiveMachineIntegerValueOf: (self stackValue: offset)