## Some simple reusable Terraform modules


```
module sg {                                                                     
  source = "git::https://github.com/MicheleMorelli/terraform_modules//base_sg"  
  name   = "my_sg"                                                          
  port_list = [8080, 8000, 80, 9000]                                                     
  cidr_list = ["0.0.0.0/0"]                                              
} 
```
