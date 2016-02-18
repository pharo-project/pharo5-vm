as yet unclassified
decodeSpecialFor: visitor
	| function |
	function := self function.
	function = SLL ifTrue: [^visitor shiftLeftLogical: self].
	function = SRL ifTrue: [^visitor shiftRightLogical: self].
	function = SRA ifTrue: [^visitor shiftRightArithmetic: self].
	function = SLLV ifTrue: [^visitor shiftLeftLogicalVariable: self].
	function = SRLV ifTrue: [^visitor shiftRightLogicalVariable: self].
	function = SRAV ifTrue: [^visitor shiftRightArithmeticVariable: self].
	function = JR ifTrue: [^visitor jumpRegister: self].
	function = JALR ifTrue: [^visitor jumpAndLinkRegister: self].
	function = BREAK ifTrue: [^visitor break: self].
	function = MFHI ifTrue: [^visitor moveFromHigh: self].
	function = MFLO ifTrue: [^visitor moveFromLow: self].
	function = MULT ifTrue: [^visitor multiplySigned: self].
	function = DIV ifTrue: [^visitor divideSigned: self].
	function = ADDU ifTrue: [^visitor addUnsigned: self].
	function = SUBU ifTrue: [^visitor subtractUnsigned: self].
	function = AND ifTrue: [^visitor bitwiseAnd: self].
	function = OR ifTrue: [^visitor bitwiseOr: self].
	function = XOR ifTrue: [^visitor bitwiseXor: self].
	function = SLT ifTrue: [^visitor setOnLessThan: self].
	function = SLTU ifTrue: [^visitor setOnLessThanUnsigned: self].
	
	self error: 'Unknown instruction'.