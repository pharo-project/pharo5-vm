configurations
saveConfig

	"write info about the current configuration to a file."
	| fileResult file |
	fileResult := (StandardFileMenu newFileMenu: FileDirectory default withPattern: '*.config')
		startUpWithCaption: 'Save VMMaker configuration...'.
	fileResult ifNotNil: [
		('*.config' match: fileResult name)
			ifFalse: [fileResult name: (fileResult name, '.config')].
		file := fileResult directory fullNameFor: fileResult name.
		vmMaker saveConfigurationTo: file].
