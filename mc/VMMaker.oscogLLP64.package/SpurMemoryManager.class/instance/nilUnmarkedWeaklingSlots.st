weakness and ephemerality
nilUnmarkedWeaklingSlots
	"Nil the unmarked slots in the weaklings on the
	 weakling stack, finalizing those that lost references.
	 Finally, empty the weaklingStack."
	<inline: #never> "for profiling"
	self cCode: '' inSmalltalk: [coInterpreter transcript nextPutAll: 'nilling...'; flush].
	self eassert: [self allOldMarkedWeakObjectsOnWeaklingStack].
	weaklingStack = nilObj ifTrue:
		[^self].
	self objStack: weaklingStack from: 0 do:
		[:weakling| | anyUnmarked |
		anyUnmarked := self nilUnmarkedWeaklingSlotsIn: weakling.
		anyUnmarked ifTrue:
			["fireFinalization: could grow the mournQueue and if so,
			  additional pages must be marked to avoid being GC'ed."
			 self assert: marking.
			 coInterpreter fireFinalization: weakling]].
	self emptyObjStack: weaklingStack