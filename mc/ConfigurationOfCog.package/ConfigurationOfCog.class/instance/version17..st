versions
version17: spec 
	<version: '1.7' imports: #('1.4-baseline') >
	
	spec for: #common do: [
		spec blessing: #release.
		spec 
			package: 'FFI-Pools' with: 'FFI-Pools-eem.3';
			package: 'SharedPool-Speech' with: 'SharedPool-Speech-dtl.2';
			package: 'Balloon-Engine-Pools' with: 'Balloon-Engine-Pools-JB.2';
			package: 'Qwaq-VMProfiling-Plugins' with: 'Qwaq-VMProfiling-Plugins-JB.5';
			package: 'Sound' with: 'Sound-StephaneDucasse.62';
			package: 'VMMaker-oscog' with: 'VMMaker-oscog.dtl.57';
			package: 'Alien-Core' with: 'Alien-Core-IgorStasenko.68';
			package: 'Cog' with: 'Cog-eem.44';
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-IgorStasenko.78'.
	].