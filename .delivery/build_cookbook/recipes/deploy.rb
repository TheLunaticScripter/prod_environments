#
# Cookbook:: build_cookbook
# Recipe:: deploy
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe 'delivery-truck::deploy'

case workflow_stage
when 'delivered'
  vault_data = get_workflow_vault_data

  vault_data['deploy']['chef_servers'].each do |server_info|
    # Set file paths inside project cache
    client_key_path = File.join(workflow_workspace_cache, 'delete_me.pem')
    knife_rb_path = File.join(workflow_workspace_cache, 'knife.rb')

    # Create key for Knife to use (gets overwritten by each deploy)
    file client_key_path do
      content server_info['key']
      sensitive true
      action :create
    end

    # Create knife.rb file (gets overwritten by each deploy)
    file knife_rb_path do
      # Set file content and strip leading white space
      content <<-EOF.gsub(/^\s+/, '')
        log_location             STDOUT
        node_name                "#{server_info['user']}"
        client_key               "#{client_key_path}"
        chef_server_url          "#{server_info['url']}"
        trusted_certs_dir        "/etc/chef/trusted_certs"
      EOF
      action :create
    end
    
    env_files = [Dir["#{workflow_workspace_repo}/environments/*.rb"]]

    puts ''
    env_files.each do |file|
      puts "This is an environment: #{file}"
    end
    puts ''

    # Ensure keys are deleted after deploy is done
    [client_key_path, knife_rb_path].each do |file_path|
      file file_path do
        action :delete
      end
    end
  end
end
