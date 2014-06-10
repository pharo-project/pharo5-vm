C code generator
selectorReturnsStruct: selector "<Symbol>"
	| tMethod |
	^(tMethod := methods
					at: selector
					ifAbsent:
						[apiMethods ifNotNil:
							[apiMethods at: selector ifAbsent: []]]) notNil
	  and: [VMStructType isTypeStruct: tMethod returnType]