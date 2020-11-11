state("pcsx2", "v1.4.0") // Offsets
{
    	int loading: "pcsx2.exe", 0x00964A54, 0xD30, 0x4AC, 0x54;
	string10 map: "pcsx2.exe", 0x009644A8, 0x588, 0x1C, 0x10A8;
}

init // Version specific
{
	byte[] exeMD5HashBytes = new byte[0];
	using (var md5 = System.Security.Cryptography.MD5.Create())
	{
		using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
		{
			exeMD5HashBytes = md5.ComputeHash(s);
		}
	}
	var MD5Hash = exeMD5HashBytes.Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
	//print("MD5Hash: " + MD5Hash.ToString());

	if(MD5Hash == "A193E39E8D9F6C53FE106C19765E5693")
	{
		version = "v1.4.0";
		print("Detected game version: " + version + " - MD5Hash: " + MD5Hash);
	}

    	else
	{
		version = "UNDETECTED";
		print("UNDETECTED GAME VERSION - MD5Hash: " + MD5Hash);
	}
}

isLoading // Gametimer
{
	return (current.loading == 1);
}

start // Start splitter
{
	if (current.loading == 0 && old.loading == 1 && current.map == "c1a0")
	{
		return true;
	}
}

update // Version specific
{
	if (version.Contains("UNDETECTED"))
		return false;
}
