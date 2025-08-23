# Splunk Enterprise SIEM Project
Enterprise-Grade SIEM with Threat Detection, Threat Intelligence, and Compliance Dashboards

🔹 Project Overview

This project demonstrates the design and implementation of a Splunk-based SIEM architecture tailored for enterprise security, compliance, and SOC operations.
The setup includes log collection, data normalization, threat detection, threat intelligence integration, compliance monitoring, and automated incident response workflows.

🔹 Architecture Diagram

<img width="1536" height="1024" alt="ChatGPT Image Aug 23, 2025, 11_20_25 PM" src="https://github.com/user-attachments/assets/06a80436-c05e-4a4c-a4c2-89d965f8ada4" />


🔹 Features

✅ Splunk Enterprise Architecture – Search head, indexer, forwarders, deployment server.

✅ Log Onboarding – Windows, Linux, firewall, IDS, and AWS CloudTrail.

✅ Data Normalization – CIM-compliant field extractions using regex, props.conf, and transforms.conf.

✅ Detection Engineering – 10+ correlation rules mapped to MITRE ATT&CK (Brute Force, Privilege Escalation, Malware, Data Exfiltration, Suspicious PowerShell).

✅ Threat Intelligence Integration – STIX/TAXII and AbuseIPDB feeds ingested for IOC correlation.

✅ SOC Dashboards & Alerts – Real-time detection dashboards, alerting workflows, and compliance reports.

✅ Compliance Monitoring – PCI-DSS, HIPAA, and ISO 27001 dashboards and reports.

✅ SOAR Automation – Automated response playbooks (e.g., block IP, disable user, isolate endpoint).

✅ Performance Tuning – Index optimization, retention policies, license management.

🔹 Tech Stack

SIEM: Splunk Enterprise, Splunk ES

Threat Intel: STIX/TAXII, AbuseIPDB, MISP (optional)

Logs Sources: Windows Event Logs, Linux Syslog, Firewall (pfSense), IDS (Suricata/Snort), AWS CloudTrail

Automation: Splunk SOAR / Shuffle (open-source SOAR alternative)

Scripting: Python, Regex, Bash, PowerShell

🔹 Detection Use Cases
Use Case	MITRE ATT&CK Tactic	Example SPL Query
Brute Force Login	Credential Access	`index=wineventlog EventCode=4625
Privilege Escalation	Privilege Escalation	index=wineventlog EventCode=4672
Suspicious PowerShell	Execution	`index=powershell EventCode=4104
Data Exfiltration	Exfiltration	index=firewall action=allow bytes_out>10000000
Malware Communication	Command & Control	index=dns query=*known_bad_domain*

(Add more correlation rules as you build them)

🔹 Dashboards

SOC Dashboard: Failed logins, suspicious admin actions, malware alerts.

Threat Intel Dashboard: Matches between internal logs and threat intel feeds.

Compliance Dashboard: PCI-DSS/ISO 27001 activity reports for audits.

(Insert screenshots of your dashboards here)

🔹 Automation (SOAR Playbooks)

Automated phishing response (extract IOCs → search in Splunk → auto-block IP/domain).

Automated account disablement for multiple failed login attempts.

Firewall integration for malicious IP blocking.

(Insert SOAR workflow diagrams or screenshots here)

🔹 How to Reproduce

Install Splunk Enterprise (or Splunk Free Trial).

Configure forwarders on Windows/Linux/Firewall/Cloud instances.

Normalize logs using CIM.

Implement detection rules (SPL queries in /detections folder).

Import dashboards (/dashboards folder).

Configure threat intel feeds and SOAR integrations.

🔹 Deliverables

📄 Architecture Diagram

📊 SOC Dashboards Screenshots

⚡ Detection Queries (SPL)

🌐 Threat Intel Integration Demo

🤖 SOAR Playbooks

📑 Project Report (PDF)

🔹 Outcome

By completing this project, I demonstrated the ability to:

Design enterprise Splunk SIEM architectures.

Onboard and normalize multi-source security logs.

Develop MITRE ATT&CK–aligned correlation searches.

Integrate threat intelligence feeds.

Build compliance dashboards for PCI-DSS/ISO 27001.

Automate incident response with SOAR.
