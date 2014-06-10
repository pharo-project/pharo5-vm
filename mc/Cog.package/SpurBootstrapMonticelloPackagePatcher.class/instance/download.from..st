repository population
download: baseConfigurationOrArray "<MCConfiguration|Array>" from: repo
	| base |
	base := baseConfigurationOrArray isArray
				ifTrue: [MCConfiguration fromArray: baseConfigurationOrArray]
				ifFalse: [baseConfigurationOrArray].
	self packagesAndPatches keysAndValuesDo:
		[:package :patches| | dependency |
		dependency := base dependencies detect: [:dep| dep package name = package name].
		self downloadToSourceDirAllPackageVersionsStartingWith: dependency versionInfo
			from: repo].