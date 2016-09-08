initialisation
initialize
	"VMMaker initialize"
	DirNames := Dictionary new.
	DirNames
		at: #coreVMDir put: 'vm';
		at: #platformsDir put: 'platforms';
		at: #pluginsDir put: 'plugins';
		at: #sourceDir put: 'src'.

	"Try and decide where the Cog source tree is.  Two configurations are likely.
	 One is that the VMMaker image is running in the image directory in the
	 source tree and hence everything will be at '..'.
	 Another is where the source tree is at the same level as the VMMaker image,
	 in which case it is likely called oscogvm or Cog."
	#('../platforms' 'oscogvm/platforms' 'Cog/platforms' '../oscogvm/platforms')
		with: #('..' 'oscogvm' 'Cog' '../oscogvm')
		do: [:dir :path|
			(FileDirectory default directoryExists: dir) ifTrue:
				[DirNames at: #sourceTree put: path.
				 ^self]]