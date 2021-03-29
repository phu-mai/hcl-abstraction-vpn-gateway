variable "create_vpn_connection" {
  description = "Set to false to prevent the creation of a VPN Connection."
  type        = bool
  default     = true
}
variable "bgp_asn" {
  type        = string
  default     = 65111
}
variable "ip_address" {
  type        = string
  default     = "13.76.241.122"
}
variable "type" {
  type        = string
  default     = "ipsec.1"
}
variable "cgw_tags" {
  type        = map(string)
  default     = {
    Name      = "vpn-customer-gateway"
    Env       = "infra-vpn"
  }
}
variable "vpc_source_name" {
  type = string
  default = "aws"
}
variable "destination_name" {
  type = string
  default = "azure"
}
variable "vpn_connection_static_routes_only" {
  description = "Set to true for the created VPN connection to use static routes exclusively (only if `create_vpn_connection = true`). Static routes must be used for devices that don't support BGP."
  type        = bool
  default     = true
}
variable "connect_to_transit_gateway" {
  description = "Set to false to disable attachment of the VPN connection route to the VPN connection (TGW uses another resource for that)"
  type        = bool
  default     = true
}

variable "transit_gateway_id" {
  description = "Identifier of EC2 Transit Gateway."
  type        = string
  default     = ""
}
variable "customer_gateway_id" {
  description = "The id of the Customer Gateway."
  type        = string
  default = ""
}
variable "tunnel1_inside_cidr" {
  description = "The CIDR block of the inside IP addresses for the first VPN tunnel."
  type        = string
  default     = ""
}
variable "tunnel2_inside_cidr" {
  description = "The CIDR block of the inside IP addresses for the second VPN tunnel."
  type        = string
  default     = ""
}
variable "tunnel1_preshared_key" {
  description = "The preshared key of the first VPN tunnel."
  type        = string
  default     = ""
}
variable "tunnel2_preshared_key" {
  description = "The preshared key of the second VPN tunnel."
  type        = string
  default     = ""
}
variable "vpn_gw_tags" {
  type        = map(string)
  default     = {
    Env       = "infra-vpn"
  }
}
variable "region" {
  type        = string
  default     = "ap-southeast-1"
}
variable "transit_gateway_route_table_id" {
  type = string
  default = ""
}
variable "vpn_attachment_name" {
  type = string
  # default = "infra-vpn"
}
variable "static_routes" {
  type    = list(any)
  default = []
}
variable "vpn_tgw_tags" {
  type        = map(string)
  default     = {
    Environment = "shared"
  }
}
