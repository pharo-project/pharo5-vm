repository population
updateSpurRepository
	"self new from: 'trunkpackages' to: 'spurpackages'; updateSpurRepository"
	"AndreasSystemProfiler spyOn: [self new from: 'trunkpackages' to: 'spurpackages'; updateSpurRepository]"
	sourceDir assureExistence.
	self download: self class squeak45baseline from: self trunk.
	destDir assureExistence.
	self patchAsNeeded.
	self uploadFrom: (MCDirectoryRepository directory: destDir) to: self spur