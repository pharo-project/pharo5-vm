inline primitive generated code
lowcodePrimitivePopPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointerValue |
	<var: #pointerValue type: #'char*' >
	pointerValue := self internalPopStackPointer.



