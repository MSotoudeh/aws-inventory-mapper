# AWS Inventory Mapper

Small read-only scripts that dump a snapshot of the main resources of an AWS account to JSON files, so you can see what is there before you change anything.

## Status

**Active, early stage.** The core collector works for nine resource types. Two interactive options (detailed Lambda configuration, CloudMapper launch) are placeholders that are not implemented yet; see [docs/HISTORY.md](docs/HISTORY.md).

## What it does

Asks for an AWS CLI profile, then runs read-only AWS CLI `describe`/`list` calls and writes one JSON file per resource type into `aws_inventory/`:

| File | AWS CLI call |
| --- | --- |
| `ec2_instances.json` | `ec2 describe-instances` |
| `vpcs.json` | `ec2 describe-vpcs` |
| `subnets.json` | `ec2 describe-subnets` |
| `security_groups.json` | `ec2 describe-security-groups` |
| `rds_instances.json` | `rds describe-db-instances` |
| `lambda_functions.json` | `lambda list-functions` |
| `s3_buckets.json` | `s3api list-buckets` |
| `iam_users.json` | `iam list-users` |
| `load_balancers.json` | `elbv2 describe-load-balancers` |

Only the default region of the chosen profile is queried. Nothing is modified in the account. The output is account data: it is git-ignored, keep it out of public places.

## How it works

Two equivalent scripts (Bash and PowerShell) share one flow: choose profile, check that `aws` is installed, loop over a list of (label, CLI command, output file). `scripts/run-collect.bat` is a double-click wrapper for the PowerShell script on Windows. The output can then be fed to tools such as [CloudMapper](https://github.com/duo-labs/cloudmapper) or used for manual diagrams.

Not implemented yet (the scripts print prompts or contain commented-out code only): per-function Lambda configuration, CloudMapper launch, ECS, ECR, route tables, gateways, network ACLs, multi-region and multi-account collection.

## Quick start

Prerequisite: [AWS CLI](https://aws.amazon.com/cli/) configured with a profile that has read-only access.

Bash (Linux, macOS, WSL, Git Bash):

```bash
chmod +x scripts/collect-aws-inventory.sh
./scripts/collect-aws-inventory.sh
```

PowerShell (Windows):

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\collect-aws-inventory.ps1
```

Windows one-click: double-click `scripts\run-collect.bat`.

Results appear in `aws_inventory/` in the directory you ran the script from.

## Configuration

The scripts are interactive and read no configuration file. They honour the standard AWS CLI environment (`AWS_PROFILE` is set from your answer to the prompt; `AWS_REGION` / `AWS_DEFAULT_REGION` select the region). There is no `.env` file.

## Project layout

```
scripts/   collect-aws-inventory.sh / .ps1 collectors, run-collect.bat wrapper
docs/      project history
```

## Testing

There is no automated test suite (the scripts need a live AWS account). Syntax checks:

```bash
bash -n scripts/collect-aws-inventory.sh
```

```powershell
$e=$null;$t=$null;[void][System.Management.Automation.Language.Parser]::ParseFile("scripts/collect-aws-inventory.ps1",[ref]$t,[ref]$e); $e.Count
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Security reports: [SECURITY.md](SECURITY.md).

## License

[MIT](LICENSE)
