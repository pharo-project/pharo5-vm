translation
translateableSubclassesAndOptions
	"CogAbstractInstruction translateableSubclassesAndOptions"
	| translateableSubclassesAndOptions |
	translateableSubclassesAndOptions := OrderedCollection new.
	self subclasses do:
		[:subclass|
		subclass ifTranslateableAddWithOptionsTo: translateableSubclassesAndOptions].
	^translateableSubclassesAndOptions sort:
		[:a :b|
		a first name < b first name
		or: [a first name = b first name "If equal, sort on the ABI"
			and: [a last last < b last last]]]