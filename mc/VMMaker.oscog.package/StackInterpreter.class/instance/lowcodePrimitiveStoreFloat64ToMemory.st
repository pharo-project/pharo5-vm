inline primitive generated code
lowcodePrimitiveStoreFloat64ToMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| doubleValue pointer |
	<var: #doubleValue type: #'double' >
	<var: #pointer type: #'char*' >
	pointer := self internalPopStackPointer.
	doubleValue := self internalPopStackFloat64.

	self floatAtPointer: pointer put: doubleValue.


