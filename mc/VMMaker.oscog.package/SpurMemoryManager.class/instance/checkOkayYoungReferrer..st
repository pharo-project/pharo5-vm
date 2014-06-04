debug support
checkOkayYoungReferrer: obj
	"Verify that the given obj is a valid youngReferrer. Check remembered is set and
	 is in remembered set.  Answer true if OK.  Otherwise print reason and answer false.
	 Assumes the object contains young references."

	(self oop: obj isLessThan: newSpaceLimit) ifTrue:
		[^true].

	(self isRemembered: obj) ifFalse:
		[ self print: 'remembered bit is not set in '; printHex: obj; cr. ^false ].

	(scavenger isInRememberedSet: obj) ifTrue: [^true].

	self printHex: obj; print: ' has remembered bit set but is not in remembered set'; cr.

	^false
