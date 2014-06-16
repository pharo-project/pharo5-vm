An ImageFileHeader represents the information in the header block of an image file, used by an interpreter VM. Subclasses may implement extensions for Cog or other header extensions.

Instance variables correspond to the fields in an image file header. An instance of ImageFileHeader may be created by reading from an image file, and an ImageFileHeader may be written to a file.

When stored to a file, the file header fields may be 32 or 64 bits in size, depending on the image format. The byte ordering of each field will be little endian or big endian, depending on the convention of the host platform. When reading from disk, endianness is inferred from the contents of the first data field.

To explore the file header of an image file:

  | fs |
  fs := (FileStream readOnlyFileNamed: Smalltalk imageName) binary.
  ([ImageFileHeader readFrom: fs] ensure: [fs close]) explore
