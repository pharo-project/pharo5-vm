inline primitive support
lowcode_mem: destAddress cp: sourceAddress y: bytes
	"This method is a workaround a GCC bug.
	In Windows memcpy is putting too much register pressure on GCC when used by Lowcode instructions"
	<inline: #never>
	<option: #LowcodeVM>
	<var: #destAddress type: #'void*'>
	<var: #sourceAddress type: #'void*'>
	<var: #bytes type: #'sqInt'>
	
	"Using memmove instead of memcpy to avoid crashing GCC in Windows."
	self mem: destAddress mo: sourceAddress ve: bytes