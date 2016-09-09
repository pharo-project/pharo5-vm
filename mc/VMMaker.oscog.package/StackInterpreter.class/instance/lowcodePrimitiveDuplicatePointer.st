inline primitive generated code
lowcodePrimitiveDuplicatePointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| dup2 dup1 pointerValue |
	<var: #dup2 type: #'char*' >
	<var: #dup1 type: #'char*' >
	<var: #pointerValue type: #'char*' >
	pointerValue := self internalPopStackPointer.

	dup1 := pointerValue.
	dup2 := pointerValue.

	self internalPushPointer: dup1.
	self internalPushPointer: dup2.

