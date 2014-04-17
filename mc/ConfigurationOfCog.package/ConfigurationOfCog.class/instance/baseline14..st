baselines
baseline14: spec 
	" Alien-Prereqs are no longer used "
	<version: '1.4-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.		
				
		spec repository: 'http://source.squeak.org/FFI';	
			  package: 'FFI-Pools'.
			
		spec repository: 'http://www.squeaksource.com/Speech';	
			  package: 'SharedPool-Speech'.
		
		spec repository: 'http://www.squeaksource.com/JBARepo';	
			  package: 'Balloon-Engine-Pools'.
		
		spec repository: 'http://www.squeaksource.com/Alien';	
			  package: 'Alien-Core'.

		spec repository: 'http://www.squeaksource.com/PharoSound';
			package: 'Sound'.
						
		spec repository: 'http://www.squeaksource.com/VMMaker';	
			  package: 'Cog' with: [ spec requires: #('VMMaker-oscog' ) ].	
			
		spec repository: 'http://www.squeaksource.com/VMMaker';
			  package: 'VMMaker-oscog' with: [ spec requires: #('SharedPool-Speech' 'FFI-Pools' 'Balloon-Engine-Pools' 'Sound' ) ].
			
		spec repository: 'http://www.squeaksource.com/JBARepo';	
			  package: 'Qwaq-VMProfiling-Plugins' with: [ spec requires: #('VMMaker-oscog' ) ].
			
		spec repository: 'http://www.squeaksource.com/VMMaker';	
			  package: 'CMakeVMMaker' with: [spec requires: #('Cog') ] .
			
		spec postLoadDoIt: #fixForPharo10.
		].