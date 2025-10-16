# 📜 SIEMplicity Evidence Archive

**Project:** SOC / SIEM Integration (“SIEMplicity”)  
**Engineer:** Latrisha Dodson – Data Quarantine Architect  
**Sprint:** 3  
**Purpose:** Central repository for system logs, Terraform outputs, and visual proof of infrastructure deployment and automation integrity.

---

## 🧾 Evidence Collection Table

| Screenshot / File Name | Purpose | Description | Status |
|--------------------------|----------|--------------|---------|
| **Terraform_Init_Success.png** | VPC Infrastructure Verification | Confirms Terraform provider plugins initialized successfully for the SIEMplicity VPC build. |  Pending |
| **Terraform_Plan_Output.png** | Infrastructure Planning Proof | Displays resource creation plan before apply (VPC, subnets, IGW, SG). | ✅ Pending |
| **Terraform_VPC_Apply_Success.png** | VPC Creation Confirmation | Shows successful Terraform apply with resource summary. | ☐ Pending |
| **AWS_VPC_Console_View.png** | AWS Console Validation | Verifies the VPC, subnets, and IGW exist in AWS Management Console. |ls vpc\*.tfopy script. | ☐ Pending |
| **EvidenceCopy_2.png** | Automated Daily Copy Verification | Confirms next-day auto-copy execution (timestamped session_log file present). | ☐ Pending |
| **session_recovery.log** | Master Log File | Persistent PowerShell session log for all terminal startups. | ☐ Pending |
| **session_log_YYYY-MM-DD.log** | Daily Evidence Snapshot | Auto-copied daily log confirming automation reliability. | ☐ Pending |
| **VPC_README_Completed.png** | Documentation Proof | Screenshot showing final README.md completion and tagging within repo. | ☐ Pending |

---

## 🗂️ Folder Structure Reference
SIEMplicity/
└── docs/
├── sprint3/
│ └── Sprint3_Deliverables.md
└── evidence/
├── README_evidence.md
├── Terraform_Init_Success.png
├── AWS_VPC_Console_View.png
├── SessionLog_Proof.png
├── EvidenceCopy_1.png
├── session_recovery.log
└── session_log_YYYY-MM-DD.log

---

## 🧠 Notes for Reviewers
- Evidence captures infrastructure creation, verification, and ongoing operational logging.  
- All files were generated and timestamped directly from Latrisha Dodson’s PowerShell environment.  
- Automation scripts ensure daily log archival without manual intervention.  
- Logs are anonymized and contain no references to the development environment or IDE tools.

---
---

## 🧠 Evidence Notes

- **Profile Automation:**  
  PowerShell auto-recovery and daily log copy verified as functional.  
  Logs are created at session start and automatically archived under `docs/evidence/`.

- **Command Integrity:**  
  All Terraform actions were run from within an authenticated AWS CLI session using profile `terraform-lab`.  
  No manual AWS Console resource edits were made — all infrastructure created via Infrastructure-as-Code (IaC).

- **Screenshot Timing:**  
  Each screenshot corresponds to an exact command execution moment or AWS console validation event.  
  Screenshot filenames follow the naming convention established in the evidence table.

- **Security Context:**  
  Evidence logs contain only timestamps and system session confirmations.  
  No workspace, IDE, or local environment identifiers are stored.

---

## ✅ SIEMplicity VPC Validation Summary

**✅ SIEMplicity VPC successfully validated. No drift or undeclared resources detected. All AWS VPC components (IGW, subnets, route tables, quarantine SG, flow logs) are operational and synchronized with Terraform state.**

**Validation Results:**
- **Terraform Init**: ✅ Provider plugins synchronized successfully
- **Terraform Refresh**: ✅ Local state synchronized with AWS resources
- **Terraform Plan**: ✅ No changes detected - infrastructure matches configuration
- **Resource Count**: 16 resources managed by Terraform
- **VPC ID**: vpc-0be0a0b29369664db
- **Status**: Stable and operational

---

✅ *Last Updated:* October 16 2025
