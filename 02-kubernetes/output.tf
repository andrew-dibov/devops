output "lb__kubernetes_api_ip" {
  value = tolist([
    for l in yandex_lb_network_load_balancer.lb__kubernetes_api.listener :
    tolist(l.external_address_spec)[0].address
  ])[0]
}
