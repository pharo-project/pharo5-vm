Base class, defining some common properties and behavior for all kinds of VM build configurations. These classes are used to generate the VM sources and the CMMake files. 

Notice that this configuration classes expect that you have download the "platofroms code" which is in Gitorious: https://gitorious.org/cogvm
You can load it executing: git clone git://gitorious.org/cogvm/blessed.git

Once that is done it should have created a directory /blessed. In order to get all the directories by default, place this image under /blessed/image 

To generate a sources/build configuration use one of my subclasses with:
<config> generate.   - to generate a build configuration
<config> generateWithSources - to generate VMMaker sources and then build configuration.

Once you do that, go to /blessed/build and execute:  cmake .    or cmake -G"MSYS Makefiles" if you are in Windows 

Since some plugins require extra settings (like additional source files etc), there is two ways to add that:

- add custom rules on plugin class side:

PluginClass>>generateFor: aCMakeVMGenerator internal: aBoolean 

	^ aCMakeVMGenerator 
		generatePlugin: self 
		internal: aBoolean
		extraRules: [:maker |   ... your rules come here ... ]
		
- define rules by adding #configure<PluginClass>: method in config class (see my 'plugin extra rules' category)

The last one is more compact and also avoids inter-package dependency, so you can load and use
CMakeVMMaker even if some 3rd-party plugins are not loaded into image.


Links of interest:

Official Cog Website: http://www.mirandabanda.org/cog
Official Cog Blog: http://www.mirandabanda.org/cogblog
Cog issue tracker: http://code.google.com/p/cog
Cog Wiki: http://code.google.com/p/cog/w/list
Cog binaries: http://www.mirandabanda.org/files/Cog/VM
Cog binaries in Pharo Hudson server: https://pharo-ic.lille.inria.fr/hudson/view/Cog
Cog SVN branch: http://squeakvm.org/svn/squeak/branches/Cog
VM mailing list: http://lists.squeakfoundation.org/mailman/listinfo/vm-dev
VM-beginners mailing list: http://lists.squeakfoundation.org/mailman/listinfo/vm-beginners
Guide step by step about how to build the Cog VM using CMakeVMMaker and Git: http://code.google.com/p/cog/wiki/Guide



