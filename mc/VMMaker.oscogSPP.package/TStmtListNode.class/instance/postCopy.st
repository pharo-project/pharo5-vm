copying
postCopy

	arguments := arguments copy.
	statements := statements collect: [ :s | s copy ]