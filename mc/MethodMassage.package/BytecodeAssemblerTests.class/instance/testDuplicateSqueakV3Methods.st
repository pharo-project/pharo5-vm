tests
testDuplicateSqueakV3Methods
	"AndreasProfiler spyOn: [self new testDuplicateSqueakV3Methods]"
	| filter |
	filter := (thisContext method respondsTo: #usesAlternateBytecodeSet)
				ifTrue: [[:method| method usesAlternateBytecodeSet not]]
				ifFalse: [[:method| true]].
	Smalltalk allClasses do:
		[:class|
		self testDuplicateMethodsFor: class if: filter.
		self testDuplicateMethodsFor: class class if: filter]