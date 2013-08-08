documentation
howToInstall

	"OSProcessPlugin about"

	| installedPluginString |
	installedPluginString := self concreteClass installedModuleVersionString.
	^ (installedPluginString isNil
		ifTrue:
			['Your system does not have an installed plugin module. Your current configuration is ']
		ifFalse:
			[(self versionString = installedPluginString)
		ifTrue: ['Your system currently has an installed, up to date plugin module. Your current configuration is ']
		ifFalse: ['Your system currently has an installed plugin module, but its version does not match the OSProcessPlugin change set in your image, so you may wish to rebuild it. Your current configuration is ']]), self installedModule, '.

', self name, ' is a plugin written in Smalltalk. The complete source code for ', self name, ' for your platform is contained in class OSProcessPlugin and its subclasses. No external support code is required. It is intended to be translated to C and compiled as a shared object module (or linked directly with the VM if built as an internal plugin). ', self name, ' has a number of subclasses which allow platform specific methods to be generated for Unix, Linux and Windows platforms. The concrete subclass for your ', self platformName, ' Squeak is ', self concreteClass printString, '.

If OSProcess cannot connect to the operating system ("OSProcess accessor canAccessSystem" evaluates to false), then you need to build and install the ', self name,' plugin.

Use VMMaker to generate the C source code for ', self name, '. The correct ', self name, ' subclass will automatically appear in the list of available modules. VMMaker will create a C source code file called ', self concreteClass moduleName, '.c in the generated source code tree. Compile the plugin according to the instructions provided with your platform source distribution.

If ', self name, ' is built as an external plugin, the C source file will be compiled and linked into a shared module called UnixOSProcessPlugin.so (for Unix or Linux) or Win32OSProcessPlugin.dll (for Windows). If the plugin is built internally, it will be linked directly into the Squeak VM executable. The shared module file should be moved to a place where Squeak can find it (your Squeak home directory is fine). After restarting Squeak, OSProcess will begin functioning with access to the operating system.'