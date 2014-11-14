I serve as a facade to ease building standard Pharo VM with Spur memory manager
I encapsulate all the details (defaults), from all configurations over all major platforms.

To generate sources & cmake files , issue:

	PharoVMSpur32Builder build.

Or, if you want to generate everything for particular platform, use one of:

	PharoVMSpur32Builder buildWin32 / buildUnix32 / buildMacOSX32.

For use by jenkins server script, there is:

	PharoVMSpur32Builder buildOnJenkins: 'platformName'

where platformName string can be one of: 'win' / 'mac' / 'linux'