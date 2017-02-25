This class defines the necessary primitives for dropping files from the OS onto Squeak.

Implementation notes:
The drop support is really a two phase process. The first thing the OS code needs to do is to signal an event of type EventTypeDragDropFiles to Squeak. This event needs to include the following information (see sq.h for the definition of sqDragDropFilesEvent):
* dragType:
		DragEnter - dragging mouse entered Squeak window
		DragMove - dragging mouse moved within Squeak window
		DragLeave - dragging mouse left Squeak window
		DragDrop - dropped files onto Squeak window
* numFiles:
		The number of files in the drop operation.
* x, y, modifiers:
		Associated mouse state.

When these events are received, the primitives implemented by this plugin come into play. The two primitives can be used to either receive a list of file names or to receive a list of (read-only) file handles. Because drag and drop operations are intended to work in a restricted (plugin) environment, certain security precautions need to be taken:
* Access to the contents of the files (e.g., the file streams) must only be granted after a drop occured. Simply dragging the file over the Squeak window is not enough to grant access.
* Access to the contents of the files after a drop is allowed to bypass the file sandbox and create a read-only file stream directly.
* Access to the names of files can be granted even if the files are only dragged over Squeak (but not dropped). This is so that appropriate user feedback can be given.

If somehow possible, the support code should track the location of the drag-and-drop operation and generate appropriate DragMove type events. While not important right now, it will allow us to integrate OS DnD operations with Morphic DnD operation in a seemless manner.
