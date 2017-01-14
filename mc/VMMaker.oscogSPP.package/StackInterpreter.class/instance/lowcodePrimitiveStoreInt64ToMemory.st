inline primitive generated code
lowcodePrimitiveStoreInt64ToMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer value |
	<var: #pointer type: #'char*' >
	<var: #value type: #'sqLong' >
	pointer := self internalPopStackPointer.
	value := self internalPopStackInt64.

	self int64AtPointer: pointer put: value.


