A SpurBootstrapMonticelloPackagePatcher is used to construct a new set of patched Monticello packages for Spur.  The use case is some bootstrap process loads a set of Monticello packages.  To repeat the bootstrap with a Spur image the bootstrap must use suitably patched Monticello packages containing the new method versions on the class side of SpurBootstrap.

Instance Variables
	destDir:			<FileDirectory>
	sourceDir:		<FileDirectory>

destDir
	- directory to which patched packages are to be written

sourceDir
	- directory from which packages to be patched are to be read