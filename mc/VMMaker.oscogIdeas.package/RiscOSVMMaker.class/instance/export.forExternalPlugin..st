generate sources
export: exportList forExternalPlugin: aPlugin
"it may be useful on certain platforms to do something with the export list of external plugins, just as the internal plugins' exports get added to the VM list. Default is to do nothing though."
"For RiscOS using the 'rink' external linker each plugin needs a 'dsc' file that looks like
id:SqueakSO
main_version:100
code_version:001

entries:
//
named_entries:
getModuleName
//
with all the exported names in the list. We also need a '/o' directory for the object files"

	"open a file called plugindir/pluginname.dsc and write into it"
	| f fd dfd |
	fd := self externalPluginsDirectoryFor: aPlugin.

	"If we get an error to do with opening the .dsc file, we need to raise an application error to suit"
	[(fd directoryExists: 'dsc') ifFalse:[fd createDirectory: 'dsc'].
	dfd := fd directoryNamed: 'dsc'.
	f := VMMaker forceNewFileNamed: (dfd fullNameFor: aPlugin moduleName)] on: FileStreamException do:[^self couldNotOpenFile: (dfd fullNameFor: aPlugin moduleName)].

	f nextPutAll: 'id:SqueakSO
main_version:100
code_version:001

entries:
//
named_entries:
'.
	exportList do:[:el|
		f nextPutAll: el.
		f cr].
	f nextPutAll: '//'; cr.
	f close.
	(fd directoryNamed: 'o') assureExistence
