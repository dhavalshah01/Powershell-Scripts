Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
 
#Set these two variables accordingly
$WebURL  = "<Site Url>"
$ListName = "<List Name>"
$XMLFilePath = "<folder Location>\exporteddata.xml\XMLReusable.xml"
 
#Get the Web
$web = Get-SPWeb $WebURL
#Get the List
$ContentList = $web.Lists[$ListName]
 
#import xml file
[xml]$DataFile = Get-Content $XMLFilePath
 
foreach ($reusableContent in $DataFile.ListData.ListItem)
 {
        $NewListITem = $ContentList.Items.Add()         
        
        #Add your columns here
        $NewListITem["Title"] = $reusableContent.Title        
        $NewListITem["Reusable HTML"] = $reusableContent.ReusableHTML    
                
        $NewListITem.Update()
        
        Write-Host "List Item $($reusableContent.Title) has been Added to list!"
 }

