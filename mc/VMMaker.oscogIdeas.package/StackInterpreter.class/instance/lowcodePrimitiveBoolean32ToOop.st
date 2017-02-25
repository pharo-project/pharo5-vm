inline primitive generated code
lowcodePrimitiveBoolean32ToOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'sqInt' >
	value := self internalPopStackInt32.

	object := value ~= 0 ifTrue: [ objectMemory trueObject ] ifFalse: [objectMemory falseObject].

	self internalPush: object.

