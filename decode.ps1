function decode($data)
{
	Add-Type -AssemblyName System.Web ;
	$final_string = "";
	do
	{
		if ($data -match '^\\') #Find "\"
		{
			if ($data.Substring(0, 12) -match '^\\\d{3}\\\d{3}\\\d{3}') 
			{
				$temp = $data.Substring(1, 11);
				$temp1 = $temp -Split '\\';
				$temp2 = "";
				foreach ($da in $temp1)
				{
					$temp2 += '%' + ([Convert]::ToInt32($da, 8)).ToString('X');
				}
				$final_string += [System.Web.HttpUtility]::UrlDecode($temp2); #Auto decode from UTF-8
			}
			$data = $data.Substring(12, $data.length - 12);
		}
		else
		{
			$final_string += $data[0];
			$data = $data.Substring(1, $data.length - 1);
		}
	}
	while ($data.length -gt 0)
	Write-Host $final_string;
}

decode("\345\257\206\347\240\201\345\267\262\350\277\207\346\234\237,\344\270\272\344\272\206\346\202\250\347\232\204\344\272\244\346\230\223\345\256\211\345\205\250\350\257\267\345\260\275\345\277\253\344\277\256\346\224\271\345\257\206\347\240\201");
