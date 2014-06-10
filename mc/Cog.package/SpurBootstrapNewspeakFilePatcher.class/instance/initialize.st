initialize-release
initialize
	substitutions := SortedCollection sortBlock: [:tupleA :tupleB | tupleA first <= tupleB first]