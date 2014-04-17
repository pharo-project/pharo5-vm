versions
version37: spec
	<version: '3.7' imports: #('3.6' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec author: 'EstebanLorenzano'.
		spec timestamp:  '2 January 2012 7:20:21 pm'.
		
		spec
			package: 'Cog' with: 'Cog-eem.46';
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-EstebanLorenzano.143' ].