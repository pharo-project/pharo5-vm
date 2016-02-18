patching
version: version withPatches: patches for: package
	| snapshot ancestry possibleSpurAncestor actualAncestor |
	snapshot := MCPatcher
					apply: (self patches: patches forSnapshot: version snapshot)
					to: version snapshot.
	ancestry := MCWorkingAncestry new addAncestor: version info.
	"this is a hack; we may not be patching w.r.t. a directory or trunk"
	possibleSpurAncestor := (self spurBranchNameForInfo: version info ancestors first package: package) , '.mcz'.
	(destDir includesKey: possibleSpurAncestor)
		ifTrue:
			[actualAncestor := self versionFor: possibleSpurAncestor in: destDir]
		ifFalse:
			[((self trunk versionNamesForPackageNamed: package name) includes: possibleSpurAncestor) ifTrue:
				[actualAncestor := self trunk versionNamed: possibleSpurAncestor]].
	actualAncestor ifNotNil:
		[ancestry addAncestor: actualAncestor info].
	^MCVersion
		package: version package
		info: (ancestry
				infoWithName: (self spurBranchNameForInfo: version info package: package)
				message:	version info name,
							' patched for Spur by ',
							(CCodeGenerator shortMonticelloDescriptionForClass: self class),
							'\\' withCRs,
							version info message)
		snapshot: snapshot
		dependencies: {} "punt on computing dependencies; there are't any so far"