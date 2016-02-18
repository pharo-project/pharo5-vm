compile abstract instructions
getLiteralCountOf: methodReg plusOne: plusOne inBytes: inBytes into: litCountReg scratch: scratchReg
	"Get the literal count of a CompiledMethod into headerReg, plus one if requested.
	  If inBytes is true, scale the count by the word size.  Deal with the possibility of
	 the method being cogged."
	self subclassResponsibility