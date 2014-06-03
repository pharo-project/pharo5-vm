frame access
ensureMethodIsCogged: methodObj
	"Uncomment this to compact frequently and hence test if clients are ready for the shock."
	"[self commenceCogCompiledCodeCompaction]
		on: Halt
		do: [:ex| ex resume: nil]."
	^super ensureMethodIsCogged: methodObj