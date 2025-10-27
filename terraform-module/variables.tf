
variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = "deny-non-east-us-locations"
}


variable "policy_display_name" {
  description = "The display name of the policy"
  type        = string
  default     = "Allow only East US location for resources"
}
variable "policy_description" {
  description = "The description of the policy assignment"
  type        = string
  default     = "Policy assignment to restrict resource creation to East US location only"
}
  
variable "policy_assignment_name" {
  description = "The name of the policy assignment"
  type        = string
  default     = "deny-non-east-us-locations-assignment"
  
}
variable "policy_assignment_display_name" {
  description = "The display name of the policy assignment"
  type        = string
  default     = "Allow only East US location for resources"  
}

variable "policy_assignmnet_description" {
  description = "The description of the policy assignment"
  type        = string
  default     = "Policy assignment to restrict resource creation to East US location only"
    
}
