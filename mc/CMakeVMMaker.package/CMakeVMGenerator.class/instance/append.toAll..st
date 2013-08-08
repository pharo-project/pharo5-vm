as yet unclassified
append: aString toAll: list
	"flatten the list, adding prefix for each element"
	^ list inject: '' into: [:result :each | result, ' ', aString, each ].