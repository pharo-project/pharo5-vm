inline primitive generated code
lowcodePrimitiveDuplicateInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value dup1 dup2 |
	<var: #value type: #'sqInt' >
	<var: #dup1 type: #'sqInt' >
	<var: #dup2 type: #'sqInt' >
	value := self internalPopStackInt32.

	dup1 := value.
	dup2 := value.

	self internalPushInt32: dup1.
	self internalPushInt32: dup2.

