debugging traps
noteAsRoot: oop headerLoc: headerLoc
	"Trap attempts to make cog methods roots."
	self assert: oop >= self startOfMemory.
	^super noteAsRoot: oop headerLoc: headerLoc