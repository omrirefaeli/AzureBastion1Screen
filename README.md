# Motiation
Does it bother you as well that when you want to RDP to an Azure Virtual Machine using "az bastion rdp", but for some reason it opens up on all your screens? yea.. 

# how to
1. Download [AZ CLI](https://learn.microsoft.com/en-us/cli/azure/?view=azure-cli-latest)
2. Run `az login` and authenticate.
3. Fill in the necessary details for your Azure Virutal Machine within the Powershell script to form a commnd of that sort:  
`az network bastion rdp --name "<bastion name>" --resource-group "<resource group>" --target-resource-id "/subscriptions/<subscriptionID/resourceGroups/<resourcegroup>/providers/Microsoft.Compute/virtualMachines/<VMName here. I.e. Serv2022-Omri >"`
4. Run the powershell script. An MSTSC windows will open and close automatically, then fill in your login creds in the MSTSC window and voilà.
