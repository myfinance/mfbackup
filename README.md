# mfdump

to install the application manually with helm: 
helm repo update
helm upgrade -i --cleanup-on-fail mfbackup local/mfbackup --set stage=prod --devel

or install the complete bundle see repo mfbundle