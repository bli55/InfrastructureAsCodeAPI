# ── KMS Key (used by SOPS to encrypt secrets.yaml) ───────────────────────────

resource "aws_kms_key" "sops" {
  description             = "SOPS encryption key for ${var.project_name}"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_kms_alias" "sops" {
  name          = "alias/${var.project_name}-sops"
  target_key_id = aws_kms_key.sops.key_id
}

# ── Secrets Manager ───────────────────────────────────────────────────────────
# Terraform creates the secret; actual values are populated via SOPS + CI or
# manually. The lifecycle block prevents Terraform from overwriting real values
# on subsequent applies.

resource "aws_secretsmanager_secret" "app" {
  name                    = var.project_name
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "app" {
  secret_id = aws_secretsmanager_secret.app.id

  secret_string = jsonencode({
    api_key     = "REPLACE_ME"
    db_password = "REPLACE_ME"
  })

  # Prevent Terraform from reverting real secret values back to the placeholder
  # after you've updated them outside of Terraform.
  lifecycle {
    ignore_changes = [secret_string]
  }
}
