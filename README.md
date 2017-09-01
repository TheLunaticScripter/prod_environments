# prod_environments

This is a structure and a build_cookbook for deploying a Chef Server Environments through an Automate Pipeline.

## Usage
   - Create a Chef vault item called workflow-vaults
   ```json
   {
     "id": "my_automate_enterprise-my_automate_org",
     "deploy": {
       "chef_servers": [
         {
           "url": "https://my-first-chef-server-fqdn/organization/production",
           "user": "my-admin-chef-user",
           "key": "My delivery key in proper json format"
         }
       ]
     }
   }
   ```
   - Push the cookbook through the pipeline and it will update the environments as needed
