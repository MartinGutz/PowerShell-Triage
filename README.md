# PowerShell-Triage
Some powershell scripts you can run on a server to quickly pull data to help triage issues. The types of things that it CAN check for depends on the modules that are in the Modules folder and the the Modules that it actually checks for are listed in the Modules.txt file.

# What does this script do
This script <b>RunTriage.ps1</b> will import and run the modules that are listed in the Modules.txt text file. Then it will generate an HTML file.

# What is the purpose
The purpose of this script is to quickly triage a server. You can add/remove modules in order to investigate specific attributes Once you create the HTML report you can provide it to someone else to help provide you assistance in troubleshooting your server/application.

# What if there are modules that I don't want to run

Simply remove the module names from the Modules.txt file. Then it will no longer run. If you don't want to accidently add the module back in then you will need to remove the psm1 file from the Modules folder.

# Instructions

1 Download the Triage folder to the Windows server</br>
2 Run the <b>RunTriage.ps1</b> script</br>
3 View the results and check the Report folder to view the results of the script
