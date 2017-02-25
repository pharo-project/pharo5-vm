inline primitive generated code
lowcodePrimitiveStoreFloat32ToMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| floatValue pointer |
	<var: #floatValue type: #'float' >
	<var: #pointer type: #'char*' >
	pointer := self internalPopStackPointer.
	floatValue := self internalPopStackFloat32.

	self singleFloatAtPointer: pointer put: floatValue.


