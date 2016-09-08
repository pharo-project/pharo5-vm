inline primitive generated code
lowcodePrimitiveIsWordsOrBytes
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'sqInt' >
	object := self internalPopStack.

	value := (objectMemory isWordsOrBytes: object) ifTrue: [1] ifFalse: [0].

	self internalPushInt32: value.

