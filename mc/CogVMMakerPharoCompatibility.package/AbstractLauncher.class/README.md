The class AutoStart in combination with the Launcher classes provides a mechanism for starting Squeak from the command line or a web page. Parameters on the command line or in the embed tag in the web page a parsed and stored in the lauchner's parameter dictionary.
Subclasses can access these parameters to determine what to do.

CommandLineLauncherExample provides an example for a command line application. if you start squeak with a command line 'class Integer' it will launch a class browser on class Integer.
To enable this execute
CommandLineLauncherExample activate
before you save the image.
To disable execute
CommandLineLauncherExample deactivate

The PluginLauncher is an example how to use this framework to start Squeak as a browser plugin. It looks for a parameter 'src' which should point to a file containing a squeak script.