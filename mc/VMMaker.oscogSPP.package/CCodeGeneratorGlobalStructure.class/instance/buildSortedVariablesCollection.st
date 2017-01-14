C code generator
buildSortedVariablesCollection
	"Build sorted vars, end result will be sorted collection based on static usage, 
	perhaps cache lines will like this!"

	| globalNames |
	globalNames := Bag new: globalVariableUsage size.
	globalVariableUsage keysAndValuesDo:
		[:k :v | | count |
		count := 0.
		v do:
			[:methodName|
			(methods at: methodName ifAbsent: []) ifNotNil:
				[:method|
				 method parseTree nodesDo:
					[:n|
					(n isVariable
					 and: [n name hasEqualElements: k]) ifTrue:
						[count := count + 1]]]].
		globalNames
			add: k		"move arrays (e.g. methodCache) to end of struct"
			withOccurrences: (((variableDeclarations at: k ifAbsent: ['']) includes: $[)
								ifTrue: [count]
								ifFalse: [count + 1000])].
	variableDeclarations keysDo:
		[:e | globalNames add: e withOccurrences: 0].
	variables do:
		[:e | globalNames add: e withOccurrences: 0].
	^(globalNames sortedElements asSortedCollection:
		[:a1 :a2| a1 value > a2 value or: [a1 value = a2 value and: [a1 key <= a2 key]]]) collect:
			[:ea| ea key]