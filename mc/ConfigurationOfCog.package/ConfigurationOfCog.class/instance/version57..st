versions
version57: spec
	<version: '5.7' imports: #('2.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec description: '- merged with Eliot''s 255'.
		spec author: 'EstebanLorenzano'.
		spec timestamp: '17 January 2013 4:49:56 pm'.
		spec 
			package: 'FFI-Pools' with: 'FFI-Pools-eem.3';
			package: 'SharedPool-Speech' with: 'SharedPool-Speech-dtl.2';
			package: 'Balloon-Engine-Pools' with: 'Balloon-Engine-Pools-JB.2';
			package: 'Sound' with: 'Sound-MarianoMartinezPeck.67';
			package: 'Alien-Core' with: 'Alien-Core-IgorStasenko.68';
			package: 'VMMaker-oscog' with: 'VMMaker-oscog-EstebanLorenzano.230';
			package: 'Cog' with: 'Cog-eem.46';
			package: 'Qwaq-VMProfiling-Plugins' with: 'Qwaq-VMProfiling-Plugins-JB.5';
			package: 'VMConstruction-Plugins-AioPlugin' with: 'VMConstruction-Plugins-AioPlugin-EstebanLorenzano.13';
			package: 'VMConstruction-Plugins-OSProcessPlugin' with: 'VMConstruction-Plugins-OSProcessPlugin.oscog-eem.32';
			package: 'Freetype-Plugin' with: 'Freetype-Plugin-dtl.63';
			package: 'ObjectiveC-Plugin' with: 'ObjectiveC-Plugin-John M McIntosh.20';
			package: 'Applescript-Core' with: 'Applescript-Core-SeanDeNigris.2';
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-EstebanLorenzano.189'. ].

	spec for: #'pharo' do: [
		spec 
			package: 'CogVMMakerPharoCompatibility' with: 'CogVMMakerPharoCompatibility-MarianoMartinezPeck.3';
			package: 'NativeBoost' with: '1.7';
			package: 'SqueakSSL-Plugin' with: 'SqueakSSL-Plugin-ar.3';
			package: 'PharoVMMaker' with: 'PharoVMMaker-EstebanLorenzano.7' ].
