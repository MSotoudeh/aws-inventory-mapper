# Contributing

## Setup

You need the AWS CLI and either Bash or PowerShell 5.1+. To try changes safely, use a profile with read-only permissions (for example the AWS-managed `ReadOnlyAccess` or `SecurityAudit` policy).

## Checks before a pull request

```bash
bash -n scripts/collect-aws-inventory.sh
```

```powershell
$e=$null;$t=$null;[void][System.Management.Automation.Language.Parser]::ParseFile("scripts/collect-aws-inventory.ps1",[ref]$t,[ref]$e); $e.Count   # must be 0
```

Keep the Bash and PowerShell collectors in sync: a new resource type goes into both, with the same output file name. Scripts must stay read-only (`describe`, `list`, `get` calls only).

## Branches and commits

Branch from the default branch using `feat/...`, `fix/...`, `docs/...` or `chore/...`. Use [Conventional Commits](https://www.conventionalcommits.org/), for example `feat(collector): add ecs list-clusters`. Never commit collected output; `aws_inventory/` and `*.json` are git-ignored.
