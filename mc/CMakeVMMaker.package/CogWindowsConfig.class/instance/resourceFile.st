resources
resourceFile

	^ self resourceFileTemplate
		copyReplaceAll: '@ICON@' with: self iconFileName