# CybersecurityBootcamp_Project1
First project for Cybersecurity Bootcamp - Tom Kastan

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

Diagrams/ElkStackDeployment.png

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the _____ file may be used to install only certain pieces of it, such as Filebeat.

The ELK deployment in this network was performed with the Ansible/ElkPlaybook.yml file, executing from Jump Box Provisioner in the RedTeams Network.

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the DVWA application will be highly available, in addition to restricting access to the network.
Load balancers route client requests across multiple servers capable of fulfilling those requests.  They provide a single point to control access to the site.  
The use of the load balancer also allows each virtual  machine to be taken off-line, updated, and then restored to service without taking down the entire Red Team Network.

The DVWA virtual machines were populated using Ansible with the Ansible/PentestPlaybook.yml from Jump Box Provisioner.  This allows identical installations of on each of the virtual machines, and 
will allow for the duplication of additional virtual machines shoud they become necessary.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for problems by centralizing logging with servers and applications.
Filebeat monitors log files on each VM, collects log events, and forwards them to Elasticsearch for indexing.
Metricbeat collects OS metrics for each VM status.

The configuration details of each machine may be found below.

| Name                | Function | IP Address | Operating System   |
|---------------------|----------|------------|--------------------|
| Jump-BoxProvisioner | Gateway  | 10.0.0.4   | Linux Ubuntu 18.04 |
| Web-1               | DVWA VM  | 10.0.0.5   | Linux Ubuntu 18.04 |
| Web-2               | DVWA VM  | 10.0.0.6   | Linux Ubuntu 18.04 |
| Web-3               | DVWA VM  | 10.0.0.7   | Linux Ubuntu 18.04 |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box-Provisioner machine (40.87.71.111) can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 165.225.60.61 for RedAdmin access to the RedTeamNet.
- 52.225.158.99 for RedTeam Load Balancer

Machines within the network can only be accessed by using Jump-Box-Provisioner with a public IP address of 40.87.71.111.
The Intenet can access the DVWA VMs via the RedTeamLB load balancer, with a public IP address of 52.255.159.99.
- _TODO: Which machine did you allow to access your ELK VM? What was its IP address?_

A summary of the access policies in place can be found in the table below.

RedTeamSG Security Rules
Priority| Name                               | Port  |   Protocol  |  Source            | Destination     |   Action
Inbound Security Rule|s
|100    |         Workstation_to VM_Port80   |  80   |   Any       |  165.225.60.61     | VirtualNetwork  |   Allow
|101    |         Ping                       | Any   |   ICMP      |  10.0.0.4          | VirtualNetwork  |   Allow
|102    |         SSH_from_Workstation       |  22   |   TCP       |  165.225.60.61     | Any             |   Allow
|103    |         RedTean_Pentest_Forwarding |  80   |   Any       |  52.255.158.99     | VirtualNetwork  |   Allow
|200    |         SSH_from_Jump_Box          |  22   |   TCP       |  10.0.0.4          | VirtualNetwork  |   Allow
|65000  |       AllowVnetInBound             | Any   |   Any       |  VIrualNetwork     | VIrtualNetwork  |   Allow
|65001  |       AllowAzureLoadBalancerBound  } Any   |   Any       |  AzureLoadBalancer | Any             |   Allow
|65500  |       DenyAllInbound               | Any   |   Any       |  Any               | Any             |   Deny
Outbound Security Rules
|230    |         AllowOutboundTraffic       | Any   |   Any       |  VirtualNetwork    | Any             |   Allow
|65000  |       AllowVnetOutBound            | Any   |   Any       |  VirtualNetwork    | VirtualNetwork  |   Allow
|65001  |       AllowInternetOutbound        | Any   |   Any       |  Any               | Internet        |   Allow
|65500  |       DenyAllOutbound              | Any   |   Any       }  Any               | Any             |   Deny

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it becomes repeatable for large scale deployments.

