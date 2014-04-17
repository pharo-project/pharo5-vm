image save/restore
snapshotCleanUp
	"Clean up right before saving an image, sweeping memory and:
	* nilling out all fields of contexts above the stack pointer. 
	* flushing external primitives 
	* clearing the root bit of any object in the root table
	* bereaving widowed contexts.
	 By ensuring that all contexts are single in a snapshot (i.e. that no married contexts
	 exist) we can maintain the invariant that a married or widowed context's frame
	 reference (in its sender field) must point into the stack pages since no married or
	 widowed contexts are present from older runs of the system."
	| oop header fmt sz |
	oop := objectMemory firstObject.
	[self oop: oop isLessThan: objectMemory freeStart] whileTrue:
		[(objectMemory isFreeObject: oop) ifFalse:
			[header := self longAt: oop.
			 fmt := objectMemory formatOfHeader: header.
			 "Clean out context"
			 (fmt = 3 and: [objectMemory isContextHeader: header]) ifTrue:
				["All contexts have been divorced. Bereave remaining widows."
				 (self isMarriedOrWidowedContext: oop) ifTrue:
					[self markContextAsDead: oop].
				 sz := objectMemory sizeBitsOf: oop.
				 (objectMemory lastPointerOf: oop) + BytesPerWord
				 to: sz - BaseHeaderSize by: BytesPerWord
				 do: [:i | self longAt: oop + i put: objectMemory nilObject]].
			 "Clean out external functions"
			 fmt >= 12 ifTrue:
				["This is a compiled method"
				 (self primitiveIndexOf: oop) = PrimitiveExternalCallIndex ifTrue:
					["Its primitiveExternalCall"
					 self flushExternalPrimitiveOf: oop]]].
			oop := objectMemory objectAfter: oop].
	objectMemory clearRootsTable