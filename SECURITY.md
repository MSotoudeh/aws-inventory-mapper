# Security

## Reporting a vulnerability

Please report security issues privately through GitHub: use "Report a vulnerability" under the repository's Security tab. Do not open a public issue with details.

## Secrets and data handling

- The scripts only call read-only AWS APIs and never write to your account.
- The output in `aws_inventory/` describes your infrastructure (account IDs, IPs, security group rules). It is git-ignored; do not publish it.
- Credentials stay in your AWS CLI configuration. Never put keys in this repository. Local secrets belong in git-ignored `secrets/` or `.env` files.
