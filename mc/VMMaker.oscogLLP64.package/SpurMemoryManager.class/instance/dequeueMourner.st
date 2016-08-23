weakness and ephemerality
dequeueMourner
	"Answer the top mourner (ephemeron or weak array) from the queue or
	 nil if the queue is empty. We don't care about order; ephemerons are
	 fired in an arbitrary order based on where they are in the heap."
	^mournQueue ~= nilObj ifTrue:
		[self popObjStack: mournQueue]