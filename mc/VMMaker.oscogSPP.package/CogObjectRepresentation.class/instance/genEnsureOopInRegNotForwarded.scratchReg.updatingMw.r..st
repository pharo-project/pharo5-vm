compile abstract instructions
genEnsureOopInRegNotForwarded: reg scratchReg: scratch updatingMw: offset r: baseReg
	"Make sure that the oop in reg is not forwarded, updating the field at offset from baseReg.
	 By default there is nothing to do.  Subclasses for memory managers that forward will override."
	<inline: true>
	^0