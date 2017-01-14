inline primitive generated code
lowcodePrimitiveStoreInt8ToMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer value |
	<var: #pointer type: #'char*' >
	<var: #value type: #'sqInt' >
	pointer := self internalPopStackPointer.
	value := self internalPopStackInt32.

	self int8AtPointer: pointer put: value.


