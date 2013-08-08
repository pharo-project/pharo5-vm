package properties
unpackedDirName
	"answer the directory name, which is created after unpacking
	downloaded archive i.e.
	
	the archive downloaded from 
	
	http://ftp.igh.cnrs.fr/pub/nongnu/freetype/freetype-2.4.9.tar.gz
	
	if untarred, will create
	freetype-2.4.9
	subdirectory. But since there is no conventions, it could be anything,
	so we should specify it here, so build system will know where to look for unpacked files"

	^ self subclassResponsibility