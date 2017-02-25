type inference
harmonizeReturnTypesIn: aSetOfTypes
	"Eliminate signed/unsigned conflicts in aSetOfTypes"
	| sqs usqs |
	#(char short int #'unsigned char' #'unsigned short' #'unsigned int' #'unsigned long')
		with: #(sqInt sqInt sqInt #usqInt #usqInt #usqInt #usqInt)
		do: [:type :replacement|
			(aSetOfTypes includes: type) ifTrue:
				[aSetOfTypes remove: type; add: replacement]].
	sqs := aSetOfTypes select: [:t| t beginsWith: 'sq'].
	usqs := aSetOfTypes select: [:t| t beginsWith: 'usq'].
	^(sqs size + usqs size = aSetOfTypes size
	   and: [sqs notEmpty
	   and: [sqs allSatisfy: [:t| usqs includes: 'u', t]]])
		ifTrue: [sqs]
		ifFalse: [aSetOfTypes]