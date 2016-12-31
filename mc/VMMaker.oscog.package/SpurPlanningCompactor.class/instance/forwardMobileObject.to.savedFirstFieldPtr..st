private
forwardMobileObject: o to: toFinger savedFirstFieldPtr: savedFirstFieldPtr
	"Forward a mobile object to some new location, saving its first field through savedFirstFieldPtr.
	 Don't use forward:to:; we dont want to alter the object in any way other than by setting the forwarding pointer."
	<inline: true>
	lastMobileObject := o.
	manager
		longAt: savedFirstFieldPtr
			put: (manager fetchPointer: 0 ofObject: o);
		storePointerUnchecked: 0
			ofObject: o
				withValue: ((manager hasOverflowHeader: o)
								ifTrue: [toFinger + manager baseHeaderSize]
								ifFalse: [toFinger]).
	^toFinger + (manager bytesInObject: o)