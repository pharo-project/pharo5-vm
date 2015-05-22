accessing
defaultConfigurationFlags 
	^#(
		'-DCMAKE_C_FLAGS=''-m32'''
		'-DCMAKE_CXX_FLAGS=''-m32'''
		'-DCMAKE_SHARED_LINKER_FLAGS="-Wl,-rpath=\$ORIGIN:\$ORIGIN/Plugins"'
	)