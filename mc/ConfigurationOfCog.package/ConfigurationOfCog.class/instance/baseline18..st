baselines
baseline18: spec 
	"Added TestOSAPlugin plugin"
	<version: '1.8-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/VMMaker'.
	
		spec 
			package: 'FFI-Pools' 
				with: [ spec repository: 'http://source.squeak.org/FFI' ];
			package: 'SharedPool-Speech' 
				with: [ spec repository: 'http://www.squeaksource.com/Speech' ];
			package: 'Balloon-Engine-Pools' 
				with: [ spec repository: 'http://www.squeaksource.com/JBARepo' ];
			package: 'Sound' 
				with: [ spec repository: 'http://www.squeaksource.com/PharoSound' ];
			package: 'Alien-Core' 
				with: [ spec repository: 'http://www.squeaksource.com/Alien' ];
			package: 'VMMaker-oscog' 
				with: [ spec requires: #('SharedPool-Speech' 'FFI-Pools' 'Balloon-Engine-Pools' 'Sound' 'Alien-Core') ];
			package: 'Cog' 
				with: [ spec requires: #('VMMaker-oscog' ) ];
			package: 'Qwaq-VMProfiling-Plugins' 
				with: [ spec repository: 'http://www.squeaksource.com/JBARepo';
					requires: #('VMMaker-oscog' ) ];
			package: 'VMConstruction-Plugins-OSProcessPlugin' 
				with: [ spec repository: 'http://www.squeaksource.com/OSProcessPlugin' ];
			package: 'Freetype-Plugin' 
				with: [ spec repository: 'http://www.squeaksource.com/FreetypePlugin';
					requires: #('VMMaker-oscog') ];
			package: 'ObjectiveC-Plugin' 
				with: [ spec repository: 'http://www.squeaksource.com/ObjectiveCBridge2';
					requires: #('VMMaker-oscog') ];
			package: 'Applescript-Core' 
				with: [ spec repository: 'http://www.squeaksource.com/Applescript';
					requires: #('VMMaker-oscog') ];
			package: 'CMakeVMMaker' 
				with: [ spec requires: #('Cog') ].	
			
			spec postLoadDoIt: #fixForPharo10.
			
			spec 
				group: 'default' with: 'ALL';
				group: 'ALL' with: #('CogVMMaker' 'Plugins' 'CMakeVMMaker');
				group: 'CogVMMaker' with: #('VMMaker-oscog' 'Cog');
				group: 'Plugins' with: #(
					'VMConstruction-Plugins-OSProcessPlugin' 
					'Qwaq-VMProfiling-Plugins' 
					'Freetype-Plugin'
					'ObjectiveC-Plugin'
					'Applescript-Core') ].
		