become api
become: array1 with: array2 twoWay: twoWayFlag copyHash: copyHashFlag

	"(thisContext findContextSuchThat: [:c| c selector == #rehashImage]) ifNotNil:
		[:ctxt|
		(((ctxt tempAt: 4) at: 1) = 108
		 and: [(ctxt tempAt: 2) byteCount = 553985]) ifTrue: [self halt]]."
	^super become: array1 with: array2 twoWay: twoWayFlag copyHash: copyHashFlag