Splunk supports all major OS versions, has very straightforward steps to install, and can be up and running in less than 10 minutes on any platform. In this task, we will only focus on installing Splunk Enterprise on the Linux host. Typically, we would create an account on splunk.com and go to this Splunk Enterprise download link to select the installation package for the latest version. 
 
Note: You’re are expected to create an account and download the Splunk Enterprise during this lab.
This task will explore installing and configuring Splunk on a Linux machine. 

 





 



Splunk Installation
Splunk installation is as simple as running a command. You will need to uncompress Splunk by running the following command.

Note: Make sure, to run sudo su to change to the root user before applying commands.
After the installation is complete, a new folder named splunk will be created, as shown below. Let's now move this folder to the /opt/ directory and start working on Splunk from there.
 
Starting Splunk
The above step unzips the Splunk installer and installs all the necessary binaries and files on the system. Once installed, go to the directory /opt/splunk/bin and run the following command to start Splunk ./splunk start --accept-license. 
 
As it is the first time we are starting the Splunk instance, it will ask the user for admin credentials. Create a user account and proceed.
 
 
Enable Splunk to run after booting process:
Until now, we didn’t make the splunk to start or run automatically after the system is powered on. 
If we don’t enable it to run after the booting process, then everytime we need to start it manually which may be inconvenient for us.
so using the following command, we can enable the splunk to run automatically after boot process.
 
Accessing Splunk
We successfully installed Splunk on our Linux machine, which took us less than 10 minutes. 1. To access Splunk, open the browser within the VM and go to the address http://localhost:8000 or http://127.0.0.1:8000.

 
2. To Access it in the host machine’s browser go to the link http://your-vm-ip:8000/ .
 
 
Use the credentials you created during the installation to access the Splunk dashboard.
 

Splunk: Interacting with CLI
Now that we have installed Splunk, it's important to learn some key commands while interacting with Splunk instances through CLI. These commands are run from the /opt/splunk/ directory. It is important to note that we can use the same commands on different platforms.
Some important and commonly used commands are shown below:
Command: ./splunk start
 
The ./splunk start command is used to start the Splunk server. This command starts all the necessary Splunk processes and enables the server to accept incoming data. If the server is already running, this command will have no effect.
Command: ./splunk stop
 
The ./splunk stop command is used to stop the Splunk server. This command stops all the running Splunk processes and disables the server from accepting incoming data. If the server is not running, this command will have no effect.
Command: ./splunk restart
 
The ./splunk restart command is used to restart the Splunk server. This command stops all the running Splunk processes and then starts them again. This is useful when changes have been made to the Splunk configuration files or when the server needs to be restarted for any other reason.
Command: ./splunk status
 
The ./splunk status command is used to check the status of the Splunk server. This command will display information about the current state of the server, including whether it is running or not, and any errors that may be occurring.
Command: ./splunk add oneshot

The ./splunk add oneshot command is used to add a single event to the Splunk index. This is useful for testing purposes or for adding individual events that may not be part of a larger data stream.
Command: ./splunk search

The splunk search command is used to search for data in the Splunk index. This command can be used to search for specific events, as well as to perform more complex searches using Splunk's search language.
Command: ./splunk help
 
The most important command is the help command which provides all the help options.
These are just a few of the many CLI commands available in Splunk. Administrators can use the CLI to manage and configure their Splunk servers more efficiently and effectively.
Splunk: Data Ingestion 
Configuring data ingestion is an important part of Splunk. This allows for the data to be indexed and searchable for the analysts. Splunk accepts data from various log sources like Operating System logs, Web Applications, Intrusion Detection logs, Osquery logs, etc. In this task, we will use Splunk Forwarder to ingest the Linux logs into our Splunk instance.
Splunk Forwarders
Splunk has two primary types of forwarders that can be used in different use cases. They are explained below:
1.	Heavy Forwarders
Heavy forwarders are used when we need to apply a filter, analyze or make changes to the logs at the source before forwarding it to the destination. In this task, we will be installing and configuring Universal forwarders.
2.	Universal Forwarders
It is a lightweight agent that gets installed on the target host, and its main purpose is to get the logs and send them to the Splunk instance or another forwarder without applying any filters or indexing. It has to be downloaded separately and has to be enabled before use. In our case, we will use a universal forwarder to ingest logs.
Universal forwarders can be downloaded from the official Splunk website. It supports various OS, as shown below:
Note: The latest version available on the Splunk site.
 
For this task, the 64-bit version of Linux Forwarder is already downloaded with the Splunk Enterprise earlier.
Install Forwarder
Change the user to sudo, unpack, and install the forwarder with the following command.
$ tar xvzf splunkforwarder.tgz


 
 
The above command will install all required files in the folder splunkforwarder. Next, we will move this folder to /opt/ path with the command mv splunkforwarder /opt/.
 
Before installation, Go to the /opt/splunkforwarder/bin/ directory to execute the installation command.
We will run the Splunk forwarder instance now and provide it with the new credentials as shown below:
 
 
By default, Splunk forwarder runs on port 8089. If the system finds the port unavailable, it will ask the user for the custom port. In this example, we are using 8090 for the forwarder.
Now that we have installed the forwarder, it needs to know where to send the data. So we will configure it on the host end to send the data and configure Splunk so that it knows from where it is receiving the data.

Splunk Configuration
Log into Splunk and Go to Settings -> Forward and receiving tab as shown below:

 
It will show multiple options to configure both forwarding and receiving. As we want to receive data from the Linux endpoint, we will click on Add New in the Configure receiving section and then proceed by configuring a new receiving port.
 
By default, the Splunk instance receives data from the forwarder on the port 9997. It's up to us to use this port or change it. For now, we will configure our Splunk to start listening on port 9997 and save, as shown below:
 
Our listening port 9997 is now enabled and waiting for the data. If we want, we can delete this entry by clicking on the Delete option under the Actions column.

 
Creating Index
Now that we have enabled a listening port, the important next step is to create an index that will store all the receiving data. If we do not specify an index, it will start storing received data in the default index, which is called the main index.
 
The indexes tab contains all the indexes created by the user or by default. This shows some important metadata about the indexes like Size, Event Count, Home Path, Status, etc.
 

