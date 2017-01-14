weakness and ephemerality
mapMournQueue
	<inline: #never>
	self objStack: mournQueue do:
		[:i :page| | mourner |
		mourner := self fetchPointer: i ofObject: page.
		(self isNonImmediate: mourner) ifTrue: "someone could try and become weaklings into immediates..."
			[(self isForwarded: mourner) ifTrue:
				[mourner := self followForwarded: mourner].
			 (scavenger isScavengeSurvivor: mourner) ifFalse:
				[mourner := scavenger copyAndForwardMourner: mourner].
			 "we could check for change but writes are cheasp with write buffers..."
			 self storePointerUnchecked: i ofObject: page withValue: mourner]]