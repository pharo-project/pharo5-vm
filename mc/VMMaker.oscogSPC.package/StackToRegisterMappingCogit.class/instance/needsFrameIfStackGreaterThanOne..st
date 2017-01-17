compile abstract instructions
needsFrameIfStackGreaterThanOne: stackDelta
	"As of August 2013, the code generator can't deal with spills in frameless methods (the
	 issue is to do with the stack offset to get at an argument, which is changed when there's a spill).
	 In e.g. TextColor>>#dominates: other ^other class == self class the second send of class
	 needs also rto allocate a register that the first one used, but the first one's register can't be
	 spilled.  So avoid this by only allowing class to be sent if the stack contains a single element."

	^stackDelta > 1