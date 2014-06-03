compile abstract instructions
storeToReg: reg
	| inst |
	<var: #inst type: #'AbstractInstruction *'>
	type caseOf: {
		[SSBaseOffset]	-> [inst := cogit MoveMw: offset r: register R: reg].
		[SSSpill]		-> [inst := cogit MoveMw: offset r: register R: reg].
		[SSConstant]	-> [inst := (objectRepresentation shouldAnnotateObjectReference: constant)
										ifTrue: [cogit annotate: (cogit MoveCw: constant R: reg) objRef: constant]
										ifFalse: [cogit MoveCq: constant R: reg]].
		[SSRegister]	-> [inst := reg ~= register
										ifTrue: [cogit MoveR: register R: reg]
										ifFalse: [cogit Label]] }.
	annotateUse ifTrue:
		[cogit annotateBytecode: inst.
		 annotateUse := false]