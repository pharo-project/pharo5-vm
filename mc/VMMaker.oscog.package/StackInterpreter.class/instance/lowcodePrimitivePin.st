inline primitive generated code
lowcodePrimitivePin
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object |
	<var: #object type: #'sqInt' >
	object := self internalPopStack.

	objectMemory pinObject: object.


