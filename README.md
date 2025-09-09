# Splunk Enterprise Lab with Snort IDS
# Project Description
- This project provides a step-by-step guide to installing, configuring, and running Splunk Enterprise on a Linux environment. Splunk is a leading platform for searching, monitoring, and analyzing machine-generated data in real time.

The documentation covers:

🔧 Installing Splunk Enterprise on Linux

⚙️ Configuring Splunk services and enabling auto-start on boot

🌐 Accessing the Splunk Web Interface from both local and remote machines

💻 Managing Splunk through the Command-Line Interface (CLI)

📥 Installing and configuring Splunk Universal Forwarders for log ingestion

📂 Creating Indexes and configuring data ingestion for centralized monitoring

This project is designed for:

🎓 Students & beginners in Cybersecurity or SIEM administration

🛠️ SOC Analysts and engineers building hands-on labs

🚀 Professionals looking to strengthen skills in log management & threat monitoring

By the end of this project, you will have a fully functional Splunk setup with data ingestion enabled, making it a perfect foundation for security monitoring and SOC lab practice.

# Key Components
1. Splunk Enterprise
2. Universal Forwarder
3. Snort IDS
4. Microsoft Defender for Endpoint
5. Attacker Machine (Kali Linux)
6. Ubuntu Desktop
7. VMware Workstation 7

# Key Features
🚀 Quick Installation – Step-by-step setup of Splunk Enterprise on Linux in under 10 minutes.

⚙️ Auto-Start Configuration – Enable Splunk to automatically start on system boot.

🌐 Web Access – Access Splunk from both the local VM and host machine browser.

💻 CLI Management – Commonly used Splunk commands (start, stop, restart, status, etc.) highlighted and explained.

📥 Data Ingestion – Configure Universal Forwarders to collect and send logs from endpoints.

📂 Custom Indexing – Create and manage indexes to organize and store ingested data.

🔒 SOC Lab Ready – Ideal setup for Security Operations Center (SOC) training and log analysis practice.

📊 Dashboard Access – Explore Splunk’s powerful GUI for searching, analyzing, and visualizing machine data.

- Splunk supports all major OS versions, has very straightforward steps to install, and can be up and running in less than 10 minutes on any platform. In this task, we will only focus on installing Splunk Enterprise on the Linux host.
- Typically, we would create an account on https://www.splunk.com/ and go to this https://www.splunk.com/en_us/download/splunk-enterprise.html?locale=en_us download link to select the installation package for the latest version. 
 <img width="940" height="225" alt="image" src="https://github.com/user-attachments/assets/a5c15c8f-2505-4efe-a8f2-7d0d8346bde1" />

Note: You’re are expected to create an account and download the Splunk Enterprise during this lab.
- This task will explore installing and configuring Splunk on a Linux machine. 
<img width="940" height="478" alt="image" src="https://github.com/user-attachments/assets/a0574ec9-99d7-48f5-9e12-464668779a4a" />

- After creating an Account in the Splunk Website, Navigate to Free trials & Downloads page and select Splunk Enterprise and Click on Copy `Wget` Link and paste it in the terminal.
<img width="931" height="317" alt="image" src="https://github.com/user-attachments/assets/7712761b-34d7-4a10-b3b3-4f1c94a1a33e" />

- Now in the same Free trials page, navigate to Universal Forwarder section and Copy the `Wget` command and paste it after the execution of the previous command.
<img width="912" height="227" alt="image" src="https://github.com/user-attachments/assets/0cd37db1-7e0c-45fe-83a5-336ce9ddcd2d" />

<img width="940" height="408" alt="image" src="https://github.com/user-attachments/assets/7b5df221-3007-4e8e-86a6-c78815cae82f" />

- Now we can see the `Splunk Enterprise` and `Universal Forwarder` has been downloaded and ready to install.
<img width="940" height="410" alt="image" src="https://github.com/user-attachments/assets/78b8232f-c9c1-4867-9296-c5894045720a" />



# Splunk Installation
- Splunk installation is as simple as running a command. You will need to uncompress Splunk by running the following command.
  `$ tar xvzf splunkforwarder.tgz`
<img width="842" height="416" alt="image" src="https://github.com/user-attachments/assets/af019488-cf86-4725-aafc-6058774da867" />

Note: Make sure, to run sudo su to change to the root user before applying commands.
- After the installation is complete, a new folder named splunk will be created, as shown below. Let's now move this folder to the `/opt/` directory and start working on Splunk from there.
 <img width="940" height="403" alt="image" src="https://github.com/user-attachments/assets/63ecec1a-b825-4bcd-8363-5173ca985c94" />

