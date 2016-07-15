Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
 
#Set these three variables accordingly
$WebURL  = "<Site Url>"
$ListName = "<List Name>"
$XMLFilePath = "<folder Location>\exporteddata.xml"
 
#Get the Web
$web = Get-SPWeb $WebURL
#Get the List
$ListName = $web.Lists[$ListName]
 
#Create a XML File
$XMLFile = New-Object System.Xml.XmlDocument
#Add XML Declaration
[System.Xml.XmlDeclaration] $xmlDeclaration = $XMLFile.CreateXmlDeclaration("1.0", "UTF-16", $null);
$XMLFile.AppendChild($xmlDeclaration) | Out-Null
    
 #Create Root Elemment "ListData"
$ListDataElement = $XMLFile.CreateElement("ListData")
  
 #Iterate through each list item and send Rows to XML file
foreach ($Item in $ListName.Items)
 {
  #Add "ListItem" node under "ListData" Root node
  $ListItemElement = $XMLFile.CreateElement("ListItem")
  
  #Create the columns here and their corresponding XML Code
  
  #Add "ID" attribute to "ListItem" element
  $ListItemElement.SetAttribute("id", $Item["ID"])
  $ListDataElement.AppendChild($ListItemElement)  | Out-Null
   
  #Populate Each Columns
  #Add "Title" node under "ListItem" node
  $TitleElement = $XMLFile.CreateElement("Title");
  $TitleElement.InnerText =  $Item["Title"] 
  #Append it to "ListItem" node
  $ListItemElement.AppendChild($TitleElement) | Out-Null
   
  #Add "Project Manager" element under "ListItem" node
  $ReusableHTMLElement = $XMLFile.CreateElement("ReusableHTML");
  $ReusableHTMLElement.InnerText = $Item["Reusable HTML"] 
  #Append it to "ListItem" node
  $ListItemElement.AppendChild($ReusableHTMLElement) | Out-Null
   

 }
  #Close the Root Element
  $XMLFile.AppendChild($ListDataElement) | Out-Null
  #Save all changes
  $XMLFile.Save($XMLFilePath)