The playbook implements the following tasks:
- Increase memory on the VM to 262144.
- Install docker.io
- Install python3-pip
- Install python docker module
- Install sebp/elk:761
- Enable docker service

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
Images/psShowingElkOnElkbox.png

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
Web-1: 10.0.0.5
Web-2: 10.0.0.6
Web-3: 10.0.0.7

We have installed the following Beats on these machines:
Filebeat

These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- sudo docker container list -a
- sudo docker start compassionate_shannon
- sudo docker attach compassionate_shannon
- cd to /etc/ansible
- Copy the ElkPlaybook.yml file to /etc/ansible.
- Update the hosts file to include:
[elk]
<local_IP_address_of_new_ELK_server> ansible_python_interpeter=/usr/bin/python3

- Run the playbook, and navigate to the <local_IP_address_of_new_ELK_server> to check that the installation worked as expected.

|ElkBoxSG Security Rules
|Priority   |   Name                            |  Port  |   Protocol |     Source            | Destination     |  Action
Inbound Security Rules
|100        |   SSH_from_Workstation            |  22    |   Any      |    165.225.60.61      | VirtualNetwork  |  Allow
|101        |   WorkStation_kibana_localIIP     |  5601  |   TCP Any  |    165.225.60.61      | 10.1.0.4        |  Allow
|65000      |   AllowVnetInBound                |  Any   |   Any      |    VIrualNetwork      | VIrtualNetwork  |  Allow
|65001      |   AllowAzureLoadBalancerBound     |  Any   |   Any      |    AzureLoadBalancer  | Any             |  Allow
|65500      |   DenyAllInbound                  |  Any   |   Any      |    Any                | Any             |  Deny
Outbound Security Rules
|65000      |   AllowVnetOutBound               |  Any   |   Any      |    VirtualNetwork     | VirtualNetwork  |  Allow
|65001      |   AllowInternetOutbound           |  Any   |   Any      |    Any                | Internet        |  Allow
|65500      |   DenyAllOutbound                 |  Any   |   Any      |    Any                | Any             |  Deny

### Exploring Kibana
Answer the following Questions:

- In the last 7 days, how many unique visitors were located in India?
There were 231 unique vistors from India in the last seven days.
Images/IndiaWebVisitors.png


- In the last 24 hours, of the visitors from China, how many were using Mac OSX?
In the last 24 hours, eleven unique visitors from China were using Mac OSX.
Images/China24hOsx.png


- In the last 2 days, what percentage of visitors received 404 errors? How about 503 errors?
I was able to generate the table, but could not determine how to provide percentages for the error codes with the time I had.
Images/ResponseCode2Days.png

- In the last 7 days, what country produced the majority of the traffic on the website?
In the last seven days, the majority of traffic was produced by China.
Images/TrafficLast7Days.png

- Of the traffic that's coming from that country, what time of day had the highest amount of activity?
The highest traffic from China was at hour 12.
Images/TrafficHeatmapByCountry.png
Images/TrafficHeatmapMaxVisits.png


- List all the types of downloaded files that have been identified for the last 7 days, along with a short description of each file type
rpm = RPM Package Manager, an open source package manager.
deb = standard Unix archive format containing two zipped files, one for the installer control information, and the other for the installable files.
zip = an archive file format that supports lossless compression.
css = Cascading Style Sheets is a style sheet for presentation of a document written in a markup language.
gz = gnu zipped file format.
Images/FileTypes7Days.png


= Unique Visitors vs Average Bytes
- Locate the time frame within the last 7 days with teh most amount of bytes
28 March 2021 21:00 to 29 March 2021 00:00 had the most bytes with three visitors
Images/EventAvgBytes.png

- In your own words, is there anything that seems potentially strange about this activity?
three users had the highest number of average bytes.
Images/EventZoom.png

- What is the timestamp of the event
The largest download occured at 22:00 on 28 March 2021.  It was the download of a 15.3 kilobyte rpm file.
Images/EventZoomFirst.png

I was able to trace the visitor to India.
Images/EventSourcIndia.png

DISCOVERY did not yield any additional information for this event.