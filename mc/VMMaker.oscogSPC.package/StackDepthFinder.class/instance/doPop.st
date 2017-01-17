instruction decoding
doPop
	"Remove Top Of Stack bytecode."
	deadCode ifFalse:
		[self drop]