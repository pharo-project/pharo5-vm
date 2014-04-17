baselines
baseline23: spec 
	<version: '2.3-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.

		spec repositories: [
			spec 
				repository: 'http://source.squeak.org/VMMaker';
				repository: 'http://www.squeaksource.com/PharoVM' ].
	
		spec 
			package: 'FFI-Pools' with: [ 
				spec repository: 'http://source.squeak.org/FFI' ];
			package: 'SharedPool-Speech' with: [ 
				spec repository: 'http://www.squeaksource.com/Speech' ];
			package: 'Balloon-Engine-Pools' with: [ 
				spec repository: 'http://www.squeaksource.com/JBARepo' ];
			package: 'Sound' with: [ 
				spec repository: 'http://www.squeaksource.com/PharoSound' ];
			package: 'Alien-Core' with: [ 
				spec repository: 'http://www.squeaksource.com/Alien' ];
			package: 'VMMaker-oscog' with: [ 
				spec requires: #('SharedPool-Speech' 'FFI-Pools' 'Balloon-Engine-Pools' 'Sound' 'Alien-Core') ];
			package: 'Cog' with: [ 
				spec requires: #('VMMaker-oscog' ) ];
			package: 'Qwaq-VMProfiling-Plugins' with: [ 
				spec 
					repository: 'http://www.squeaksource.com/JBARepo';
					requires: #('VMMaker-oscog' ) ];
			package: 'VMConstruction-Plugins-AioPlugin' with: [ 
				spec 
					repository: 'http://www.squeaksource.com/AioPlugin';
					requires: #('VMMaker-oscog') ];
			package: 'VMConstruction-Plugins-OSProcessPlugin' with: [ 
				spec 
					repository: 'http://www.squeaksource.com/OSProcessPlugin';
					requires: #('VMMaker-oscog' 'VMConstruction-Plugins-AioPlugin') ];
			package: 'Freetype-Plugin' with: [ 
				spec 
					repository: 'http://www.squeaksource.com/FreetypePlugin';
					requires: #('VMMaker-oscog') ];
			package: 'SqueakSSL-Plugin' with: [ 
				spec 
					repository: 'http://www.squeaksource.com/SqueakSSL';
					requires: #('VMMaker-oscog') ];
			package: 'ObjectiveC-Plugin' with: [ 
				spec 
					repository: 'http://www.squeaksource.com/ObjectiveCBridge2';
					requires: #('VMMaker-oscog') ];
			package: 'Applescript-Core' with: [ 
				spec 
					repository: 'http://www.squeaksource.com/Applescript';
					requires: #('VMMaker-oscog') ];
				
			package: 'CMakeVMMaker' with: [ 
				spec requires: #('Cog') ].	
			
			spec postLoadDoIt: #fixForPharo10.
			
			spec 
				group: 'default' with: 'ALL';
				group: 'ALL' with: #('CogVMMaker' 'Plugins' 'CMakeVMMaker');
				group: 'CogVMMaker' with: #('VMMaker-oscog' 'Cog');
				group: 'Plugins' with: #(
					'VMConstruction-Plugins-AioPlugin' 
					'VMConstruction-Plugins-OSProcessPlugin' 
					'Qwaq-VMProfiling-Plugins' 
					'Freetype-Plugin'
					'SqueakSSL-Plugin'
					'ObjectiveC-Plugin'
					'Applescript-Core') ].
		
		spec for: #pharo do: [		
			spec package: 'CogVMMakerPharoCompatibility'.
			
			spec package: 'VMMaker-oscog' with: [ 
				spec requires: #(
					'SharedPool-Speech' 
					'FFI-Pools' 
					'Balloon-Engine-Pools' 
					'Sound' 
					'Alien-Core' 
					'CogVMMakerPharoCompatibility') ].
			
			spec project: 'NativeBoostPlugin' with: [			
				spec
					className: 'ConfigurationOfNativeBoost';
					loads: #('Plugin' );
					repository: 'http://www.smalltalkhub.com/mc/Pharo/NativeBoost/main' ].
			
			spec package: 'SqueakSSL-Plugin' with: [ 
				spec repository: 'http://www.squeaksource.com/SqueakSSL' ].		
		
			spec package:  'PharoVMMaker'.
			
			spec 
				group: 'ALL' with: #('CogVMMaker' 'Plugins' 'PharoPlugins' 'CMakeVMMaker' 'PharoVMMaker');
				group: 'PharoPlugins' with: #('NativeBoostPlugin' 'SqueakSSL-Plugin') ]