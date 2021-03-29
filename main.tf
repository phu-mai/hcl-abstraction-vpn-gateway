resource "aws_customer_gateway" "main" {
  count = var.create_vpn_connection ? 1 : 0
  bgp_asn    = var.bgp_asn
  ip_address = var.ip_address
  type       = var.type
  tags = merge(
    {
    Terraform = "true"
    Owner     = "devops"
    },
    var.cgw_tags,
  )
}

module "vpn_gw" {
  source  = "git::git@github.com:cxagroup/infra-terraform-modules.git//terraform-aws-vpn-gateway"
  vpc_source_name                   = var.vpc_source_name
  destination_name                  = var.destination_name
  vpn_connection_static_routes_only = var.vpn_connection_static_routes_only
  connect_to_transit_gateway        = var.connect_to_transit_gateway
  transit_gateway_id                = var.transit_gateway_id == "" ? data.terraform_remote_state.tgw.outputs.tgw_cxa_infra_id : var.transit_gateway_id
  customer_gateway_id               = aws_customer_gateway.main[0].id
  tags = merge(
    {
    Env       = "infra-vpn"
    Terraform = "true"
    Owner     = "devops"
    Purpose   = "${var.vpc_source_name}-${var.destination_name}-site-to-site-vpn"
    },
    var.vpn_gw_tags,
  )
}

module "tgw_vpn_route" {
  source = "git::git@github.com:cxagroup/infra-terraform-modules//terraform-aws-transit-gateway/modules/transit-gateway-routes/?ref=INFRA-1514-Upgrade_Terraform_to_0.13.5"
  name                           = "${var.vpc_source_name}-${var.destination_name}-site-to-site-vpn"
  region                         = var.region
  transit_gateway_id             = var.transit_gateway_id == "" ? data.terraform_remote_state.tgw.outputs.tgw_cxa_infra_id : var.transit_gateway_id
  transit_gateway_attachment_id  = module.vpn_gw.vpn_connection_transit_gateway_attachment_id
  transit_gateway_route_table_id = var.transit_gateway_route_table_id == "" ? data.terraform_remote_state.tgw.outputs.tgw_cxa_infra_route_table_id : var.transit_gateway_route_table_id
  vpn_attachments = {
    (var.vpn_attachment_name)  = {
      tgw_routes = length(var.static_routes) == 0 ? [] : local.static_routes
    }
  }
  tags = merge(
    {
    Terraform   = "true"
    Purpose     = "${var.vpc_source_name}-${var.destination_name}-site-to-site-vpn"
    Owner       = "devops"
    },
    var.vpn_tgw_tags,
  )
}
