versions
version38: spec
	<version: '3.8' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec author: 'MarianoMartinezPeck'.
		spec timestamp:  '01/12/2012 16:05'.
		
		spec
			package: 'FFI-Pools' with: 'FFI-Pools-eem.3';
			package: 'SharedPool-Speech' with: 'SharedPool-Speech-dtl.2';
			package: 'Balloon-Engine-Pools' with: 'Balloon-Engine-Pools-JB.2';
			package: 'Alien-Core' with: 'Alien-Core-IgorStasenko.68';
			package: 'Sound' with: 'Sound-StephaneDucasse.62';
			package: 'VMConstruction-Plugins-OSProcessPlugin' 
				with: 'VMConstruction-Plugins-OSProcessPlugin.oscog-eem.32';
			package: 'Freetype-Plugin' with: 'Freetype-Plugin-dtl.63';
			package: 'ObjectiveC-Plugin' with: 'ObjectiveC-Plugin-John M McIntosh.20';
			package: 'Cog' with: 'Cog-eem.46';
			package: 'VMMaker-oscog' with: 'VMMaker-oscog-EstebanLorenzano.139';
			package: 'Qwaq-VMProfiling-Plugins' with: 'Qwaq-VMProfiling-Plugins-JB.5';
			package: 'Applescript-Core' with: 'Applescript-Core-SeanDeNigris.2';		
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-EstebanLorenzano.143'  ].


