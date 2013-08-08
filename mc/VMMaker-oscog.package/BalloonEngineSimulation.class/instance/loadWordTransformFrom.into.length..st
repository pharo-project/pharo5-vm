initialize
loadWordTransformFrom: transformOop into: destPtr length: n
	"Load a float array transformation from the given oop"

	| srcPtr wordDestPtr |

	false ifTrue:
		[^super loadWordTransformFrom: transformOop into: destPtr length: n].

	srcPtr := interpreterProxy firstIndexableField: transformOop.
	wordDestPtr := destPtr as: CArrayAccessor.  "Remove float conversion shell"
	0 to: n-1 do: [:i | wordDestPtr at: i put: (srcPtr floatAt: i)]