versions
version67: spec
	<version: '6.7' imports: #('2.3-baseline' )>

	"
	Making it work with FileSystem for latest Pharo20
	"
	spec for: #'common' do: [
		spec blessing: #'development'.
		spec author: 'EstebanLorenzano'.
		spec timestamp: '31 July 2013 3:24:47 pm'.
		spec 
			package: 'FFI-Pools' with: 'FFI-Pools-eem.3';
			package: 'SharedPool-Speech' with: 'SharedPool-Speech-dtl.2';
			package: 'Balloon-Engine-Pools' with: 'Balloon-Engine-Pools-JB.2';
			package: 'Sound' with: 'Sound-GuillermoPolito.69';
			package: 'Alien-Core' with: 'Alien-Core-IgorStasenko.71';
			package: 'VMMaker-oscog' with: 'VMMaker-oscog-EstebanLorenzano.303';
			package: 'Cog' with: 'Cog-eem.61';
			package: 'Qwaq-VMProfiling-Plugins' with: 'Qwaq-VMProfiling-Plugins-JB.5';
			package: 'VMConstruction-Plugins-AioPlugin' with: 'VMConstruction-Plugins-AioPlugin-EstebanLorenzano.13';
			package: 'VMConstruction-Plugins-OSProcessPlugin' with: 'VMConstruction-Plugins-OSProcessPlugin.oscog-eem.32';
			package: 'Freetype-Plugin' with: 'Freetype-Plugin-IgorStasenko.64';
			package: 'ObjectiveC-Plugin' with: 'ObjectiveC-Plugin-John M McIntosh.20';
			package: 'Applescript-Core' with: 'Applescript-Core-SeanDeNigris.2'.
		spec 
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-EstebanLorenzano.213';
			package: 'CogVMMakerPharoCompatibility' with: 'CogVMMakerPharoCompatibility-MarianoMartinezPeck.6';
			project: 'NativeBoostPlugin' with: '2.1';
			package: 'SqueakSSL-Plugin' with: 'SqueakSSL-Plugin-ar.3';
			package: 'PharoVMMaker' with: 'PharoVMMaker-EstebanLorenzano.9' ].
