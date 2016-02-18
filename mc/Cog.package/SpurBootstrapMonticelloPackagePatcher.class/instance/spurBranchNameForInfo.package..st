patching
spurBranchNameForInfo: versionInfoOrString package: package
	^(versionInfoOrString isString
		ifTrue: [versionInfoOrString]
		ifFalse: [versionInfoOrString name]) copyReplaceAll: package name with: package name, '.spur'