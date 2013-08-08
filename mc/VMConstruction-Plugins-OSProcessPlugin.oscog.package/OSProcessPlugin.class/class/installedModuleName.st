version testing
installedModuleName
	"Answer the module name string for the plugin which is actually running in the VM"

	"OSProcessPlugin installedModuleName"

	^ self concreteClass installedModuleName