versions
version10: spec 
	<version: '1.0' imports: #('1.0-baseline') >
	
	spec for: #common do: [
		spec blessing: #release.
		spec 
			package: 'FFI-Pools' with: 'FFI-Pools-ar.1';
			package: 'SharedPool-Speech' with: 'SharedPool-Speech-dtl.2';
			package: 'Balloon-Engine-Pools' with: 'Balloon-Engine-Pools-JB.2';
			package: 'Qwaq-VMProfiling-Plugins' with: 'Qwaq-VMProfiling-Plugins-JB.5';
			package: 'VMMaker' with: 'VMMaker-oscog.16';
			package: 'Alien-Prereqs' with: 'Alien-Prereqs-KenTreis.5';
			package: 'Alien-Core' with: 'Alien-Core-FernandoOlivero.64';
			package: 'Cog' with: 'Cog-JB.41'.
			
	].		