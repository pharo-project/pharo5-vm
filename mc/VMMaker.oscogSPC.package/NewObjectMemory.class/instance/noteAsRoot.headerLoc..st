garbage collection
noteAsRoot: oop headerLoc: headerLoc 
	"Record that the given oop in the old object area points to an object in the young area.
	 HeaderLoc is usually = oop, but may be an addr in a forwarding block."
	| header |
	<inline: true>
	header := self longAt: headerLoc.
	(self isYoungRootHeader: header) ifFalse:
		"record oop as root only if not already recorded"
		[rootTableCount < RootTableSize
			ifTrue:
				"record root if there is enough room in the roots table.
				 IMPORTANT: since clearRootsTable is the only thing that clears root bits
				 do *not* set the root bit unless an object is in the root table.  checking
				 routines will complain about the root bit being unset instead of the table
				 being full, but that's life"
				[rootTableCount := rootTableCount + 1.
				 rootTable at: rootTableCount put: oop.
				 self longAt: headerLoc put: (header bitOr: RootBit).
				 rootTableCount >= RootTableRedZone ifTrue:
					"if we're now in the red zone force an IGC ASAP"
					[self scheduleIncrementalGC]]
			ifFalse: "note overflow; will need to do a fullGC instead of an incremental."
				[rootTableOverflowed := true]]