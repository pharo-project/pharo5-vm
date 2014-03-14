versions
version23: spec
	<version: '2.3' imports: #('1.6-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec description: 'Added freetype plugin'.
		spec author: 'IgorStasenko'.
		spec timestamp: '4/07/2011 11:15'.
		spec
			package: 'FFI-Pools' with: 'FFI-Pools-eem.3';
			package: 'SharedPool-Speech' with: 'SharedPool-Speech-dtl.2';
			package: 'Balloon-Engine-Pools' with: 'Balloon-Engine-Pools-JB.2';
			package: 'Alien-Core' with: 'Alien-Core-IgorStasenko.68';
			package: 'Sound' with: 'Sound-StephaneDucasse.62';
			package: 'VMConstruction-Plugins-OSProcessPlugin' with: 'VMConstruction-Plugins-OSProcessPlugin-dtl.27';
			package: 'Freetype-Plugin' with: 'Freetype-Plugin-IgorStasenko.61';
			package: 'Cog' with: 'Cog-eem.44';
			package: 'VMMaker-oscog' with: 'VMMaker-oscog-IgorStasenko.92';
			package: 'Qwaq-VMProfiling-Plugins' with: 'Qwaq-VMProfiling-Plugins-JB.5';
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-IgorStasenko.115'. ].