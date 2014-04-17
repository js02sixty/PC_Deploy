
=============
PC Deploy 1.0
=============

Quickly Join PCs to the domain and configure them to be used by a primary user


Installation
------------

Unzip PCDeploy to engineer's local PC


Use a CSV (Optional)
--------------------

create CSV file in this format (You can use MS Excel):

  PC,Branch,User,PW
  MXLXXXXXXX,ph,jdoe,password
  MXLXXXXXXY,kq,jschmo,passwd

* not all PCs in the list need a user and Password


Run Script
----------

1. Unbox PC, connect power and network, and turn on.
2. Double click on RUN.cmd.
3. Press 1 for "Step 1" to join PCs to the domain.
      This will copy a script file to the new machine and use PSEXEC to run the script which will join the PC to the domain and enable WinRM.
4. After a few minutes to allow PC to reboot, Select Step 2.
      This step moves the PC to the specified branch, Adds the specified default user to the local admin group and remote desktop user's group, and reboots the PC.
5. Step 3 Automatically opens a RDP session for each user to help quickly create the user account for the first time.
6. Disable the local policy “Network access: Do not allow storage of passwords and credentials for network authentication” with GPEDIT.msc. it is located in “Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options\”
7. This optional step will begin copying the backup files from the server down to the PCs.

