inline primitive generated code
lowcodePrimitiveDuplicateFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value dup1 dup2 |
	<var: #value type: #'float' >
	<var: #dup1 type: #'float' >
	<var: #dup2 type: #'float' >
	value := self internalPopStackFloat32.

	dup1 := value.
	dup2 := value.

	self internalPushFloat32: dup1.
	self internalPushFloat32: dup2.

