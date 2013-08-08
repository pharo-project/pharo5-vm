as yet unclassified
extraVMSettings: maker
	| versionC |
	self generateConfigH.
	
	
	"output a fake version.c file"
	
	self write:
'int vm_serial= 1;
char *vm_date= "<HERE IS SUPPOSED TO BE THE DATE>";
char *cc_version= "<HERE IS SUPPOSED TO BE gcc VERSION>";
char *ux_version= "<FAKE FROZEN VERSION FOR DEBUGGING PURPOSES>";
'
	toFile: 'version.c'.
