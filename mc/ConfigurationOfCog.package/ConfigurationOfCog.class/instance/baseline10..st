baselines
baseline10: spec 
	<version: '1.0-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.		
				
		spec repository: 'http://source.squeak.org/FFI';	
			  package: 'FFI-Pools'.
			
		spec repository: 'http://www.squeaksource.com/Speech';	
			  package: 'SharedPool-Speech'.
		
		spec repository: 'http://www.squeaksource.com/JBARepo';	
			  package: 'Balloon-Engine-Pools'.
		
			
		spec repository: 'http://www.squeaksource.com/Alien';	
			  package: 'Alien-Core' with: [spec requires: #('Alien-Prereqs')];
			  package: 'Alien-Prereqs'.
			
		spec repository: 'http://www.squeaksource.com/JBARepo';	
			  package: 'Cog' with: [ spec requires: #('VMMaker' ) ].	
			
		spec repository: 'http://www.squeaksource.com/VMMaker';
			  package: 'VMMaker' with: [ spec requires: #('SharedPool-Speech' 'FFI-Pools' 'Balloon-Engine-Pools' ) ].
			
		spec repository: 'http://www.squeaksource.com/JBARepo';	
			  package: 'Qwaq-VMProfiling-Plugins' with: [ spec requires: #('VMMaker' ) ].
			
		spec postLoadDoIt: #fixForPharo10.
		].