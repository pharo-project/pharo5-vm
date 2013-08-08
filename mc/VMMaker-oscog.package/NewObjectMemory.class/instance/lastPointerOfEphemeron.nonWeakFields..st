ephemerons
lastPointerOfEphemeron: oop nonWeakFields: nonWeakCnt
 "
	The ephemeron has a following layout: 
	
		list next ... [ value1 ... valueN key ]

	the slots in [] are variable slots, which inherited from weak object format.
	There could be zero or more value slots and additional last one is a key, which is used to trigger ephemeron's logic.
	
	If at current point, ephemeron's key already marked, then ephemeron behaves as an object with all slots
	having strong references.
	If ephemeron's key are not yet marked, it is put into special queue, which will be processed later at the end of mark phase,
	while at current point, only fixed slots of ephemeron will be traced.
	If ephemeron's key is nil, then all value slots are processed as a weak references (won't be traced)

	"
	<inline: false >
	| keyOffset key |


	keyOffset := self ephemeronKeyOffset: oop.

	key := self longAt: oop + keyOffset.

	key == self nilObject ifTrue: [
		"Do not trace the value fields"
		^nonWeakCnt << ShiftForWord
	].

	(self alreadyMarked: key) ifTrue: [
		^ keyOffset - BytesPerWord  "proceed with tracing all value slots as strong references"
		].

	"if ephemeron is already reported as an almost-collectable  (placed in its finalization list), but not yet handled by image, we should trace all its slots a strong references"
	(self isReportedEphemeron: oop) ifTrue: [ ^ keyOffset ].

	"otherwise we don't know yet. Add ephemeron to ephemerons queue. "	
	self queueEphemeron: oop.

	"trace only fixed slots"
	^nonWeakCnt << ShiftForWord
	