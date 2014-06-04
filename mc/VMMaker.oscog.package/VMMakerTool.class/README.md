VMMakerTool help information
------------------------------------
If you really get stuck, send mail to the Squeak mailing list, squeak-dev@lists.squeakfoundation.org

	VMMakerTool openInWorld

What this is
--------------
This tool is a simple interactive interface to VMMaker. You can change the directory paths for where the system looks for the platform files (those C files that are handwritten for each platform) and where it will put the assembled sources (the appropriate platform files and generated files) ready for you to compile into a new vm. You can change the platform for which it will generate files. You can choose which plugins are built and whether they are built for internal or external use. 

How to use it
---------------
To build a configuration, drag plugins from the leftmost  'Plugins not built' list to either the 'Internal Plugins' list or the 'External Plugins' list.  Plugins that cannot be built on your machine due to missing files will not be draggable.
Once you have a configuration, you can save it for later retrieval by pressing the 'Save Configuration' button. Unsurprisingly you can reload a saved configuration with the 'Load Configuration' button.

To generate an entire code tree, press the 'Generate All' button. This will process all the vm and plugin files needed for your configuration. To generate only the files for the vm and any internal plugins, use the 'Generate Core VM' button. This will be most useful if you are experimenting with the design of the vm internals or new object memory layouts etc. The 'Generate External Plugins' button will regenerate all the plugins in the External Plugins list. Note that 'excess' directories will be deleted each time you generate the vm in order to reduce potential confusion if you move a plugin from internal to external etc. If you repeatedly generate the vm only the files that appear to be out of date will be recreated; this drastically reduces the time taken if you have only changed a single plugin class for example.

You can also generate internal or external plugins singly, using the menus in the lists but be warned - internal plugins are tightly related to the generated file 'vm/sqNamedPrims.h' and adding or removing an internal plugin without regenerating this (via 'Generate Core VM' or 'Generate All') will cause much grief. The application attempts to prevent this, but there are surely ways to confuse both yourself and the code. In general when writing experimental plugins it is much simpler to build them as external during the development cycle. 

If the default path for the platforms code is not correct for your machine you can use the 'Find Path' button to search for a plausible directory. Note that this could take an arbitrarily long time on a machine with connections to other machines since you may end up searching all their disc space as well.

You can choose from a menu of all known platforms (at least, all those known in the set of files on your machine) by using the 'Find platform' button. This is useful if you want to generate files for some other platform and feel uncertain of the exact spelling. By default the platform will be set to that upon which you are running.

If you feel the need to delete all the generated files you can press the 'Clean out' button - this will recursively delete everything below the path for the generated sources.

Details
-------
You really ought to read the class comment for VMMaker. Really. Go on, do it now.

Errors
-------
A number of errors are possible, mostly relating to the two directory paths and the platform name. As much as possible these are trapped and you will see 'inform' menus to let you know. Inevitably, if you put in the effort, you will be able to confuse the tool and break it.
