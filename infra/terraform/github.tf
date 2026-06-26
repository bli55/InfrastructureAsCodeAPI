resource "github_branch_protection" "main" {
  repository_id = var.github_repository
  pattern       = "main"

  required_pull_request_reviews {
    required_approving_review_count = 1
    dismiss_stale_reviews           = true
  }

  allows_deletions    = false
  allows_force_pushes = false
}
