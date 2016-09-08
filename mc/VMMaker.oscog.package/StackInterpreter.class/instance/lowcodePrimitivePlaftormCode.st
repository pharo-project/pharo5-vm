inline primitive generated code
lowcodePrimitivePlaftormCode
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| code |
	<var: #code type: #'sqInt' >

	self abort.

	self internalPushInt32: code.

