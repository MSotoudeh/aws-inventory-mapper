# AWS Inventory Collector Script (PowerShell)
# This script collects AWS resource information and saves it as JSON files.

$OutputDir = "aws_inventory"
if (!(Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir
}

Write-Host "------------------------------------------" -ForegroundColor Cyan
Write-Host "   AWS Inventory Collector (PowerShell)   " -ForegroundColor Cyan
Write-Host "------------------------------------------" -ForegroundColor Cyan

# Select AWS Profile
$AwsProfile = Read-Host "Enter AWS Profile Name [default]"
if ([string]::IsNullOrWhiteSpace($AwsProfile)) { $AwsProfile = "default" }
$env:AWS_PROFILE = $AwsProfile

Write-Host "Using AWS Profile: $AwsProfile"

# Check AWS CLI
if (!(Get-Command aws -ErrorAction SilentlyContinue)) {
    Write-Error "AWS CLI is not installed."
    exit
}

# Function to collect data
function Collect-AwsData {
    param($Service, $Command, $Filename)
    Write-Host "Collecting $Service data..."
    $cmd = "aws $Command"
    Invoke-Expression $cmd | Out-File -FilePath "$OutputDir\$Filename.json"
}

# Collection Process
Collect-AwsData "EC2 Instances" "ec2 describe-instances" "ec2_instances"
Collect-AwsData "VPCs" "ec2 describe-vpcs" "vpcs"
Collect-AwsData "Subnets" "ec2 describe-subnets" "subnets"
Collect-AwsData "Security Groups" "ec2 describe-security-groups" "security_groups"
Collect-AwsData "RDS Instances" "rds describe-db-instances" "rds_instances"
Collect-AwsData "Lambda Functions" "lambda list-functions" "lambda_functions"
Collect-AwsData "S3 Buckets" "s3api list-buckets" "s3_buckets"
Collect-AwsData "IAM Users" "iam list-users" "iam_users"
Collect-AwsData "ELB (v2)" "elbv2 describe-load-balancers" "load_balancers"

Write-Host "------------------------------------------" -ForegroundColor Green
Write-Host "Collection complete. Files saved in $OutputDir\" -ForegroundColor Green
Write-Host "------------------------------------------" -ForegroundColor Green
