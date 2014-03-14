baselines
baseline12: spec 
	" Alien-Prereqs are no longer used "
	<version: '1.2-baseline'>
	
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
						
		spec repository: 'http://www.squeaksource.com/JBARepo';	
			  package: 'Cog' with: [ spec requires: #('VMMaker' ) ].	
			
		spec repository: 'http://www.squeaksource.com/VMMaker';
			  package: 'VMMaker' with: [ spec requires: #('SharedPool-Speech' 'FFI-Pools' 'Balloon-Engine-Pools' 'Sound' ) ].
			
		spec repository: 'http://www.squeaksource.com/JBARepo';	
			  package: 'Qwaq-VMProfiling-Plugins' with: [ spec requires: #('VMMaker' ) ].
			
		spec postLoadDoIt: #fixForPharo10.
		].