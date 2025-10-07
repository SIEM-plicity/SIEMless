# AWS EventBridge Rule: S3 → Lambda Ingestion

This rule listens for S3 `ObjectCreated` events and routes them through EventBridge to trigger the `S3IngestHandler` Lambda function. The Lambda then retrieves and processes the object, logs results to CloudWatch, and returns a success response.

## Architecture Diagram

```mermaid
graph TD
A[S3 Bucket: ObjectCreated Event] --> B[EventBridge Rule: Match *.ObjectCreated:*]
B --> C[Lambda Function: S3IngestHandler]
C --> D[CloudWatch Logs]
