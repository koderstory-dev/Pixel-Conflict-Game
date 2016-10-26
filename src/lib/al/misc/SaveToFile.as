package al.misc 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	public class SaveToFile 
	{
		//private static var stream	: FileStream 	= null;
		//public function SaveToFile() 
		//{
			//
		//}
		//
		//public static function openStream(_fileName:String = "SavedFile", _fileType:String="json") 
		//{
			//var fileToSave:File = File.applicationDirectory.resolvePath(_fileName);
			////var fileToSave:File = File.applicationStorageDirectory.resolvePath(_fileName);
			//var nativePath:String;
			//if( fileToSave.extension == null ) {
				//nativePath = fileToSave.nativePath + "."+_fileType+"";
			//}
			//else {
				//nativePath = fileToSave.nativePath.substr(0, fileToSave.nativePath.lastIndexOf(fileToSave.extension)) + ".csv";
			//}
		 //
			//var file:File = new File(nativePath);
			//if( file.exists ) {
				//file.deleteFile();
			//}
		 //
			//
			//stream	= new FileStream();
			//stream.open(file, FileMode.APPEND);
		//}
		//public static function closeStream()
		//{
			//if (stream != null)
			//{
				//stream.close();
				//stream = null;
			//}
			//
		//}
		//public static function save(_data:String):void
		//{
			//if (stream != null && _data!="" && _data!=null){
					//stream.writeUTFBytes(_data); // value being the clipboard content
					////trace("> Data has been written!");
			//} else throw("ERROR: Error Writing!");
		//}
		//public static function saveByColumn(_information:String, _information2:String="", _index:int=-1):void
		//{
			//if (stream != null){
				//stream.writeUTFBytes(_information + "," + _information2 + "\n"); // value being the clipboard content
				////if (_index == -1)
					////trace("> please wait. writing ...!");
				////else
					////trace(_index + " ) please wait. writing ...!");
			//} else throw("ERROR: Error Writing!");
		//}
		//
		//
	}

}