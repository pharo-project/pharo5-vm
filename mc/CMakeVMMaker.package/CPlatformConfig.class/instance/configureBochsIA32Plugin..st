plugin extra rules
configureBochsIA32Plugin: maker

 	maker
		addDefinitions: '-DUSE_BOCHS_CONFIG_H=1';
		includeDirectories: '${topDir}/processors/IA32/bochs/ ${topDir}/processors/IA32/bochs/instrument/stubs/ ${topDir}/processors/IA32/macbochs/';
		
		cmd: 'file' params: 'DOWNLOAD "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD" "${topDir}/processors/IA32/bochs/config.sub" STATUS downloadStatus SHOW_PROGRESS';
		cmd: 'file' params: 'DOWNLOAD "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD" "${topDir}/processors/IA32/bochs/config.guess" STATUS downloadStatus SHOW_PROGRESS';
		
		addDependency: '"${topDir}/processors/IA32/macbochs/bochsconfig.h"';
		addDependency: '"${topDir}/processors/IA32/macbochs/cpu/libcpu.a"';
		addDependency: '"${topDir}/processors/IA32/macbochs/disasm/libdisasm.a"';
		addDependency: '"${topDir}/processors/IA32/macbochs/fpu/libfpu.a"';
		cmd: 'add_custom_command' params: 'OUTPUT "${topDir}/processors/IA32/macbochs/bochsconfig.h" "${topDir}/processors/IA32/macbochs/cpu/libcpu.a" "${topDir}/processors/IA32/macbochs/disasm/libdisasm.a" "${topDir}/processors/IA32/macbochs/fpu/libfpu.a"
		COMMAND ./conf.COG
		COMMAND ../bochs/makeem
		WORKING_DIRECTORY "${topDir}/processors/IA32/macbochs/"
		COMMENT "Building Bochs Library"';
		
		"I don't get why the dummy target is necessary, but otherwise the correct order is not preserved."
		cmd: 'add_custom_target' params: 'bochsconfig DEPENDS "${topDir}/processors/IA32/macbochs/bochsconfig.h"';
		addDependency: 'bochsconfig';
		
		cmd: 'REMOVE_DEFINITIONS' params: '-std=gnu99';
		addCrossSources: #( 'sqBochsIA32Plugin.cpp'  ).
	
	maker vmGenerator
		addExternalLibraries: #('${topDir}/processors/IA32/macbochs/cpu/libcpu.a' '${topDir}/processors/IA32/macbochs/disasm/libdisasm.a' '${topDir}/processors/IA32/macbochs/fpu/libfpu.a')
	

