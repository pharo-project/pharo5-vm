patching
version: version withPatches: patches for: package
	| snapshot ancestry |
	snapshot := MCPatcher
					apply: (self patchForPackage: package withPatches: patches snapshot: version snapshot)
					to: version snapshot.
	ancestry := MCWorkingAncestry new addAncestor: version info.
	^MCVersion
		package: version package
		info: (ancestry
				infoWithName: version info name
				message:	version info name,
							' patched for Spur by ',
							(CCodeGenerator shortMonticelloDescriptionForClass: self class),
							'\\' withCRs,
							version info message)
		snapshot: snapshot
		dependencies: {} "punt on computing dependencies; there are't any so far"
