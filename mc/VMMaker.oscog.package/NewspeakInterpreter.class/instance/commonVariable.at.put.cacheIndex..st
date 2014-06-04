indexing primitive support
commonVariable: rcvr at: index put: value cacheIndex: atIx
	"This code assumes the receiver has been identified at location atIx in the atCache."
	"It also assumes that all immutability checking has been done by the caller."
	| stSize fmt fixedFields valToPut |
	<inline: true>

	stSize := atCache at: atIx+AtCacheSize.
	((self cCoerce: index to: 'usqInt ') >= 1
		and: [(self cCoerce: index to: 'usqInt ') <= (self cCoerce: stSize to: 'usqInt ')])
	ifTrue:
		[fmt := atCache at: atIx+AtCacheFmt.
		fmt <= 4 ifTrue:
			[fixedFields := atCache at: atIx+AtCacheFixedFields.
			^ self storePointer: index + fixedFields - 1 ofObject: rcvr withValue: value].
		fmt < 8 ifTrue:  "Bitmap"
			[valToPut := self positive32BitValueOf: value.
			self successful ifTrue:
				[^self storeLong32: index - 1 ofObject: rcvr withValue: valToPut].
			^ self primitiveFailFor: PrimErrBadArgument].
		fmt >= 16  "Note fmt >= 16 is an artificial flag for strings"
			ifTrue: [valToPut := self asciiOfCharacter: value.
					self successful ifFalse: [^ self primitiveFailFor: PrimErrBadArgument]]
			ifFalse: [valToPut := value].
		(self isIntegerObject: valToPut) ifTrue:
			[valToPut := self integerValueOf: valToPut.
			((valToPut >= 0) and: [valToPut <= 255]) ifFalse:
				[^ self primitiveFailFor: PrimErrBadArgument].
			^ self storeByte: index - 1 ofObject: rcvr withValue: valToPut].
		^self primitiveFailFor: PrimErrInappropriate].

	^self primitiveFailFor: ((self formatOf: rcvr) <= 1
								ifTrue: [PrimErrBadReceiver]
								ifFalse: [PrimErrBadIndex])