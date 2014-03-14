versions
version14: spec 
	<version: '1.4' imports: #('1.3-baseline') >
	
	spec for: #common do: [
		spec blessing: #release.
		spec 
			package: 'FFI-Pools' with: 'FFI-Pools-eem.3';
			package: 'SharedPool-Speech' with: 'SharedPool-Speech-dtl.2';
			package: 'Balloon-Engine-Pools' with: 'Balloon-Engine-Pools-JB.2';
			package: 'Qwaq-VMProfiling-Plugins' with: 'Qwaq-VMProfiling-Plugins-JB.5';
			package: 'Sound' with: 'Sound-StephaneDucasse.62';
			package: 'VMMaker-oscog' with: 'VMMaker-oscog.52';
			package: 'Alien-Core' with: 'Alien-Core-IgorStasenko.68';
			package: 'Cog' with: 'Cog-eem.44'.
			
	].		