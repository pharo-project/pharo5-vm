as yet unclassified
initializeWithMemory: aByteArray
	memory := aByteArray.
	readableBase := 0.
	writableBase := 0.
	exectuableBase := 0.
	readableLimit := memory size.
	writableLimit := memory size.
	exectuableLimit := memory size.