compile abstract instructions
initializeFixup: fixup
	"Initialize a fixup.  These are the targets of backward branches.  A backward branch fixup's
	 simStackPtr needs to be set when generating the code for the bytecode at the targetPC.
	 Initially a fixup's target is just a flag.  Later on it is replaced with a proper instruction."
	<var: #fixup type: #'BytecodeFixup *'>
	<inline: true>
	fixup
		becomeMergeFixup;
		setIsBackwardBranchFixup