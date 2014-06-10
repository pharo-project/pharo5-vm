patching
patchPackage: packageFileName with: patches for: package
	| version newVersion |
	version := self versionFor: packageFileName.
	newVersion := self version: version withPatches: patches for: package.
	self storeVersion: newVersion