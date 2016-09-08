inline primitive generated code
lowcodePrimitiveMemcpy64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| source dest size |
	<var: #source type: #'char*' >
	<var: #dest type: #'char*' >
	<var: #size type: #'sqLong' >
	size := self internalPopStackInt64.
	source := self internalPopStackPointer.
	dest := self internalPopStackPointer.

	self mem: dest cp: source y: size.


