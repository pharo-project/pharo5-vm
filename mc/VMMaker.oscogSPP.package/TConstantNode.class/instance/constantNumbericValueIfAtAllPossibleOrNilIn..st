accessing
constantNumbericValueIfAtAllPossibleOrNilIn: aCCodeGen
	"This is a version of constantNumbericValueOrNil for type checking rather than code generation.
	 It aims to yield a value if at all possible.  This should /not/ be overridden in TDefineNode."
	^value isNumber ifTrue: [value]