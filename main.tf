resource "github_repository" "main" {
  name         = var.name
  description  = var.description
  homepage_url = var.homepage_url
  visibility   = "private"

  // PR merging
  allow_merge_commit          = false
  allow_rebase_merge          = false
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  allow_auto_merge            = true
  delete_branch_on_merge      = true

  has_issues      = false
  has_discussions = false
  has_downloads   = false
  auto_init       = true

  vulnerability_alerts = true

  lifecycle {
    // Prevent imported repos from being recreated
    ignore_changes = [auto_init]
  }
}
