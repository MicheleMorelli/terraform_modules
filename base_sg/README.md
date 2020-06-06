## Base SG module

A simple module to easily set-up a SG multitude of rules. 



### Use example:

You can use this module by referecing this Github repository:

```
module sg {                                                                     
  source = "git::https://github.com/MicheleMorelli/terraform_modules//base_sg"  
  name   = "my_sg"                                                          
  port_list = [8080, 8000, 80, 9000]                                                     
  cidr_list = ["1.2.3.4/32"]                                              
} 
```
