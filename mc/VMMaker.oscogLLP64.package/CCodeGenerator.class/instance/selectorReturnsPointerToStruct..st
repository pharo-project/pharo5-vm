C code generator
selectorReturnsPointerToStruct: selector "<Symbol>"
	| tMethod |
	^(tMethod := methods
					at: selector
					ifAbsent:
						[apiMethods ifNotNil:
							[apiMethods at: selector ifAbsent: []]]) notNil
	  and: [VMStructType isTypePointerToStruct: tMethod returnType]