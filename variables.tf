variable "name" {
  description = "GitHub project name"
}
variable "description" {
  description = "GitHub project description"
}
variable "homepage_url" {
  default     = ""
  description = "GitHub project homepage"
}
variable "ci_contexts" {
  default     = []
  type        = list(string)
  description = "Required CI contexts for PRs to merged in the main branch"
}

variable "support_releases" {
  default     = true
  description = "Whether the project uses Semantic Releases"
}
