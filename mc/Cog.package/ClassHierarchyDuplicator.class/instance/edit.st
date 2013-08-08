code editing
edit
	(ChangeSet superclassOrder: classes asArray) do:
		[:class| | newClass |
		newClass := class subclassDefinerClass evaluate: (self editClassDefinitionOf: class).
		{ class. class class }
			with: { newClass. newClass class }
			do: [:b :nb|
				b selectors do:
					[:s|
					nb
						compile: (self editCode: (b sourceCodeAt: s) inClass: b withSelector: s)
						classified: (class organization categoryOfElement: s)]]]

	"self new edit"