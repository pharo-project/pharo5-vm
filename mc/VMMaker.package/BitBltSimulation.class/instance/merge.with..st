combination rules
merge: sourceWord with: destinationWord
	| mergeFnwith |
	"Sender warpLoop is too big to include this in-line"
	<var: #mergeFnwith declareC: 'sqInt (*mergeFnwith)(sqInt, sqInt)'>
	mergeFnwith := self cCoerce: (opTable at: combinationRule+1) to: 'sqInt (*)(sqInt, sqInt)'.
	mergeFnwith.  "null ref for compiler"

	^ self mergeFn: sourceWord with: destinationWord