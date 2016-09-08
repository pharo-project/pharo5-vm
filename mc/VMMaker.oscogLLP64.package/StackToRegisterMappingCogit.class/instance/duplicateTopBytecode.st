bytecode generators
duplicateTopBytecode
	| desc |
	<var: #desc type: #SimStackEntry>
	desc := self ssTopDescriptor.
	^self ssPushDesc: desc