class initialization
table: primArray from: specArray 
	"Fill in the specified entries in the primitive table."
	specArray do:
		[:spec | 
		 (spec first <= primArray size
		  and: [spec second == #genFastPrimFail
			  or: [self objectRepresentationClass shouldIncludeMethodForSelector: spec second]]) ifTrue:
			[(primArray at: spec first put: CogPrimitiveDescriptor new)
				primitiveGenerator: spec second;
				primNumArgs: (spec at: 3 ifAbsent: -1)]].
	primArray object withIndexDo:
		[:generator :i|
		generator ifNil:
			[(primArray object at: i put: CogPrimitiveDescriptor new)
				primNumArgs: -1]]