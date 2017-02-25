accessing
constantNumbericValueIfAtAllPossibleOrNilIn: aCCodeGen
	"This is a version of constantNumbericValueOrNil for type checking rather than code generation.
	 It aims to yield a value if at all possible."
	^self constantNumbericValueOrNil