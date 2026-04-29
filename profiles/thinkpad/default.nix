{ ... }:

{

  imports = [ 
    ../../modules 
    ../../users
    #../../modules/hardware/cpu/amd
    #../../modules/hardware/gpu/amd
  ];
  
  # Users
  myusers.simon.enable         		      = true;

  # Desktop
  mymodules.gdm.enable			            = true;
  mymodules.hyprland.enable		          = true;

  # System
  mymodules.common.enable		            = true;
  mymodules.bash.enable			            = true;
  mymodules.networking.enable		        = true;
  mymodules.keyring.enable		          = true;
  mymodules.dotfiles.enable		          = true;
  mymodules.theme.enable		            = true;
  mymodules.smb-share.enable            = true;
  mymodules.boot-animation.enable       = false;

  # Apps - Browsers
  mymodules.firefox.enable		          = true;
  mymodules.chromium.enable		          = true;

  # Apps - Dev
  mymodules.docker.enable               = true;

  # Apps - Editors
  mymodules.vim.enable			            = true;

  # Apps - File-browsers
  mymodules.nautilus.enable		          = true;
  mymodules.thunar.enable		            = true;

  # Apps - Terminals
  mymodules.alacritty.enable 		        = true;
  mymodules.kitty.enable		            = true;

  # Apps - Office
  mymodules.thunderbird.enable		      = true;

  # Apps - Media
  mymodules.music.enable		            = true;
  mymodules.video.enable		            = true;
  mymodules.screenshot.enable		        = true;
  mymodules.playercontrols.enable	      = true;

  # Apps - Gaming
  mymodules.wine.enable			            = true;

  # Hardware
  mymodules.cpu-amd.enable              = true;
  mymodules.gpu-amd.enable              = true;
  mymodules.input.enable		            = true;
  mymodules.power-management.enable	    = true;
  mymodules.printing.enable 		        = true;
  mymodules.sensors.enable	          	= true;
  mymodules.sound.enable		            = true;

}
