separate vm scripts
doClassSide
	"self doClassSide"
	| classes rules model env sortedChanges |
	classes := (PackageInfo named: 'VMMaker') classes.
	classes := classes select: [:c| classes anySatisfy: [:d| d name last = $S and: [d name allButLast = c name]]].

	rules := RBParseTreeRewriter new.
	model := RBNamespace new.
	env := RBBrowserEnvironment new forClasses: classes.
	classes do: [:c| rules replace: c name with: c name, 'S'].
	env classesAndSelectorsDo:
		[:class :selector| | tree |
		class isMeta ifTrue:
			[tree := class parseTreeFor: selector.
			rules executeTree: tree.
			model compile: rules tree newSource in: class classified: (class whichCategoryIncludesSelector: selector)]].
	false ifTrue: [model changes inspect].
	false ifTrue: "shortest change:"
		[(model changes changes inject: model changes changes first into: [:c1 :c2| c1 printString size < c2 printString size ifTrue: [c1] ifFalse: [c2]]) inspect].

	sortedChanges := model changes changes asSortedCollection:
						[:c1 :c2|
						c1 changeClass == c2 changeClass
							ifTrue: [c1 selector <= c2 selector]
							ifFalse: [c2 changeClass inheritsFrom: c1 changeClass]].
	true ifTrue:
		[MessageSetTextDifferencer
			openMessageList: (sortedChanges collect: [:mr| { MethodReference class: mr changeClass selector: mr selector. TextReference new text: mr source class: mr class selector: mr selector }])
			name: 'class side' 
			autoSelect: nil].

	sortedChanges do:
		[:mr|
		(Smalltalk classNamed: (mr changeClass theNonMetaClass name, 'S') asSymbol) class
			compile: mr source
			classified: (mr changeClass whichCategoryIncludesSelector: mr selector)
			withStamp: (mr source asString = (mr changeClass sourceCodeAt: mr selector) asString
							ifTrue: [(mr changeClass >> mr selector) timeStamp]
							ifFalse: [Utilities changeStamp copyReplaceAll: Utilities authorInitials with: Utilities authorInitials, ' (objmem refactor)'])
			notifying: nil]