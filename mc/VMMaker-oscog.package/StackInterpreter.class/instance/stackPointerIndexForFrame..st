frame access
stackPointerIndexForFrame: theFP
	"Return the 0-based index rel to the given frame.
	 (This is what stackPointer used to be before conversion to pointer)"
	"In the StackInterpreter stacks grow down."
	| thePage theSP |
	<inline: false>
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #theSP type: #'char *'>
	thePage := stackPages stackPageFor: theFP.
	theSP := self findSPOf: theFP on: thePage.
	^self stackPointerIndexForFrame: theFP WithSP: theSP