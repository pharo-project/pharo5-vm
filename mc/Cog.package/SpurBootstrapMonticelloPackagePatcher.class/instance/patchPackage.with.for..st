patching
patchPackage: packageFileName with: patches for: package
	| version newVersion |
	version := self versionFor: packageFileName in: sourceDir.
	newVersion := self version: version withPatches: patches for: package.
	self storeVersion: newVersion