ephemerons
processEphemeron: oop
	"
		At this point, we only tracing value slot(s) if ephemeron's key slot is marked.
		If ephemeron's key not yet marked, then we add it again to queue, in hope that some other ephemerons
		residing in queue could reach the key slot through their (possibly indirect) references.
	
		Note,  ephemerons with key == nil never placed to queue, so we don't need to do check it here (see #lastPointerOfEphemeron:nonWeakFields:)
	"

	| keyOffset key |

	keyOffset := self ephemeronKeyOffset: oop. 
	key := self longAt:  oop + keyOffset.
	
	(self alreadyMarked: key) ifTrue: [
		self unlinkEphemeron: oop. "scrath the 'next' slot, so ephemeron will not point to another unrelated ephemeron "
		self traceEphemeronWeakSlots: oop.  "trace the all weak slots"
		^ true
	].
	
	"otherwise we don't know yet. Add ephemeron to ephemerons queue again. "	
	self queueEphemeron: oop.
	^ false 