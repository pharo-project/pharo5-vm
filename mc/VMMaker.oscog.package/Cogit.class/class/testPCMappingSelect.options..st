tests
testPCMappingSelect: aBlock options: optionsDictionaryOrArray
	"Test pc mapping both ways using a selection of the methods in the current image."
	| cogit coInterpreter |
	self initializeWithOptions: (self asOptionsDictionary: optionsDictionaryOrArray).
	cogit := self new.
	coInterpreter := CurrentImageCoInterpreterFacade forCogit: cogit.
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
			[coInterpreter voidHeaderToMethodMap.
			 Transcript nextPut: $.; flush.
			 [coInterpreter.
			  cm := cogit
						cog: (coInterpreter oopForObject: m)
						selector: (coInterpreter oopForObject: m selector).
			   cm isNil and: [coInterpreter isCogCompiledCodeCompactionCalledFor]] whileTrue:
				[cogit methodZone clearCogCompiledCode.
				 coInterpreter clearCogCompiledCodeCompactionCalledFor.
				 coInterpreter initializeObjectMap].
			 cogit testPCMappingForCompiledMethod: m cogMethod: cm].
		 false]