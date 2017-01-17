path access
platformsPathText: aText
	"set the path to the platform sources"
	[^vmMaker platformRootDirectoryName: aText asString] on: VMMakerException do:[:ex| self inform:'problem with this directory name; check the path settings, permissions or spelling?'. ex return: false]