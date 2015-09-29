*Cog-method prototypes
WeakRegistryPROTOTYPEadd: anObject executor: anExecutor
	self protected: [ | finItem |
		finItem := valueDictionary 
			at: anObject 
			ifAbsentPut: [ WeakFinalizerItem new list: list object: anObject ].
		finItem add: anExecutor ].
	^ anObject