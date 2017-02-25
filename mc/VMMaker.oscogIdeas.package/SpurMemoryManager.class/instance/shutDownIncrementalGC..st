gc - incremental
shutDownIncrementalGC: objectsShouldBeUnmarked
	"If the incremental collector is running mark bits may be set; stop it and clear them if necessary."
	self flag: 'need to implement the inc GC first...'.
	objectsShouldBeUnmarked ifTrue:
		[self assert: self allObjectsUnmarked]