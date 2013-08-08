benchmark scripts
referenceTimesForClosureInterpreter
	 "ClosureVM (QF 1.2.23 + Closure Bytecodes) on Eliot's 2010 vintage 2.66GHz Intel Core i7 MacBook Pro"
	^Dictionary new
		at: #nbody put: 4543;
		at: #binarytrees put: 6944;
		at: #chameneosredux put: 5799;
		at: #threadring put: 5623;
		yourself

	 "ClosureVM (QF 1.2.23 + Closure Bytecodes) on Eliot's 2006 vintage 2.16GHz Intel Core Duo MacBook Pro"
	"^Dictionary new
		at: #nbody put: 7660;
		at: #binarytrees put: 14417;
		at: #chameneosredux put: 8478;
		at: #threadring put: 8718;
		yourself"