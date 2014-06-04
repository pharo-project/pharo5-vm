oop util
bytesOrInt: oop growTo: len 
	"Attention: this method invalidates all oop's! Only newBytes is valid at return."
	| newBytes val class |
	(interpreterProxy isIntegerObject: oop)
		ifTrue: 
			[val := interpreterProxy integerValueOf: oop.
			val < 0
				ifTrue: [class := interpreterProxy classLargeNegativeInteger]
				ifFalse: [class := interpreterProxy classLargePositiveInteger].
			newBytes := interpreterProxy instantiateClass: class indexableSize: len.
			self cCopyIntVal: val toBytes: newBytes]
		ifFalse: [newBytes := self bytes: oop growTo: len].
	^ newBytes