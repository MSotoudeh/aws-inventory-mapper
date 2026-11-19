# History

## Why this exists

Large or legacy AWS accounts are often undocumented: nobody knows which VPCs, Lambda functions, databases or load balancers exist, which makes changes risky. This project started (February 2026) as a one-step way to dump an account's main resources to JSON, with the idea of feeding the result to CloudMapper for a network diagram.

## Phases

1. **2026-02-18, initial commit.** The repository was created in a single commit containing a Bash collector, a PowerShell collector, a Windows `.bat` wrapper, the README and the MIT license. This is the only commit before the cleanup; there are no other branches or tags.
2. **2026-11-19, public-ready cleanup.** Scripts moved into `scripts/` with kebab-case names, README rewritten to describe what the scripts really do, contributing and security documents added.

## Previous state versus current state

The original README described a broader tool than the code: it listed ECS, ECR, route tables, gateways, network ACLs and an optional per-function Lambda configuration fetch and CloudMapper run. The scripts only implement the nine collection calls listed in the README. The Lambda and CloudMapper prompts in the Bash script are stubs (commented-out code). The README now documents the real scope and lists the rest as unfinished.

## Unmerged lines of work

None. There were no other branches.

## Known unfinished

- Per-function Lambda configuration (`lambda get-function-configuration`) is a stub in the Bash script and missing from PowerShell.
- CloudMapper integration is commented out.
- ECS, ECR, route tables, gateways, network ACLs, network interfaces.
- Multi-region and multi-account collection.
- The Bash collector discards CLI errors (`2>/dev/null`), so a failed call leaves an empty file; the PowerShell collector does not check exit codes either.
