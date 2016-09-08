inline primitive generated code
lowcodePrimitiveOopToPointerReinterpret
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object pointer |
	<var: #object type: #'sqInt' >
	<var: #pointer type: #'char*' >
	object := self internalPopStack.

	pointer := self cCoerce: object to: 'char*'.

	self internalPushPointer: pointer.

