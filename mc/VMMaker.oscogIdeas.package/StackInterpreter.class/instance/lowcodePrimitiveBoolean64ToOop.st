inline primitive generated code
lowcodePrimitiveBoolean64ToOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'sqLong' >
	value := self internalPopStackInt64.

	object := value ~= 0 ifTrue: [ objectMemory trueObject ] ifFalse: [objectMemory falseObject].

	self internalPush: object.

