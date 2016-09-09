inline primitive generated code
lowcodePrimitiveMemcpyFixed
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| source size dest |
	<var: #source type: #'char*' >
	<var: #dest type: #'char*' >
	size := extA.
	source := self internalPopStackPointer.
	dest := self internalPopStackPointer.

	self mem: dest cp: source y: size.

	extA := 0.

