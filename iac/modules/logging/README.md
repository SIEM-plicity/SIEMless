# Logging Module

This Terraform module provisions the core logging infrastructure for SIEMplicity, a SIEM + SOC integration project that centralizes AWS security logs (CloudTrail, GuardDuty, VPC Flow Logs) into OpenSearch for analytics and threat detection.

## Architecture Overview

The logging module implements a robust data ingestion pipeline with the following flow:

```
AWS Security Logs → Kinesis Firehose → OpenSearch Domain
                                ↓
                            S3 Archive Bucket (Backup)
                                ↓
                            CloudWatch Logs (Monitoring)
```

### Data Flow Components

1. **S3 Archive Bucket**: Stores backup copies of all ingested logs with GZIP compression
2. **Kinesis Firehose**: Real-time data streaming service that buffers and delivers logs
3. **OpenSearch Domain**: Primary destination for log indexing and analysis
4. **CloudWatch Logs**: Monitoring and observability for delivery stream operations

### Key Features

- **Dual Delivery**: Primary delivery to OpenSearch with S3 backup for data durability
- **Buffering**: Configurable buffering (300 seconds, 5MB) for optimal performance
- **Compression**: GZIP compression for S3 backups to reduce storage costs
- **Monitoring**: Comprehensive CloudWatch logging for both delivery and backup operations
- **Retry Logic**: Built-in retry mechanism (300 seconds) for failed deliveries

## Usage Example

```hcl
module "logging" {
  source = "./modules/logging"

  region                = var.region
  project_prefix        = var.project_prefix
  environment           = var.environment
  opensearch_domain_arn = var.opensearch_domain_arn
  firehose_role_arn     = var.firehose_role_arn
}
```

### Prerequisites

Before using this module, ensure you have:

1. An existing OpenSearch domain with appropriate permissions
2. An IAM role with permissions for:
   - OpenSearch domain access
   - S3 bucket read/write operations
   - CloudWatch Logs creation and writing

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `region` | AWS region for resource deployment | `string` | n/a | yes |
| `project_prefix` | Prefix for project resource naming | `string` | n/a | yes |
| `environment` | Deployment environment (dev/staging/prod) | `string` | n/a | yes |
| `opensearch_domain_arn` | ARN of the OpenSearch domain for log delivery | `string` | n/a | yes |
| `firehose_role_arn` | IAM role ARN used by Firehose for OpenSearch and S3 delivery | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| `archive_bucket_name` | Name of the S3 archive bucket used for log backups |
| `firehose_stream_name` | Name of the Kinesis Firehose delivery stream |

## Resources Created

This module creates the following AWS resources:

- **S3 Bucket**: Archive storage for log backups
- **Kinesis Firehose Delivery Stream**: Real-time log ingestion pipeline
- **CloudWatch Log Groups**: Monitoring for delivery and backup operations

## Configuration Details

### S3 Archive Bucket
- **Naming**: `{project_prefix}-logs-{random-suffix}`
- **Force Destroy**: Enabled for development environments
- **Compression**: GZIP compression for cost optimization
- **Buffering**: 300 seconds or 5MB, whichever comes first

### Kinesis Firehose Stream
- **Destination**: OpenSearch domain
- **Index Name**: `siem-logs`
- **Buffering**: 300 seconds interval, 5MB size limit
- **Retry Duration**: 300 seconds for failed deliveries
- **Backup Mode**: All documents backed up to S3

### CloudWatch Logging
- **Delivery Logs**: `/aws/kinesisfirehose/{project_prefix}-delivery`
- **Backup Logs**: `/aws/kinesisfirehose/{project_prefix}-backup`
- **Log Stream**: Separate streams for delivery and backup operations

## Security Considerations

- Ensure the Firehose IAM role has minimal required permissions
- Consider enabling S3 bucket encryption for sensitive log data
- Implement proper VPC endpoints if using private subnets
- Regular review of CloudWatch log groups for security events

## Monitoring and Alerting

The module provides comprehensive monitoring through CloudWatch Logs. Consider setting up:

- CloudWatch Alarms for delivery failures
- SNS notifications for critical errors
- Dashboard for monitoring delivery stream metrics
- Log retention policies for compliance requirements

## Diagram Placeholder

<!-- TODO: Insert AWS architecture diagram showing the complete logging pipeline -->
<!-- Diagram should include: S3 sources, Kinesis Firehose, OpenSearch, S3 backup, CloudWatch -->

## Contributing

When modifying this module:

1. Update variable descriptions if adding new inputs
2. Document any new outputs in this README
3. Test changes in a development environment
4. Update the architecture diagram if data flow changes

## License

This module is part of the SIEMplicity project. See the main project repository for license information.
