benchmark scripts
referenceTimesAndArgsForClosureInterpreter
	 "Interpreter + Closures VM (Mac Cocoa 5.7b3 27-Aug-10 >7BCAB029-A835-4D12-946D-4AB7083D2955< VMMaker versionString 4.4.9)
	  on Eliot's 2012 vintage 2.2GHz Intel (quad) Core i7 MacBook Pro"
	^Dictionary new
		at: #nbody				put: #(40903	2000000);
		at: #binarytrees		put: #(30573	17);
		at: #chameneosredux	put: #(30722	2000000);
		at: #threadring			put: #(9148		30000000);
		yourself