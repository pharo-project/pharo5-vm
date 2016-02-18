compile abstract instructions
genEnsureObjInRegNotForwarded: reg scratchReg: scratch
	"Make sure that the object in reg is not forwarded.  By default there is
	 nothing to do.  Subclasses for memory managers that forward will override."
	<inline: true>
	^0