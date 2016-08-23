configurations
loadConfig
	| fileResult file |
	fileResult := (StandardFileMenu oldFileMenu: FileDirectory default withPattern: '*.config')
				startUpWithCaption: 'Select VMMaker configuration...'.
	fileResult
		ifNotNil: [file := fileResult directory fullNameFor: fileResult name.
			[vmMaker := VMMaker forConfigurationFile: file.
			vmMaker logger: logger.
			vmMaker platformDirectory]
				on: Error
				do: [self inform: 'Possible problem with path settings or platform name?'].
			self updateAllViews]