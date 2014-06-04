accessing
allLocals
	"The merge of locals and declarations (don't ask)"

	^(declarations keys asSet reject: [:k| (declarations at: k) == #implicit])
		addAll: locals; yourself