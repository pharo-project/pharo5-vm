type inference
typeOrNilFrom: aCodeGenerator in: aTMethod
	| types |
	types := Set withAll: (cases collect: [:case| case typeOrNilFrom: aCodeGenerator in: aTMethod]).
	^types size = 1 ifTrue: [types anyOne]