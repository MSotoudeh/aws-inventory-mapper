# AWS Inventory Mapper

## Overview

**AWS Inventory Mapper** is a public repository for a fully interactive and automated AWS inventory collection solution. This project helps DevOps engineers, cloud architects, or anyone managing complex AWS accounts to quickly map their cloud environment. The scripts collect key resources and optionally visualize network and service architecture using [CloudMapper](https://github.com/duo-labs/cloudmapper).

### Problem Statement

In large or legacy AWS accounts, it is often difficult to understand the architecture due to missing documentation. This causes risk when making changes, as there may be hidden dependencies, unknown network flows, or misconfigured security groups.

**Pain Points:**
- No existing documentation of VPCs, subnets, or network routes.
- Unknown Lambda functions, ECS tasks, and RDS instances.
- Lack of visibility into ECR repositories or Load Balancers.
- Risky changes without a clear architecture map.

### Solution

This repository provides:

1. **Bash and PowerShell scripts** for collecting AWS inventory in one step.
2. **Interactive prompts** for selecting AWS profile, optionally fetching Lambda configuration, and running CloudMapper visualization.
3. **Output JSON files** for all major AWS services:
   - EC2, Security Groups, Network Interfaces
   - Lambda functions (+ optional config)
   - ECS clusters and tasks
   - RDS instances and subnet groups
   - ECR repositories and images
   - Load Balancers, Listeners, Target Groups
   - VPC, Route Tables, NAT/Internet Gateways, Network ACLs
4. **Optional CloudMapper visualization** for network and service architecture.
5. **Cross-platform support**: Linux/macOS/WSL (Bash) and Windows (PowerShell + one-click .bat wrapper).

### Key Benefits

- Quickly gain **full visibility** into AWS account architecture.
- Avoid manual and error-prone documentation efforts.
- **Safe, read-only execution** — scripts do not modify any resources.
- Output files can be used for:
  - CloudMapper visualization
  - diagrams.net manual diagrams
  - internal documentation or audits

---

## Installation

### Prerequisites

- AWS CLI installed and configured with read-only access.
- Python 3.x installed.
- CloudMapper cloned and dependencies installed:
```bash
git clone https://github.com/duo-labs/cloudmapper.git
cd cloudmapper
pip install -r requirements.txt
```

## Usage

### Bash (Linux/macOS/WSL)
```bash
chmod +x collect_aws_inventory.sh
./collect_aws_inventory.sh
```

### PowerShell (Windows)
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\Collect-AwsInventory.ps1
```

### One-click Windows
Double-click `run_collect.bat` to start the PowerShell script with default settings.

### Interactive Features
- **AWS Profile selection**: Choose which profile to use or default.
- **Lambda configuration**: Optional per-function fetch with estimated runtime warning.
- **CloudMapper visualization**: Optional execution to generate web-based architecture map.

### Output
- All JSON output files are stored in `aws_inventory/`.
- CloudMapper runs a local web server showing:
  - VPC topology
  - Security Groups
  - EC2, ECS, Lambda, Load Balancer connections

### Recommendations
- Use `jq` (Linux/macOS) for robust parsing of JSON outputs.
- Ensure sufficient disk space for large accounts.
- Run in a read-only role to prevent accidental changes.

## License
MIT License – free and open source.

## Contributing
Pull requests welcome for:
- Adding support for additional AWS services.
- Enhancing visualization features.
- Multi-region or multi-account inventory collection.

## Contact
For questions or issues, open an issue in this repository.
