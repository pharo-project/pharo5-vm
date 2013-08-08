intermediate operations
loadAndDisposeAEDesc: anAEDesc mode: anInteger

	| anOSAID result |
	anOSAID := OSAID new.
	result := self primOSALoad: anAEDesc mode: anInteger to: anOSAID.
	anAEDesc dispose.
	result isZero ifFalse: [^nil].
	^anOSAID