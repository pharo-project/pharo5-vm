versions
version34: spec
	<version: '3.4' imports: #('3.3' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec author: 'EstebanLorenzano'.
		spec timestamp:  '10/17/2011 12:10'.
		
		spec
			package: 'VMConstruction-Plugins-OSProcessPlugin' 
				with: 'VMConstruction-Plugins-OSProcessPlugin.oscog-eem.32';
			package: 'VMMaker-oscog' with: 'VMMaker-oscog-EstebanLorenzano.124';
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-EstebanLorenzano.140' ].