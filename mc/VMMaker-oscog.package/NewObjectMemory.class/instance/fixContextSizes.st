initialization
fixContextSizes
	"Correct context sizes at start-up."
	| numBadContexts obj oop map delta hdr len i methodContextProtoIndex methodContextProto |
	<var: #map type: #'sqInt *'>
	methodContextProto := self splObj: (methodContextProtoIndex := 35).
	((self isContext: methodContextProto)
	 and: [self badContextSize: methodContextProto]) ifTrue:
		[self splObj: methodContextProtoIndex put: nilObj.
		 "If it is unreferenced except here; nuke it, otherwise resize it"
		 (self numReferencesTo: methodContextProto) = 0 ifTrue:
			[self freeObject: methodContextProto]].
	"Count the number of bad contexts"
	numBadContexts := 0.
	obj := self firstObject.
	[obj < freeStart] whileTrue:
		[((self isFreeObject: obj) not
		   and: [(self isContextNonInt: obj)
		   and: [self badContextSize: obj]]) ifTrue:
			[numBadContexts := numBadContexts + 1].
		 obj := self objectAfter: obj].
	numBadContexts = 0 ifTrue:
		[^self].
	"Allocate a map of pairs of context obj and how much it has to move."
	map := self cCode: [self malloc: numBadContexts + 1 * 2 * BytesPerOop]
				inSmalltalk: [CArrayAccessor on: (Array new: numBadContexts + 1 * 2)].
	"compute the map"
	numBadContexts := 0.
	delta := 0.
	obj := self firstObject.
	[obj < freeStart] whileTrue:
		[((self isFreeObject: obj) not
		   and: [(self isContextNonInt: obj)
		   and: [self badContextSize: obj]]) ifTrue:
			[delta := ((self byteLengthOf: obj) > SmallContextSize
						ifTrue: [LargeContextSize]
						ifFalse: [SmallContextSize]) - (self byteLengthOf: obj).
			 map at: numBadContexts put: (self objectAfter: obj).
			 numBadContexts = 0
				ifTrue: [map at: numBadContexts + 1 put: delta]
				ifFalse: [map at: numBadContexts + 1 put: delta + (map at: numBadContexts - 1)].
			numBadContexts := numBadContexts + 2].
		 obj := self objectAfter: obj].
	"block-move the segments to make room for the resized contexts"
	map at: numBadContexts put: freeStart.
	self assert: freeStart = youngStart. "designed to be run at startup"
	freeStart := freeStart + (map at: numBadContexts - 1).
	youngStart := freeStart.
	[(numBadContexts := numBadContexts - 2) >= 0] whileTrue:
		[obj := map at: numBadContexts.
		 oop := map at: numBadContexts + 2.
		 self mem:	"dest" obj + (map at: numBadContexts + 1)
			  mo: 	"src" obj
			  ve:	"len" oop - obj].
	"now fix-up objs, resizing wrongly-sized contexts along the way."
	obj := self firstObject.
	[obj < freeStart] whileTrue:
		[(self isFreeObject: obj) not ifTrue:
			[((self isContextNonInt: obj)
			   and: [self badContextSize: obj]) ifTrue:
				[hdr := self baseHeader: obj.
				 len := (hdr bitAnd: SizeMask) > SmallContextSize ifTrue: [LargeContextSize] ifFalse: [SmallContextSize].
				 self baseHeader: obj put: ((hdr bitClear: SizeMask) bitOr: len).
				 "now check the enumeration"
				 oop := self objectAfter: obj.
				 self assert: oop <= freeStart.
				 numBadContexts := 0.
				 [oop > (map at: numBadContexts)] whileTrue:
					[numBadContexts := numBadContexts + 2].
				 self assert: oop = ((map at: numBadContexts) + (map at: numBadContexts + 1))].
			(self headerType: obj) ~= HeaderTypeShort ifTrue: "see remapClassOf:"
				[oop := (hdr := self longAt: obj - BytesPerWord) bitAnd: AllButTypeMask.
				 oop >= (map at: 0) ifTrue:
					[numBadContexts := 2.
					 [oop >= (map at: numBadContexts)] whileTrue:
						[numBadContexts := numBadContexts + 2].
					 hdr := oop + (map at: numBadContexts - 1) + (hdr bitAnd: TypeMask).
					 self longAt: obj - BytesPerWord put: hdr]].
			((self isPointersNonInt: obj) or: [self isCompiledMethod: obj]) ifTrue:
				[(self isCompiledMethod: obj)
					ifTrue:
						[i := self literalCountOf: obj]
					ifFalse:
						[(self isContextNonInt: obj)
							ifTrue: [i := CtxtTempFrameStart + (coInterpreter fetchStackPointerOf: obj)]
							ifFalse: [i := self lengthOf: obj]].
				[(i := i - 1) >= 0] whileTrue:
					[oop := self fetchPointer: i ofObject: obj.
					 ((self isNonIntegerObject: oop)
					  and: [oop >= (map at: 0)]) ifTrue:
						[numBadContexts := 2.
						 [oop >= (map at: numBadContexts)] whileTrue:
							[numBadContexts := numBadContexts + 2].
						 self storePointerUnchecked: i ofObject: obj withValue: oop + (map at: numBadContexts - 1)]]]].
		 obj := self objectAfter: obj].
	self clearLeakMapAndMapAccessibleObjects.
	(self asserta: self checkHeapIntegrity) ifFalse:
		[self error: 'failed to resize contexts correctly']