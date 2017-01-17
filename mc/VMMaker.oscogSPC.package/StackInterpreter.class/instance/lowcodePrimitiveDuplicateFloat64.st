inline primitive generated code
lowcodePrimitiveDuplicateFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value dup1 dup2 |
	<var: #value type: #'double' >
	<var: #dup1 type: #'double' >
	<var: #dup2 type: #'double' >
	value := self internalPopStackFloat64.

	dup1 := value.
	dup2 := value.

	self internalPushFloat64: dup1.
	self internalPushFloat64: dup2.

