object access primitives
primitiveObjectAt
	(self stackValue: 1) = 16r1148000 ifTrue: [self halt].
	^super primitiveObjectAt