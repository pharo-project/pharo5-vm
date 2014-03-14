versions
version33: spec
	<version: '3.3' imports: #('3.2' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec author: 'EstebanLorenzano'.
		spec timestamp:  '9/12/2011 10:15'.
		
		spec
			package: 'Freetype-Plugin' with: 'Freetype-Plugin-dtl.63';
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-EstebanLorenzano.138' ].