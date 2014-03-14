versions
version25: spec
	<version: '2.5' imports: #('1.6-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec description: 'Added rule 41 into bitblt plugin'.
		spec author: 'IgorStasenko'.
		spec timestamp:  '7/11/2011 16:55'.
		spec
			package: 'FFI-Pools' with: 'FFI-Pools-eem.3';
			package: 'SharedPool-Speech' with: 'SharedPool-Speech-dtl.2';
			package: 'Balloon-Engine-Pools' with: 'Balloon-Engine-Pools-JB.2';
			package: 'Alien-Core' with: 'Alien-Core-IgorStasenko.68';
			package: 'Sound' with: 'Sound-StephaneDucasse.62';
			package: 'VMConstruction-Plugins-OSProcessPlugin' with: 'VMConstruction-Plugins-OSProcessPlugin.oscog-eem.31';
			package: 'Freetype-Plugin' with: 'Freetype-Plugin-IgorStasenko.61';
			package: 'Cog' with: 'Cog-eem.44';
			package: 'VMMaker-oscog' with: 'VMMaker-oscog-IgorStasenko.96';
			package: 'Qwaq-VMProfiling-Plugins' with: 'Qwaq-VMProfiling-Plugins-JB.5';
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-IgorStasenko.123'. ].