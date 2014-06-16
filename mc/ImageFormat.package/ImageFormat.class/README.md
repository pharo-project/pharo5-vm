ImageFormat represents the requirements of the image in terms of capabilities that must be supported by the virtual machine. The image format version is saved as an integer value in the header of an image file. When an image is loaded, the virtual machine checks the image format version to determine whether it is capable of supporting the requirements of that image.

The image format version value is treated as a bit map of size 32, derived from the 32-bit integer value saved in the image header. Bits in the bit map represent image format requirements. For example, if the image sets bit 15 to indicate that it requires some capability from the VM, then the VM can check bit 15 and decide whether it is able to satisfy that requirement.

The base image format numbers (6502, 6504, 68000, and 68002) utiliize 10 of the 32 available bits. The high order bit is reserved as an extension bit for future use. The remaining 21 bits are used to represent additional image format requirements. For example, the low order bit is used to indication that the image uses (and requires support for) the platform byte ordering implemented in the StackInterpreter (Cog) VM.

	"(ImageFormat fromFile: Smalltalk imageName) description"
