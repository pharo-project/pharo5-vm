versions
version35: spec
	<version: '3.5' imports: #('3.4' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec author: 'EstebanLorenzano'.
		spec timestamp:  '11/11/2011 14:32'.
		
		spec
			package: 'VMMaker-oscog' with: 'VMMaker-oscog-EstebanLorenzano.139';
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-EstebanLorenzano.141' ].