inline primitive generated code
lowcodePrimitiveFree
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer |
	<var: #pointer type: #'char*' >
	pointer := self internalPopStackPointer.

	self free: pointer.


