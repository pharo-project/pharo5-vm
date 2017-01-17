inline primitive generated code
lowcodePrimitiveUnpin
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object |
	<var: #object type: #'sqInt' >
	object := self internalPopStack.

	objectMemory unpinObject: object.


