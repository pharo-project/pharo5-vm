translation
translateableInstructionSubclassesAndInstalledOptionsDo: aBlock
	"Evaluate aBlock with the translateable subclass and its options installed, being careful to clean-up afterwards."
	CogAbstractInstruction translateableSubclassesAndOptions do:
		[:pair|
		[:class :options| | toRemove |
		 toRemove := Set new.
		 options pairsDo:
			[:key :value|
			 (initializationOptions includesKey: key) ifFalse:
				[toRemove add: key].
			 initializationOptions at: key put: value].
		 aBlock value: class.
		 toRemove do: [:key| initializationOptions removeKey: key]]
			valueWithArguments: pair]