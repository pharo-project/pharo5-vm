compile abstract instructions
maybeDumpLiterals: descriptor
	<inline: true>
	<var: #descriptor type: #'BytecodeDescriptor *'>
	((literalsManager mustDumpLiterals: opcodeIndex)
	  or: [descriptor isUnconditionalBranch
	  or: [descriptor isReturn]]) ifTrue:
		[literalsManager dumpLiterals: (descriptor isUnconditionalBranch
										or: [descriptor isReturn]) not]