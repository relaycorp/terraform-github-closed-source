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

resource "github_branch_protection" "main" {
  repository_id = github_repository.main.node_id
  pattern       = "main"

  required_linear_history         = true
  require_conversation_resolution = true

  required_status_checks {
    strict = true
    contexts = concat(
      var.support_releases ? ["pr-ci / semantic-pr-title", "release / release"] : [],
      var.ci_contexts,
    )
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    required_approving_review_count = 1
  }

  restrict_pushes {
    blocks_creations = true
    push_allowances = [
      local.github_actions_app_node_id, # Allow @semantic-release/github to create GH releases
    ]
  }
}
