image save/restore
snapshotCleanUp
	"Clean up right before saving an image, garbage collecting, sweeping memory and:
	* nilling out all fields of contexts above the stack pointer. 
	* flushing external primitives 
	* clearing the root bit of any object in the root table
	* bereaving widowed contexts.
	 By ensuring that all contexts are single in a snapshot (i.e. that no married contexts
	 exist) we can maintain the invariant that a married or widowed context's frame
	 reference (in its sender field) must point into the stack pages since no married or
	 widowed contexts are present from older runs of the system."

	objectMemory hasSpurMemoryManagerAPI
		ifTrue: [objectMemory flushNewSpace]
		ifFalse: [objectMemory incrementalGC].	"compact memory and compute the size of the memory actually in use"

	"maximimize space for forwarding table"
	objectMemory fullGC.

	objectMemory allObjectsDo:
		[:obj| | header fmt sz |
		 header := self longAt: obj.
		 fmt := objectMemory formatOfHeader: header.
		 "Clean out context"
		 (fmt = objectMemory indexablePointersFormat
		  and: [objectMemory isContextHeader: header]) ifTrue:
			["All contexts have been divorced. Bereave remaining widows."
			 (self isMarriedOrWidowedContext: obj) ifTrue:
				[self markContextAsDead: obj].
			 "Fill slots beyond top of stack with nil"
			 (self fetchStackPointerOf: obj) to: (objectMemory numSlotsOf: obj) do:
				[:i | objectMemory
						storePointerUnchecked: i + CtxtTempFrameStart
						ofObject: obj
						withValue: objectMemory nilObject]].
		 "Clean out external functions from compiled methods"
		 fmt >= objectMemory firstCompiledMethodFormat ifTrue:
			["Its primitiveExternalCall"
			 (self primitiveIndexOf: obj) = PrimitiveExternalCallIndex ifTrue:
				[self flushExternalPrimitiveOf: obj]]].

	objectMemory hasSpurMemoryManagerAPI ifFalse:
		[objectMemory clearRootsTable]