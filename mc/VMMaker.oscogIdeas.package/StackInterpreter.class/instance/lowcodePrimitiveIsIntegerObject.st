inline primitive generated code
lowcodePrimitiveIsIntegerObject
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'sqInt' >
	object := self internalPopStack.

	value := (objectMemory isIntegerObject: object) ifTrue: [1] ifFalse: [0].

	self internalPushInt32: value.

