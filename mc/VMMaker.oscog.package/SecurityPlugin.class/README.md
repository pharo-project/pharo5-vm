IMPLEMENTATION NOTES:
The support should assume a trusted directory based on which access to files is granted when running in restricted mode. If necessary, links need to be resolved before granting access (currently, this applies only to platforms on which links can be created by simply creating the right kind of file).

The untrusted user directory returned MUST be different from the image and VM location. Otherwise a Badlet could attempt to overwrite these by using simple file primitives. The secure directory location returned by the primitive is a place to store per-user security information. Again, this place needs to be outside the untrusted space. Examples:

[Windows]
	* VM+image location: "C:\Program Files\Squeak\"
	* secure directory location: "C:\Program Files\Squeak\username\"
	* untrusted user directory: "C:\My Squeak\username\"
[Unix]
	* VM+image location: "/user/local/squeak"
	* secure directory location: "~username/.squeak/
	* untrusted user directory: "~username/squeak/"
[Mac]
	* plugin VM location: "MacHD:Netscape:Plugins:"
	* standalone VM and image location: "MacHD:Squeak:"
	* secure directory location: "MacHD:Squeak:username:"
	* untrusted user directory: "MacHD:My Squeak:username:"

Restoring the rights revoked by an image might be possible by some interaction with the VM directly. Any such action should be preceeded by a BIG FAT WARNING - the average user will never need that ability (if she does, we did something wrong) so this is a last resort in cases where something fundamtally tricky happened.
