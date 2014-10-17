code editing
editClassDefinitionOf: aClass
	| classDef categoryString |
	categoryString := 'category: '''.
	classDef := self editCode: aClass definition inClass: nil withSelector: nil.
	classDef := classDef
					copyReplaceAll: categoryString
					with: categoryString, prefix.
	^classDef
		copyReplaceAll: aClass classVariablesString
		with: (String streamContents: [:s| aClass classVariablesString subStrings do: [:ea| s nextPutAll: prefix; nextPutAll: ea; space]])

	"self new editClassDefinitionOf: MessageNode"