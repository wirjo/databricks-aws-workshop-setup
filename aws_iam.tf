resource "aws_iam_role" "external" {
  name               = var.external_location_name
  assume_role_policy = data.aws_iam_policy_document.external_trust.json
}

resource "aws_iam_role_policy" "metastore_permission" {
  name   = "s3-${var.external_location_name}"
  role   = aws_iam_role.external.id
  policy = data.aws_iam_policy_document.external_permission.json
}

data "aws_iam_policy_document" "external_trust" {
  statement {
    principals {
      type        = "AWS" # Databricks controlplane: Unity catalog master role
      identifiers = ["arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"]
    }

    actions = ["sts:AssumeRole"]

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.databricks_account_id]
    }
  }
}

data "aws_iam_policy_document" "external_permission" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]

    resources = [
      aws_s3_bucket.external.arn,
      "${aws_s3_bucket.external.arn}/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.external_location_name}"
    ]
  }
}