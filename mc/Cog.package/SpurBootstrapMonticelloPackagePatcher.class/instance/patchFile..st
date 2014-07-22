patching
patchFile: packageFile
	"(SpurBootstrapMonticelloPackagePatcher new
			from: '/Users/eliot/oscogvm/image/package-cache'
			to: '/Users/eliot/oscogvm/image/spurpackages')
		patchFile: 'Collections-ul.573(nice.572).mcd'"
	
	sourceDir exists ifFalse:
		[self error: 'source directory doest not exist'].
	destDir assureExistence.
	self packagesAndPatches keysAndValuesDo:
		[:package :patches|
		 ((packageFile beginsWith: package name)
		  and: [(packageFile at: package name size + 1) isLetter not]) ifTrue:
			[self patchPackage: packageFile with: patches for: package]]