# Starting Splunk
- The above step unzips the Splunk installer and installs all the necessary binaries and files on the system. Once installed, go to the directory `/opt/splunk/bin` and run the following command to start Splunk `./splunk start --accept-license`. 
 <img width="940" height="405" alt="image" src="https://github.com/user-attachments/assets/fa785f7e-3f14-4180-a6e6-8471db71c732" />

- As it is the first time we are starting the Splunk instance, it will ask the user for admin credentials. Create a user account and proceed.
 <img width="940" height="408" alt="image" src="https://github.com/user-attachments/assets/3ab17c89-7a21-4d61-b0f5-48dead26632a" />
<img width="940" height="495" alt="image" src="https://github.com/user-attachments/assets/22c1e8a4-a76e-4c54-8c73-125cb6cafa61" />

 
# Enable Splunk to run after booting process:
- Until now, we didn’t make the splunk to start or run automatically after the system is powered on. 
- If we don’t enable it to run after the booting process, then everytime we need to start it manually which may be inconvenient for us.
- so using the following command, we can enable the splunk to run automatically after boot process.
 <img width="940" height="111" alt="image" src="https://github.com/user-attachments/assets/386378b7-d4db-4e5d-80ba-2d70840d5530" />




# Accessing Splunk

1. To access Splunk, open the browser within the VM and go to the address http://localhost:8000 or http://127.0.0.1:8000.
<img width="940" height="474" alt="image" src="https://github.com/user-attachments/assets/9ab5fa56-8a58-476f-aeec-7234229ab504" />
 
2. To Access it in the host machine’s browser go to the link http://your-vm-ip:8000/ .
 <img width="748" height="225" alt="image" src="https://github.com/user-attachments/assets/99009614-18a8-4073-a042-48580a3fa864" />

 <img width="940" height="476" alt="image" src="https://github.com/user-attachments/assets/935176b2-c51f-4944-8eac-b756ee91e923" />

Use the credentials you created during the installation to access the Splunk dashboard.
 <img width="940" height="474" alt="image" src="https://github.com/user-attachments/assets/dbf3c6b1-889e-4d2b-b81e-b6aeeabdc3e7" />


# Splunk: Interacting with CLI
Now that we have installed Splunk, it's important to learn some key commands while interacting with Splunk instances through CLI. These commands are run from the `/opt/splunk/` directory. It is important to note that we can use the same commands on different platforms.
Some important and commonly used commands are shown below:

- Command: `./splunk start`
 <img width="474" height="209" alt="image" src="https://github.com/user-attachments/assets/f0ba12f7-4297-4566-a7bc-72d8994aa56a" />

The `./splunk start` command is used to start the Splunk server. This command starts all the necessary Splunk processes and enables the server to accept incoming data. If the server is already running, this command will have no effect.
- Command: `./splunk stop`
 <img width="599" height="174" alt="image" src="https://github.com/user-attachments/assets/87cece77-84be-40fc-9ccc-9777416be3af" />

The `./splunk stop` command is used to stop the Splunk server. This command stops all the running Splunk processes and disables the server from accepting incoming data. If the server is not running, this command will have no effect.
- Command: `./splunk restart`
 <img width="940" height="493" alt="image" src="https://github.com/user-attachments/assets/2098cace-bb83-4dd3-91c8-dcfd207fd047" />

The `./splunk restart` command is used to restart the Splunk server. This command stops all the running Splunk processes and then starts them again. This is useful when changes have been made to the Splunk configuration files or when the server needs to be restarted for any other reason.
- Command: `./splunk status`
 <img width="940" height="99" alt="image" src="https://github.com/user-attachments/assets/147a73e1-56a2-4c99-9630-8ddca327eaef" />

The `./splunk status` command is used to check the status of the Splunk server. This command will display information about the current state of the server, including whether it is running or not, and any errors that may be occurring.
- Command: `./splunk add oneshot`

The `./splunk add oneshot` command is used to add a single event to the Splunk index. This is useful for testing purposes or for adding individual events that may not be part of a larger data stream.
- Command: `./splunk search`

The `./splunk search` command is used to search for data in the Splunk index. This command can be used to search for specific events, as well as to perform more complex searches using Splunk's search language.
- Command: `./splunk help`
 <img width="940" height="454" alt="image" src="https://github.com/user-attachments/assets/8598d5de-55ad-41cf-ba1d-f8215e7016ac" />

The most important command is the help command which provides all the help options.
These are just a few of the many CLI commands available in Splunk. Administrators can use the CLI to manage and configure their Splunk servers more efficiently and effectively.

# Splunk: Data Ingestion 
Configuring data ingestion is an important part of Splunk. This allows for the data to be indexed and searchable for the analysts. Splunk accepts data from various log sources like Operating System logs, Web Applications, Intrusion Detection logs, Osquery logs, etc. In this task, we will use Splunk Forwarder to ingest the Linux logs into our Splunk instance.

