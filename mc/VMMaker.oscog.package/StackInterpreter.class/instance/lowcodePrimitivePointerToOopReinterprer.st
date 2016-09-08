inline primitive generated code
lowcodePrimitivePointerToOopReinterprer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer object |
	<var: #pointer type: #'char*' >
	<var: #object type: #'sqInt' >
	pointer := self internalPopStackPointer.

	object := self cCoerce: pointer to: 'sqInt'.

	self internalPush: object.

