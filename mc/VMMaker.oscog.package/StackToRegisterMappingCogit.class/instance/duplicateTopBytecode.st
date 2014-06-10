bytecode generators
duplicateTopBytecode
	| desc |
	<var: #desc type: #CogSimStackEntry>
	desc := self ssTopDescriptor.
	^self ssPushDesc: desc