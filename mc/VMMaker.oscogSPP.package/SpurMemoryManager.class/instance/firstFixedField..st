object access
firstFixedField: objOop
	<returnTypeC: #'void *'>
	^ self pointerForOop: objOop + self baseHeaderSize