versions
version53: spec
	<version: '5.3' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec description: 'Cairo library builds on Win32'.
		spec author: 'IgorStasenko'.
		spec timestamp: '23 Oct 2012'.
		spec 
			package: 'FFI-Pools' with: 'FFI-Pools-eem.3';
			package: 'SharedPool-Speech' with: 'SharedPool-Speech-dtl.2';
			package: 'Balloon-Engine-Pools' with: 'Balloon-Engine-Pools-JB.2';
			package: 'Sound' with: 'Sound-MarianoMartinezPeck.67';
			package: 'Alien-Core' with: 'Alien-Core-IgorStasenko.68';
			package: 'VMMaker-oscog' with: 'VMMaker-oscog-EstebanLorenzano.164';
			package: 'Cog' with: 'Cog-eem.46';
			package: 'Qwaq-VMProfiling-Plugins' with: 'Qwaq-VMProfiling-Plugins-JB.5';
			package: 'VMConstruction-Plugins-AioPlugin' with: 'VMConstruction-Plugins-AioPlugin-EstebanLorenzano.13';
			package: 'VMConstruction-Plugins-OSProcessPlugin' with: 'VMConstruction-Plugins-OSProcessPlugin.oscog-eem.32';
			package: 'Freetype-Plugin' with: 'Freetype-Plugin-dtl.63';
			package: 'SqueakSSL-Plugin' with: 'SqueakSSL-Plugin-ar.3';
			package: 'ObjectiveC-Plugin' with: 'ObjectiveC-Plugin-John M McIntosh.20';
			package: 'Applescript-Core' with: 'Applescript-Core-SeanDeNigris.2';
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-IgorStasenko.184'. ].

	spec for: #'pharo' do: [
		spec 
			package: 'CogVMMakerPharoCompatibility' with: 'CogVMMakerPharoCompatibility-MarianoMartinezPeck.3'].
