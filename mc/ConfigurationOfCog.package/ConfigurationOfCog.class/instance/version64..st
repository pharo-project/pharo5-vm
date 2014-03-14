versions
version64: spec
	<version: '6.4' imports: #('2.3-baseline' )>

	"
	-fix in freetype (Freetype-Plugin-IgorStasenko.64)
	-download thirdparty lib sources from files.pharo.org (CMakeVMMaker-IgorStasenko.205)
	"
	spec for: #'common' do: [
		spec blessing: #'development'.
		spec author: 'EstebanLorenzano'.
		spec timestamp: '12 June 2013 4:01:38 pm'.
		spec 
			package: 'FFI-Pools' with: 'FFI-Pools-eem.3';
			package: 'SharedPool-Speech' with: 'SharedPool-Speech-dtl.2';
			package: 'Balloon-Engine-Pools' with: 'Balloon-Engine-Pools-JB.2';
			package: 'Sound' with: 'Sound-MarianoMartinezPeck.67';
			package: 'Alien-Core' with: 'Alien-Core-IgorStasenko.71';
			package: 'VMMaker-oscog' with: 'VMMaker-oscog-EstebanLorenzano.239';
			package: 'Cog' with: 'Cog-IgorStasenko.57';
			package: 'Qwaq-VMProfiling-Plugins' with: 'Qwaq-VMProfiling-Plugins-JB.5';
			package: 'VMConstruction-Plugins-AioPlugin' with: 'VMConstruction-Plugins-AioPlugin-EstebanLorenzano.13';
			package: 'VMConstruction-Plugins-OSProcessPlugin' with: 'VMConstruction-Plugins-OSProcessPlugin.oscog-eem.32';
			package: 'Freetype-Plugin' with: 'Freetype-Plugin-IgorStasenko.64';
			package: 'ObjectiveC-Plugin' with: 'ObjectiveC-Plugin-John M McIntosh.20';
			package: 'Applescript-Core' with: 'Applescript-Core-SeanDeNigris.2';
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-IgorStasenko.205' ].

	spec for: #'pharo' do: [
		spec 
			package: 'CogVMMakerPharoCompatibility' with: 'CogVMMakerPharoCompatibility-MarianoMartinezPeck.6';
			project: 'NativeBoostPlugin' with: '2.1';
			package: 'SqueakSSL-Plugin' with: 'SqueakSSL-Plugin-ar.3';
			package: 'PharoVMMaker' with: 'PharoVMMaker-EstebanLorenzano.9' ].
