baselines
baselineGit: spec 
	<version: 'git'>
	
	spec for: #common do: [
		spec blessing: #baseline.

		spec repositories: [
			spec repository: self repositoryDir ].
	
		spec 
			package: 'FFI-Pools';
			package: 'SharedPool-Speech';
			package: 'Balloon-Engine-Pools';
			package: 'Sound';
			package: 'Alien-Core';
			package: 'VMMaker.oscog' with: [ 
				spec requires: #('SharedPool-Speech' 'FFI-Pools' 'Balloon-Engine-Pools' 'Sound' 'Alien-Core') ];
			package: 'Cog' with: [ 
				spec requires: #('VMMaker.oscog' ) ];
			package: 'Qwaq-VMProfiling-Plugins' with: [ 
				spec requires: #('VMMaker.oscog' ) ];
			package: 'VMConstruction-Plugins-AioPlugin' with: [ 
				spec requires: #('VMMaker.oscog') ];
			package: 'VMConstruction-Plugins-OSProcessPlugin' with: [ 
				spec requires: #('VMMaker.oscog' 'VMConstruction-Plugins-AioPlugin') ];
			package: 'Freetype-Plugin' with: [ 
				spec requires: #('VMMaker.oscog') ];
			package: 'SqueakSSL-Plugin' with: [ 
				spec requires: #('VMMaker.oscog') ];
			package: 'ObjectiveC-Plugin' with: [ 
				spec requires: #('VMMaker.oscog') ];
			package: 'Applescript-Core' with: [ 
				spec requires: #('VMMaker.oscog') ];
			package: 'CMakeVMMaker' with: [ 
				spec requires: #('Cog') ].	
			
			"spec postLoadDoIt: #fixForPharo10."
			
		spec 
			group: 'default' with: 'ALL';
			group: 'ALL' with: #('CogVMMaker' 'Plugins' 'CMakeVMMaker');
			group: 'CogVMMaker' with: #('VMMaker.oscog' 'Cog');
			group: 'Plugins' with: #(
				'VMConstruction-Plugins-AioPlugin' 
				'VMConstruction-Plugins-OSProcessPlugin' 
				'Qwaq-VMProfiling-Plugins' 
				'Freetype-Plugin'
				'SqueakSSL-Plugin'
				'ObjectiveC-Plugin'
				'Applescript-Core') ].
		
		spec for: #pharo do: [		
			spec 
				package: 'CogVMMakerPharoCompatibility';
				package: 'VMMaker.oscog' with: [ 
					spec requires: #(
						'SharedPool-Speech' 
						'FFI-Pools' 
						'Balloon-Engine-Pools' 
						'Sound' 
						'Alien-Core' 
						'CogVMMakerPharoCompatibility') ];
				package: 'NativeBoost-CogPlugin' with: [ 
					spec requires: 'VMMaker.oscog' ];
			 	package: 'SqueakSSL-Plugin' with: [ 
					spec requires: 'VMMaker.oscog' ];
				package:  'CMakeLibSSH2' with: [ 
					spec requires: 'CMakeVMMaker' ];
				package:  'CMakeLibGit2' with: [ 
					spec requires: 'CMakeVMMaker' ];
				package:  'PharoVMMaker' with: [ 
					spec requires: 'CMakeVMMaker' ].
			
			spec 
				group: 'ALL' with: #('CogVMMaker' 'Plugins' 'PharoPlugins' 'CMakeVMMaker' 'PharoVMMaker' 'ThirdPartyLibs');
				group: 'PharoPlugins' with: #('NativeBoost-CogPlugin' 'SqueakSSL-Plugin');
				group: 'ThirdPartyLibs' with: #('CMakeLibSSH2' 'CMakeLibGit2') ]