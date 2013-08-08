ephemerons
processEphemeronsQueue: fullGCFlag

	"process all ephemerons in queue, iterate until none left to be traced(marked)"
	
	<inline: false>
	| eph  somethingWasTraced |
	[
	[ 
		somethingWasTraced := false. 
		eph := ephemeronsQueue. 
		ephemeronsQueue := self nilObject.

		[ eph == self nilObject ] whileFalse: [ | next |
			next := self nextEphemeron: eph.  
			somethingWasTraced := somethingWasTraced or: [ self processEphemeron: eph ].
			eph := next.
		].
		somethingWasTraced 
	] whileTrue: [
		self traceHeapLeftovers: fullGCFlag ].

	" The ephemerons which are left in queue are those which has their keys almost-collectable. 
	Put each of them into their finalization list(s), and then trace all their weak slots"

	eph := ephemeronsQueue.
	ephemeronsQueue := self nilObject.
	[ eph ~~ self nilObject ] whileTrue: [ | next |
		next := self nextEphemeron: eph. 
		self addEphemeronToFinalizationList: eph.
		self traceEphemeronWeakSlots: eph.  
		eph := next.
	].

	"trace things which were hidden, since not all ephemerons were fully traced"
	self traceHeapLeftovers: fullGCFlag.

	"repeat until queue is empty"
	ephemeronsQueue == self nilObject ] whileFalse.

