# Motiation
Does it bother you as well that when you want to RDP to an Azure Virtual Machine using "az bastion rdp", but for some reason it opens up on all your screens? yea.. 

# how to
Run AZ CLI 
`az network bastion rdp --name "<bastion name>" --resource-group "<resource group>" --target-resource-id "/subscriptions/<subscriptionID/resourceGroups/<resourcegroup>/providers/Microsoft.Compute/virtualMachines/<VMName here. I.e. Serv2022-Omri >"`

So far so good. Let it run and once you get prompt with the MSTSC window, close the that window and the terminal. 
<br>Then, run the Powershell code and enter your credential in the MSTSC pop up window and connect via one screen only.

## TODO
Automatically close the created terminal + mstsc.exe that is created with AZ CLI and run everything automatically from the ps1 script
