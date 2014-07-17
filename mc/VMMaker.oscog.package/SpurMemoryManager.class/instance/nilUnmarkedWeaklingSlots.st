weakness and ephemerality
nilUnmarkedWeaklingSlots
	"Nil the unmarked slots in the weaklings on the
	 weakling stack, finalizing those that lost references.
	 Finally, empty the weaklingStack."
	<inline: #never> "for profiling"
	self cCode: '' inSmalltalk: [coInterpreter transcript nextPutAll: 'nilling...'; flush].
	self assert: self allOldMarkedWeakObjectsOnWeaklingStack.
	weaklingStack = nilObj ifTrue:
		[^self].
	self objStack: weaklingStack from: 0 do:
		[:weakling| | anyUnmarked |
		anyUnmarked := self nilUnmarkedWeaklingSlotsIn: weakling.
		anyUnmarked ifTrue:
			[coInterpreter signalFinalization: weakling]].
	self emptyObjStack: weaklingStack