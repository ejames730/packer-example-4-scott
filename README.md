# packer-example-4-scott
This is a Packer template written in HashiCorp Configuration Language (HCL) that defines a Packer build configuration for creating a custom Windows Server 2019 image on Google Cloud Platform (GCP). Packer is a tool used for creating machine images for multiple platforms, and in this case, it is used to create a customized Windows Server 2019 image with specific configurations and software installations.

## Let's break down the template section by section:

Variables: This section defines various input variables that can be used to customize the image creation process. Users can provide their desired values for these variables while running Packer.

packer: This section specifies required plugins for Packer. In this case, it requires the "googlecompute" plugin with version 1.0.0 or higher.

locals: This section defines a local variable called "hostname" and sets it to the value of the "name" variable.

source "googlecompute": This section defines the Google Cloud Platform as the source for the image. It configures various parameters like instance name, image name, description, project ID, machine type, subnetwork, network, zone, communicator (SSH in this case), disk size, and various other image-related settings.

build: This section defines the build process. It uses the source defined in the previous section to create a Google Cloud instance, customizes it by running PowerShell scripts, and then saves it as a new image.

## Inside the "build" section, there are two provisioners used to customize the instance:

provisioner "file": This provisioner copies files from the local machine to the instance. It copies Windows installer files from "./Software_tools/installers/Windows" to "C:\installers\" on the Google Cloud instance.

provisioner "powershell": This provisioner runs a PowerShell script on the instance. The script sets the User Account Control (UAC) off, which allows for elevated privileges without prompts. The script "uac_off.ps1" is executed on the instance using the "powershell -executionpolicy bypass" command.

provisioner "windows-restart": This provisioner restarts the instance after the UAC changes, which is necessary for the changes to take effect.

Overall, this Packer template creates a Windows Server 2019 image with specific configurations and software installations, and it can be used as a base image for launching instances on Google Cloud Platform. The resulting image will be saved on GCP with a name and description based on the provided variables.
