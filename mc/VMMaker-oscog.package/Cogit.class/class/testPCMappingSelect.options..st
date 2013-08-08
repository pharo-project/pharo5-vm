tests
testPCMappingSelect: aBlock options: optionsDictionaryOrArray
	"Test pc mapping both ways using the methods in the current image"
	| cogit coInterpreter |
	self initializeWithOptions: (self asOptionsDictionary: optionsDictionaryOrArray).
	cogit := self new.
	coInterpreter := CurrentImageCoInterpreterFacade new cogit: cogit; yourself.
	[cogit
			setInterpreter: coInterpreter;
			singleStep: true;
			initializeCodeZoneFrom: 1024 upTo: coInterpreter memory size]
		on: Notification
		do: [:ex|
			(ex messageText beginsWith: 'cannot find receiver for') ifTrue:
				[ex resume: coInterpreter]].
	SystemNavigation new allSelect:
		[:m| | cm |
		(m isQuick not
		 and: [aBlock value: m]) ifTrue:
			[Transcript nextPut: $.; flush.
			 [cm := cogit
						cog: (coInterpreter oopForObject: m)
						selector: (coInterpreter oopForObject: m selector).
			   cm isNil and: [coInterpreter isCogCompiledCodeCompactionCalledFor]] whileTrue:
				[cogit methodZone clearCogCompiledCode.
				 coInterpreter clearCogCompiledCodeCompactionCalledFor.
				 coInterpreter initializeObjectMap].
			 cogit testPCMappingForMethod: cm].
		 false]