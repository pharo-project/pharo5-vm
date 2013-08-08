benchmark scripts
referenceTimesForSqueakVM
	 "Squeak VM (4.2.2beta1 + Closure Bytecodes) on Eliot's 2010 vintage 2.66GHz Intel Core i7 MacBook Pro"
	^Dictionary new
		at: #nbody put: 4917;
		at: #binarytrees put: 8593;
		at: #chameneosredux put: 5405;
		at: #threadring put: 3789;
		yourself