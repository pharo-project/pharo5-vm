directories
setupDirectories: gen
	"same logic as the super has, but use gmake syntax instead of cmake"
	| dirsInclude |

	" write the directories in separate include file"
	dirsInclude := gen captureOutputDuring: [
		gen
			set: #topDir to: ('$(ROOT)/', self topDir fullName); 
			set: #buildDir to: (self buildDir ifNil: ['$(topDir)/build'] ifNotNil: ['$(ROOT)/', self buildDir fullName] );
			set: #platformsDir to: ('$(ROOT)/', self platformsDir);
			set: #srcDir to: ('$(ROOT)/', self srcDir);
			set: #srcPluginsDir to: (pluginsDir ifNil: [ '$(srcDir)/plugins' ]);
			set: #srcVMDir to: '$(srcDir)/vm';
			set: #platformName to: self platformName;
			set: #targetPlatform to: '$(platformsDir)/$(platformName)';
			set: #crossDir to: '$(platformsDir)/Cross';
			set: #platformVMDir to: '$(targetPlatform)/vm'.
	].

	self write: dirsInclude toFile: 'cogdirs.mk'
