simulation
loadWordTransformFrom: transformOop into: destPtr length: n 
	"Load a float array transformation from the given oop"
	| srcPtr |
	srcPtr := interpreterProxy firstIndexableField: transformOop.
	"Use BalloonArray's float conversion shell.  It stores both the float bits into
	 the heap object, and the float object into the simArray.  This is needed for
	 correct simulation, otherwise there will be errors in BalloonArray>>floatAt:"
	0 to: n - 1 do: [:i| destPtr at: i put: (srcPtr floatAt: i)]