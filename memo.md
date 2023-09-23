# OCI CLI memo

## iam

```text
iam availability-domain list
```

## network

```text
network vcn list

network internet-gateway list

network route-table list

network security-list list

network subnet list
```

```text
network subnet delete --subnet-id $subnet_id

# before deleting route-table, we must detach internet gateways from route-rules
network route-table update --rt-id $rt_id --route-rules '[]'

network internet-gateway delete --ig-id $ig_id

network vcn delete --vcn-id $vcn_id
```

## compute

```text
compute instance list

compute instance list-vnics
```
