type inference
harmonizeReturnTypesIn: aSetOfTypes
	"Eliminate signed/unsigned conflicts in aSetOfTypes. Non-negative integers can be either
	 signed or unsigned. Ignore them unless there are no types, in which case default to sqInt."
	| constantIntegers sqs usqs |
	constantIntegers := aSetOfTypes select: [:element| element isInteger].
	aSetOfTypes removeAll: constantIntegers.
	"N.B. Because of LP64 vs LLP64 issues do *not* rename #long to #sqInt or #'unsigned long' to #usqInt"
	#(char short int #'long long' #'unsigned char' #'unsigned short' #'unsigned int' #'unsigned long long')
		with: #(sqInt sqInt sqInt sqLong usqInt usqInt usqInt usqLong)
		do: [:type :replacement|
			(aSetOfTypes includes: type) ifTrue:
				[aSetOfTypes remove: type; add: replacement]].
	sqs := aSetOfTypes select: [:t| t beginsWith: 'sq'].
	usqs := aSetOfTypes select: [:t| t beginsWith: 'usq'].
	^(sqs size + usqs size = aSetOfTypes size
	   and: [sqs notEmpty
	   and: [sqs allSatisfy: [:t| usqs includes: 'u', t]]])
		ifTrue: [sqs]
		ifFalse: [(aSetOfTypes isEmpty and: [constantIntegers notEmpty])
					ifTrue: [Set with: #sqInt]
					ifFalse: [aSetOfTypes]]