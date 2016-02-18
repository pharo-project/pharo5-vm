store check
remember: objOop
	"Add the argument to the remembered set and set its isRemembered bit to true.
	 Answer the argument for the benefit of the Cogit."
	<api>
	<inline: false>
	self assert: (manager isNonImmediate: objOop).
	self deny: (manager isYoungObject: objOop).
	self deny: (manager isRemembered: objOop).
	self deny: (self isInRememberedSet: objOop).
	manager setIsRememberedOf: objOop to: true.
	rememberedSetSize >= rememberedSetLimit ifTrue:
		[self growRememberedSet].
	rememberedSet at: rememberedSetSize put: objOop.
	(rememberedSetSize := rememberedSetSize + 1) >= rememberedSetRedZone ifTrue:
		[manager scheduleScavenge].
	^objOop