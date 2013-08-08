This class builds a VM codebase from the in-image and on-file code.

The platforms file tree you need can be downloaded via cvs from http://squeak.Sourceforge.net. See also the swiki (http://minnow.cc.gatech.edu/squeak/2106) for instructions.

It is fairly configurable as to where directories live and can handle multiple platform's source trees at once. It's main purpose is to allow easy building of source trees with any combination of internal/external/unused plugins to suit your platform needs and capabilities. For example, the Acorn has no need of Sound or AsynchFile plugins since I haven't written any platform code for them. 

There is a simple UI tool for this 
	VMMakerTool openInWorld
will open a reasonably self explanatory tool with balloon help to explain all the fields - and a help window on top of that.

There are some simple workspace & inspector commands, allowing scripted building:
	VMMaker default initializeAllExternal generateEntire
for example will build sources for a system with all the plugins external whereas 
	VMMaker default initializeAllInternal generateEntire
would build all applicable plugins for internal compilation.
	(VMMaker forPlatform: 'Mac OS') initializeAllExternal generateEntire
would build a source tree for a Mac even on a Windows machine (err, ignoring for now the irritation of lineends).

	If you have a slightly more complex configuration you want to use, perhaps with Socket and Serial support external (because for your case they are rarely used and saving the space has some value) then you could try
		(VMMaker default initializeAllInternalBut: #(SocketPlugin SerialPlugin) generateEntire
	More complex still would be
		(VMMaker default initializeInternal: #(BitBltPlugin MiscPrimsPlugin FilePlugin) external: #(SocketPlugin ZipPlugin B2DPlugin)
which allows you to precisely list all the plugins to use.

WARNING If you miss out a plugin you need, it won't be there. This message is really best suited to use by a UI like VMMakerTool.

	To save a configuration for later use, you need to send #saveConfiguration to an active instance of VMMaker. Obviously you could simply use
		(VMMaker default initializeAllInternalBut: #(SocketPlugin SerialPlugin) saveConfiguration
but inspecting 
		VMMaker default
and altering the internalPlugins and externalPlugins or the boolean flags for inline or forBrowser followed by saving the configuration allows ultimate power for now. To load a saved configuration file, use #loadConfigurationFrom: aFilename whilst inspecting a VMMaker. The loaded state will completely override any pre-existing state, so take care.
	You can generate only parts of the source tree if you wish; as shown above #generateEntire will create the whole collection of internal and external plugins as well as the core VM. To create only  the external plugins use #generateExternalPlugins, or create a single  plugin with #generateExternalPlugin: name. To assemble the main VM including the internal plugins, use #generateMainVM. The interpreter 'interp.c' file is made with #generateInterpreterFile. You can generate a single internal plugin with #generateInternalPlugin: only if it has already been generated before; this interlocking is intended to make sure the named primitive table in the vm is correct.

There are some rules to observe in order to use this:-
- under the working directory (by default - you can configure it) you need a directory called 'platforms' (also configurable) with subdirectories named as the platform names returned by Smalltalk platformName (ie unix, RiscOS, Mac OS, etc - this isn't configurable). At the very least you need the one for your own platform and the pseudo-platform called 'Cross'. By adding a 'DirNames' entry for #machineType you can cross 'compile' for some other platform. Now all we need is a cross-compiler for the C code :-)
- under this directory you must have a simple structure of directories for each generated plugin that you support on the platform, plus 'vm'. In each directory you place any/all platform specific files (and subdirectories) for that plugin. In 'misc' you can place any miscellaneous files such as makefiles, resources etc. For example, for unix you have
	platforms/
		unix/
			plugins/
				AsynchFilePlugin /
					sqUnixAsynchfile.c
			vm/
				sqGnu.h
				Profile/
			misc/
				makefile.in
				util/
				
				...etc
Any plugins requiring platform files that you don't support shouldn't appear in the resulting code tree. If you try to include an unsupported plugin in the list to be made external, the VMMaker simply ignores it. However, if you include it in the list to be made internal you will get an error since that seems like a potentially serious source of confusion.

There are three lists of plugins maintained herein:-
1) the list of all known generatable plugins. We scan this list and compare with the supported plugins as indicated by the file tree.
2) the list of chosen internal plugins.
3) the list of chosen external plugins.
See initializeAllPlugins, initialiseAllExternal etc for fairly obvious usage.
There is also a short list of directory names in the class variable 'DirNames' that you can alter if needed.

Known problems:-
a) since Squeak has really poor filename handling, you can't simply change the directory names to '/foo/bar/myEvilCodeBase' and expect it to work. You fix file names and I'll fix VMMaker :-)
b) Squeak copying of a file loses the assorted permissions, filetype info and other useful bits. To workaround this problem, see the FileCopyPlugin, which provides the platform independent part of a simple access for the OS filecopy capability. So far there are functional plugins for unix, Mac and Acorn. DOS machines appear not to need one. This is less of a problem in practise now that unix, Acorn & Mac no longer copy files from /platforms to /src.

inline <Boolean> - is the generated code to be inlined or not
forBrowser <Boolean> - is this to be a build for in-Browser use? Only relevent to Macs
allPlugins <Collection> - all the known possible plugins
internalPlugins <Collection> - the plugins chosen to be generated for internal linking
externalPlugins <Collection> - the plugins intended to be external plugins
exportList <Collection> - a list of function names exported from plugins intended to be internal
platformName <String> - the name of the platform for which we are building a source tree. It is possible to do 'cross-compiles'
sourceDirName, platformRootDirName <String> - the name of the directory into which we write the generated sources and the name of the directory where we should find the platforms tree.