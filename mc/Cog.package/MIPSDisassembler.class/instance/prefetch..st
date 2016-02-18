instructions - memory
prefetch: instruction
	| hintName |
	instruction rt = HintLoad ifTrue: [hintName :=  'load'].
	instruction rt = HintStore ifTrue: [hintName :=  'store'].
	^'pref ', hintName, ', ',
	(instruction signedImmediate printString), '(',
	(MIPSConstants nameForRegister: instruction rs), ')'