compile abstract instructions
genEnsureOopInRegNotForwarded: reg scratchReg: scratch
	"Make sure that the oop in reg is not forwarded.  By default there is
	 nothing to do.  Subclasses for memory managers that forward will override."
	<inline: true>
	^0