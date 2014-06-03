disassembly
pc: address isWithinMethod: cogMethod
	<api>
	<var: #address type: #'char *'>
	<var: #cogMethod type: #'CogMethod *'>
	^address asInteger
		between: cogMethod asInteger + (self sizeof: CogMethod)
		and: cogMethod asInteger + cogMethod blockSize