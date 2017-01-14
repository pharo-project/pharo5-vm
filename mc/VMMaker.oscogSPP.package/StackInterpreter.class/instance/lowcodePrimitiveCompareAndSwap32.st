inline primitive generated code
lowcodePrimitiveCompareAndSwap32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| newValue check oldValue value |
	<var: #newValue type: #'sqInt' >
	<var: #check type: #'char*' >
	<var: #oldValue type: #'sqInt' >
	<var: #value type: #'sqInt' >
	newValue := self internalPopStackInt32.
	oldValue := self internalPopStackInt32.
	check := self internalPopStackPointer.

	self abort.

	self internalPushInt32: value.

