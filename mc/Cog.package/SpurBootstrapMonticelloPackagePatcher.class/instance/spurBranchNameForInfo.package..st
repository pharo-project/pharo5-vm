patching
spurBranchNameForInfo: versionInfo package: package
	^versionInfo name copyReplaceAll: package name with: package name, '.spur'