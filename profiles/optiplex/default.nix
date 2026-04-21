{ ... }:

{

  imports = [ 
    ../../modules 
    ../../users
  ];
  
  # Users
  myusers.simon.enable         		  = true;
  myusers.serveruser.enable         = true;

  # System
  mymodules.common.enable		        = true;
  mymodules.bash.enable			        = true;

  # Apps - Editors
  mymodules.vim.enable			        = true;

}
