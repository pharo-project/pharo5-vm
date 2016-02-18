patching
patch
	"(SpurBootstrapMonticelloPackagePatcher new
			from: 'trunkpackages'
			to: 'spurpackages')
		patch"
	"(SpurBootstrapMonticelloPackagePatcher new
			from: '/Users/eliot/Squeak/Squeak4.5-spur/squeakv3-package-cache'
			to: '/Users/eliot/Squeak/Squeak4.5-spur/package-cache')
		patch"
	"(SpurBootstrapMonticelloPackagePatcher new
			from: '/Users/eliot/Glue/repositories/nsboot/Squeak4.3/squeak-package-cache'
			to: '/Users/eliot/Glue/repositories/nsboot/Squeak4.3/package-cache')
		patch"
	
	sourceDir exists ifFalse:
		[self error: 'source directory doest not exist'].
	destDir assureExistence.
	self packagesAndPatches keysAndValuesDo:
		[:package :patches|
		 (self filesForPackage: package in: sourceDir) do:
			[:packageFile|
			 self patchPackage: packageFile with: patches for: package]]