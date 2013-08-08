class initialization
table: primArray from: specArray 
	"Fill in the specified entries in the primitive table."
	specArray do:
		[:spec | | descriptor |
		(primArray at: spec first put: CogPrimitiveDescriptor new)
			primitiveGenerator: spec second;
			primNumArgs: (spec at: 3 ifAbsent: -1);
			enabled: (spec at: 4 ifAbsent: nil)].
	primArray object withIndexDo:
		[:generator :i|
		generator ifNil:
			[(primArray object at: i put: CogPrimitiveDescriptor new)
				primNumArgs: -1]]