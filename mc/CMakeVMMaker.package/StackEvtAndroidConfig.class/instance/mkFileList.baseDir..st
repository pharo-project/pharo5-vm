utils
mkFileList: anArray baseDir: aDir
	"answer the concatenated contents of the array interspersed with backslash-newline sequences"
	^ (anArray collect: [ :s | aDir, s]) inject: '' into: [ :s :n | s , #($\), {Character cr}, n ].