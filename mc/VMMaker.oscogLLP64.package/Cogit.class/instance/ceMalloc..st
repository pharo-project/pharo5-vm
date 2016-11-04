trampoline support
ceMalloc: size
	<api>
	<var: #size type: #'size_t'>
	<returnTypeC: #'void*'>
	^ self malloc: size