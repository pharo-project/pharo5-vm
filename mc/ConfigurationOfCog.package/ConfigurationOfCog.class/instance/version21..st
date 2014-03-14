versions
version21: spec
	<version: '2.1' imports: #('1.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec description: 'Added OSProcessPlugin'.
		spec author: 'EstebanLorenzano'.
		spec timestamp: '6/14/2011 14:59'.
		spec 
			package: 'FFI-Pools' with: 'FFI-Pools-eem.3';
			package: 'SharedPool-Speech' with: 'SharedPool-Speech-dtl.2';
			package: 'Balloon-Engine-Pools' with: 'Balloon-Engine-Pools-JB.2';
			package: 'Alien-Core' with: 'Alien-Core-IgorStasenko.68';
			package: 'Sound' with: 'Sound-StephaneDucasse.62';
			package: 'VMConstruction-Plugins-OSProcessPlugin' with: 'VMConstruction-Plugins-OSProcessPlugin-dtl.27';
			package: 'Cog' with: 'Cog-eem.44';
			package: 'VMMaker-oscog' with: 'VMMaker-oscog-IgorStasenko.55';
			package: 'Qwaq-VMProfiling-Plugins' with: 'Qwaq-VMProfiling-Plugins-JB.5';
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-EstebanLorenzano.108'. ].
