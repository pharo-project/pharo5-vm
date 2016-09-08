baseline
baseline: spec
	<baseline>
	spec
		for: #'common'
      do: 
		[ spec 
			package: 'FileSystem-Legacy' with: [ 
				spec repository: 'http://smalltalkhub.com/mc/PharoExtras/FileSystemLegacy/main' ];
			package: 'FFI-Pools';
			package: 'SharedPool-Speech';
			package: 'Balloon-Engine-Pools';
			package: 'Sound';
			"package: 'Alien-Core';"
			package: 'VMMaker' with: [ 
				spec 
					file: 'VMMaker';
					requires: #('FileSystem-Legacy' 'SharedPool-Speech' 'FFI-Pools' 'Balloon-Engine-Pools' 'Sound' "'Alien-Core'") ];
			package: 'Cog' with: [ spec requires: #('VMMaker' ) ];
			package: 'ImageFormat' with: [ spec requires: #('VMMaker' ) ];
			package: 'MethodMassage' with: [ spec requires: #('VMMaker' ) ];
			package: 'MethodMassageCompatibility' with: [ spec requires: #('VMMaker' ) ];
			package: 'Qwaq-VMProfiling-Plugins' with: [ spec requires: #('VMMaker' ) ];
			package: 'VMConstruction-Plugins-AioPlugin' with: [ spec requires: #('VMMaker') ];
			package: 'VMConstruction-Plugins-OSProcessPlugin' with: [ 
				spec 
					file: 'VMConstruction-Plugins-OSProcessPlugin.oscog';
					requires: #('VMMaker' 'VMConstruction-Plugins-AioPlugin') ];
			package: 'Freetype-Plugin' with: [ spec requires: #('VMMaker') ];
			package: 'ObjectiveC-Plugin' with: [ spec requires: #('VMMaker') ];
			package: 'Applescript-Core' with: [ spec requires: #('VMMaker') ];
			package: 'CryptographyPlugins' with: [ spec requires: #('VMMaker') ];
			package: 'SDL2DisplayPlugin' with: [ spec requires: #('VMMaker') ];
			package: 'EventsHandlerPlugin' with: [ spec requires: #('VMMaker') ];
			package: 'CMakeVMMaker' with: [ spec requires: #('Cog') ];
			package: 'SpurVMMaker' with: [ spec requires: #('Cog') ].				

		spec 
			group: 'default' with: 'all';
			group: 'all' with: #('maker' 'plugins' 'builders');
			group: 'builders' with: #('CMakeVMMaker');
			group: 'maker' with: #('VMMaker' 'Cog' 'ImageFormat' 'MethodMassage' 'MethodMassageCompatibility');
			group: 'plugins' with: #(
				'VMConstruction-Plugins-AioPlugin' 
				'VMConstruction-Plugins-OSProcessPlugin' 
				'Qwaq-VMProfiling-Plugins' 
				'Freetype-Plugin'
				'ObjectiveC-Plugin'
				'Applescript-Core'
				'CryptographyPlugins') ].
		
		spec for: #pharo do: [		
			spec 
				package: 'CogVMMakerPharoCompatibility';
				package: 'SpurVMMakerPharoCompatibility' with: [ 
					spec requires: #('VMMaker' 'CogVMMakerPharoCompatibility') ];
				package: 'VMMaker' with: [ 
					spec 
						file: 'VMMaker.oscog';
						requires: #(
							'SharedPool-Speech' 
							'FFI-Pools' 
							'Balloon-Engine-Pools' 
							'Sound' 
							"'Alien-Core'"
							'CogVMMakerPharoCompatibility') ];
			 	package: 'BytecodeSets' with: [ spec requires: 'VMMaker' ];
				package: 'CMakeLibSSH2' with: [ spec requires: 'CMakeVMMaker' ];
				package: 'CMakeLibGit2' with: [ spec requires: 'CMakeVMMaker' ];
				package: 'CMakeLibSDL2' with: [ spec requires: 'CMakeVMMaker' ];
				package: 'PharoVMMaker' with: [ spec requires: 'CMakeVMMaker' ].
			
			spec 
				group: 'all' with: #('pharoCompatibility' 'maker' 'plugins' 'pharoPlugins' 'pharoBuilders' 'libs');
				group: 'pharoCompatibility' with: #('CogVMMakerPharoCompatibility' 'SpurVMMakerPharoCompatibility');
				group: 'pharoBuilders' with: #('CMakeVMMaker' 'SpurVMMaker' 'PharoVMMaker');
				group: 'pharoPlugins' with: #('SDL2DisplayPlugin' 'EventsHandlerPlugin');
				group: 'libs' with: #('CMakeLibSSH2' 'CMakeLibGit2' 'CMakeLibSDL2') ]