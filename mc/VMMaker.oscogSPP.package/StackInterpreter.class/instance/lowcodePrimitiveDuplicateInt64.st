inline primitive generated code
lowcodePrimitiveDuplicateInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value dup1 dup2 |
	<var: #value type: #'sqLong' >
	<var: #dup1 type: #'sqLong' >
	<var: #dup2 type: #'sqLong' >
	value := self internalPopStackInt64.

	dup1 := value.
	dup2 := value.

	self internalPushInt64: dup1.
	self internalPushInt64: dup2.

