separate vm scripts
defineSpurPigCompactor
	"Define SpurPigCompactor"
	"self defineSpurPigCompactor"
	| changes pigCompactor |
	pigCompactor := SpurMemoryManager superclass
						subclass: #SpurPigCompactor
						instanceVariableNames: 'manager scavenger coInterpreter firstFreeChunk lastFreeChunk numCompactionPasses'
						classVariableNames: 'CompactionPassesForGC CompactionPassesForSnapshot'
						poolDictionaries: 'SpurMemoryManagementConstants VMBasicConstants VMSpurObjectRepresentationConstants'
						category: SpurMemoryManager category.
	changes := CogScripts changedSpurCompactorMethods.
	changes do:
		[:mr|
		pigCompactor compile: mr source classified: (SpurMemoryManager whichCategoryIncludesSelector: mr selector)].
	changes do:
		[:mr|
		SpurMemoryManager removeSelector: mr selector].
	SpurMemoryManager organization removeEmptyCategories