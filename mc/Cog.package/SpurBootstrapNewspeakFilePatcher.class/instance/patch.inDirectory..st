patching
patch: className inDirectory: dir
	"SpurBootstrapNewspeakFilePatcher new
		patch: 'KernelForSqueak'
		inDirectory: '../newspeak'"
	| directory |
	directory := FileDirectory default directoryNamed: dir.
	source := directory oldFileNamed: className, '.ns3'.
	self substitute: self parse.
	self editTo: (directory forceNewFileNamed: className, '.ns3.patched')