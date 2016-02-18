iteration callbacks
count: info num: size modules: ignored
	<returnTypeC: #int>
	<var: #info type: #'struct dl_phdr_info *'>
	<var: #size type: #'size_t'>
	<var: #ignored type: #'void *'>
	numModules := numModules + 1.
	^0