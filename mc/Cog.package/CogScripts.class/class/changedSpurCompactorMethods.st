separate vm scripts
changedSpurCompactorMethods
	"Answer the methods in SpurPigCompactor and subclasses that change if sends to self for methods implemented
	 in SpurMemoryManager become sends to manager."
	"CogScripts changedSpurCompactorMethods"
	| selectors compactorVars spurMemoryManagerSelectors rules model environment sortedChanges |
	selectors := (self systemNavigation allAccessesTo: 'firstFreeChunk' from: SpurMemoryManager) asSet,
				 (self systemNavigation allAccessesTo: 'lastFreeChunk' from: SpurMemoryManager)
					collect: [:mr| mr selector].
	selectors addAll: (SpurMemoryManager selectors select: [:s| ('*pigcompact*' match: s) or: [s endsWith: 'Pig']]).
	compactorVars := #('numCompactionPasses' 'firstFreeChunk' 'lastFreeChunk' 'scavenger' 'coInterpreter').
	spurMemoryManagerSelectors := SpurMemoryManager selectors.
	rules := RBParseTreeRewriter new.
	rules
		replace: 'self `@method: ``@args'
		with: 'manager `@method: ``@args'
		when: [:node| (spurMemoryManagerSelectors includes: node selector) and: [(selectors includes: node selector) not]].
	(SpurMemoryManager instVarNames reject: [:iv| compactorVars includes: iv]) do:
		[:instVar|
		 rules
			replace: instVar, ' := ``@args' with: 'manager ', instVar, ': ``@args';
			replace: instVar with: 'manager ', instVar].
	#(	'nilObj' 'trueObj' 'falseObj')
		do: [:instVar|
			rules
				replace: instVar, ' := ``@args' with: 'manager ', instVar, 'ect: ``@args';
				replace: instVar with: 'manager ', instVar, 'ect'].
	model := RBNamespace new.
	environment := RBBrowserEnvironment new forClasses: { SpurMemoryManager }.
	environment classesAndSelectorsDo:
		[ :class :selector | | tree |
		((selectors includes: selector)
		 and: [rules executeTree: (tree := class parseTreeFor: selector)]) ifTrue:
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
			openMessageList: (sortedChanges collect: [:mr| { MethodReference class: mr changeClass selector: mr selector. TextReference new text: mr source class: mr changeClass selector: mr selector }])
			name: 'self foo <-> manager foo et al' 
			autoSelect: nil].

	^sortedChanges