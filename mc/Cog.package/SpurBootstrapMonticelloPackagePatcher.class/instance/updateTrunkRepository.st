repository population
updateTrunkRepository
	"Download all the Collections, Kernel and System packages from trunk into srcDir,
	 patch them into destDir,
	 upload the patched and branched files that aren't already in trunk to trunk."
	"self new from: 'trunkpackages' to: 'spurpackages'; updateTrunkRepository"
	"AndreasSystemProfiler spyOn: [self new from: 'trunkpackages' to: 'spurpackages'; updateSpurRepository]"
	sourceDir assureExistence.
	self download: self class squeak45baseline from: self trunk.
	destDir assureExistence.
	self patchAsNeeded.
	self uploadFrom: (MCDirectoryRepository directory: destDir) to: self trunk