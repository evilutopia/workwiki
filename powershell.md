

批量缩短文件名名
--------------------------------

Get-childitem %pattern% |Rename-Item -NewName {$_.name.substring(0,$_.BaseName.length-4) + $_.Extension}

https://www.windowscentral.com/how-rename-multiple-files-bulk-windows-10#rename_filename_powershell
