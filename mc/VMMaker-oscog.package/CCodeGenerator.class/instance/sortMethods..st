utilities
sortMethods: aTMethodCollection
	"We need to define this since different Squeak versions answer different results
	 for asSortedCollection and if sort order changes, generated code changes too."
	^aTMethodCollection asSortedCollection:
		[:a :b| a selector caseSensitiveLessOrEqual: b selector]