debug support
assertValidStackedInstructionPointers: ln
	"Check that the stacked instruction pointers in all pages are correct.
	 Checks the interpreter sender/machine code callee contract.
	 Written so it will be optimized away if not in an assert VM."
	| thePage |
	<inline: false>
	<var: #thePage type: #'StackPage *'>
	0 to: numStackPages - 1 do:
		[:i|
		thePage := stackPages stackPageAt: i.
		(stackPages isFree: thePage) ifFalse:
			[self assert: (self assertValidStackedInstructionPointersIn: thePage line: ln) l: ln]]