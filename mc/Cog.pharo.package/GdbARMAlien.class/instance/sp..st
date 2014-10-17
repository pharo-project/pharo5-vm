accessing
sp: anUnsignedInteger
Transcript nextPutAll: 'set SP to ', anUnsignedInteger hex; cr.
	^self unsignedLongAt: 65 put: anUnsignedInteger