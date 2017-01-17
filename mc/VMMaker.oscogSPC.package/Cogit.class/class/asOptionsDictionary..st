in-image compilation
asOptionsDictionary: optionsDictionaryOrArray
	optionsDictionaryOrArray isArray ifTrue:
		[| dict |
		dict := Dictionary new.
		self assert: optionsDictionaryOrArray size even.
		1 to: optionsDictionaryOrArray size by: 2 do:
			[:i| | key |
			key := optionsDictionaryOrArray at: i.
			self assert: key isSymbol.
			dict at: key put: (optionsDictionaryOrArray at: i + 1)].
		^dict].
	^optionsDictionaryOrArray