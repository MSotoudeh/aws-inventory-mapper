#!/bin/bash

# AWS Inventory Collector Script
# This script collects AWS resource information and saves it as JSON files.

OUTPUT_DIR="aws_inventory"
mkdir -p "$OUTPUT_DIR"

echo "------------------------------------------"
echo "   AWS Inventory Collector (Bash)         "
echo "------------------------------------------"

# Select AWS Profile
read -p "Enter AWS Profile Name [default]: " AWS_PROFILE
AWS_PROFILE=${AWS_PROFILE:-default}
export AWS_PROFILE

echo "Using AWS Profile: $AWS_PROFILE"

# Check AWS CLI
if ! command -v aws &> /dev/null; then
    echo "Error: AWS CLI is not installed."
    exit 1
fi

# Function to collect data
collect() {
    local service=$1
    local command=$2
    local filename=$3
    echo "Collecting $service data..."
    aws $command > "$OUTPUT_DIR/$filename.json" 2>/dev/null
}

# Collection Process
collect "EC2 Instances" "ec2 describe-instances" "ec2_instances"
collect "VPCs" "ec2 describe-vpcs" "vpcs"
collect "Subnets" "ec2 describe-subnets" "subnets"
collect "Security Groups" "ec2 describe-security-groups" "security_groups"
collect "RDS Instances" "rds describe-db-instances" "rds_instances"
collect "Lambda Functions" "lambda list-functions" "lambda_functions"
collect "S3 Buckets" "s3api list-buckets" "s3_buckets"
collect "IAM Users" "iam list-users" "iam_users"
collect "ELB (v2)" "elbv2 describe-load-balancers" "load_balancers"

# Optional Lambda Config
read -p "Do you want to fetch detailed Lambda configurations? (y/n): " FETCH_LAMBDA
if [[ "$FETCH_LAMBDA" == "y" ]]; then
    echo "Fetching Lambda configurations (this may take time)..."
    # Logic to iterate through functions and get-config
fi

# Optional CloudMapper
read -p "Do you want to run CloudMapper visualization? (y/n): " RUN_CLOUDMAPPER
if [[ "$RUN_CLOUDMAPPER" == "y" ]]; then
    if [ -d "cloudmapper" ]; then
        echo "Starting CloudMapper..."
        # python3 cloudmapper.py prepare --account myaccount
        # python3 cloudmapper.py webserver
    else
        echo "CloudMapper directory not found. Please clone it first."
    fi
fi

echo "------------------------------------------"
echo "Collection complete. Files saved in $OUTPUT_DIR/"
echo "------------------------------------------"
