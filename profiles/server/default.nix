{ ... }:

{

  imports = [ 
    ../../modules 
    ../../users
  ];
  
  # Users
  myusers.simon.enable         		            = true;
  myusers.serveruser.enable                   = true;

  # System
  mymodules.common.enable		                  = true;
  mymodules.bash.enable			                  = true;
  mymodules.smb-server.enable                 = true;

  # Apps
  mymodules.vim.enable			                  = true;
  mymodules.docker.enable                     = true;
  mymodules.containers.satisfactory.enable    = true;

}
