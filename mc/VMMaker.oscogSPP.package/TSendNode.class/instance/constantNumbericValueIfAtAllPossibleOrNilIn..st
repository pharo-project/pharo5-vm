accessing
constantNumbericValueIfAtAllPossibleOrNilIn: aCCodeGen
	"This is a version of constantNumbericValueOrNil for type checking rather than code generation.
	 It aims to yield a value if at all possible."
	(#(* // + - << >> bitAnd: bitOr: bitShift:) includes: selector) ifTrue:
		[(receiver constantNumbericValueIfAtAllPossibleOrNilIn: aCCodeGen) ifNotNil:
			[:rval|
			(arguments first constantNumbericValueIfAtAllPossibleOrNilIn: aCCodeGen) ifNotNil:
				[:aval|
				^rval perform: selector with: aval]]].
	^(aCCodeGen anyMethodNamed: selector) ifNotNil:
		[:m|
		 m isReturnConstant ifTrue:
			[m statements last expression constantNumbericValueIfAtAllPossibleOrNilIn: aCCodeGen]]