inline cacheing
relocateMethodReferenceBeforeAddress: pc by: delta
	"If possible we generate the method address using pc-relative addressing.
	 If so we don't need to relocate it in code.  So check if pc-relative code was
	 generated, and if not, adjust a long sequence.  There are two cases, a push
	 or a register load.  If a push, then there is a register load, but in the instruction
	 before."
	^self subclassResponsibility