I serve as a facade to ease building standard Pharo VM

i encapsulating all the details (defaults), from all configurations over all major platforms.

To generate sources & cmake files , issue:

	PharoVMBuilder build.

Or, if you want to generate everything for particular platform, use one of:

	PharoVMBuilder buildWin32 / buildUnix32 / buildMacOSX32.

For use by jenkins server script, there is:

	PharoVMBuilder buildOnJenkins: 'platformName'

where platformName string can be one of: 'win' / 'mac' / 'linux'