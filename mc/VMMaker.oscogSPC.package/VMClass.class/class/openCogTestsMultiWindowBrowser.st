utilities
openCogTestsMultiWindowBrowser
	"Answer a new multi-window browser on the test classes in VMMaker"
	"self openCogTestsMultiWindowBrowser"
	| testClasses b |
	testClasses := (PackageInfo named: 'VMMaker') classes select: [:c| c inheritsFrom: TestCase].
	testClasses removeAll: AbstractInstructionTests allSubclasses.
	testClasses removeAll: (testClasses select: [:c| '*Plugin*' match: c name]).
	b := Browser open.
	testClasses do:
		[:class| b selectCategoryForClass: class; selectClass: class]
		separatedBy:
			[b multiWindowState addNewWindow].
	b multiWindowState selectWindowIndex: 1