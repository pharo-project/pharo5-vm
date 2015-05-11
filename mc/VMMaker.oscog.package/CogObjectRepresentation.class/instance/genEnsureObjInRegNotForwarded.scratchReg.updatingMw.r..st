compile abstract instructions
genEnsureObjInRegNotForwarded: reg scratchReg: scratch updatingMw: offset r: baseReg
	"Make sure that the non-immediate oop in reg is not forwarded, updating the field
	 at offset from baseReg.  By default there is nothing to do.  Subclasses for memory
	 managers that forward will override."
	^0