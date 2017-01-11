inline primitive generated code
lowcodePrimitiveMemcpy32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| source dest size |
	<var: #source type: #'char*' >
	<var: #dest type: #'char*' >
	<var: #size type: #'sqInt' >
	size := self internalPopStackInt32.
	source := self internalPopStackPointer.
	dest := self internalPopStackPointer.

	self lowcode_mem: dest cp: source y: size.


