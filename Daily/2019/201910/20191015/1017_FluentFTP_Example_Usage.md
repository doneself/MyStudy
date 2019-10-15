## FluentFTP Example Usage

```csharp
// create an FTP client
FtpClient client = new FtpClient("123.123.123.123");

// if you don't specify login credentials, we use the "anonymous" user account
client.Credentials = new NetworkCredential("david", "pass123");

// begin connecting to the server
client.Connect();

// get a list of files and directories in the "/htdocs" folder
foreach (FtpListItem item in client.GetListing("/htdocs")) {

	// if this is a file
	if (item.Type == FtpFileSystemObjectType.File){

		// get the file size
		long size = client.GetFileSize(item.FullName);

	}

	// get modified date/time of the file or folder
	DateTime time = client.GetModifiedTime(item.FullName);

	// calculate a hash for the file on the server side (default algorithm)
	FtpHash hash = client.GetHash(item.FullName);

}

// upload a file
client.UploadFile(@"C:\MyVideo.mp4", "/htdocs/MyVideo.mp4");

// rename the uploaded file
client.Rename("/htdocs/MyVideo.mp4", "/htdocs/MyVideo_2.mp4");

// download the file again
client.DownloadFile(@"C:\MyVideo_2.mp4", "/htdocs/MyVideo_2.mp4");

// delete the file
client.DeleteFile("/htdocs/MyVideo_2.mp4");

// delete a folder recursively
client.DeleteDirectory("/htdocs/extras/");

// check if a file exists
if (client.FileExists("/htdocs/big2.txt")){ }

// check if a folder exists
if (client.DirectoryExists("/htdocs/extras/")){ }

// upload a file and retry 3 times before giving up
client.RetryAttempts = 3;
client.UploadFile(@"C:\MyVideo.mp4", "/htdocs/big.txt", FtpExists.Overwrite, false, FtpVerify.Retry);

// disconnect! good bye!
client.Disconnect();
```

