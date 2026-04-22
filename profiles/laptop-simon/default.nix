{ ... }:

{

  imports = [ 
    ../../modules 
    ../../users
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

  # Apps - Browsers
  mymodules.firefox.enable		          = true;
  mymodules.chromium.enable		          = true;

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
  mymodules.steam.enable		            = true;
  mymodules.perm-pkgs.enable		        = true;
  mymodules.gamemode.enable		          = true;

  # Hardware
  mymodules.input.enable		            = true;
  mymodules.lenovo-legion.enable	      = true;
  mymodules.nvidia.enable		            = true;
  mymodules.nvidia.batterySaver		      = true;
  mymodules.power-management.enable	    = true;
  mymodules.printing.enable 		        = true;
  mymodules.sensors.enable	          	= true;
  mymodules.sound.enable		            = true;

}
