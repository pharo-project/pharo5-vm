printing
nameForRegister: reg "<Integer>"
	<doNotGenerate>
	| default |
	default := super nameForRegister: reg.
	^(default last = $?
	  and: [reg between: 0 and: 15])
		ifTrue: [#(RAX RCX RDX RBX RSP RBP RSI RDI R8 R9 R10 R11 R12 R13 R14 R15) at: reg + 1]
		ifFalse: [default]