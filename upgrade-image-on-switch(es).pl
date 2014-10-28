#!/usr/local/bin/perl
use executeInBackground;

# COMMAND OPTIONS & THEIR USE:
# switch systemType server eraseConfig skipKick path kickImg sysImg
#
# switch: hostname
# server: win OR eng (HOST-A or HOST-B)
# eraseConfig: erase-config OR save-config
# skipKick: skip-kick OR no-skip-kick
# path: path (only needed for eng server option, win uses /img always; used for both kick & sys img download, modify TTL script to override)
# kickImg: filename
# sysImg: filename

# OPTIONS
$server = "win";
#$server = "eng";
$eraseConfig = "save-config";
#$eraseConfig = "erase-config";
$skipKick = "no-skip-kick";

# PATH & FILENAMES TO LOAD UP
$kickpath = "/auto/tftpboot/";
$syspath = $kickpath;
#$syspath = "/auto/tftpboot2/";
$kickImg = "n7700-s2-kickstart.6.2.10.bin";
$sysImg = "n7700-s2-dk9.6.2.10.bin";

# SWITCHES TO UPGRADE
@switchesToUpgrade = ();
push(@switchesToUpgrade, ('switch-a'));
#push(@switchesToUpgrade, ('switch-b'));
push(@switchesToUpgrade, ('switch-c'));
push(@switchesToUpgrade, ('switch-d'));



# If config was erased, wait for system to fully reboot and then apply base configs
unless ($eraseConfig =~ /save-config/) {
        foreach (@switchesToUpgrade) {
               $currentswitch = $_;
               execbg('"C:\\Program Files\\teraterm\\ttpmacro.exe" "C:\\Program Files\\teraterm\\init-config-' . $currentswitch . '.ttl"');
     }
}

# Wait a few seconds to let the consoles open
sleep 2;

# copy images, set boot strings, erase config (optional), reload
foreach (@switchesToUpgrade) {
     $currentswitch = $_;
     execbg('"C:\\Program Files\\teraterm\\ttpmacro.exe" "C:\\Program Files\\teraterm\\INFRA-upgrade-n7k-switch.ttl" ' . $currentswitch . ' ' . $server . ' ' . $eraseConfig . ' ' . $skipKick . ' ' . $kickpath . ' ' . $syspath . ' ' . $kickImg . ' ' . $sysImg);
}

exit(0);
