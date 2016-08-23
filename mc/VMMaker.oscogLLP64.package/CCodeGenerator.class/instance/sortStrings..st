utilities
sortStrings: aStringOrSymbolCollection
	"We need to define this since different Squeak versions answer different results
	 for asSortedCollection and if sort order changes, generated code changes too."
	^aStringOrSymbolCollection asSortedCollection: [:a :b| a caseSensitiveLessOrEqual: b]