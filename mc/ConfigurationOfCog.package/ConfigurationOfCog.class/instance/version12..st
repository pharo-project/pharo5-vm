versions
version12: spec 
	<version: '1.2' imports: #('1.2-baseline') >
	
	spec for: #common do: [
		spec blessing: #release.
		spec 
			package: 'FFI-Pools' with: 'FFI-Pools-eem.2';
			package: 'SharedPool-Speech' with: 'SharedPool-Speech-dtl.2';
			package: 'Balloon-Engine-Pools' with: 'Balloon-Engine-Pools-JB.2';
			package: 'Qwaq-VMProfiling-Plugins' with: 'Qwaq-VMProfiling-Plugins-JB.5';
			package: 'Sound' with: 'Sound-StephaneDucasse.62';
			package: 'VMMaker' with: 'VMMaker-oscog-Igor.Stasenko.48';
			package: 'Alien-Core' with: 'Alien-Core-IgorStasenko.68';
			package: 'Cog' with: 'Cog-JB.41'.
			
	].		