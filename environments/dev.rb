name 'dev'
description 'The Development Environment'
cookbook 'workflow_testing', '= 0.1.3'
default_attributes workflow_testing: {
                     test: 'dev',
                   },
                   audit: {
                     fetcher: 'chef-server-automate',
                     reporter: 'chef-server-automate',
                     profiles: [
                       {
                         name: 'CIS Microsoft Windows Server 2012 R2 Benchmark Level 1 - Memeber Server',
                         compliance: 'admin/cis-windows2012r2-level1-memeberserver',
                       },
                     ],
                   }
