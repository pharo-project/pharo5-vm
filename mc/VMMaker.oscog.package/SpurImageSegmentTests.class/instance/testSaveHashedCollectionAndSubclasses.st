tests
testSaveHashedCollectionAndSubclasses
	SimulatorHarnessForTests new
		withExecutableInterpreter: self initializedVM
		do: [:vm :harness| | objects |
			CheckForLeaks == true ifTrue: "CheckForLeaks := self confirm: 'Check for leaks?'"
				[vm objectMemory setCheckForLeaks: (vm objectMemory class bindingOf: #GCModeImageSegment) value].
			objects := harness
				interpreter: vm
				object: (harness findClassNamed: 'Compiler')
				perform: (harness findSymbol: #evaluate:)
				withArguments: {vm objectMemory stringForCString:
					'| seg out result |
					 seg := WordArray new: 1024 * 1024.
					 out := Array new: 256.
					 nil tryPrimitive: 98 withArgs: {	HashedCollection subclasses,
													(HashedCollection subclasses collect: [:ea| ea class]).
													seg. out }.
					 result := { seg. out }.
					 nil tryPrimitive: 99 withArgs: result.
					 result'}]