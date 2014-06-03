initialization
reinitializeCountersFrom: start to: stop
	"Reinitialize the counter labels in the given range.  We give them bogus
	 addresses since we can't determine their address until after the map
	 is generated.  So we have to regenerate their dependent instructions
	 after map generation."
	| label |
	<var: #label type: #'AbstractInstruction *'>
	start to: stop do:
		[:i|
		label := self addressOf: (counters at: i).
		label
			opcode: Label;
			dependent: nil;
			address: methodZone zoneEnd - (numCounters + i * CounterBytes)]