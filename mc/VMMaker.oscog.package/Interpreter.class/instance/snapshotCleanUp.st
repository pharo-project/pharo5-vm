image save/restore
snapshotCleanUp
	"Clean up right before saving an image, sweeping memory and:
	* nilling out all fields of contexts above the stack pointer. 
	* flushing external primitives 
	* clearing the root bit of any object in the root table "
	| oop header fmt sz |
	oop := self firstObject.
	[self oop: oop isLessThan: endOfMemory]
		whileTrue: [(self isFreeObject: oop)
				ifFalse: [header := self longAt: oop.
					fmt := header >> 8 bitAnd: 15.
					"Clean out context"
					(fmt = 3 and: [self isContextHeader: header])
						ifTrue: [sz := self sizeBitsOf: oop.
							(self lastPointerOf: oop) + self wordSize
								to: sz - self baseHeaderSize by: self wordSize
								do: [:i | self longAt: oop + i put: nilObj]].
					"Clean out external functions"
					fmt >= 12
						ifTrue: ["This is a compiled method"
							(self primitiveIndexOf: oop) = PrimitiveExternalCallIndex
								ifTrue: ["It's primitiveExternalCall"
									self flushExternalPrimitiveOf: oop]]].
			oop := self objectAfter: oop].
	self clearRootsTable