frame access
checkStackPointerIndexForFrame: theFP
	"Version of stackPointerIndexForFrame: that does not depend on writing back head frame pointers.
	 Used for assertion checking. Safe only in external primitives (framePointer valid).
	 Answer the 0-based index rel to the given frame.
	 (This is what stackPointer used to be before conversion to pointer)"
	"In the StackInterpreter stacks grow down."
	| thePage theSP |
	<inline: false>
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #theSP type: #'char *'>
	thePage := stackPages stackPageFor: theFP.
	theSP := self findSPOrNilOf: theFP
				on: thePage
				startingFrom: (thePage = stackPage ifTrue: [framePointer] ifFalse: [thePage headFP]).
	^self stackPointerIndexForFrame: theFP WithSP: theSP