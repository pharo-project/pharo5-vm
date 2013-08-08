debug support
checkOkayYoungReferrer: obj
	"Verify that the given obj is a valid youngReferrer. Check RootBit is set and
	 is in rootTable.  Answer true if OK.  Otherwise print reason and answer false.
	 Assumes the object contains young references."

	(self oop: obj isGreaterThanOrEqualTo: youngStart) ifTrue:
		[^true].

	(self isYoungRoot: obj) ifFalse:
		[ self print: 'root bit is not set in '; printHex: obj; cr. ^false ].

	1 to: rootTableCount do:
		[:i| obj = (rootTable at: i) ifTrue: [^true]].

	self printHex: obj; print: ' has root bit set but is not in rootTable'; cr.

	^false
