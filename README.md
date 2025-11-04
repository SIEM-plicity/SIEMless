# 🚨 SIEMplicity — SOC it to 'EM SIEMlessly
*(Cloud Incident Response Automator: IaC + SIEM + Automation)*

---

### 🧩 Executive Summary
SIEMplicity automates the ingestion, detection, and response of cloud security incidents using **AWS S3**, **Lambda**, and **EventBridge**.  
This system forms the foundation of a scalable SOC (Security Operations Center) framework, built on Terraform infrastructure-as-code.  
It automates event handling from file ingestion to security response — reducing manual workload and enabling near real-time alerting and remediation.

---

### 🎯 Project Goal & Scope
**Goal:**  
Develop an automated pipeline for ingesting and processing cloud security events using a serverless AWS architecture.

**Scope Includes:**
- Event-driven file ingestion pipeline (S3 → EventBridge → Lambda)
- Data validation and logging using Python and CloudWatch
- Infrastructure automation via Terraform
- Modular SIEM integration for Wazuh or OpenSearch
- Alignment with NIST SP 800-61 and CIS AWS Benchmarks

---

### 🧠 Methodology
**Framework:**  
Follows NIST Incident Response Lifecycle — *Preparation, Detection, Containment, Eradication, Recovery.*

**Tools & Technologies**
| Tool | Purpose |
|------|----------|
| **AWS S3** | Stores incoming logs or artifacts |
| **AWS Lambda** | Executes automated responses and parsing logic |
| **EventBridge** | Routes events to Lambda for processing |
| **CloudWatch** | Logs and monitors pipeline health |
| **Terraform** | Manages IaC and state backend (S3 + DynamoDB) |
| **Python (Boto3)** | Scripted automation and data processing |

---

### 🧱 Architecture Overview
*(Insert diagram)*  
📸 `diagrams/SIEMplicity_Pipeline.png`

**Workflow Summary**
1. S3 bucket receives a new file → emits `ObjectCreated` event.  
2. EventBridge rule triggers Lambda.  
3. Lambda parses, logs, and sends data to OpenSearch/Wazuh.  
4. CloudWatch monitors performance and error rates.

---

### ⚙️ Deployment Instructions
#### Prerequisites
- AWS account with IAM Admin role  
- Terraform v1.9+  
- Configured AWS CLI  

#### Steps
```bash
terraform init
terraform plan
terraform apply

Logs can be verified in CloudWatch under /aws/lambda/siem_ingestion_handler.

🧪 Testing & Findings
Scenario	Expected Behavior	Result	Status
File upload to S3 bucket	Lambda trigger executes	Success	✅
GuardDuty simulated alert	EventBridge routes correctly	Success	✅
CloudWatch log retrieval	Entry created with timestamp	Success	✅

Outcome:
Achieved 100% success rate in automated Lambda execution tests. Average response latency was <2s per event.

📊 Compliance & Observations

Security Controls: NIST SP 800-61, CIS AWS Foundations Benchmark v1.5

Forensics: S3 versioning and DynamoDB state lock ensure immutability

Scalability: Fully serverless and horizontally scalable

📎 Documentation

Technical Report PDF

Terraform Configuration

Lambda Automation Code

Evidence Screenshots

🧑‍💻 Author

Latrisha Dodson
AWS Cloud Security | SOC Automation | Privacy-by-Design Advocate
📧 Contact

🔗 LinkedIn
 | Portfolio

Tags: #AWS #Terraform #SIEM #Lambda #CloudSecurity #Automation


---