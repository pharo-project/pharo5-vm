store check
remember: objOop
	"Add the argument to the remembered set and set its isRemembered bit to true.
	 Answer the argument for the benefit of the Cogit."
	<api>
	<inline: false>
	self assert: (manager isNonImmediate: objOop).
	self assert: (manager isYoungObject: objOop) not.
	self assert: (manager isRemembered: objOop) not.
	manager setIsRememberedOf: objOop to: true.
	rememberedSetSize < RememberedSetLimit
		ifTrue:
			[rememberedSet at: rememberedSetSize put: objOop.
			 (rememberedSetSize := rememberedSetSize + 1) >= RememberedSetRedZone ifTrue:
				[manager scheduleScavenge]]
		ifFalse:
			[self error: 'remembered set overflow' "for now"].
	^objOop