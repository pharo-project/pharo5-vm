type inference
mergeTypeOf: var in: aDictionary with: newType method: tMethod
	"var is a variable that has been assigned an expression of type  newType.
	 Either assign its type, if it is as yet untyped, or merge newType with its existing type.
	 N.B. We refuse to promote a variable that already has integral type to a floating point
	 type.  The existing plugins depend on this; one can always use an explicit type in future."
	| existingType mergedType |
	existingType := self
						extractTypeFor: var
						fromDeclaration: (aDictionary at: var ifAbsentPut: [newType, ' ', var]).
	existingType ~= newType ifTrue:
		[((self isPointerCType: existingType)
		  or: [self isPointerCType: newType])
			ifTrue:
				[existingType = #'void *' ifTrue: [^newType].
				 newType = #'void *' ifTrue: [^existingType].
				 self logger show: 'conflicting types ', existingType, ' ', newType, ' for ', var, ' in ', tMethod selector.
				 ^existingType]
			ifFalse:
				[((self isIntegralCType: existingType)
				  and: [self isFloatingPointCType: newType]) ifFalse:
					[mergedType := self promoteArithmeticTypes: existingType and: newType.
					 aDictionary at: var put: mergedType, ' ', var]]]