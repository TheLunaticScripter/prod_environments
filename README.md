# prod_environments

This is a structure and a build_cookbook for deploying a Chef Server Environments through an Automate Pipeline.

## Usage

   - Create a Chef vault item 
   ```json
   {
     "id": "my_automate_enterprise-my_automate_org",
     "deploy": {
       "chef_server": [
         {
           "url": "https://my-first-chef-server-fqdn/organization/production",
           "user": "my-admin-chef-user",
           "key": "My delivery key in proper json format"
         }
       ]
     }
   }
   ```

   - Add an environments folder to the cookbook

   - Create a environment file like
   prod_environment/environments/dev.rb
   ```ruby
   name 'dev'
   description 'The Development Environment'
   cookbook 'foo' '= 0.1.0'
   ```

   - Push the cookbook through the pipeline and it will update the environments as needed
