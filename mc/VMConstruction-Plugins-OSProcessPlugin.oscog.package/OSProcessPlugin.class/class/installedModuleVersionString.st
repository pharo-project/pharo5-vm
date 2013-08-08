version testing
installedModuleVersionString
	"Answer the version string for the plugin which is actually running in the VM"

	"OSProcessPlugin installedModuleVersionString"

	^ self concreteClass installedModuleVersionString