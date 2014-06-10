compile abstract instructions
needsFrameIfFollowsSend: stackDelta
	"As of August 2013, the code generator can't deal with spills in frameless methods (the
	 issue is to do with the stack offset to get at an argument, which is changed when there's a spill).
	 The only context in a spill is needed in a frameless method that I can think of is sends
	 following sends as in e.g. TextColor>>#dominates: other ^other class == self class.
	 Only need to check for the frameless sends since all other sends will force a frame."

	self assert: (prevBCDescriptor notNil and: [prevBCDescriptor needsFrameFunction notNil]).
	^prevBCDescriptor generator == #genSpecialSelectorEqualsEquals
	  or: [prevBCDescriptor generator == #genSpecialSelectorClass]