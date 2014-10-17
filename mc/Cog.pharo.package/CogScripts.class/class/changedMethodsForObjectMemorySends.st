separate vm scripts
changedMethodsForObjectMemorySends
	"Answer the methods in StackInterpreter and subclasses that change if sends to self for methods implemented
	 in ObjectMemory, NewObjectMemory (& NewObjectMemorySE ?) become sends to objectMemory."
	"CogScripts changedMethodsForObjectMemorySends"
	| selectors rules model environment sortedChanges |
	selectors := { ObjectMemory. NewObjectMemory. "NewObjectMemorySE" }
					inject: Set new
					into: [:sels :class| sels addAll: class selectors; yourself].
	rules := RBParseTreeRewriter new.
	rules
		replace: 'self `@method: ``@args'
		with: 'objectMemory `@method: ``@args'
		when: [:node| selectors includes: node selector].
	#(	'nilObj' 'trueObj' 'falseObj')
		do: [:instVar|
			rules
				replace: instVar, ' := ``@args' with: 'objectMemory ', instVar, 'ect: ``@args';
				replace: instVar with: 'objectMemory ', instVar, 'ect'].
	self readWriteVars do: [:instVar|
			rules
				replace: instVar, ' := ``@args' with: 'objectMemory ', instVar, ': ``@args';
				replace: instVar with: 'objectMemory ', instVar].
	self readOnlyVars do: [:instVar|
			rules replace: instVar with: 'objectMemory ', instVar].
	model := RBNamespace new.
	environment := RBBrowserEnvironment new forClasses:
						{ StackInterpreter. CoInterpreter. CoInterpreterMT.
						   StackInterpreterSimulator. CogVMSimulator }.
	environment classesAndSelectorsDo:
		[ :class :selector | | tree |
		"(class == StackInterpreter and: [selector == #isContextHeader:]) ifTrue: [self halt]."
		"(class == StackInterpreter and: [selector == #isIndexable:]) ifTrue: [self halt]."
		"(class == StackInterpreter and: [selector == #printContextCallStackOf:]) ifTrue: [self halt]."
		tree := class parseTreeFor: selector.
		(rules executeTree: tree) ifTrue:
			[model compile: rules tree newSource in: class classified: (class whichCategoryIncludesSelector: selector)]].
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
			name: 'self foo <-> objectMemory foo et al' 
			autoSelect: nil].

	^sortedChanges