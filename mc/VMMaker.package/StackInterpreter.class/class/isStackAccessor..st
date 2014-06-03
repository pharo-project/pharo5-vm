spur compilation support
isStackAccessor: selector
	^#( stackTop stackValue: stackTopPut: stackValue:put:
		stackFloatValue: stackIntegerValue: stackObjectValue:) includes: selector