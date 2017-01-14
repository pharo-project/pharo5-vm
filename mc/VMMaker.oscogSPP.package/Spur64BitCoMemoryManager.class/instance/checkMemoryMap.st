debug support
checkMemoryMap
	"Override to check that Cog methods are considered neither young nor old.
	 Being young would cause them to be scavenged.
	 Being old would cause them to be remembered if stored into (but wait, they don't get stored into)."

	self assert: (self isYoungObject: newSpaceStart).
	self assert: (self isYoungObject: newSpaceLimit - self wordSize).
	self assert: (self isOldObject: newSpaceStart) not.
	self assert: (self isOldObject: newSpaceLimit - self wordSize) not.
	self assert: (self isYoungObject: newSpaceLimit) not.
	self assert: (self isYoungObject: oldSpaceStart) not.
	self assert: (self isYoungObject: endOfMemory) not.
	self assert: (self isOldObject: oldSpaceStart).
	self assert: (self isOldObject: endOfMemory).

	"we would like the following to be true, but we either choose one boundary check for
	 cogMethods vs objects (isMachineCodeFrame: et al) or one boundary check for
	 copyAndForward:.  We can't have both, and the former is likely the highest dynamic
	 frequency."
	false ifTrue:
		[self assert: (self isYoungObject: cogit minCogMethodAddress) not.
		 self assert: (self isYoungObject: cogit maxCogMethodAddress) not].
	self assert: (self isOldObject: cogit minCogMethodAddress) not.
	self assert: (self isOldObject: cogit maxCogMethodAddress) not