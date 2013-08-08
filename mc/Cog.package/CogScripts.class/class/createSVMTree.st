separate vm scripts
createSVMTree
	"Create the parallel StackInterpreterS, CoInterpreterS tree in which
	 objectMemory is an inst var rather than ObjectMemory et al being a superclass"
	"CogScripts createSVMTree"

	| changes map |
	changes := Cursor execute showWhile: [self changedMethodsForObjectMemorySends].

	map := Cursor execute showWhile: [self createStackInterpreterSHierarchy].

	(ChangeSet superclassOrder: (StackInterpreter withAllSubclasses select: [:c| map includesKey: c]) asArray) do:
		[:sourceClass|
		sourceClass selectors do:
			[:sel| | destClass source stamp |
			destClass := map
							at: (((sel beginsWith: 'primitive')
								and: [sel last ~~ $:
								and: [sel ~~ #primitiveFail]])
									ifTrue: [{sourceClass. #primitives}]
									ifFalse: [sourceClass])
							ifAbsent: [map at: sourceClass].
			(changes detect: [:c| c changeClass == sourceClass and: [c selector = sel]] ifNone: [])
				ifNotNil:
					[:change|
					source := change source.
					stamp := Utilities changeStamp copyReplaceAll: Utilities authorInitials with: Utilities authorInitials, ' (objmem refactor)']
				ifNil:
					[source := sourceClass sourceCodeAt: sel.
					stamp := (sourceClass >> sel) timeStamp].
			[destClass
					compile: source
					classified: (sourceClass whichCategoryIncludesSelector: sel)
					withStamp: stamp
					notifying: nil]
				on: SyntaxErrorNotification
				do: [:ex| | newBrowser |
					newBrowser := Browser new setClass: destClass selector: nil.
					newBrowser selectMessageCategoryNamed: (sourceClass whichCategoryIncludesSelector: sel).
					Browser
						openBrowserView: (newBrowser openMessageCatEditString: source)
						label: 'category "', (sourceClass whichCategoryIncludesSelector: sel), '" in ', destClass name]]].

	self readWriteVars, self readOnlyVars do:
		[:sym|
		(NewObjectMemory whichClassIncludesSelector: sym) ifNil:
			[(NewObjectMemory whichClassDefinesInstVar: sym asString)
				compile: sym, (String with: Character cr with: Character tab with: $^), sym
				classified: #accessing]].
	self readWriteVars do:
		[:sym| | setter | setter := (sym, ':') asSymbol.
		(NewObjectMemory whichClassIncludesSelector: setter) ifNil:
			[(NewObjectMemory whichClassDefinesInstVar: sym asString)
				compile: setter, ' aValue', (String with: Character cr with: Character tab with: $^), sym, ' := aValue'
				classified: #accessing]].