- Splunk Forwarders
Splunk has two primary types of forwarders that can be used in different use cases. They are explained below:
1.	Heavy Forwarders
Heavy forwarders are used when we need to apply a filter, analyze or make changes to the logs at the source before forwarding it to the destination. In this task, we will be installing and configuring Universal forwarders.
2.	Universal Forwarders
It is a lightweight agent that gets installed on the target host, and its main purpose is to get the logs and send them to the Splunk instance or another forwarder without applying any filters or indexing. It has to be downloaded separately and has to be enabled before use. In our case, we will use a universal forwarder to ingest logs.
Universal forwarders can be downloaded from the official Splunk website. It supports various OS, as shown below:
Note: The latest version available on the Splunk site.
 <img width="940" height="402" alt="image" src="https://github.com/user-attachments/assets/6544f0ec-9b7f-4eb1-89bd-630175d116f6" />

For this task, the 64-bit version of Linux Forwarder is already downloaded with the Splunk Enterprise earlier.
# Install Forwarder
Change the user to sudo, unpack, and install the forwarder with the following command.
`$ tar xvzf splunkforwarder.tgz`

<img width="940" height="152" alt="image" src="https://github.com/user-attachments/assets/1367273d-2fa4-4fd1-a927-37bbd0f8d888" />
<img width="940" height="202" alt="image" src="https://github.com/user-attachments/assets/b6328fe7-9e67-4fa4-b0ae-1d4edc7c9b6e" />

 
 
The above command will install all required files in the folder splunkforwarder. Next, we will move this folder to /opt/ path with the command mv splunkforwarder /opt/.
 <img width="940" height="312" alt="image" src="https://github.com/user-attachments/assets/6770e3c3-1a30-4d27-9974-e949a1bae4ec" />

Before installation, Go to the /opt/splunkforwarder/bin/ directory to execute the installation command.
<img width="940" height="555" alt="image" src="https://github.com/user-attachments/assets/99d47d1b-a209-4bd1-9691-55019e6bfb0b" />

We will run the Splunk forwarder instance now and provide it with the new credentials as shown below:
 <img width="940" height="486" alt="image" src="https://github.com/user-attachments/assets/f333d17e-6844-4600-b75b-669f2071a7d3" />

 <img width="940" height="285" alt="image" src="https://github.com/user-attachments/assets/c7dc7f37-9ef4-4088-805d-edc0bc14ec8a" />

By default, Splunk forwarder runs on port 8089. If the system finds the port unavailable, it will ask the user for the custom port. In this example, we are using 8090 for the forwarder.
Now that we have installed the forwarder, it needs to know where to send the data. So we will configure it on the host end to send the data and configure Splunk so that it knows from where it is receiving the data.

# Splunk Configuration
Log into Splunk and Go to Settings -> Forward and receiving tab as shown below:

 <img width="940" height="297" alt="image" src="https://github.com/user-attachments/assets/1b8ab7ae-b95a-414c-a642-254ee96753d4" />

It will show multiple options to configure both forwarding and receiving. As we want to receive data from the Linux endpoint, we will click on Add New in the Configure receiving section and then proceed by configuring a new receiving port.
 <img width="940" height="427" alt="image" src="https://github.com/user-attachments/assets/413319fa-3929-46a5-8682-7406f1398a6b" />

By default, the Splunk instance receives data from the forwarder on the port 9997. It's up to us to use this port or change it. For now, we will configure our Splunk to start listening on port 9997 and save, as shown below:
 <img width="940" height="300" alt="image" src="https://github.com/user-attachments/assets/75b06323-3855-46e4-a08a-725d6045c2a2" />

Our listening port 9997 is now enabled and waiting for the data. If we want, we can delete this entry by clicking on the Delete option under the Actions column.
<img width="940" height="283" alt="image" src="https://github.com/user-attachments/assets/d3fea7e7-815f-47ec-aa27-e28ad7d7e489" />

 
# Creating Index
Now that we have enabled a listening port, the important next step is to create an index that will store all the receiving data. If we do not specify an index, it will start storing received data in the default index, which is called the main index.
 <img width="940" height="289" alt="image" src="https://github.com/user-attachments/assets/abd23374-a621-4041-86f0-03bfca53af00" />

The indexes tab contains all the indexes created by the user or by default. This shows some important metadata about the indexes like Size, Event Count, Home Path, Status, etc.
<img width="940" height="495" alt="image" src="https://github.com/user-attachments/assets/fa15ce29-0e7c-40f9-8613-7a5f61d26a2a" />

