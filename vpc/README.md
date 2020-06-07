## Base VPC module

A simple module to easily set-up a VPC. 
It allows to create a VPC with one Internet Gateway, simple route tables, and a variable number of subnets (both private and public). The subnets are automatically associated to the relevant route table. 

### Use example:

You can use this module by referecing this Github repository:

```
module vpc {                                                                     
  source = "git::https://github.com/MicheleMorelli/terraform_modules//vpc"  
  name = "my_vpc"
  vpc_cidr_range = "192.168.0.0/16"
  public_subnets_cidr_blocks_list = ["192.168.1.0/24", "192.168.2.0/24"]
  private_subnets_cidr_blocks_list = ["192.168.3.0/24", "192.168.4.0/24"]
} 
```
