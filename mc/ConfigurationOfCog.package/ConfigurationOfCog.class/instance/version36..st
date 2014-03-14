versions
version36: spec
	<version: '3.6' imports: #('3.5' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec author: 'EstebanLorenzano'.
		spec timestamp:  '12/03/2011 18:30'.
		
		spec
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-EstebanLorenzano.142' ].